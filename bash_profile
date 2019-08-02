if [ -f ~/.bashrc ]
then
	. ~/.bashrc
fi

# Needed for node
export NVM_DIR=~/.nvm
source $(brew --prefix nvm)/nvm.sh
