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

source "$ZSH/oh-my-zsh.sh"

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

export LANG=en_US.UTF-8

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.

export POWERLEVEL9K_DISABLE_RPROMPT=false

export POWERLEVEL9K_TIME_FORMAT="%D{%r, %a %b %d, %Y}"

export POWERLEVEL9K_MODE='awesome-fontconfig'

export POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(ssh context os_icon dir dir_writable newline load my_cpu_temp ram vcs)

export POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(battery disk_usage newline time)

export POWERLEVEL9K_LEFT_SEGMENT_SEPARATOR='\UE0B4'

export POWERLEVEL9K_RIGHT_SEGMENT_SEPARATOR='\UE0B6'

function prompt_my_cpu_temp() {
	p10k segment -t " $(temp)"
}

export PATH="$HOME/config/:$PATH"

export POWERLEVEL9K_MY_CPU_TEMP_FOREGROUND=208

eval "$(rbenv init -)"

alias list="exa -lah --git --icons"
alias icloud="cd $HOME/Library/Mobile\ Documents/com~apple~CloudDocs/"

function dockerDeleteAll() {
	docker rm "$(docker ps --filter=status=exited --filter=status=created -q)"
	docker rmi "$(docker images -a -q)"
}

function dockerRunCommand {
	docker run --rm -v $(pwd):/src -w /src $@
}

function clearFinderCache() {
	/System/Library/Frameworks/CoreServices.framework/Versions/A/Frameworks/LaunchServices.framework/Versions/A/Support/lsregister -kill -r -domain local -domain system -domain user
}

fpath=($HOME/.zsh $fpath)
fpath=(/Users/stanleylebrun/homebrew/share/zsh/site-functions/ $fpath)

fpath=($HOME/.zsh/completion $fpath)

export PATH="/usr/local/opt/llvm/bin:$PATH"
#export LDFLAGS="-L/usr/local/opt/llvm/lib"
#export CPPFLAGS="-I/usr/local/opt/llvm/include"
alias nvim-config="nvim ~/.config/nvim/init.vim"

export EDITOR="nvim"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

#export FZF_DEFAULT_COMMAND="fd"
export PATH="/usr/local/opt/python@3.9/bin:$PATH"

export GPG_TTY=$(tty)
export PATH="/usr/local/opt/ruby/bin:$PATH"
#export LDFLAGS="-L/usr/local/opt/ruby/lib"
#export CPPFLAGS="-I/usr/local/opt/ruby/include"

export C_INCLUDE_PATH="/Users/stanleylebrun/homebrew/include:$C_INCLUDE_PATH"

#export C_INCLUDE_PATH=/usr/local/include
export LIBRARY_PATH="/Users/stanleylebrun/homebrew/lib"

fpath=($HOME/.zsh/completion $fpath)
autoload -U compinit
compinit

.//usr/local/etc/profile.d/z.sh
export PATH="/usr/local/sbin:$PATH"

alias weather="curl wttr.in"
export PATH="/usr/local/opt/openjdk/bin:$PATH"

HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000000
SAVEHIST=10000000
setopt BANG_HIST                 # Treat the '!' character specially during expansion.
setopt EXTENDED_HISTORY          # Write the history file in the ":start:elapsed;command" format.
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space.
setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.
setopt HIST_VERIFY               # Don't execute immediately upon history expansion.
setopt HIST_BEEP                 # Beep when accessing nonexistent history.
export SAVEHIST=$HISTSIZE
export PATH="/usr/local/opt/m4/bin:$PATH"

roi() {
	env /usr/bin/arch -x86_64 $@
}

iBrew() {
	roi /Users/stanleylebrun/homebrew/bin/brew $@
}
export PATH="/Users/stanleylebrun/homebrew/bin:$PATH"
export PATH="/Users/stanleylebrun/homebrew/opt/icu4c/bin:$PATH"
export PATH="/Users/stanleylebrun/homebrew/opt/icu4c/sbin:$PATH"
export PATH="/Users/stanleylebrun/homebrew/opt/llvm/bin:$PATH"
export PATH="/usr/local/lib/python3.9/site-packages/:$PATH"
export PATH="/usr/local/lib/ruby/gems/3.0.0/bin:$PATH"
test -e /Users/jefflebrun/.iterm2_shell_integration.zsh && source /Users/jefflebrun/.iterm2_shell_integration.zsh || true
