#!/bin/bash
sudo apt-get update && sudo apt-get install -y \
    libzbar-dev \
    libzbar0 \
    zbar-tools \
    build-essential \
    python3-dev \
    gcc
pip install zbar