# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel9k/powerlevel9k"

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

POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(ssh os_icon dir dir_writable vcs)

POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(time battery)

export SITE=localhost:8080
export EMAIL_PASSWORD=ykfzlgexwmmbmhrc
export DATABASE_URL=postgres://bzjjiczqasdfey:c4e571f2fe010719ab01b65e452d50947b5cfc885a2b2e64aa9f3713d3f86a03@ec2-3-91-112-166.compute-1.amazonaws.com:5432/dfc51d2diggfu1
export LOCATION=D
export SALT=designersworkshop/
export PORT=8080
export API_KEY=Fw3keJO69rNjW0cHHwVg
eval "$(rbenv init -)"

alias list="exa -lah --git"
alias icloud="cd $HOME/Library/Mobile\ Documents/com~apple~CloudDocs/"

source ~/.iterm2_shell_integration.zsh
fpath=(~/.zsh $fpath)
