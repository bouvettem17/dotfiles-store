set fish_greeting ""

set -gx EDITOR nvim
set -gx TERMINFO (brew --prefix ncurses)/share/terminfo
set -gx TERMINFO_DIRS /usr/local/opt/ncurses/share/terminfo:/usr/share/terminfo
set -gx XDG_CONFIG_HOME $HOME/.config

# aliases
alias ls "ls -p -G"
alias la "ls -A"
alias ll "ls -l"
alias lla "ll -A"
alias ide1 "source ~/Development/shell_scripts/tmux_scripts/ide1.sh"
alias ide2 "source ~/Development/shell_scripts/tmux_scripts/ide2.sh"
alias g git
command -qv nvim && alias vim nvim

# brazil
alias bb brazil-build
alias bba "brazil-build apollo-pkg"
alias bre brazil-runtime-exec
alias brc brazil-recursive-cmd
alias bws "brazil ws"
alias bwsuse "bws use --gitMode -p"
alias bwscreate "bws create -n"
alias bbr "brc brazil-build"
alias bball "brc --allPackages"
alias bbb "brc --allPackages brazil-build"
alias bbra "bbr apollo-pkg"


# paths
fish_add_path bin
fish_add_path ~/bin
fish_add_path ~/.local/bin
fish_add_path ~/.toolbox/bin
fish_add_path /usr/local/opt/llvm/bin
fish_add_path ~/.rbenv/shims

# other
abbr weather "curl -s wttr.in/San+Diego | grep -v Follow"

# os-specific config
switch (uname)
    case Darwin
        source (dirname (status --current-filename))/config-osx.fish
    case Linux
        source (dirname (status --current-filename))/config-linux.fish
    case '*'
        source (dirname (status --current-filename))/config-windows.fish
end
