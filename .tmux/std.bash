#!/bin/bash
# A standard session emphasizing vim with two small panes for miscellaneous use e.g. testing/debugging

tmux new-session -d

# Create/size the panes
tmux select-pane -t 0
tmux split-window -v -p 28
tmux split-window -h -p 50

# Open vi and start nerdtree
tmux send-keys -t 0 'vi' Enter
tmux send-keys -t 0 ':NERDTree' Enter

tmux select-pane -t 0

tmux -2 attach-session -d
