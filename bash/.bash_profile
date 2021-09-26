[[ -r ~/.bashrc ]] && . ~/.bashrc

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
alias bach="/Users/marca/.prezi/frontend-packages/node_modules/.bin/bach"
alias ci="/Users/marca/.prezi/frontend-packages/node_modules/.bin/ci"

eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
[[ -f ~/.bashrc ]] && source ~/.bashrc # ghcup-env
