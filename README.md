# dotfiles

Terminal setup: Ghostty + tmux + zsh + git, tuned for a Python workflow.
Neovim config lives separately at
[ShimBoi/kickstart.nvim](https://github.com/ShimBoi/kickstart.nvim) (a fork
of kickstart.nvim) since it's already its own repo — `install.sh` clones it
into place automatically.

## What's here

| File | Purpose |
|---|---|
| `zsh/.zshrc` | starship, zoxide, fzf, aliases, autosuggestions/syntax-highlighting |
| `tmux/.tmux.conf` | prefix `Ctrl+a`, vi copy-mode + pbcopy clipboard, mouse on |
| `git/.gitconfig` | delta as pager, zdiff3 conflict style |
| `ghostty/config` | theme, opacity, `macos-option-as-alt`, quick-terminal keybind |
| `Brewfile` | every CLI tool / cask this setup depends on |
| `install.sh` | symlinks everything into place + clones tmux plugins + nvim |

## Fresh machine setup

```sh
git clone https://github.com/ShimBoi/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh
```

Requires [Homebrew](https://brew.sh) to already be installed. The script is
safe to re-run — existing real files get backed up to `<file>.bak` before
being replaced with a symlink, and steps that already exist (plugins, the
nvim clone) are skipped.

After it finishes: fully restart Ghostty (`Cmd+Q`), then open `nvim` once
so lazy.nvim + Mason can install plugins and LSP tools (needs internet).
