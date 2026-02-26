function cat --wraps='bat --paging=never' --wraps='bat --paging=never  --style=-grid,+snip,-numbers' --description 'alias cat=bat --paging=never  --style=-grid,+snip,-numbers'
    bat --paging=never  --style=-grid,+snip,-numbers $argv
end
