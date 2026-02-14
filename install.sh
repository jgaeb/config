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

symlink_one() {
	local source="$1"
	local target="$2"

	if [[ -L "$target" ]]; then
		# Already a symlink -- replace it
		ln -sfn "$source" "$target"
	elif [[ -d "$source" && -d "$target" ]]; then
		# Both are real directories -- merge by symlinking contents
		for child in "$source"/*; do
			symlink_one "$child" "$target/$(basename "$child")"
		done
	elif [[ -e "$target" ]]; then
		# Exists but is a real file -- ask before replacing
		echo "$target exists and is not a symlink. Replace? [y/N]"
		read -r reply
		if [[ "$reply" =~ ^[Yy]$ ]]; then
			rm -rf "$target"
			ln -s "$source" "$target"
		else
			echo "Skipping $target"
		fi
	else
		# Doesn't exist -- create symlink
		ln -s "$source" "$target"
	fi
}

for f in ${FILES[*]}
do
	if [[ $( basename "$f" ) != $( basename "$0" ) ]]
	then
		symlink_one "${PWD}/${f%/}" "${HOME}/.${f%/}"
	fi
done
