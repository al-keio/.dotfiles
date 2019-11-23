#!/bin/bash
i=1
PIDI=0
PPIDI=0
COMMANDI=0

for word in `ps alxc | head -n 1 | tr -s ' ' '\n'`
do
  if [[ -z $word ]]; then
    continue
  fi
  if [[ $word = "PID" ]]; then
    PIDI=$i
  fi
  if [[ $word = "PPID" ]]; then
    PPIDI=$i
  fi
  if [[ $word = "COMMAND" ]]; then
    COMMANDI=$i
  fi
  i=$((i + 1))
done

tty=`tmux list-panes -F '#{pane_active} #{pane_tty}' | grep "1\ " | awk '{print $2}'`
tty=`basename $tty`
PID=`ps | grep $tty | tail -n 1 | awk '{print $1}'`

job=`ps alxc | awk -v ipid="${PID}" -v pidi="${PIDI}" -v ppidi="${PPIDI}" -v commandi="${COMMANDI}" '
{
    parent[$pidi]=$ppidi
    command[$pidi]=$commandi
}

END{
    pid=ipid
    while(pid != 1 && pid != 0) {
      arrow=""
      if (pid != ipid) {
        arrow=" <- "
      }
      cmd=command[pid]
      pid=parent[pid]
      if (cmd == "tmux") {
        break
      }
      printf("%s%s", arrow, cmd)
    }
    print ""
}
'`
echo $job
