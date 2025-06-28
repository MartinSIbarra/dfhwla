#!/bin/sh
set -e

image_name="alpine-ngrok-nginx-proxy"  
image_tag="latest"

files=()
for file in "../../common/scripts/*"; do
    cp "$file" ./scripts/
    files+=("$file")
done

docker rmi -f "$image_name:$image_tag" || true
docker build -t "$image_name:$image_tag" .
