#!/bin/bash

SESH="devenv"

if [ -n "$1" ]; then
  SESH="$1"
fi

tmux has-session -t $SESH 2>/dev/null
if [ $? != 0 ]; then
  tmux new-session -d -s $SESH -n "editor"

  # Create a new window for editing with Vim
  tmux send-keys -t $SESH:editor "cd ~/Coding" C-m
  # tmux send-keys -t $SESH:editor "nvim ." C-m

  # Create a new window for running scripts or terminal commands
  tmux new-window -t $SESH -n "terminal"
  tmux send-keys -t $SESH:terminal "cd ~/Coding" C-m
fi

tmux attach-session -t $SESH
