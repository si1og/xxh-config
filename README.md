# xxh config

Portable SSH environment managed by
[`xxh`](https://github.com/xxh/xxh). It installs a prebuilt Linux
Neovim with the configuration from
[`si1og/neovim-config`](https://github.com/si1og/neovim-config).

The remote host does not need Neovim, Stack, GHC or root access. The payload is
stored under the remote xxh home and leaves the system Vim untouched.

## Installation

```sh
git clone https://github.com/si1og/xxh-config.git ~/.config/xxh
sh ~/.config/xxh/install.sh
xxh my-server
```

Inside the xxh shell, `nvim` starts the portable editor and `vim` is an alias
for it. The first editor launch downloads Neovim plugins into the hermetic xxh
home.

The plugin downloads the rolling `xxh-latest` payload published by the
`neovim-config` CI workflow. Its local package contains both Linux x86_64 and
aarch64 payloads; the remote shell selects the matching one using `uname -m`.
