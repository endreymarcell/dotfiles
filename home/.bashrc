#########################################
###            PREFERENCES            ###
#########################################

export HISTSIZE=
export HISTFILESIZE=
export HISTCONTROL=ignoreboth
export HISTFILE=~/.bash_eternal_history
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export IGNOREEOF=1

shopt -s histappend
shopt -s cdspell

export BAT_THEME=GitHub
export EDITOR=code

#######################################
###            ALIASES              ###
#######################################

### EXECUTABLES ###
alias chrome='open -a "Google Chrome"'
alias edit='$EDITOR'
alias svgo=svgoim
alias idea='open -a "/Applications/IntelliJ IDEA.app"'
alias diff=colordiff
alias cci=circleci
alias yy=pbcopy
alias pp=pbpaste
alias n='sudo /usr/local/bin/n'
alias ji=jiraf
alias lg=/usr/local/bin/lazygit

### GIT ###
alias gg='git status'
alias ggs='git status -s'
alias gpl='git pull'
alias gps='git push'
alias gcm='git checkout master'
alias gcb='git checkout -b'
alias gmm='git merge master'

### PYTHON & DJANGO ###
alias vv='virtualenv virtualenv'
alias wv=get_venv_name
alias dea=deactivate
alias mp='vea && ./manage.py'
alias mpt='vea && ./manage.py test'
alias mps='vea && ./manage.py shell'
alias mpd='vea && ./manage.py dbshell'
alias mpr='vea && ./manage.py runserver'
alias p8='pycodestyle --ignore E501 --exclude virtualenv/ .'

### MISC ###
alias 'll=ls -laG'
alias ..='cd ..'
alias notif='(if [[ $? = 0 ]]; then afplay /System/Library/Sounds/Ping.aiff; else afplay ~/personal/misc/notif_error.mp3; fi &) >/dev/null'
alias pg='ping google.com'
alias wifi='networksetup -setairportpower en0'   # suffix with 'on' or 'off'
alias rewifi='echo "Turning wifi off..." && wifi off && sleep 3 && echo "Turning wifi on..." && wifi on && sleep 3 && pg'
alias br='edit -w ~/.bashrc && . ~/.bashrc'
alias dps='docker ps --format "table {{.ID}}\t{{.RunningFor}}\t{{.Status}}\t{{.Names}}"'
alias thisdir='basename $(pwd)'
alias preview="fzf --preview 'bat --color \"always\" {}'"
alias hist='history -a; history -r'

#######################################
###    SOURCE FILES AND EXPORTS     ###
#######################################

source_if_exists() {
    test -f "$1" && source "$1"
}

### PATH ###

export PATH="$PATH:/Library/Frameworks/Python.framework/Versions/3.5/bin"
export PATH="$PATH:/usr/local/bin/gradle-1.8/bin"
export PATH="$PATH:/Users/Marca/.local/bin:/Users/Marca/bin"
export PATH="/Applications/Postgres.app/Contents/Versions/latest/bin/:$PATH"

### OTHER EXPORTS ###

export PKG_CONFIG_PATH=/opt/X11/lib/pkgconfig/
export HAXE_STD_PATH="/usr/local/lib/haxe-3.1.3"
export FLEX_HOME=/Users/Marca/.prezi/flex_sdk_4.6

### SOURCE FILES ###

source_if_exists ~/.prezi/.bashrc_prezi.sh
([ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion & 2>/dev/null)
source_if_exists /usr/local/etc/profile.d/autojump.sh
source_if_exists ~/.fzf.bash
source_if_exists /usr/local/etc/bash_completion.d/git-completion.bash
source_if_exists /usr/local/etc/bash_completion.d/git-prompt.sh

#######################################
###    BASH PROMPT CUSTOMIZATION    ###
#######################################

git_status_for_prompt() {
    test -d .git && __git_ps1
}
GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWCOLORHINTS=true
GIT_PS1_SHOWUNTRACKEDFILES=true

function nonzero_return() {
    # TODO: fix
    RETVAL=$?
    [ $RETVAL -ne 0 ] && echo "✘ " || echo ""
}

hr() {
    printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' ─
}

get_venv_name() {
    if [[ $VIRTUAL_ENV = "" ]]; then
        return
    elif [[ $(basename $VIRTUAL_ENV) = virtualenv ]]; then
        echo "$(basename $(dirname $VIRTUAL_ENV))+ "
    else
        echo "$(basename $VIRTUAL_ENV)+ "
    fi
}
export VIRTUAL_ENV_DISABLE_PROMPT=1

function jiraf_card() {
    [ -f ~/.jiraf/status ] && cat ~/.jiraf/status
}

[[ "$(id -u)" -eq 0 ]] && PS1_SYMBOL=⌘ || PS1_SYMBOL=❯

export PS1='\[\033[1;37\]$(hr)\[\033[0m\]\n\[\033[1;31m\]$(nonzero_return)\[\033[0m\]\[\033[1;90m\]$(get_venv_name)\[\033[0m\]\[\033[1;4;34m\]\w\[\033[0m\]\[\033[1;32m\]$(git_status_for_prompt) \[\033[0m\]$(jiraf_card)\n$PS1_SYMBOL '

#######################################
###            FUNCTIONS            ###
#######################################

### GIT SHORTCUTS ###

function gl() {
    git log --oneline "-n${1-10}"
}

gitlast() {
    git show $(git log --no-color --oneline -n1 | awk '{print $1}')
}

function gh() {
    REPO=$(git ls-remote --get-url origin | sed "s/:/\//" | sed "s/git@/https:\/\//" | sed "s/\/\/\//:\/\//"| sed s/.git$//)
    if [[ "$1" == "-m" ]]; then
        chrome $REPO
    else
        BRANCH=`git rev-parse --abbrev-ref HEAD`
        chrome $REPO/tree/$BRANCH
    fi
}

function gpr() {
    gpsu
    REPO=$(git ls-remote --get-url origin | sed "s/:/\//" | sed "s/git@/https:\/\//" | sed "s/\/\/\//:\/\//"| sed s/.git$//);
    BRANCH=$(git rev-parse --abbrev-ref HEAD)
    chrome "$REPO/compare/$BRANCH?expand=1"
}

function gpsu() {
    git push -u origin $(git rev-parse --abbrev-ref HEAD)
}

function gpfu() {
    git push -f origin $(git rev-parse --abbrev-ref HEAD)
}

function gup() {
    [[ "$(git st -s | wc -l)" -eq 0 ]] && gcm && gpl || gg
}

### OTHER HELPERS ###

grab() {
    peco | tr ' ' '\n' | peco | xargs | yy
}

function vea() {
    if [[ $(which python | grep virtualenv | wc -l | xargs) -eq 1 ]]; then
        deactivate
    fi
    if [[ -e virtualenv/bin/activate ]]; then
        . virtualenv/bin/activate
    else
        echo "No virtualenv found at $(pwd)/virtualenv/bin/python"
    fi
}

function denter() {
    sudo docker exec -ti $1 bash
}

svgoim() {
    ~/.nvm/versions/node/v6.9.1/bin/svgo $(if [[ -d $1 ]]; then echo '-f'; else echo '-i'; fi) $1
}

mkcd() {
    mkdir -p ${1} && cd ${1}
}

history_search() {
    local action
    action="$(cat ~/.bash_eternal_history | fzf --no-sort --tac)"
    [ "$action" = "" ] && return
    history -s "${action}"
    echo "${action}"
    eval "${action}"
}
bind '"\C-r":"history_search\n"'

#######################################
###       AUTOMATICALLY ADDED       ###
#######################################

export NVM_DIR="/Users/Marca/.nvm"
([ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" &) > /dev/null 2>&1  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
