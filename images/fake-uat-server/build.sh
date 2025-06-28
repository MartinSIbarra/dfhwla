#!/bin/bash
set -e

image_name="uat-server"  
image_tag="fake"

docker rmi -f "$image_name:$image_tag" || true
docker build -t "$image_name:$image_tag" .
