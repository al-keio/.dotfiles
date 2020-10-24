# slack終了通知
# https://qiita.com/izumin5210/items/c683cb6addc58cae59b6
# 同じディレクトリに.tmpを抜いたファイル名にコピーして使用すること

# 設定変数読み込み(ない場合はテンプレートからコピー)
FILE_DIR=`dirname $0`
if [ ! -e ${FILE_DIR}/notify.env ]; then
  cp ${FILE_DIR}/notify.env.tmpl ${FILE_DIR}/notify.env
  echo "notify.zsh: notify env file copied"
fi
source ${FILE_DIR}/notify.env

if [ -z "${SLACK_WEBHOOK_URL}" ]; then
  echo "notify.zsh: SLACK_WEBHOOK_URL is empty !!!"
  echo "Edit 'SLACK_WEBHOOK_URL' or set 'SLACK_NOTIF_DISABLED' to any value at '${FILE_DIR}/notify.env'"
fi

function notify_preexec {
  notif_prev_executed_at=`date`
  notif_prev_command=$2
}

function notify_precmd {
  notif_status=$?

  [[ -z $notif_prev_command ]] && return # 起動時は通知しない(preexecで定義される変数で判断)

  ### デタッチされたtmuxセッション上でコマンドが終了したら問答無用で通知
  # 現在のセッションがデタッチされているか(attach: 0，detach: 1)
  local on_detached_tmux_session
  if [ -z $TMUX ]; then
    # tmuxのセッションにいない時
    on_detached_tmux_session=0
  else
    local tmux_session_name=`tmux display-message -p '#S'` # 現在のセッション名
    on_detached_tmux_session=`tmux ls -F "#{session_name}: #{session_attached}" | grep "${tmux_session_name}: 0" | wc -l`
  fi

  if [ -n "${SLACK_WEBHOOK_URL}" ] && [ $TTYIDLE -gt ${SLACK_NOTIF_THRESHOLD:-180} -o $on_detached_tmux_session -eq 1 ] && [ $notif_status -ne 130 ] && [ $notif_status -ne 146 ] && [ -z ${SLACK_NOTIF_DISABLED} ]; then
    local elapsed_time
    tty_idle=${TTYIDLE}
    local days=$(( ${tty_idle} / 60 / 60 / 24 ))
    local hours=$(( ${tty_idle} / 60 / 60 % 24 ))
    local minutes=$(( ${tty_idle} / 60 % 60 ))
    local seconds=$(( ${tty_idle} % 60 ))
    (( days > 0 )) && elapsed_time+="${days}d "
    (( hours > 0 )) && elapsed_time+="${hours}h "
    (( minutes > 0 )) && elapsed_time+="${minutes}m "
    elapsed_time+="${seconds}s"
    notif_title=$([ $notif_status -eq 0 ] && echo "Command succeeded :smile:" || echo "Command failed :innocent:")
    notif_color=$([ $notif_status -eq 0 ] && echo "good" || echo "danger")
    notif_icon=$([ $notif_status -eq 0 ] && echo ":desktop_computer:" || echo ":desktop_computer:")
    payload=`cat << EOS
{
  "username": "command result",
  "icon_emoji": "$notif_icon",
  "attachments": [
    {
      "color": "$notif_color",
      "title": "$notif_title",
      "mrkdwn_in": ["fields"],
      "fields": [
        {
          "title": "command",
          "value": "\\\`$notif_prev_command\\\`",
          "short": false
        },
        {
          "title": "directory",
          "value": "\\\`$(pwd)\\\`",
          "short": false
        },
        {
          "title": "user",
          "value": "\\\`$(whoami)\\\`",
          "short": true
        },
        {
          "title": "hostname",
          "value": "\\\`$(hostname)\\\`",
          "short": true
        },
        {
          "title": "executed at",
          "value": "\\\`$notif_prev_executed_at\\\`",
          "short": true
        },
        {
          "title": "elapsed time",
          "value": "\\\`${elapsed_time}\\\`",
          "short": true
        }
      ]
    }
  ]
}
EOS
`
    curl --request POST \
      --header 'Content-type: application/json' \
      --data "$(echo "$payload" | tr '\n' ' ' | tr -s ' ')" \
      $SLACK_WEBHOOK_URL -s > /dev/null

    echo "notify.zsh: notify slack"
    echo ""
  fi
}

add-zsh-hook preexec notify_preexec
add-zsh-hook precmd notify_precmd
