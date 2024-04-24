function cat --wraps='bat --plain' --wraps='bat -pp' --wraps='bat -p' --description 'alias cat=bat -p'
  bat -p $argv
        
end
