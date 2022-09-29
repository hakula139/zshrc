# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=5"
export UPDATE_ZSH_DAYS=14

ENABLE_CORRECTION="true"
HYPHEN_INSENSITIVE="true"

plugins=(
  git
  extract
  autojump
  zsh-autosuggestions
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# User configuration

export EDITOR="code --wait"
export HOMEBREW_BOTTLE_DOMAIN="https://mirrors.cloud.tencent.com/homebrew-bottles"

export JAVA_HOME=$(/usr/libexec/java_home)
export HADOOP_HOME="$(readlink -f $(brew --prefix hadoop))/libexec"

autoload -U zmv

alias zcp="zmv -C"
alias zln="zmv -L"
alias zshcfg="$EDITOR $HOME/.zshrc"
alias zshrst="source $HOME/.zshrc"
alias bi="brew install"
alias bu="brew upgrade"

[[ ! -f "$HOME/.p10k.zsh" ]] || source "$HOME/.p10k.zsh"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/homebrew/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/homebrew/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/opt/homebrew/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/opt/homebrew/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# If you come from bash you might have to change your $PATH.
export -U PATH="$HOME/.yarn/bin:$HOME/go/bin:$HOME/.local/bin:$PATH"
