# eval "$(rbenv init -)"
# export PATH="$HOME/.rbenv/bin:$PATH"

export EDITOR='vim'

# alias
alias ls='ls -G'
alias ll='ls -alG'
alias ss='git status'
alias g='git'
alias r='bundle exec rails'
alias rs='bundle exec rails s -b 0.0.0.0'

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
