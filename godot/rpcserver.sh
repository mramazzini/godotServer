#!/bin/sh
echo -ne '\033c\033]0;teramon3\a'
base_path="$(dirname "$(realpath "$0")")"
"$base_path/rpcserver.x86_64" "$@"
