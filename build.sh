#!/usr/bin/env bash

set -euo pipefail

kernel="linux"
quiet=0

while getopts "A:K:q" option; do
  case "$option" in
    A) : ;; # The package contains payloads for every supported remote architecture.
    K) kernel="$OPTARG" ;;
    q) quiet=1 ;;
  esac
done

kernel="$(printf '%s' "$kernel" | tr '[:upper:]' '[:lower:]')"
if [[ "$kernel" != "linux" ]]; then
  printf 'xxh Neovim supports Linux only, got %s\n' "$kernel" >&2
  exit 1
fi

plugin_dir="$(cd "$(dirname "$0")" && pwd)"
build_dir="$plugin_dir/build"

rm -rf "$build_dir"
mkdir -p "$build_dir"

for arch in x86_64 aarch64; do
  asset="xxh-neovim-linux-$arch.tar.gz"
  url="https://github.com/si1og/neovim-config/releases/download/xxh-latest/$asset"
  mkdir -p "$build_dir/$arch"

  if [[ "$quiet" -eq 0 ]]; then
    printf 'Downloading prebuilt Neovim environment for Linux %s...\n' "$arch"
  fi
  curl --fail --location --silent --show-error "$url" \
    | tar -xz -C "$build_dir/$arch"
done

cp "$plugin_dir/pluginrc.sh" "$build_dir/pluginrc.sh"
cp "$plugin_dir/pluginrc.zsh" "$build_dir/pluginrc.zsh"
