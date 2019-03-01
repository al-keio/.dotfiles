#!/bin/sh

usage_exit() {
  echo "Usage: $0 [-u username] " 1>&2
  exit 1
}

user=""
while getopts u: OPT
do
  case $OPT in
    u)  user="$OPTARG@"
      ;;
    \?) usage_exit
      ;;
  esac
done

shift $((OPTIND - 1))

session="abilenes"
### tmuxのセッションを作成
tmux new-session -d -s $session

### 各ホストにsshログイン
# 最初の1台はsshするだけ
tmux send-keys "ssh ${user}abilene01" C-m
shift

# 残りはpaneを作成してからssh
for i in `seq 2 12`;do
  tmux split-window
  tmux select-layout tiled
  num=`printf %02d $i`
  tmux send-keys "ssh ${user}abilene${num}" C-m
done

### 最初のpaneを選択状態にする
tmux select-pane -t 0

### paneの同期モードを設定
tmux set-window-option synchronize-panes on

### セッションにアタッチ
tmux attach-session -t $session
