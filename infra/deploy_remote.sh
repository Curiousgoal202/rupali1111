#!/bin/bash
set -euo pipefail

ARTIFACT="$1"
APP_NAME="payment-gateway"
PORT="5000"
BASE_DIR="/home/deployer/${APP_NAME}"

sudo mkdir -p "$BASE_DIR"
sudo tar -xzf "$ARTIFACT" -C "$BASE_DIR"

cd "$BASE_DIR"
python3 -m venv venv
source venv/bin/activate
pip install -r app/requirements.txt

sudo systemctl daemon-reload
sudo systemctl restart payment-gateway.service
