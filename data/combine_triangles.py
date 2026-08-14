#!/usr/bin/env python3

"""Combine same-color triangle runs when their union is a convex polygon."""

from __future__ import annotations

import argparse
from dataclasses import dataclass
from pathlib import Path


CMD_COLOR = -1
CMD_POLYGON = -7


@dataclass
class Polygon:
    indices: list[int]
    first: int
    triangles: int = 1


def sections(path: Path) -> dict[str, list[int]]:
    result = {}
    name = None
    for line in path.read_text().splitlines():
        line = line.strip()
        if line.startswith("["):
            name = line[1:-1].lower()
        elif line.startswith("data="):
            result[name] = [int(value) for value in line[5:].split(",")]
    return result


def parse_commands(values: list[int]) -> list[tuple[int, list[int]]]:
    count, position, result = values[0], 1, []
    for _ in range(count):
        opcode, size = values[position : position + 2]
        position += 2
        result.append((opcode, values[position : position + size]))
        position += size
    if position != len(values):
        raise ValueError("command record has trailing values")
    return result


def polygon_area(indices: list[int], vertices: list[tuple[int, int]]) -> int:
    points = [vertices[index - 1] for index in indices]
    return abs(sum(
        x1 * y2 - x2 * y1
        for (x1, y1), (x2, y2) in zip(points, points[1:] + points[:1])
    ))


def edges(indices: list[int]) -> set[tuple[int, int]]:
    return {
        tuple(sorted((a, b)))
        for a, b in zip(indices, indices[1:] + indices[:1])
    }


def convex_hull(
    indices: list[int], vertices: list[tuple[int, int]]
) -> list[int]:
    by_point = {vertices[index - 1]: index for index in indices}
    points = sorted(by_point)
    if len(points) < 3:
        return []

    def cross(a, b, c):
        return (b[0] - a[0]) * (c[1] - a[1]) - (b[1] - a[1]) * (c[0] - a[0])

    lower = []
    for point in points:
        while len(lower) >= 2 and cross(lower[-2], lower[-1], point) <= 0:
            lower.pop()
        lower.append(point)
    upper = []
    for point in reversed(points):
        while len(upper) >= 2 and cross(upper[-2], upper[-1], point) <= 0:
            upper.pop()
        upper.append(point)
    return [by_point[point] for point in lower[:-1] + upper[:-1]]


def merge_pair(
    left: Polygon, right: Polygon, vertices: list[tuple[int, int]]
) -> Polygon | None:
    if not edges(left.indices) & edges(right.indices):
        return None
    hull = convex_hull(left.indices + right.indices, vertices)
    if not hull:
        return None
    if polygon_area(hull, vertices) != (
        polygon_area(left.indices, vertices) + polygon_area(right.indices, vertices)
    ):
        return None
    return Polygon(hull, min(left.first, right.first), left.triangles + right.triangles)


def merge_run(
    triangles: list[list[int]], vertices: list[tuple[int, int]]
) -> list[Polygon]:
    polygons = [Polygon(indices, position) for position, indices in enumerate(triangles)]
    while True:
        choices = []
        for i, left in enumerate(polygons):
            for j in range(i + 1, len(polygons)):
                merged = merge_pair(left, polygons[j], vertices)
                if merged:
                    choices.append((merged.triangles, -len(merged.indices), i, j, merged))
        if not choices:
            break
        _, _, i, j, merged = max(choices)
        polygons[i] = merged
        del polygons[j]
    return sorted(polygons, key=lambda polygon: polygon.first)


def combine_commands(
    commands: list[tuple[int, list[int]]], vertices: list[tuple[int, int]]
) -> tuple[list[tuple[int, list[int]]], int, int]:
    output = []
    current_color = None
    position = merged_triangles = polygons_created = 0

    while position < len(commands):
        opcode, arguments = commands[position]
        if opcode == CMD_COLOR:
            if arguments[0] != current_color:
                current_color = arguments[0]
                output.append((opcode, arguments))
            position += 1
            continue
        if opcode != CMD_POLYGON or len(arguments) != 3:
            output.append((opcode, arguments))
            position += 1
            continue

        triangles = []
        scan = position
        while scan < len(commands):
            scan_opcode, scan_arguments = commands[scan]
            if scan_opcode == CMD_COLOR and scan_arguments == [current_color]:
                scan += 1
            elif scan_opcode == CMD_POLYGON and len(scan_arguments) == 3:
                triangles.append(scan_arguments)
                scan += 1
            else:
                break

        polygons = merge_run(triangles, vertices)
        output.extend((CMD_POLYGON, polygon.indices) for polygon in polygons)
        merged_triangles += sum(polygon.triangles for polygon in polygons if polygon.triangles > 1)
        polygons_created += sum(polygon.triangles > 1 for polygon in polygons)
        position = scan

    return output, merged_triangles, polygons_created


def rewrite(command_path: Path, vertex_path: Path, write: bool) -> tuple[int, int, int]:
    vertex_records = sections(vertex_path)
    source = command_path.read_text().splitlines()
    name = None
    records_changed = merged_triangles = polygons_created = 0

    for line_number, line in enumerate(source):
        stripped = line.strip()
        if stripped.startswith("["):
            name = stripped[1:-1].lower()
        elif stripped.startswith("data="):
            vertex_values = vertex_records[name]
            vertices = list(zip(vertex_values[1::2], vertex_values[2::2]))
            original = parse_commands([int(value) for value in stripped[5:].split(",")])
            combined, merged, created = combine_commands(original, vertices)
            if combined != original:
                records_changed += 1
                values = [len(combined)]
                for opcode, arguments in combined:
                    values.extend((opcode, len(arguments), *arguments))
                source[line_number] = "data=" + ",".join(map(str, values))
            merged_triangles += merged
            polygons_created += created

    if write:
        command_path.write_text("\n".join(source) + "\n")
    return records_changed, merged_triangles, polygons_created


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--write", action="store_true")
    args = parser.parse_args()
    root = Path(__file__).parent
    totals = [0, 0, 0]
    for command_name, vertex_name in (
        ("o_cmds.txt", "o_verts.txt"),
        ("t_cmds.txt", "t_verts.txt"),
    ):
        result = rewrite(root / command_name, root / vertex_name, args.write)
        totals = [a + b for a, b in zip(totals, result)]
        print(
            f"{command_name}: {result[0]} shapes changed; "
            f"{result[1]} triangles -> {result[2]} convex polygons"
        )
    print(
        f"total: {totals[0]} shapes changed; "
        f"{totals[1]} triangles -> {totals[2]} convex polygons"
    )


if __name__ == "__main__":
    main()
