#!/usr/bin/env bash
set -euo pipefail

data_dir="$(cd "$(dirname "$0")" && pwd)"
cd "$data_dir"

python3 pack.py \
  w_verts.txt w_cmds.txt o_verts.txt o_cmds.txt t_verts.txt object_defs.txt \
  --map-inputs w_meta.txt waves.txt t_cmds.txt messages.txt \
  --cart ../main.p8 --cart ../shape_viewer.p8
cp packed_data.p8 ../packed_data.p8
