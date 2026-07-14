export PATH="/usr/local/bin:$PATH"
export EDITOR="code -w"

source ~/.zsh-plugins/init.zsh
source ~/.zsh-plugins/git.zsh
source ~/.zsh-plugins/bundler.zsh
source ~/.zsh-plugins/rails.zsh
source ~/.zsh-plugins/rbates.zsh

if command -v jp >/dev/null 2>&1; then
  alias jsonplot="jp"
fi

if command -v yq >/dev/null 2>&1; then
  alias yaml="yq"
fi

if command -v atuin >/dev/null 2>&1; then
  eval "$(atuin init zsh)"
fi

if command -v starship >/dev/null 2>&1; then
  eval "$(starship init zsh)"
fi
