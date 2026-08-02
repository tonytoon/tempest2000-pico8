#!/usr/bin/env bash
set -euo pipefail

project_dir="$(cd "$(dirname "$0")" && pwd)"
cd "$project_dir"

.venv/bin/python ./shrinko8/shrinko8.py \
	main.p8 t2k.p8.png \
	--merge data/packed_gfx.txt gfx p8 \
	--merge data/packed_map.txt map p8 \
	--merge music.txt music p8 \
	--merge sfx.txt sfx p8 \
	--label cart_label.png \
	--minify -ob -c
