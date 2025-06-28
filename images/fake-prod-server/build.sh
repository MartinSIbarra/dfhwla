#!/bin/sh
set -e

image_name="prod-server"  
image_tag="fake"

docker rmi -f "$image_name:$image_tag" || true
docker build -t "$image_name:$image_tag" .
