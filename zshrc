# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

export UPDATE_ZSH_DAYS=5

ENABLE_CORRECTION="true"

COMPLETION_WAITING_DOTS5="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(git textmate ruby lighthouse)
plugins=(git ruby zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

export LANG=en_US.UTF-8

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.

POWERLEVEL9K_DISABLE_RPROMPT=false

POWERLEVEL9K_TIME_FORMAT="%D{%r, %a %b %d, %Y}"

POWERLEVEL9K_MODE='awesome-fontconfig'

POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(ssh os_icon dir dir_writable load my_cpu_temp ram vcs)

POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(battery disk_usage time)

POWERLEVEL9K_LEFT_SEGMENT_SEPARATOR='\UE0B4'

POWERLEVEL9K_RIGHT_SEGMENT_SEPARATOR='\UE0B6'

function prompt_my_cpu_temp() {
	p10k segment -t " $(Temp)"
}

export PATH="$HOME/config/:$PATH"

POWERLEVEL9K_MY_CPU_TEMP_FOREGROUND=208

eval "$(rbenv init -)"

alias list="exa -lah --git --icons"
alias icloud="cd $HOME/Library/Mobile\ Documents/com~apple~CloudDocs/"

fpath=(~/.zsh $fpath)

export PATH="/usr/local/opt/llvm/bin:$PATH"
export LDFLAGS="-L/usr/local/opt/llvm/lib"
export CPPFLAGS="-I/usr/local/opt/llvm/include"
alias nvim-config="nvim ~/.config/nvim/init.vim"

export EDITOR="nvim"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

#export FZF_DEFAULT_COMMAND="fd"
export PATH="/usr/local/opt/python@3.8/bin:$PATH"

export GPG_TTY=`tty`
export PATH="/usr/local/opt/ruby/bin:$PATH"
export LDFLAGS="-L/usr/local/opt/ruby/lib"
export CPPFLAGS="-I/usr/local/opt/ruby/include"

export C_INCLUDE_PATH=/usr/local/include
export LIBRARY_PATH=/usr/local/lib

fpath=(~/.zsh/completion $fpath)
autoload -U compinit
compinit
