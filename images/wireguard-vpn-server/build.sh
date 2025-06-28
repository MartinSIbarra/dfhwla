#!/bin/sh
set -e

image_name="alpine-wg-vpn-server"  
image_tag="latest"

docker rmi -f "$image_name:$image_tag" || true
docker build -t "$image_name:$image_tag" .
