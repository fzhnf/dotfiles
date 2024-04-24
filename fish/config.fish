if status is-interactive
    # Commands to run in interactive sessions can go here
    zoxide init fish --cmd cd | source

    set -x GOPATH $HOME/.go
    set -x EDITOR nvim
end


function fish_greeting
    toilet --termwidth -f smbraille -F border "Bismillah"  | lolcat
end

function yy
	set tmp (mktemp -t "yazi-cwd.XXXXXX")
	yazi $argv --cwd-file="$tmp"
	if set cwd (cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
		cd -- "$cwd"
	end
	rm -f -- "$tmp"
end



if status --is-login
    cat ~/.cache/wal/sequences 
end &>/dev/null
