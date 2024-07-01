#!/usr/bin/zsh
project_path=$(zoxide query --interactive)
selected_name=$(basename $project_path)
tmux new-session -d -s $selected_name -c $project_path

mamba=$(micromamba env list | tail -n  +3 | awk '{print $1}' | fzf)
tmux send-keys -t $selected_name.0 "micromamba activate $mamba" ENTER

filepath=$(find $project_path | fzf)
tmux send-keys -t $selected_name.0 "nvim $filepath" ENTER

tmux attach -t $selected_name
