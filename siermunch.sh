#!/bin/sh

# (c) and GPLv2 2010-2025 William Towle <william_towle@yahoo.co.uk>
# Based on a discussion with Stuart Brady <sdb@zubnet.me.uk>

# Draws a sierpinski triangle in a similar manner to munching squares
# A power of two size argument is required for the effect to work


SIZE=$1
if [ -z "${SIZE}" ] ; then
	printf '%s: %s\n' $0 'Expected SIZE parameter' 1>&2
	exit 1
fi
shift

DELAY=$(printf '%.3f' $(( 5000 / ($SIZE * $SIZE) )) )e-3


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

pause()
{
	sleep ${DELAY}
}

display()
{
	PLIM=$(( ${SIZE} - 1 ))
	for P in `seq 0 ${PLIM}` ; do
		for X in `seq 0 ${PLIM}` ; do
			Y=$(( $X ^ $P ))
			[ $(( ( $X ) & ( $PLIM - $P ) )) -eq 0 ] && show0 $Y $X || show1 $Y $X

			pause
		done
	done

	tput cup ${SIZE} 0
}

trap 'tput cup ${SIZE} 0 ; tput sgr0 ; exit 1' 1 2 3 6

tput init

display ${SIZE}
