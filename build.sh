#!/usr/bin/env bash

set -euo pipefail

kernel="linux"
arch="x86_64"
quiet=0

while getopts "A:K:q" option; do
  case "$option" in
    A) arch="$OPTARG" ;;
    K) kernel="$OPTARG" ;;
    q) quiet=1 ;;
  esac
done

kernel="$(printf '%s' "$kernel" | tr '[:upper:]' '[:lower:]')"
case "$arch" in
  amd64) arch="x86_64" ;;
esac

if [[ "$kernel" != "linux" || "$arch" != "x86_64" ]]; then
  printf 'xxh Neovim supports Linux x86_64, got %s %s\n' "$kernel" "$arch" >&2
  exit 1
fi

plugin_dir="$(cd "$(dirname "$0")" && pwd)"
build_dir="$plugin_dir/build"
asset="xxh-neovim-linux-x86_64.tar.gz"
url="https://github.com/si1og/neovim-config/releases/download/xxh-latest/$asset"

rm -rf "$build_dir"
mkdir -p "$build_dir"

if [[ "$quiet" -eq 0 ]]; then
  printf 'Downloading prebuilt Neovim environment for Linux x86_64...\n'
fi
curl --fail --location --silent --show-error "$url" | tar -xz -C "$build_dir"

cp "$plugin_dir/pluginrc.sh" "$build_dir/pluginrc.sh"
cp "$plugin_dir/pluginrc.zsh" "$build_dir/pluginrc.zsh"
