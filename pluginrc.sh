plugin_root="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
case "$(uname -m)" in
  x86_64|amd64) plugin_arch="x86_64" ;;
  aarch64|arm64) plugin_arch="aarch64" ;;
  *)
    printf 'xxh Neovim does not support architecture %s\n' "$(uname -m)" >&2
    return 1
    ;;
esac
plugin_dir="$plugin_root/$plugin_arch"
export PATH="$plugin_dir/bin:$PATH"
export EDITOR="nvim"
export VISUAL="nvim"
alias vim="nvim"
