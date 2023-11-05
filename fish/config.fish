set fish_greeting ""

set -gx TERM xterm-256color

# theme
set -g theme_color_scheme terminal-dark
set -g fish_prompt_pwd_dir_length 1
set -g theme_display_user yes
set -g theme_hide_hostname no
set -g theme_hostname always

# aliases
alias ls "ls -p -G"
alias la "ls -A"
alias ll "ls -l"
alias lla "ll -A"
alias ide1 "source ~/Development/shell_scripts/ide1.sh"
alias ide2 "source ~/Development/shell_scripts/ide2.sh"
alias g git
command -qv nvim && alias vim nvim

# brazil
alias bb "brazil-build"
alias bba "brazil-build apollo-pkg"
alias bre "brazil-runtime-exec"
alias brc "brazil-recursive-cmd"
alias bws "brazil ws"
alias bwsuse "bws use --gitMode -p"
alias bwscreate "bws create -n"
alias bbr "brc brazil-build"
alias bball "brc --allPackages"
alias bbb "brc --allPackages brazil-build"
alias bbra "bbr apollo-pkg"

set -gx EDITOR nvim

rtx activate fish | source

set -gx PATH bin $PATH 
set -gx PATH ~/bin $PATH
set -gx PATH ~/.local/bin $PATH
set -gx PATH ~/.toolbox/bin $PATH
set -gx PATH ~/usr/local/opt/llvm/bin $PATH
set -gx PATH $HOME/.rbenv/shims $PATH

switch (uname)
  case Darwin
    source (dirname (status --current-filename))/config-osx.fish
  case Linux
    source (dirname (status --current-filename))/config-linux.fish
  case '*'
    source (dirname (status --current-filename))/config-windows.fish
end
