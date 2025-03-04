#!/bin/sh
echo -ne '\033c\033]0;LostSpring\a'
base_path="$(dirname "$(realpath "$0")")"
"$base_path/LostSpring.x86_64" "$@"
