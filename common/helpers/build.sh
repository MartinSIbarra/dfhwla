#!/bin/sh
set -e

image_path=$1
image_name=$2


files=()
for file in "../../common/scripts/*"; do
    cp "$file" ./scripts/
    files+=("$file")
done

docker rmi -f "$image_name" || true
docker build -t "$image_name" "$image_path"
