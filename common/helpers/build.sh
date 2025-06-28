#!/bin/bash
set -e

image_name=$1
image_tag=$2

[ -z "$image_name" ] && { echo "Image name is required"; exit 1; }
[ -z "$image_tag" ] && { echo "Image tag is required"; exit 1; }

common_scripts=(./common/scripts/*)
image_path="./images/$image_name"
image_scripts_path="$image_path/scripts"

if [ ! -d "$image_scripts_path" ]; then
    for script in "${common_scripts[@]}"; do
        cp "$script" "$image_scripts_path/"
    done
fi

docker rmi -f "$image_name:$image_tag" 2>/dev/null || true
docker build -t "$image_name:$image_tag" "$image_path"

if [ ! -d "$image_scripts_path" ]; then
    for script in "${common_scripts[@]}"; do
        rm "$image_scripts_path/$script"
    done
fi
