# if status is-interactive
#     # Commands to run in interactive sessions can go here
# end

alias cd=z

set -x GOPATH $HOME/.go

set -x BAT_THEME "Catppuccin-mocha"

function fish_greeting
    toilet --termwidth -f smbraille -F border "Bismillah"  | lolcat
end

