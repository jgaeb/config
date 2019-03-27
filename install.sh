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
	for f in *
	do
		if [[ "$f" != "$0" ]]
		then
			ln -shi "${PWD}/${f}" "${HOME}/.${f}"
		fi
	done

else
	for f in ${FILES-@}
	do
		ln -shi "${PWD}/${f}" "${HOME}/.${f}"
	done
fi
