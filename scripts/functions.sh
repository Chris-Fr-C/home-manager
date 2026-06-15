# For management of suspended processes.
fgf() {
local job
job=$(jobs -l | fzf --ansi | awk '{print $1}' | tr -d '[]')
if [ -n "$job" ]; then
  fg %"$job"
fi
}
# Or with gum 
fgg() {
# List jobs with job number + command
local job
job=$(jobs -l | awk '{print "[" $1 "] " substr($0, index($0,$3)) }' \
      | gum choose --height 10)

if [ -n "$job" ]; then
  # Extract job number between brackets
  local job_num=$(echo "$job" | grep -oP '\[\K[0-9]+')
  fg %"$job_num"
fi
}

cfg(){
cd ~/.config/home-manager
}
cfge(){
nvim ~/.config/home-manager/dotfiles/dot_config/nvim/init.lua
}


refresh() {
  local dir=~/.config/home-manager
  # Use fd to list .nix files in the folder, non-recursive
  local file
  file=$(fd --type f --extension nix . "$dir" | xargs -n1 basename | gum choose --height 10)

  if [ -n "$file" ]; then
      echo "Switching to $file..."
      home-manager switch -f "$dir/$file"
  else
      echo "No file selected."
  fi
}
term(){
ttyd -p 9001 -t fontFamily="JetBrainsMono Nerd Font" --writable zsh & disown
}

