#!/usr/bin/env python3

"""Pack labeled text records into PICO-8 graphics memory."""

from __future__ import annotations

import argparse
import re
from dataclasses import dataclass, field
from decimal import Decimal, InvalidOperation, ROUND_HALF_UP
from pathlib import Path


GFX_LINE_BYTES = 64
MAP_LINE_BYTES = 128
MAP_BYTES = 0x1000
P8_HEADER = "pico-8 cartridge // http://www.pico-8.com\nversion 43\n"
ALIAS_PAYLOAD_SIZE = 3
OBJECT_FIELDS = (
    "type",
    "state",
    "team",
    "active",
    "depth",
    "zspeed",
    "wait",
    "cross",
    "flip_frame",
    "v_pos",
    "rot",
    "pierce",
    "collision",
    "invuln",
    "flip_wait",
    "shoots",
    "health",
    "duration",
    "start_scale",
    "end_scale",
    "rot_speed",
    "angle",
    "super_run",
    "score",
    "color",
)
OBJECT_BOOL_FIELDS = {"active", "pierce", "invuln", "shoots", "super_run"}
OBJECT_128_FIELDS = {"zspeed"}
OBJECT_256_FIELDS = {"start_scale", "end_scale"}
OBJECT_FIXED_FIELDS = {"rot", "rot_speed"}


@dataclass
class ObjectDefinition:
    name: str
    attributes: dict[str, str] = field(default_factory=dict)
    shapes: list[str] = field(default_factory=list)
    curve: str | None = None


@dataclass
class ObjectDefinitions:
    objects: list[ObjectDefinition] = field(default_factory=list)
    curves: dict[str, list[int]] = field(default_factory=dict)

# prefix: (runtime pointer table, shared ID namespace)
TYPES = {
    "V": ("verts_data", "WEB"),
    "C": ("cmds_data", "WEB"),
    "M": ("meta_data", "WEB"),
    "W": ("waves_data", "WAVE"),
    "S": ("messages_data", "MESSAGE"),
}

TYPE_WORDS = {
    "V": {"vert", "verts", "vertex", "vertices"},
    "C": {"cmd", "cmds", "command", "commands"},
    "M": {"meta", "metadata"},
    "W": {"wave", "waves"},
    "S": {"message", "messages", "msg", "msgs"},
}


@dataclass
class Label:
    name: str
    enum_name: str
    index: int
    address: int
    enum_value: int = 0


@dataclass
class PackedFile:
    path: Path
    address: int
    section: str
    prefix: str | None
    data: list[int] = field(default_factory=list)
    labels: list[Label] = field(default_factory=list)
    messages: list[str] = field(default_factory=list)
    object_defs: ObjectDefinitions | None = None


@dataclass
class SourceEntry:
    key: str
    value: str
    line_number: int


@dataclass
class SourceSection:
    name: str
    line_number: int
    entries: list[SourceEntry] = field(default_factory=list)


def enum_name(text: str) -> str:
    """Turn a filename or label into an uppercase identifier."""
    name = re.sub(r"[^A-Za-z0-9]+", "_", text.strip()).strip("_").upper()
    if not name:
        raise ValueError(f"cannot create an enum name from {text!r}")
    return "_" + name if name[0].isdigit() else name


def parse_sections(path: Path) -> list[SourceSection]:
    """Parse the shared [record] / key=value source format."""
    sections: list[SourceSection] = []
    current: SourceSection | None = None

    for line_number, raw_line in enumerate(
        path.read_text(encoding="utf-8").splitlines(), 1
    ):
        line = raw_line.strip()
        if not line or line.startswith(";"):
            continue
        if line.startswith("[") and line.endswith("]"):
            name = line[1:-1].strip()
            if not name:
                raise ValueError(f"{path}:{line_number}: section name cannot be empty")
            current = SourceSection(name, line_number)
            sections.append(current)
            continue
        if current is None:
            raise ValueError(f"{path}:{line_number}: value appears before a section")
        if "=" not in line:
            raise ValueError(f"{path}:{line_number}: expected key=value")
        key, value = (part.strip() for part in line.split("=", 1))
        if not key or not value:
            raise ValueError(f"{path}:{line_number}: key and value cannot be empty")
        current.entries.append(SourceEntry(key.lower(), value, line_number))

    return sections


def file_prefix(path: Path) -> str | None:
    """Infer V, C, M, or W from words in a filename."""
    words = set(re.split(r"[^a-z0-9]+", path.stem.lower()))
    matches = [prefix for prefix, choices in TYPE_WORDS.items() if words & choices]
    if len(matches) > 1:
        raise ValueError(f"{path}: filename ambiguously identifies multiple data types")
    return matches[0] if matches else None


def gfx_byte(value: int) -> int:
    """Validate a byte and swap its nibbles for PICO-8 __gfx__ storage."""
    if not -128 <= value <= 255:
        raise ValueError(f"byte value out of range: {value}")
    value &= 0xFF
    return (value << 4 | value >> 4) & 0xFF


def gfx_u16(value: int) -> list[int]:
    if not 0 <= value <= 0xFFFF:
        raise ValueError(f"u16 value out of range: {value}")
    return [gfx_byte(value & 0xFF), gfx_byte(value >> 8)]


def parse_numbers(path: Path, line_number: int, fields: list[str]) -> list[int]:
    values = []
    for field_number, field in enumerate(fields, 1):
        try:
            values.append(int(field))
        except ValueError as error:
            raise ValueError(
                f"{path}:{line_number}: invalid integer {field!r} "
                f"at field {field_number}"
            ) from error
    return values


def pack_record(
    path: Path, line_number: int, fields: list[str], is_wave: bool
) -> list[int]:
    """Pack one ordinary or wave record, including its size byte."""
    values = parse_numbers(path, line_number, fields)

    if is_wave:
        if len(values) < 2:
            raise ValueError(
                f"{path}:{line_number}: wave record needs generator_count,total_enemies"
            )
        generator_count, total_enemies, *generators = values
        if len(generators) != generator_count * 2:
            raise ValueError(
                f"{path}:{line_number}: wave declares {generator_count} generators "
                f"but supplies {len(generators) // 2}"
            )

        payload = [gfx_byte(generator_count), gfx_byte(total_enemies)]
        for enemy_type, period in zip(generators[::2], generators[1::2]):
            payload.append(gfx_byte(enemy_type))
            payload.extend(gfx_u16(period))
    else:
        payload = [gfx_byte(value) for value in values]

    if len(payload) > 255:
        raise ValueError(
            f"{path}:{line_number}: record payload is {len(payload)} bytes; "
            "maximum is 255"
        )
    return [gfx_byte(len(payload)), *payload]


def parse_object_defs(
    path: Path, sections: list[SourceSection]
) -> ObjectDefinitions:
    """Parse readable object attributes, shapes, and difficulty curves."""
    result = ObjectDefinitions()
    seen_sections: set[str] = set()

    for section in sections:
        words = section.name.split()
        if len(words) == 2 and words[0].lower() == "curve":
            name = enum_name(words[1])
            section_key = f"CURVE_{name}"
            if section_key in seen_sections:
                raise ValueError(
                    f"{path}:{section.line_number}: duplicate section {section.name!r}"
                )
            seen_sections.add(section_key)
            result.curves[name] = []
            for entry in section.entries:
                if entry.key != "values":
                    raise ValueError(
                        f"{path}:{entry.line_number}: curve sections only accept values="
                    )
                result.curves[name].extend(
                    parse_numbers(
                        path,
                        entry.line_number,
                        [item.strip() for item in entry.value.split(",")],
                    )
                )
        elif len(words) == 1:
            name = enum_name(words[0])
            if name in seen_sections:
                raise ValueError(
                    f"{path}:{section.line_number}: duplicate section {section.name!r}"
                )
            seen_sections.add(name)
            definition = ObjectDefinition(name)
            result.objects.append(definition)
            for entry in section.entries:
                key, value = entry.key, entry.value
                if key == "shapes":
                    definition.shapes = [
                        item.strip().upper()
                        for item in value.split(",")
                        if item.strip()
                    ]
                elif key == "curve":
                    definition.curve = enum_name(value)
                elif key in OBJECT_FIELDS:
                    if key in definition.attributes:
                        raise ValueError(
                            f"{path}:{entry.line_number}: "
                            f"duplicate object attribute {key!r}"
                        )
                    definition.attributes[key] = value
                else:
                    raise ValueError(
                        f"{path}:{entry.line_number}: "
                        f"unknown object attribute {key!r}"
                    )
        else:
            raise ValueError(
                f"{path}:{section.line_number}: invalid section {section.name!r}"
            )

    if not result.objects or result.objects[0].name != "ENEMY":
        raise ValueError(f"{path}: first object section must be [ENEMY]")
    for name, values in result.curves.items():
        if len(values) != 50:
            raise ValueError(
                f"{path}: curve {name} contains {len(values)} values; expected 50"
            )
        if any(not 0 <= value <= 255 for value in values):
            raise ValueError(f"{path}: curve {name} values must fit in one byte")
    return result


def object_defs_size(defs: ObjectDefinitions) -> int:
    size = 2 + sum(len(values) for values in defs.curves.values())
    for definition in defs.objects:
        encoded_attributes = sum(
            1 if key in OBJECT_BOOL_FIELDS
            or (key == "score" and value.lower() == "bonus")
            else 3
            for key, value in definition.attributes.items()
        )
        payload_size = (
            4 + len(definition.shapes) + encoded_attributes
        )
        if payload_size > 255:
            raise ValueError(
                f"object {definition.name} payload is {payload_size} bytes; maximum is 255"
            )
        size += 1 + payload_size
    return size


def parse_lua_constants(path: Path) -> dict[str, int]:
    symbols: dict[str, int] = {}
    pattern = re.compile(
        r"^\s*--\[\[const\]\]\s+([A-Za-z_][A-Za-z0-9_]*)\s*=\s*"
        r"(-?(?:0x[0-9a-fA-F]+|\d+))\s*$"
    )
    for line in path.read_text(encoding="utf-8").splitlines():
        match = pattern.match(line)
        if match:
            symbols[match.group(1)] = int(match.group(2), 0)
    return symbols


def resolve_object_value(
    path: Path, object_name: str, field_name: str, text: str, symbols: dict[str, int]
) -> tuple[int, int]:
    """Return field-code flags and the compact unsigned value."""
    field_id = OBJECT_FIELDS.index(field_name) + 1
    lower = text.lower()
    if field_name in OBJECT_BOOL_FIELDS:
        if lower != "true":
            raise ValueError(
                f"{path}: {object_name}.{field_name} only supports true overrides"
            )
        return field_id + 32, 0
    if field_name == "score" and lower == "bonus":
        return field_id + 128, 0

    if text in symbols:
        value = Decimal(symbols[text])
    else:
        try:
            value = Decimal(text)
        except InvalidOperation as error:
            raise ValueError(
                f"{path}: {object_name}.{field_name} has unknown value {text!r}"
            ) from error

    negative = value < 0
    value = abs(value)
    if field_name in OBJECT_128_FIELDS:
        value *= 128
    elif field_name in OBJECT_256_FIELDS:
        value *= 256
    elif field_name in OBJECT_FIXED_FIELDS:
        value *= 65536
    encoded = int(value.to_integral_value(rounding=ROUND_HALF_UP))
    if Decimal(encoded) != value and field_name not in OBJECT_FIXED_FIELDS:
        raise ValueError(
            f"{path}: {object_name}.{field_name} cannot be represented exactly"
        )
    if not 0 <= encoded <= 0xFFFF:
        raise ValueError(
            f"{path}: {object_name}.{field_name} encoded value is out of range"
        )
    return field_id + (64 if negative else 0), encoded


def finalize_object_defs(
    packed: PackedFile, symbols: dict[str, int]
) -> None:
    defs = packed.object_defs
    if defs is None:
        return
    curve_ids = {name: index for index, name in enumerate(defs.curves, 1)}
    data = [gfx_byte(len(defs.objects)), gfx_byte(len(defs.curves))]
    for values in defs.curves.values():
        data.extend(gfx_byte(value) for value in values)

    for definition in defs.objects:
        object_symbol = definition.name
        if object_symbol not in symbols:
            raise ValueError(f"{packed.path}: unknown object type {object_symbol}")
        if definition.curve is not None and definition.curve not in curve_ids:
            raise ValueError(
                f"{packed.path}: {definition.name} has unknown curve "
                f"{definition.curve}"
            )
        payload = [
            gfx_byte(symbols[object_symbol]),
            gfx_byte(curve_ids.get(definition.curve or "", 0)),
            gfx_byte(len(definition.shapes)),
        ]
        for shape in definition.shapes:
            if shape not in symbols:
                raise ValueError(
                    f"{packed.path}: {definition.name} has unknown shape {shape}"
                )
            payload.append(gfx_byte(symbols[shape]))
        payload.append(gfx_byte(len(definition.attributes)))
        for field_name, text in definition.attributes.items():
            field_code, value = resolve_object_value(
                packed.path, definition.name, field_name, text, symbols
            )
            payload.append(gfx_byte(field_code))
            if field_code < 32 or 64 <= field_code < 128:
                payload.extend(gfx_u16(value))
        data.extend([gfx_byte(len(payload)), *payload])

    if len(data) != len(packed.data):
        raise AssertionError(
            f"{packed.path}: estimated {len(packed.data)} bytes but generated {len(data)}"
        )
    packed.data = data


def pack_file(path: Path, address: int) -> PackedFile:
    """Parse and pack one labeled input file."""
    packed = PackedFile(path, address, enum_name(path.stem), file_prefix(path))
    sections = parse_sections(path)
    if path.stem.lower() == "object_defs":
        packed.object_defs = parse_object_defs(path, sections)
        packed.data = [0] * object_defs_size(packed.object_defs)
        return packed

    seen_labels: set[str] = set()
    records: dict[bytes, int] = {}

    for section in sections:
        data_entry: SourceEntry | None = None
        names = [section.name]
        for entry in section.entries:
            if entry.key == "data":
                if data_entry is not None:
                    raise ValueError(
                        f"{path}:{entry.line_number}: duplicate data= entry"
                    )
                data_entry = entry
            elif entry.key == "aliases":
                names.extend(
                    name.strip() for name in entry.value.split(",") if name.strip()
                )
            else:
                raise ValueError(
                    f"{path}:{entry.line_number}: "
                    "packed records only accept aliases= and data="
                )
        if data_entry is None:
            raise ValueError(
                f"{path}:{section.line_number}: packed record requires data="
            )
        for name in names:
            identifier = enum_name(name)
            if identifier in seen_labels:
                raise ValueError(
                    f"{path}:{section.line_number}: "
                    f"duplicate label/enum {identifier!r}"
                )
            seen_labels.add(identifier)
            packed.labels.append(
                Label(
                    name,
                    identifier,
                    len(packed.labels) + 1,
                    address + len(packed.data),
                )
            )
        entry = data_entry
        fields = [field.strip() for field in entry.value.split(",")]
        if any(not field for field in fields):
            raise ValueError(f"{path}:{entry.line_number}: empty value in data line")
        if packed.prefix == "S":
            # Message data lives in a Lua string: it costs characters, but almost
            # no PICO-8 tokens and requires no byte-by-byte decoder.
            # Plain text (no x,y,hold,exit) is allowed for messages that never setmsg/drawmsg.
            if len(fields) == 1:
                packed.messages.append(fields[0].replace(r"\n", "|"))
            elif len(fields) == 5:
                parse_numbers(path, entry.line_number, fields[:4])
                packed.messages.append(",".join(fields[:4] + [fields[4].replace(r"\n", "|")]))
            else:
                raise ValueError(
                    f"{path}:{entry.line_number}: "
                    "message data needs x,y,hold,exit,text or just text"
                )
        else:
            record = pack_record(
                path, entry.line_number, fields, packed.prefix == "W"
            )
            record_key = bytes(record)
            canonical = records.get(record_key)
            if canonical is not None and len(record) > ALIAS_PAYLOAD_SIZE + 1:
                packed.data.extend(
                    [
                        gfx_byte(ALIAS_PAYLOAD_SIZE),
                        gfx_byte(0),
                        *gfx_u16(canonical),
                    ]
                )
            else:
                records[record_key] = address + len(packed.data)
                packed.data.extend(record)

    return packed


def assign_ids(files: list[PackedFile]) -> None:
    """Give matching geometry labels shared IDs and other types their own IDs."""
    ids: dict[str, dict[str, int]] = {"WEB": {}, "WAVE": {}, "MESSAGE": {}}
    owners: dict[tuple[str, str], Path] = {}

    for packed in files:
        if packed.prefix is None:
            continue
        domain = ids[TYPES[packed.prefix][1]]
        for label in packed.labels:
            label.enum_value = domain.setdefault(label.enum_name, len(domain) + 1)
            key = packed.prefix, label.enum_name
            if key in owners:
                raise ValueError(
                    f"duplicate generated enum {packed.prefix}_{label.enum_name} in "
                    f"{owners[key]} and {packed.path}"
                )
            owners[key] = packed.path


def write_gfx(path: Path, data: list[int]) -> None:
    lines = [
        "".join(f"{byte:02x}" for byte in data[start : start + GFX_LINE_BYTES])
        for start in range(0, len(data), GFX_LINE_BYTES)
    ]
    path.write_text(
        P8_HEADER + "__gfx__\n" + "\n".join(lines) + "\n",
        encoding="ascii",
    )


def write_map(path: Path, data: list[int]) -> None:
    """Write runtime bytes using the conventional __map__ byte order."""
    if len(data) > MAP_BYTES:
        raise ValueError(f"map data is {len(data)} bytes; maximum is {MAP_BYTES}")
    data = data + [0] * (MAP_BYTES - len(data))
    lines = [
        "".join(
            f"{gfx_byte(byte):02x}" for byte in data[start : start + MAP_LINE_BYTES]
        )
        for start in range(0, len(data), MAP_LINE_BYTES)
    ]
    path.write_text(
        P8_HEADER + "__map__\n" + "\n".join(lines) + "\n",
        encoding="ascii",
    )


def section_data(path: Path, section: str) -> str:
    """Read a generated cartridge section without its section header."""
    source = path.read_text(encoding="ascii")
    header = f"__{section}__\n"
    start = source.find(header)
    if start < 0:
        raise ValueError(f"{path}: expected {header.strip()} header")
    return source[start + len(header):]


def update_cart(path: Path, gfx: Path, map_data: Path) -> None:
    """Replace generated cartridge data sections, preserving audio and code."""
    source = path.read_text(encoding="utf-8")
    gfx_start = source.find("__gfx__\n")
    sfx_start = source.find("__sfx__\n", gfx_start)
    if gfx_start < 0:
        raise ValueError(f"{path}: expected __gfx__ section")
    if sfx_start < 0:
        data = "".join(section_data(gfx, "gfx").splitlines()).ljust(0x4000, "0")
        lines = "\n".join(data[i:i + 128] for i in range(0, len(data), 128)) + "\n"
        path.write_text(source[:gfx_start] + "__gfx__\n" + lines, encoding="utf-8")
        return
    sections = (
        "__gfx__\n" + section_data(gfx, "gfx")
        + "__map__\n" + section_data(map_data, "map")
    )
    path.write_text(source[:gfx_start] + sections + source[sfx_start:], encoding="utf-8")


def write_index(path: Path, files: list[PackedFile]) -> None:
    lines = ["# file,input,start_dec,start_hex,size"]
    lines += [
        f"file,{item.path.name},{item.address},0x{item.address:04X},{len(item.data)}"
        for item in files
    ]
    lines += ["", "# label,input,index,name,enum,address_dec,address_hex"]
    lines += [
        f"label,{item.path.name},{label.index},{label.name},{label.enum_value},"
        f"{label.address},0x{label.address:04X}"
        for item in files
        for label in item.labels
    ]
    path.write_text("\n".join(lines) + "\n", encoding="utf-8")


def const(name: str, value: str | int) -> str:
    return f"--[[const]] {name}={value}"


def typed_files(files: list[PackedFile], prefix: str) -> list[PackedFile]:
    return [item for item in files if item.prefix == prefix and item.labels]


def write_enums(path: Path, files: list[PackedFile]) -> None:
    """Write constants and runtime pointer-table initialization."""
    sections = [item.section for item in files]
    if len(sections) != len(set(sections)):
        duplicate = next(name for name in sections if sections.count(name) > 1)
        raise ValueError(f"duplicate generated section name {duplicate!r}")

    lines = ["-- generated by pack.py; do not edit", "", "-- packed section starting addresses"]
    lines += [
        const(f"PTR_{item.section}_DATA", f"0x{item.address:04X}") for item in files
    ]

    lines += ["", "-- typed record ids"]
    lines += [
        const(f"{item.prefix}_{label.enum_name}", label.enum_value)
        for item in files
        if item.prefix is not None
        for label in item.labels
    ]

    lines += ["", "-- difficulty curve addresses (50 bytes each, indexed by (stage-1)\\2)"]
    for item in files:
        if item.object_defs is None:
            continue
        curve_addr = item.address + 2
        for name in item.object_defs.curves:
            lines.append(const(f"CURVE_{name}", f"0x{curve_addr:04X}"))
            curve_addr += 50

    lines += [
        "",
        "-- build direct record-pointer tables once at startup",
        "function add_data(t,a,i,n)",
        " for j=0,n-1 do",
        "  t[i+j]=a",
        "  a+=@a+1",
        " end",
        "end",
    ]
    lines += [
        f"{table}={{}}" for prefix, (table, _) in TYPES.items()
        if prefix != "S" and typed_files(files, prefix)
    ]

    message_rows = [row for item in typed_files(files, "S") for row in item.messages]
    if message_rows:
        lines += [
            "",
            "message_string=[[" + "\n".join(message_rows) + "]]",
            "function get_message(i)",
            ' return split(split(message_string,"\\n")[i])',
            "end",
        ]

    lines += ["", "function init_packed_data()"]
    for prefix, (table, _) in TYPES.items():
        if prefix == "S":
            continue
        for item in typed_files(files, prefix):
            start = 0
            while start < len(item.labels):
                shared = start + 1
                while (
                    shared < len(item.labels)
                    and item.labels[shared].enum_value
                    == item.labels[shared - 1].enum_value + 1
                    and item.labels[shared].address == item.labels[start].address
                ):
                    shared += 1
                if shared > start + 1:
                    first, last = item.labels[start], item.labels[shared - 1]
                    lines.append(
                        f" for i={prefix}_{first.enum_name},{prefix}_{last.enum_name} do "
                        f"{table}[i]=0x{first.address:04X} end"
                    )
                    start = shared
                    continue
                end = start + 1
                while (
                    end < len(item.labels)
                    and item.labels[end].enum_value
                    == item.labels[end - 1].enum_value + 1
                    and item.labels[end].address > item.labels[end - 1].address
                ):
                    end += 1
                first = item.labels[start]
                lines.append(
                    f" add_data({table},0x{first.address:04X},"
                    f"{prefix}_{first.enum_name},{end-start})"
                )
                start = end
    lines.append("end")
    path.write_text("\n".join(lines) + "\n", encoding="utf-8")


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description="Pack labeled integer records into a PICO-8 __gfx__ blob."
    )
    parser.add_argument("inputs", nargs="+", type=Path, help="input files in packing order")
    parser.add_argument("-o", "--output", type=Path, default=Path("packed_gfx.txt"))
    parser.add_argument("--map-inputs", nargs="+", type=Path, default=[])
    parser.add_argument("--map-output", type=Path, default=Path("packed_map.txt"))
    parser.add_argument("--cart", type=Path, action="append", help="cartridge whose data sections to update")
    parser.add_argument("-i", "--index", type=Path, default=Path("packed_index.txt"))
    parser.add_argument("-e", "--enums", type=Path, default=Path("packed_data.p8"))
    parser.add_argument(
        "-b", "--base-address", type=lambda value: int(value, 0), default=0
    )
    return parser.parse_args()


def main() -> None:
    args = parse_args()
    gfx_files: list[PackedFile] = []
    address = args.base_address

    for path in args.inputs:
        if not path.is_file():
            raise FileNotFoundError(f"Input file not found: {path}")
        packed = pack_file(path, address)
        gfx_files.append(packed)
        address += len(packed.data)
    if address > 0x2000:
        raise ValueError(f"graphics data ends at 0x{address:04X}, beyond 0x1FFF")

    map_files: list[PackedFile] = []
    address = 0x2000
    for path in args.map_inputs:
        if not path.is_file():
            raise FileNotFoundError(f"Input file not found: {path}")
        packed = pack_file(path, address)
        map_files.append(packed)
        address += len(packed.data)
    if address > 0x3000:
        raise ValueError(f"map data ends at 0x{address:04X}, beyond 0x2FFF")

    files = gfx_files + map_files
    assign_ids(files)
    symbols = parse_lua_constants(Path(__file__).resolve().parent.parent / "enums.p8")
    for item in files:
        if item.prefix is not None:
            for label in item.labels:
                symbols[f"{item.prefix}_{label.enum_name}"] = label.enum_value
    for item in files:
        finalize_object_defs(item, symbols)
    gfx_data = [byte for item in gfx_files for byte in item.data]
    map_data = [byte for item in map_files for byte in item.data]
    write_gfx(args.output, gfx_data)
    write_map(args.map_output, map_data)
    for cart in args.cart or []:
        update_cart(cart, args.output, args.map_output)
    write_index(args.index, files)
    write_enums(args.enums, files)

    print(f"Wrote {len(gfx_data)} bytes to {args.output}")
    print(f"Wrote {len(map_data)} bytes to {args.map_output}")
    print(f"Wrote metadata for {len(files)} files to {args.index}")
    print(f"Wrote enums and pointer initialization to {args.enums}\n")
    for item in files:
        print(
            f"PTR_{item.section}_DATA=0x{item.address:04X} "
            f"-- size={len(item.data)}, labels={len(item.labels)}"
        )
        if item.prefix is None and item.labels:
            print(
                f"  warning: could not infer V_/C_/M_/W_/S_ type from "
                f"{item.path.name}; no typed enums generated"
            )


if __name__ == "__main__":
    main()
