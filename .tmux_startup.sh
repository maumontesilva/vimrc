#!/bin/bash

MAIN_SESSION="neovim"

tmux new-session -d -s $MAIN_SESSION -n neovim
tmux send-keys -t $MAIN_SESSION:0 'cd ~/workspaces/onefs && nv' C-m
tmux select-pane -t $MAIN_SESSION:0.0
tmux select-pane -T "nvim-pane"

tmux new-window -t $MAIN_SESSION:1 -n split
tmux select-window -t $MAIN_SESSION:1
tmux split-window -h

tmux select-pane -t $MAIN_SESSION:1.0
tmux select-pane -T "build container"
tmux send-keys -t $MAIN_SESSION:1.0 'cd ~/workspaces/onefs && docker container start build && clear && docker container exec -it build bash' C-m

tmux select-pane -t $MAIN_SESSION:1.1
tmux select-pane -T "wsl terminal"
tmux send-keys -t $MAIN_SESSION:1.1 'cd ~/workspaces/onefs && clear' C-m

# Always attach to the session
tmux attach-session -t $MAIN_SESSION

