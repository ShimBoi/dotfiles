
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/jay/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/jay/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/jay/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/jay/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# starship prompt
eval "$(starship init zsh)"

# zoxide (smart cd)
eval "$(zoxide init zsh)"

# fzf (fuzzy finder: ctrl+r history, ctrl+t files, alt+c cd)
eval "$(fzf --zsh)"

# ls
alias l='eza -lah'
alias la='eza -lAh'
alias ll='eza -lh'
alias ls='eza -G'

# modern replacements
alias cat='bat --paging=never --style=plain'
alias find='fd'

# git
alias lg='lazygit'

# nvim
alias vim='nvim'
alias vi='nvim'
alias v='nvim'

# tmux
alias tl='tmux ls'
alias tn='tmux new -s'
alias ta='tmux a -t'

alias school='cd ~/Documents/College/Fall2026/'

# Run a GUI (Tkinter etc.) Python script and force its window to the front.
# Needed because a plain `python script.py` from the terminal doesn't get
# treated as a foreground app by macOS, so its window opens behind everything.
pyrun() {
  python "$@" &
  local pid=$!
  sleep 0.5
  osascript -e "tell application \"System Events\" to set frontmost of (first process whose unix id is $pid) to true" 2>/dev/null
  wait $pid
}

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/jay/Documents/College/Fall2025/Cloud-Native-Computing/assignment4/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/jay/Documents/College/Fall2025/Cloud-Native-Computing/assignment4/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/jay/Documents/College/Fall2025/Cloud-Native-Computing/assignment4/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/jay/Documents/College/Fall2025/Cloud-Native-Computing/assignment4/google-cloud-sdk/completion.zsh.inc'; fi

# Added by Antigravity
export PATH="/Users/jay/.antigravity/antigravity/bin:$PATH"

# zsh-autosuggestions
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# zsh-syntax-highlighting (must be sourced last)
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
