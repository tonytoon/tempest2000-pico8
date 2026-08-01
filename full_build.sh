#!/usr/bin/env bash
set -euo pipefail

project_dir="$(cd "$(dirname "$0")" && pwd)"

"$project_dir/data/pack.sh"
"$project_dir/build.sh"
