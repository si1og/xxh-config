#!/bin/sh

set -eu

source="xxh-plugin-prerun-neovim+git+https://github.com/si1og/xxh-config.git"
xxh +RI "$source"
printf 'Installed the xxh Neovim package. Connect with: xxh <host>\n'
