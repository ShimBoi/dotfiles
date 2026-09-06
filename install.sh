#!/usr/bin/env bash
# Bootstrap this machine to match the configured setup: Homebrew packages,
# symlinked dotfiles, tmux plugins, and the nvim config (a separate repo).
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
NVIM_REPO="git@github.com:ShimBoi/kickstart.nvim.git"

echo "==> Checking Homebrew"
if ! command -v brew >/dev/null 2>&1; then
  echo "Homebrew not found. Install it first: https://brew.sh"
  exit 1
fi

echo "==> Installing packages from Brewfile"
brew bundle --file="$DOTFILES_DIR/Brewfile"

link() {
  local src="$1" dest="$2"
  if [ -e "$dest" ] && [ ! -L "$dest" ]; then
    echo "Backing up existing $dest -> $dest.bak"
    mv "$dest" "$dest.bak"
  fi
  mkdir -p "$(dirname "$dest")"
  ln -sfn "$src" "$dest"
  echo "Linked $dest -> $src"
}

echo "==> Symlinking dotfiles"
link "$DOTFILES_DIR/zsh/.zshrc"      "$HOME/.zshrc"
link "$DOTFILES_DIR/tmux/.tmux.conf" "$HOME/.tmux.conf"
link "$DOTFILES_DIR/git/.gitconfig"  "$HOME/.gitconfig"
link "$DOTFILES_DIR/ghostty/config"  "$HOME/.config/ghostty/config"

echo "==> Cloning tmux plugins"
mkdir -p "$HOME/.tmux/plugins"
clone_plugin() {
  local name="$1" url="$2"
  if [ ! -d "$HOME/.tmux/plugins/$name" ]; then
    git clone --depth 1 "$url" "$HOME/.tmux/plugins/$name"
  else
    echo "$name already present, skipping"
  fi
}
clone_plugin "vim-tmux-navigator" "https://github.com/christoomey/vim-tmux-navigator"
clone_plugin "tmux-resurrect"     "https://github.com/tmux-plugins/tmux-resurrect"
clone_plugin "tmux-continuum"     "https://github.com/tmux-plugins/tmux-continuum"

echo "==> Neovim config"
if [ ! -d "$HOME/.config/nvim" ]; then
  git clone "$NVIM_REPO" "$HOME/.config/nvim"
else
  echo "$HOME/.config/nvim already exists, skipping clone"
fi

cat << 'EOF'

==> Done.

Next steps:
  1. Fully quit and restart Ghostty (Cmd+Q) to pick up the new config.
  2. Open a new terminal, start tmux (`tmux`), and reload it once with
     `prefix + r` if anything looks stale.
  3. Open nvim - lazy.nvim and Mason will auto-install plugins and LSP
     tools (basedpyright, ruff, debugpy, stylua, etc.) on first launch.
     This needs internet access and will take a minute or two.
EOF
