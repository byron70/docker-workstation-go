
# BEGIN FROM DOCKER
export GOPATH=/d/projects/go
export PATH=$GOPATH/bin:$GOROOT/bin:$PATH

cp -rf /root/ssh_temp /root/.ssh/
chmod -R 600 /root/.ssh
alias l='ls -CF'
alias la='ls -A'
alias ll='ls -alF'
alias ls='ls --color=auto'

source /etc/profile.d/bash_completion.sh

if [ -n '$SSH_AUTH_SOCK' ] ; then
       eval $(ssh-agent -s)
       ssh-add
fi

export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=/d/projects/go/src/gitlab.eng.cleardata.com
mkdir -p $WORKON_HOME
conda init bash
conda config --add envs_dirs $WORKON_HOME
