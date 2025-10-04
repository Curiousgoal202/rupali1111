#!/bin/bash
set -e
echo "Building Payment Gateway App..."
python3 -m venv venv
source venv/bin/activate
pip install -r app/requirements.txt
python -m compileall app/
echo "✅ Build successful."
