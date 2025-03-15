# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

#eval "$(starship init zsh)"
source ~/.powerlevel10k/powerlevel10k.zsh-theme

FUNCNEST=1000

export PATH=$PATH:/usr/sbin
[[ -f ~/.profile ]] && source ~/.profile


###################### ZSH-Autocomplete #################################
source /usr/share/zsh-autocomplete/zsh-autocomplete.plugin.zsh
zle -N menu-search
zle -N recent-paths
bindkey              '^I'         menu-complete
bindkey "$terminfo[kcbt]" reverse-menu-complete

compdef _files nvim
zstyle ':completion:*:*:nvim:*' file-patterns '*:all-files'
zstyle ':completion:*:*:nvim:*' menu select

##################### AUTOSUGGESTION ##############################
source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh

##################### ZOXIDE ######################################
eval "$(zoxide init zsh)"
alias Z='z /'

###################### FZF ########################################
source /usr/share/doc/fzf/examples/key-bindings.zsh
source /usr/share/doc/fzf/examples/completion.zsh

export FZF_ALT_C_OPTS='--walker-root=DIR [/]'
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
  --color=fg:-1,fg+:#ffffff,bg:-1,bg+:#262626
  --color=hl:#5f87af,hl+:#5fd7ff,info:#afaf87,marker:#ffe100
  --color=prompt:#d7005f,spinner:#af5fff,pointer:#af5fff,header:#c69dff
  --color=border:#262626,label:#aeaeae,query:#d9d9d9
  --border="rounded" --border-label="" --preview-window="border-rounded" --prompt="> "
  --marker=">" --pointer="◆" --separator="─" --scrollbar="│"'
alias fz='fzf --height 40% --reverse'
# Searching fg-funtction
fq() {
  local query=""
  local fzf_opts=("-m")

  # Parse arguments to separate query terms and fzf options
  for arg in "$@"; do
    if [[ "$arg" == -* ]]; then
      fzf_opts+=("$arg")
    else
      query+="$arg "
    fi
  done

  # Remove trailing space from query
  query=${query% }

  # Generate the list of files and pipe it into fzf with the specified options
  find / -type f 2>/dev/null | fzf --height 40% --reverse --exact --query="$query" "${fzf_opts[@]}"
}


# Custom keybindings for tab completion
bindkey '^I' fzf-completion
bindkey '^[[Z' fzf-completion  # Shift-Tab
# Arrow key bindings for completion menu
bindkey '^[[A' history-beginning-search-backward
bindkey '^[[B' history-beginning-search-forward
bindkey '^[[C' forward-char           # Right arrow
bindkey '^[[D' backward-char          # Left arrow
# Enhanced tab completion navigation
zstyle ':completion:*' menu select interactive
zmodload zsh/complist
bindkey -M menuselect '^[[A' up-line-or-history
bindkey -M menuselect '^[[B' down-line-or-history
bindkey -M menuselect '^[[C' forward-char
bindkey -M menuselect '^[[D' backward-char
autoload -Uz compinit
compinit


###################################################################
alias ls='eza --icons=always -aF --group-directories-first --sort=name'
alias lsd='eza --icons=always -Da'
alias lsf='eza --icons=always -af'
alias lsi='eza --icons=always -alrbZ --sort=size --total-size'
alias lssi='eza --icons=always --all --long --tree --level=3'
alias rzsh='source ~/.zshrc'
alias ipinfo='http -b https://ipinfo.io/ip'
alias v='/snap/bin/nvim'
alias htbeu='sudo openvpn --daemon --config ~/.vpn/lab_Iomin_VIP_EU.ovpn'
alias htbus='sudo openvpn --daemon --config ~/.vpn/starting_point_Iomin_US_VIP.ovpn'

##################### HISTORY #####################################
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS
setopt INC_APPEND_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt SHARE_HISTORY
#bindkey '^R' history-incremental-search-backward

################### Encoding/Decoding ############################
function hex-encode() {
    echo "$@" | xxd -p
}

function hex-decode() {
    echo "$@" | xxd -p -r
}

function rot13() {
    echo "$@" | tr 'A-Za-z' 'N-ZA-Mn-za-m'
}

################### SYNTAX-HIGHLIGHTING ##########################
source ~/.zsh/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.x[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
