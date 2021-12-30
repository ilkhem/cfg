
# Path to your oh-my-zsh installation.
# export ZSH="$HOME/.oh-my-zsh"
# export ZSH_CUSTOM="$ZSH/custom"

# Theme
ZSH_THEME="ilyes"

# Plugins
# plugins=(pip colored-man-pages screen tmux vi-mode history-substring-search zsh-autosuggestions zsh-syntax-highlighting)

# Aliases
# source $ZSH/oh-my-zsh.sh
source ~/.aliases

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LANG=en_GB.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='nvim'
else
  export EDITOR='nvim'
fi

# add local bin folder to path
export PATH=$PATH:$HOME/bin

# fix gpg fatal error
export GPG_TTY=$(tty)

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
# Install Ruby Gems to ~/gems
export GEM_HOME="$HOME/gems"
export PATH="$HOME/gems/bin:$PATH"
# add path to app installed locally on gatsby desktop
export PATH="$HOME/Apps:$PATH"

# resource .aliases
source ~/.aliases



# run ssh-agent to hold private keys
if [[ -n $SSH_CONNECTION ]]; then
        eval `ssh-agent -s` > /dev/null
fi

# disable opencv warnings in howdy
export OPENCV_LOG_LEVEL=ERROR


# start tmux on every shell login
# if command -v tmux >/dev/null 2>&1 && [ "${DISPLAY}" ]; then
#     # if not inside a tmux session, and if no session is started, start a new session
#     [ -z "${TMUX}" ] && (tmux attach >/dev/null 2>&1 || tmux)
# fi
alias config='/usr/bin/git --git-dir=/home/ilyes/.cfg/ --work-tree=/home/ilyes'


eval "$(starship init zsh)"

# configure pyenv path
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi
eval "$(pyenv virtualenv-init -)"
