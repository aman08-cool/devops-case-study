#!/usr/bin/env bash
set -euo pipefail

echo "[INFO] Removing dangling Docker images..."
docker image prune -f

echo "[INFO] Pruning unused containers..."
docker container prune -f

echo "[INFO] Pruning unused Docker networks..."
docker network prune -f

