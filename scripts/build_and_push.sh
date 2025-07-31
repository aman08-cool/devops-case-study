#!/usr/bin/env bash
set -euo pipefail

if [[ -z "${GIT_COMMIT:-}" ]]; then
  GIT_COMMIT=$(git rev-parse --short HEAD)
fi

IMAGE="amankube/myapp:$GIT_COMMIT"
echo "[INFO] Building Docker image $IMAGE"
docker build -t $IMAGE .
echo "[INFO] Logging in to DockerHub"
docker login
echo "[INFO] Pushing image to DockerHub"
docker push $IMAGE

