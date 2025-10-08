#!/usr/bin/env bash

# Devtools
set -euo pipefail

if command -v apt-get >/dev/null 2>&1; then
  # Ubuntu / Debian
  sudo apt-get update -y
  sudo DEBIAN_FRONTEND=noninteractive apt-get install -y \
    build-essential \
    libsqlite3-dev \
    libffi-dev \
    libbz2-dev \
    libncurses5-dev \
    libncursesw5-dev \
    libreadline-dev \
    libssl-dev \
    zlib1g-dev \
    wget \
    curl \
    xclip \
    xz-utils
elif command -v yum >/dev/null 2>&1; then
  # RHEL / CentOS / Amazon Linux
  sudo yum -y groupinstall "Development Tools"
  sudo yum -y install \
    sqlite-devel \
    libffi-devel \
    bzip2-devel \
    ncurses-devel \
    readline-devel \
    openssl-devel \
    zlib-devel \
    wget \
    curl \
    xclip \
    xz
else
  echo "Error: neither apt-get nor yum is available on this system." >&2
  exit 1
fi
