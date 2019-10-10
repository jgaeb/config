#!/usr/bin/env bash
# Automatically installs dotfiles contained in this directory.
# USAGE: ./install.sh DOTFILE
#        ./install -a
# (Second usage installs all dotfiles.)

WRONG_ARGS=1

if [[ ! $# -ge 1 ]]
then
	echo "Usage: ./install.sh DOTFILE [DOTFILE [DOTFILE ...]]" 1>&2
	echo "       ./install.sh -a" 1>&2
	exit "$WRONG_ARGS"
fi


BASEDIR=$(dirname $0)

cd "$BASEDIR"

if [[ $1 == "-a" ]]
then
	FILES=( * )
else
	FILES="$@"
fi

for f in ${FILES[*]}
do
	if [[ $( basename "$f" ) != $( basename "$0" ) ]]
	then
		ln -sni "${PWD}/${f%/}" "${HOME}/.${f%/}"
	fi
done
