function yay --wraps='sudo dnf upgrade --refresh --allowerasing --best' --wraps='sudo dnf upgrade --allowerasing --best' --wraps='sudo dnf upgrade' --description 'alias yay=sudo dnf upgrade'
  sudo dnf upgrade $argv
        
end
