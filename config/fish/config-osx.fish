if type -q eza
    alias ll "eza -l -g --icons"
    alias llt "eza --tree"
    alias lla "ll -a"
end

# Fzf
set -g FZF_PREVIEW_FILE_CMD "bat --style=numbers --color=always --line-range :500"
set -g FZF_LEGACY_KEYBINDINGS 0
