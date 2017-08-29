# -- Homebrew -------------------------------------------------------
export PATH="/usr/local/bin:$PATH"

# -- rvm ------------------------------------------------------------
source $HOME/.rvm/scripts/rvm

# -- Aliases --------------------------------------------------------
if [[ -f "$HOME/.aliases" ]]; then
  source $HOME/.aliases
fi

# -- Editor ---------------------------------------------------------
EDITOR="nvim"

# -- fzf ------------------------------------------------------------
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# -- ZPlug ----------------------------------------------------------
# Check if zplug is installed
if [[ ! -d ~/.zplug ]]; then
    git clone https://github.com/zplug/zplug ~/.zplug
    source ~/.zplug/init.zsh && zplug update --self
fi

source ~/.zplug/init.zsh

zplug 'zplug/zplug', hook-build:'zplug --self-manage'

# Can manage local plugins
zplug "~/.zsh", from:local

# Load theme file
# zplug 'dracula/zsh', as:theme
zplug "config-env/agnoster-zsh-theme", as:theme

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
zplug load --verbose

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
