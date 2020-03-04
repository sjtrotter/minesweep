#!/usr/bin/env bash

# File: minesweep.sh
# - A simple minesweeper game written in bash.

# Changelog:
#===========
# 
# 
# 2020-02-20 :	<stephen.j.trotter@gmail.com>
#	- Began development.
#	- Fleshed out program features.
#	- Found awesome menu script on unix stack exchange!
#	- Found matrix solution, on stackoverflow

# Features:
#============
# [ WORK ] - Implement menu if invoked without args
# [ WORK ] - Allow argument invocation
# [ DONE ] - Implement a matrix (2D array); zero-fill.
# [ DONE ] - Randomly pick mines; change to 1 in matrix.
# [ WORK ] - Choose & implement user input: either cursor in minefield or coords
# [ WORK ] - Check user input against matrix; calculate mines, or die.
# [ WORK ] - Continue game loop until win or die.
#============
# [  29% ] - v0.2.0
# Semantic Versioning - semver.org - Major.Feature.Bugfix
VERSION=0.2.0


declare -A MINEGRID


function matrix() {
	# declares an associative array with matrix-like keys
	# then fills it with zeros
# https://stackoverflow.com/questions/16487258/how-to-declare-2d-array-in-bash
	# $1 - number of rows
	# $2 - number of columns
	rows="$1"
	cols="$2"
	#declare -A MINEGRID

	for ((i=0;i<rows;i++)) do
		for ((j=0;j<cols;j++)) do
			MINEGRID["$i,$j"]=0
		done
	done
}

function generate_mines() {
	# generates a number of mines, inputs into array
	# $1 - number of mines
	# $2 - width of grid
	# $3 - height of grid
	num_mines="$1"
#	printf "debug: num_mines = $1\n"
	width="$2"
#	printf "debug: width = $2\n"
	height="$3"
#	printf "debug: height = $3\n"
	mines=0
#	printf "debug: mines = $mines\n"

#	printf "debug: starting while loop\n"
	while [[ $mines -lt $num_mines ]]; do
		x=$(shuf -i 0-$(($width-1)) -n 1)
#		printf "debug: x = $x\n"
		y=$(shuf -i 0-$(($height-1)) -n 1)
#		printf "debug: y = $y\n"
#		[[ ${MINEGRID["$x,$y"]} == 0 ]]
#		test_if="$?"
#		printf "debug: MINEGRID[x,y] zero - $test_if\n"
		if [[ ${MINEGRID["$x,$y"]} == 0 ]]; then
			MINEGRID["$x,$y"]=1
#		printf "debug: MINEGRID[x,y]=${MINEGRID[$x,$y]}\n"
#		printf "debug: mines=$mines\n"
			mines=$(($mines+1))
#		printf "debug: mines=$mines\n"
		fi
#	[[ $mines -lt $num_mines ]]
#	test_if="$?"
#	printf "debug: mines lt num_mines: $test_if\n"
	done
}



function display_grid() {
	# displays minesweeper grid, ready for input
	# clears screen first
	# $1 - width of grid
	# $2 - height of grid
	width="$1"
	height="$2"
	TOPBOT="+=+"
	MID="| |"
	clear
	for ((j=0;j<height;j++)) do
		for ((i=0;i<width;i++)) do
			printf "+"
		done
		printf "\n"
	done
}


if [[ $(basename $0) == "minesweep.sh" ]]; then

	# current tests
	matrix 10 10
	printf "\ndebug: matrix gen'd zero-fill\n"
	for key in ${!MINEGRID[@]}; do printf "$key - ${MINEGRID[$key]}\t"; done
	sleep 10
	generate_mines 10 10 10
	printf "\ndebug: mines chosen\n"
	for key in ${!MINEGRID[@]}; do
		if [[ ${MINEGRID["$key"]} -eq 1 ]]; then
			printf "$key - ${MINEGRID[$key]}\t"
		fi
	done
fi
