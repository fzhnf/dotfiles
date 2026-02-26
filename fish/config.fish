# Commands to run in interactive sessions
if status is-interactive
    # Editor
    set -gx EDITOR nvim
    set -gx VISUAL nvim

    # Android SDK tools (adb, etc)
    set -gx ANDROID_HOME $HOME/Android/Sdk
    fish_add_path $ANDROID_HOME/emulator
    fish_add_path $ANDROID_HOME/platform-tools
    fish_add_path $ANDROID_HOME/cmdline-tools/latest/bin

    # Flutter 
    fish_add_path $HOME/.Flutter/flutter/bin

    # Dart tools (e.g., flutterfire_cli)
    fish_add_path $HOME/.pub-cache/bin

    # Go tools (e.g., lazygit, lazydocker)
    set -gx GOPATH $HOME/.go
    fish_add_path $GOPATH/bin

    # pnpm
    set -gx PNPM_HOME $HOME/.local/share/pnpm
    fish_add_path $PNPM_HOME

    # bun
    set -gx BUN_INSTALL "$HOME/.bun"
    fish_add_path $BUN_INSTALL/bin

    # Composer (PHP)
    fish_add_path $HOME/.composer/vendor/bin

    # Zoxide for directory navigation
    zoxide init fish --cmd cd | source

    # mise activation
    mise activate fish | source
end

function fish_greeting
    set -l banner '┌────────────────────────┐
│ ⣏⡱ ⠄ ⢀⣀ ⣀⣀  ⠄ ⡇ ⡇ ⢀⣀ ⣇⡀│
│ ⠧⠜ ⠇ ⠭⠕ ⠇⠇⠇ ⠇ ⠣ ⠣ ⠣⠼ ⠇⠸│
└────────────────────────┘
'
    printf %s $banner | lolcat
end
