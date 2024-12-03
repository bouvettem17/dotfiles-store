set fish_greeting ""

set -gx EDITOR nvim
set -gx TERMINFO (brew --prefix ncurses)/share/terminfo
set -gx TERMINFO_DIRS /usr/local/opt/ncurses/share/terminfo:/usr/share/terminfo
set -gx XDG_CONFIG_HOME $HOME/.config
set -gx JAVA_HOME /Library/Java/JavaVirtualMachines/amazon-corretto-21.jdk/Contents/Home
set -x LG_CONFIG_FILE /Users/mjbouvet/.config/lazygit/config.yml,/Users/mjbouvet/.cache/nvim/lazygit-theme.yml

command -qv nvim && alias vim nvim

# Enhanced Shell Navigation
alias ls "ls -p -G"
alias la "ls -A"
alias ll "ls -l"
alias lla "ll -A"

# Tmux scripts
alias ide1 "source ~/Development/shell_scripts/tmux_scripts/ide1.sh"
alias ide2 "source ~/Development/shell_scripts/tmux_scripts/ide2.sh"

# Wezterm tab name
alias stt "wezterm cli set-tab-title"

# Git
alias g git
alias gc "git checkout"
alias gcm "git checkout mainline"
alias gcb "git checkout -b"
alias lazygit "TERM=xterm-256color command lazygit"
alias gg lazygit

# brazil
alias bb brazil-build
alias bbc "bb clean"
alias bba "brazil-build apollo-pkg"
alias bre brazil-runtime-exec
alias brc brazil-recursive-cmd
alias bws "brazil ws"
alias bwsc "brazil ws clean"
alias bwsuse "bws use -p"
alias bwscreate "bws create -n"
alias bbr "brc brazil-build"
alias bball "brc --allPackages"
alias bbb "brc --allPackages brazil-build"
alias bbra "bbr apollo-pkg"

# bemol
alias bemol "bemol --watch --verbose"

# auth
alias auth "kinit -f && mwinit -s --fido2"

# paths
fish_add_path bin
fish_add_path ~/bin
fish_add_path ~/.local/bin
fish_add_path ~/.toolbox/bin
fish_add_path /usr/local/opt/llvm/bin
fish_add_path ~/.rbenv/shims

# other
abbr weather "curl -s \"wttr.in/San+Diego?u\" | grep -v Follow"

# os-specific config
switch (uname)
    case Darwin
        source (dirname (status --current-filename))/config-osx.fish
    case Linux
        source (dirname (status --current-filename))/config-linux.fish
    case '*'
        source (dirname (status --current-filename))/config-windows.fish
end
