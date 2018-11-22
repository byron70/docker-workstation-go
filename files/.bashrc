
# BEGIN FROM DOCKER
export GOROOT=/usr/local/go
export GOPATH=/f/projects/go
export PATH=/f/projects/go/bin:/usr/local/go/bin:$PATH
export PATH="$HOME/miniconda/bin:$PATH"

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
export PROJECT_HOME=/f/projects/go/src/gitlab.eng.cleardata.com

source /usr/bin/virtualenvwrapper.sh
source $HOME/miniconda/bin/activate
