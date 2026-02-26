# See https://www.nushell.sh/book/configuration.html
# You can also pretty-print and page through the documentation for configuration
# options using:
#     config nu --doc | nu-highlight | less -R

# Editor for nushell
$env.config.buffer_editor = "nvim" 
# Set default editor globally
$env.EDITOR = "nvim"
$env.VISUAL = "nvim"

# Standard library path helper
use std/util "path add"

# Android SDK tools like adb, etc.
$env.ANDROID_HOME = ($env.HOME | path join "Android" "Sdk")
path add ($env.ANDROID_HOME | path join "emulator")
path add ($env.ANDROID_HOME | path join "platform-tools")
path add ($env.ANDROID_HOME | path join "cmdline-tools" "latest" "bin")

# Dart tools
path add ($env.HOME | path join ".pub-cache" "bin")

# Go tools
$env.GOPATH = ($env.HOME | path join ".go")
path add ($env.GOPATH | path join "bin")

# pnpm
$env.PNPM_HOME = ($env.HOME | path join ".local" "share" "pnpm")
path add $env.PNPM_HOME

# bun
$env.BUN_INSTALL = ($env.HOME | path join ".bun")
path add ($env.BUN_INSTALL | path join "bin")

# Composer (PHP)
path add ($env.HOME | path join ".composer" "vendor" "bin")

# mise 
# WARN: run these two lines first before using it:
# let mise_path = $nu.default-config-dir | path join mise.nu
# ^mise activate nu | save $mise_path --force
use ($nu.default-config-dir | path join mise.nu)


# prompt style
$env.PROMPT_COMMAND = {||
    let user = (whoami)
    let host = (sys host | get hostname)
    
    # Get path relative to home with ~ prefix
    let path = (pwd | str replace $env.HOME '~')
    
    # Shorten path like fish (first char of each dir except last)
    let parts = ($path | path split)
    let short_path = ($parts | enumerate | each {|it|
        if $it.index == (($parts | length) - 1) {
            $it.item
        } else {
            ($it.item | str substring 0..0)
        }
    } | path join)
    
    # Get git branch if in repo
    let branch = (do -i { git rev-parse --abbrev-ref HEAD } | complete | get stdout | str trim)
    let git_part = if ($branch | is-not-empty) { 
        $" \((ansi white)($branch)(ansi reset)\)" 
    } else { 
        "" 
    }
    
    $"(ansi green)($user)(ansi reset)@(ansi blue)($host)(ansi reset) (ansi yellow)($short_path)(ansi reset)($git_part)"
}

$env.PROMPT_INDICATOR = {|| $"(ansi white)> (ansi reset)" }





# zoxide init
zoxide init nushell --cmd cd | save -f ~/.zoxide.nu

$env.config.show_banner = false #disable default banner
let banner = "┌────────────────────────┐
│ ⣏⡱ ⠄ ⢀⣀ ⣀⣀  ⠄ ⡇ ⡇ ⢀⣀ ⣇⡀│
│ ⠧⠜ ⠇ ⠭⠕ ⠇⠇⠇ ⠇ ⠣ ⠣ ⠣⠼ ⠇⠸│
└────────────────────────┘
"
echo $banner | lolcat # show banner

# source zoxide config
source ~/.zoxide.nu

# source theme config
source ($nu.default-config-dir  | path join "theme/catppuccin_mocha.nu")



# alias ls = eza --icons --git-ignore
alias ll = ls -l
alias la = ls -a
alias tree = eza --tree
alias yay = sudo dnf upgrade

def --env y [...args] {
	let tmp = (mktemp -t "yazi-cwd.XXXXXX")
	^yazi ...$args --cwd-file $tmp
	let cwd = (open $tmp)
	if $cwd != $env.PWD and ($cwd | path exists) {
		cd $cwd
	}
	rm -fp $tmp
}
