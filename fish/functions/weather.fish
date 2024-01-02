function weather --wraps='curl wttr.in/balikpapan' --description 'alias weather=curl wttr.in/balikpapan'
  curl wttr.in/balikpapan $argv
        
end
