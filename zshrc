##################################### PATH #####################################

if [[ -e ~/.path ]]
then
  source ~/.path
fi

################################### GENERAL ####################################

# Set VISUAL and EDITOR to nvim or vim otherwise
if which nvim > /dev/null 2>&1
then
	export EDITOR=$( which nvim )
	export VISUAL=$( which nvim )
else
	export EDITOR=$( which vim )
	export VISUAL=$( which vim )
fi

# ssh
export SSH_KEY_PATH="~/.ssh/rsa_id"

# Log history
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt INC_APPEND_HISTORY
setopt EXTENDED_HISTORY

# Use vi mode
bindkey -v

# Better command mode.
bindkey kj vi-cmd-mode
export KEYTIMEOUT=10

# Vi mode settings
# Better searching in command mode
bindkey -M vicmd '?' history-incremental-search-backward
bindkey -M vicmd '/' history-incremental-search-forward

# Edit the command line in nvim
autoload edit-command-line
zle -N edit-command-line
bindkey -M vicmd ' ' edit-command-line

# Beginning search with arrow keys
bindkey -M vicmd "k" up-line-or-beginning-search
bindkey -M vicmd "j" down-line-or-beginning-search

# Ensure locale settings are correct
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Turn on ksh globbing
setopt ksh_glob

# Source for great good!
if [[ -e ~/.ghcup/env ]]
then
	source ~/.ghcup/env
fi

################################### DISPLAY ####################################

# Function for displaying only the last three tokens of the working directory.
function short_pwd {
	local dir_tokens=(${(s:/:)PWD})	
	if [[ $#dir_tokens -gt 3 ]]
	then
		echo "...""$( for f in ${dir_tokens[@]: -3:3}; do echo -n "/${f}"; done)"
	else
		echo $PWD
	fi
}

# Allow the prompts to change
setopt prompt_subst

# Set the left-hand prompt
PROMPT="%K{blue}%F{black} 算 %f%k%F{blue}%f "

# Set the right-hand prompt
RPROMPT='%F{yellow}%f%K{yellow}%F{black} $( short_pwd ) %f%k'
RPROMPT+='%F{green}%K{yellow}%k%f%K{green}%F{black} (%n@%m)'
