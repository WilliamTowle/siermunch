#!/bin/sh

# (c) and GPLv2 William Towle <william_towle@yahoo.co.uk>


plots()
{
	R=$1
	C=$(( $2 * 2 ))
	S=$3

	tput cup $R $C && printf '%s%s' $S$S
}


show0()
{
	X=$1
	Y=$2
	plots $X $Y '$'
}

show1()
{
	X=$1
	Y=$2
	plots $X $Y ':'
}

tput init

for X in `seq 0 7` ; do
	[ $(( $X & 1 )) -eq 0 ] && show0 $X $X || show1 $X $X
	echo
done
