#!/usr/bin/env python3

"""Replace packed shape polygon commands with geometry-preserving triangles."""

from __future__ import annotations

import argparse
from pathlib import Path


CMD_POL = -7
CMD_TRI = -8


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


def commands(values: list[int]) -> list[tuple[int, list[int]]]:
    count, position, result = values[0], 1, []
    for _ in range(count):
        opcode, size = values[position : position + 2]
        position += 2
        result.append((opcode, values[position : position + size]))
        position += size
    if position != len(values):
        raise ValueError("command record has trailing values")
    return result


def cross(a, b, c):
    return (b[0] - a[0]) * (c[1] - b[1]) - (b[1] - a[1]) * (c[0] - b[0])


def inside(p, a, b, c, winding):
    return all(winding * cross(x, y, p) >= 0 for x, y in ((a, b), (b, c), (c, a)))


def triangulate(indices: list[int], vertices: list[tuple[int, int]]) -> list[list[int]]:
    remaining = list(indices)
    area = sum(
        vertices[a - 1][0] * vertices[b - 1][1]
        - vertices[b - 1][0] * vertices[a - 1][1]
        for a, b in zip(indices, indices[1:] + indices[:1])
    )
    if area == 0:
        raise ValueError("polygon has zero signed area")
    winding = 1 if area > 0 else -1
    result = []

    while len(remaining) > 3:
        for position, current in enumerate(remaining):
            previous = remaining[position - 1]
            following = remaining[(position + 1) % len(remaining)]
            a, b, c = (vertices[index - 1] for index in (previous, current, following))
            if winding * cross(a, b, c) <= 0:
                continue
            if any(
                inside(vertices[index - 1], a, b, c, winding)
                for index in remaining
                if index not in (previous, current, following)
            ):
                continue
            result.append([previous, current, following])
            del remaining[position]
            break
        else:
            raise ValueError("polygon is not simple or cannot be triangulated")

    result.append(remaining)
    return result


def rewrite(command_path: Path, vertex_path: Path, write: bool) -> tuple[int, int]:
    vertex_records = sections(vertex_path)
    source = command_path.read_text().splitlines()
    name = None
    polygon_count = triangle_count = 0

    for line_number, line in enumerate(source):
        stripped = line.strip()
        if stripped.startswith("["):
            name = stripped[1:-1].lower()
        elif stripped.startswith("data="):
            vertex_values = vertex_records[name]
            count, coords = vertex_values[0], vertex_values[1:]
            if len(coords) != count * 2:
                raise ValueError(f"{vertex_path}: malformed vertex record {name}")
            vertices = list(zip(coords[::2], coords[1::2]))
            rewritten = []
            for opcode, arguments in commands(
                [int(value) for value in stripped[5:].split(",")]
            ):
                if opcode == CMD_POL:
                    triangles = triangulate(arguments, vertices)
                    rewritten.extend((CMD_TRI, triangle) for triangle in triangles)
                    polygon_count += 1
                    triangle_count += len(triangles)
                else:
                    rewritten.append((opcode, arguments))
            values = [len(rewritten)]
            for opcode, arguments in rewritten:
                values.extend((opcode, len(arguments), *arguments))
            source[line_number] = "data=" + ",".join(map(str, values))

    if write:
        command_path.write_text("\n".join(source) + "\n")
    return polygon_count, triangle_count


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--write", action="store_true")
    args = parser.parse_args()
    root = Path(__file__).parent
    total_polygons = total_triangles = 0
    for command_name, vertex_name in (("o_cmds.txt", "o_verts.txt"), ("t_cmds.txt", "t_verts.txt")):
        polygons, triangles = rewrite(root / command_name, root / vertex_name, args.write)
        print(f"{command_name}: {polygons} polygons -> {triangles} triangles")
        total_polygons += polygons
        total_triangles += triangles
    print(f"total: {total_polygons} polygons -> {total_triangles} triangles")


if __name__ == "__main__":
    main()
