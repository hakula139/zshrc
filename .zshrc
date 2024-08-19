# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=5"
export UPDATE_ZSH_DAYS=3

ENABLE_CORRECTION="true"
HYPHEN_INSENSITIVE="true"

plugins=(
  autojump
  autoupdate
  brew
  extract
  fzf
  git
  gitignore
  git-lfs
  helm
  kubectl
  nvm
  sudo
  zsh-autosuggestions
  zsh-syntax-highlighting
)

zstyle ':omz:plugins:nvm' silent-autoload yes

source $ZSH/oh-my-zsh.sh

# User configuration

export EDITOR="code --wait"
export HOMEBREW_BOTTLE_DOMAIN="https://mirrors.cloud.tencent.com/homebrew-bottles"

export JAVA_HOME=$(/usr/libexec/java_home)
export HADOOP_HOME="$(readlink -f $(brew --prefix hadoop))/libexec"
export PNPM_HOME="$HOME/Library/pnpm"

autoload -U zmv

alias zcp="zmv -C"
alias zln="zmv -L"
alias zshcfg="$EDITOR $HOME/.zshrc"
alias zshrst="source $HOME/.zshrc"

alias gls="git pull --recurse-submodules && git submodule foreach git lfs pull"

[ -f "$HOME/.p10k.zsh" ] && source "$HOME/.p10k.zsh"

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
export -U PATH="$PNPM_HOME:$HOME/.yarn/bin:$HOME/go/bin:$HOME/.local/bin:$PATH"

PYTHONPATH=$(python3 -c "import sys; print(':'.join(sys.path)[1:])")
alias pytrace="python3 -m trace --ignore-dir=$PYTHONPATH -t"
