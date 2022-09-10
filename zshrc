# Fig pre block. Keep at the top of this file.
[[ -f "$HOME/.fig/shell/zshrc.pre.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.pre.zsh"
# Fig pre block. Keep at the top of this file.
[ -s $HOME/.fig/shell/zshrc.pre.zsh ] && # If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
#ZSH_THEME="powerlevel10k/powerlevel10k"

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

plugins=(git zsh-syntax-highlighting)

source "$ZSH/oh-my-zsh.sh"

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

export LANG=en_US.UTF-8

# Functions

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

roi() {
	env /usr/bin/arch -x86_64 $@
}

iBrew() {
	roi /Users/lebje/homebrew/bin/brew $@
}

# Aliases
alias ls="exa -lah --git --icons"
alias lsl="ls -mugU --octal-permissions"
alias weather="curl wttr.in"
alias icloud="cd $HOME/Library/Mobile\ Documents/com~apple~CloudDocs/"
alias nvim-init="nvim ~/config/nvim/init.lua"
alias nvim-config="nvim ~/.config/nvim/lua/settings.lua"
alias nvim-plugins="nvim ~/.config/nvim/lua/plugins.lua"
alias nvim-pluginsS="nvim ~/.config/nvim/lua/pluginsSetup.lua"
alias nvim-cNvimDAP="nvim ~/.config/nvim/lua/nvimDapSetup.lua"
alias nvim-cCocNvim="nvim ~/.config/nvim/lua/cocNvimSetup.lua"
alias nvim-cStatusBar="nvim ~/.config/nvim/lua/felineSetup.lua"


alias bat="bat --pager=\"less -FRS\" --theme \"TwoDark\""
alias ts="tree-sitter"
alias sba="swift build --arch x86_64 && swift build --arch arm64"
alias sbdr="swift build -c debug && swift build -c release"

# fpath

fpath=($HOME/.zsh $fpath)
fpath=($(brew --prefix)/share/zsh/site-functions/ $fpath)
fpath=($HOME/.zsh/completion $fpath)

export PATH="/usr/local/opt/m4/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"
export PATH="/usr/local/opt/ruby/bin:$PATH"
export PATH="/usr/local/opt/python@3.9/bin:$PATH"
#export PATH="/usr/local/opt/llvm/bin:$PATH"
export PATH="/Users/lebje/homebrew/bin:$PATH"
export PATH="/Users/lebje/homebrew/opt/icu4c/bin:$PATH"
export PATH="/Users/lebje/homebrew/opt/icu4c/sbin:$PATH"
#export PATH="/Users/lebje/homebrew/opt/llvm/bin:$PATH"
export PATH="/usr/local/lib/python3.9/site-packages/:$PATH"
export PATH="/usr/local/lib/ruby/gems/3.0.0/bin:$PATH"
export PATH="/usr/local/opt/binutils/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"
export PATH="$HOME/Programs/sourcekit-lsp/.build/release/sourcekit-lsp:$PATH"
export PATH="$HOME/tree-sitter/target/release/:$PATH"

export EDITOR="nvim"

export GPG_TTY=$(tty)

export LDFLAGS="-L/Users/lebje/homebrew/lib"
export CPPFLAGS="-I/Users/lebje/homebrew/include"
export CFLAGS="-I/Users/lebje/homebrew/include"

export CPATH="/usr/local/include:/Users/lebje/homebrew/include"
export C_INCLUDE_PATH="/usr/local/include:/Users/lebje/homebrew/include"
export LIBRARY_PATH="/usr/local/lib:/Users/lebje/homebrew/lib"

export FZF_DEFAULT_COMMAND="fd"

autoload -U compinit
compinit

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
test -e ~/.iterm2_shell_integration.zsh && source ~/.iterm2_shell_integration.zsh || true

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C ~/homebrew/bin/bit bit

eval "$(zoxide init zsh)"
eval "$(starship init zsh)"

# ZSH Customization
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


alias luamake=/Users/lebje/luamake/luamake

eval "$(atuin init zsh)"

# Fig post block. Keep at the bottom of this file.
[ -s $HOME/.fig/shell/zshrc.post.zsh ] &&

# Fig post block. Keep at the bottom of this file.
[[ -f "$HOME/.fig/shell/zshrc.post.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.post.zsh"
