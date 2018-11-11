#not meant to be run as a script!
exit 1

############################
# auto start the ssh agent #
############################
SSH_ENV="$HOME/.ssh/environment"

function start_agent {
    echo "Initialising new SSH agent..."
    /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
    echo succeeded
    chmod 600 "${SSH_ENV}"
    . "${SSH_ENV}" > /dev/null
    /usr/bin/ssh-add;
    ssh-add ~/.ssh/github-key
}

# Source SSH settings, if applicable

if [ -f "${SSH_ENV}" ]; then
    . "${SSH_ENV}" > /dev/null
    #ps ${SSH_AGENT_PID} doesn't work under cywgin
    ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
        start_agent;
    }
else
    start_agent;
fi

############################
# create ssh tunnel easily #
############################
tunnel() {
    local REMOTE=${1:-"altus"}
    local REMOTE_PORT=${2:-8888}
    local LOCAL_PORT=${3:-8888}
    ssh -NL localhost:$LOCAL_PORT\:localhost:$REMOTE_PORT $REMOTE
}


############################
# bash autocomplete tweaks #
############################
bind "TAB:menu-complete"
bind "set show-all-if-ambiguous on"
bind "set menu-complete-display-prefix on"
