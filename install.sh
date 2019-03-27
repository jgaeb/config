#!/usr/bin/env bash
# Automatically installs dotfiles contained in this directory.
# USAGE: ./install.sh DOTFILE
#        ./install -a
# (Second usage installs all dotfiles.)

WRONG_ARGS=1

if [[ ! $# -ge 1 ]]
then
	echo "Usage: ./install.sh DOTFILE [DOTFILE [DOTFILE ...]]" 1>&2
	exit "$WRONG_ARGS"
fi

BASEDIR=$(dirname $0)

cd "$BASEDIR"

for f in "$@"
do
	ln -s "${PWD}/${f}" "${HOME}/.${f}"
done
