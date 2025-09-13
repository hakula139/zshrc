# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=5"
export UPDATE_ZSH_DAYS=14

# ENABLE_CORRECTION="true"
HYPHEN_INSENSITIVE="true"

plugins=(
  autojump
  autoupdate
  brew
  docker
  docker-compose
  extract
  fzf
  git
  git-lfs
  gitignore
  helm
  kubectl
  nvm
  pip
  podman
  poetry
  sudo
  zsh-autosuggestions
  zsh-syntax-highlighting
)

zstyle ':omz:plugins:nvm' silent-autoload yes

source $ZSH/oh-my-zsh.sh

# User configuration

autoload -U zmv

if which cursor >/dev/null; then
  export EDITOR="cursor"
elif which code >/dev/null; then
  export EDITOR="code"
else
  export EDITOR="vim"
fi

alias e="$EDITOR"
alias sudo="sudo "
alias nproc="sysctl -n hw.logicalcpu"

alias zcp="zmv -C"
alias zln="zmv -L"
alias zcfg="e $HOME/.zshrc"
alias zrst="source $HOME/.zshrc"

function git-retag() {
  local tag=$1
  if git tag | grep -q $tag; then
    git tag --delete $tag
    git push origin --delete $tag
  fi
  git tag $tag
  git push origin $tag
}

alias gls="git pull --recurse-submodules && git submodule foreach git lfs pull"
alias gtr="git-retag"
alias kdelpf="kdelp --field-selector=status.phase=Failed"
alias kdelrs="kubectl delete replicaset"
alias kdelrs0="kdelrs \$(kgrs -o jsonpath='{ .items[?(@.spec.replicas==0)].metadata.name }')"

[ -f "$HOME/.p10k.zsh" ] && source "$HOME/.p10k.zsh"
[ -f "$HOME/.cargo/env" ] && source "$HOME/.cargo/env"

# Fix Cursor Agent Terminal not completing commands issue with Powerlevel10k
# Reference: https://forum.cursor.com/t/cursor-agent-terminal-doesn-t-work-well-with-powerlevel10k-oh-my-zsh/96808/12
if [ -n $CURSOR_TRACE_ID ]; then
  PROMPT_EOL_MARK=""
  [ -f "$HOME/.iterm2_shell_integration.zsh" ] && source "$HOME/.iterm2_shell_integration.zsh"
  precmd() {
    print -Pn "\e]133;D;%?\a"
  }
  preexec() {
    print -Pn "\e]133;C;\a"
  }
fi

if which brew >/dev/null; then
  export HOMEBREW_API_DOMAIN="https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles/api"
  export HOMEBREW_BOTTLE_DOMAIN="https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles"

  export LLVM_HOME=$(brew --prefix llvm@20)
  export CC="$LLVM_HOME/bin/clang"
  export CXX="$LLVM_HOME/bin/clang++"
  export CPPFLAGS="-I$LLVM_HOME/include"
  export LDFLAGS="-L$LLVM_HOME/lib/c++ -L$LLVM_HOME/lib/unwind -lunwind"
  export PATH="$LLVM_HOME/bin:/opt/homebrew/bin:$PATH"
fi

if which python3 >/dev/null; then
  PYTHONPATH=$(python3 -c "import sys; print(':'.join(sys.path)[1:])")
  alias py="python3"
  alias pytrace="python3 -m trace --ignore-dir=$PYTHONPATH -t"
fi

if /usr/libexec/java_home >/dev/null; then
  export JAVA_HOME=$(/usr/libexec/java_home)
  export PATH="$JAVA_HOME/bin:$PATH"
fi

if [ -d "$HOME/Library/pnpm" ]; then
  export PNPM_HOME="$HOME/Library/pnpm"
  export PATH="$PNPM_HOME:$PATH"
fi

if [ -d "$HOME/go/bin" ]; then
  export PATH="$HOME/go/bin:$PATH"
fi

if [ -d "$HOME/.local/bin" ]; then
  export PATH="$HOME/.local/bin:$PATH"
fi

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
