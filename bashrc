##################################### PATH ##################################### 

if [[ -e ~/.path ]]
then
  source ~/.path
fi

################################### GENERAL ####################################

# Enable extended globbing
shopt -s extglob

# Set VISUAL and EDITOR to nvim or vim otherwise
if which nvim > /dev/null 2>&1
then
	export EDITOR=$( which nvim )
	export VISUAL=$( which nvim )
else
	export EDITOR=$( which vim )
	export VISUAL=$( which vim )
fi

# Ensure locale settings are correct
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8


# Source for great good!
if [[ -e ~/.ghcup/env ]]
then
	source ~/.ghcup/env
fi

################################### DISPLAY ####################################

# Function for displaying only the last three tokens of the working directory.
function short_pwd {
	IFS="/" read -ra dir_tokens <<< "$PWD"
	if [[ ${#dir_tokens[@]} -gt 3 ]]
	then
		echo "...""$( for f in ${dir_tokens[@]: -3}; do printf "/$f"; done)"
	else
		echo $PWD
	fi
}

# Set the three pieces of the prompt
PS1='\[\e[42m\]\[\e[30m\] (\u@\h) \[\e[43m\]\[\e[32m\]'
PS1+='\[\e[43m\]\[\e[30m\] $( short_pwd ) \[\e[44m\]\[\e[33m\]'
PS1+='\[\e[44m\]\[\e[30m\] 算 \[\e[100m\]\[\e[34m\]\[\e[0m\] '
