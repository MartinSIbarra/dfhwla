#!/bin/bash
set -e

docker_hub_user="bishopplusplus"
image_name="alpine-ngrok-nginx-proxy"
image_tag="latest"

docker buildx create --use
docker buildx inspect --bootstrap
docker buildx build \
    --platform linux/amd64,linux/arm64 \
    -t "$docker_hub_user/$image_name:$image_tag" \
    --push .
docker rmi "$docker_hub_user/$image_name:$image_tag" || true
docker pull "$docker_hub_user/$image_name:$image_tag"

# Verifica si hay contenedores que coincidan con el patrón 'buildx' y los elimina
mapfile -t containers < <(docker ps -a --format '{{.Names}}' | grep '^buildx')
if [ ${#containers[@]} -gt 0 ]; then
    docker rm -f "${containers[@]}"
fi
