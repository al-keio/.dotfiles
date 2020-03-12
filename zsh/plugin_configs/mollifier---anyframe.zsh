zstyle ":anyframe:selector:" use fzf
zstyle ":anyframe:selector:fzf:" command 'fzf -0'
bindkey '^R' anyframe-widget-put-history

# aliases of anyframe widgets
alias saif="anyframe-widget-put-ssh-add"
alias taif="anyframe-widget-put-tmux-attach"
alias tkif="anyframe-widget-put-tmux-kill"
alias deif="anyframe-widget-put-docker-exec"
