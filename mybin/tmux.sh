#!/bin/bash

if [[ $# -ne 1 ]]; then
  echo "usage: tmux.sh <pane-num>"
  exit
fi

### tmuxのセッションを作成
tmux new-session -d

for i in `seq 2 $1`;do
  tmux split-window
  tmux select-layout tiled
done

### 最初のpaneを選択状態にする
tmux select-pane -t 0

### paneの同期モードを設定
tmux set-window-option synchronize-panes on

tmux a
