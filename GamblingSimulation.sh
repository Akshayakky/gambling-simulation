#!/bin/bash -x

echo  Welcome To Gambling Simulation Problem

#CONSTANTS
STAKE_PER_DAY=100
BET_PER_GAME=1
WIN=1

#VARIABLES
money=$STAKE_PER_DAY
checkWin=$((RANDOM%2))

#CHECKING FOR WIN OR LOSE AND CALCULATE MONEY
if [ $checkWin -eq $WIN ]
then
	echo Gambler Won
	money=$(($money+$BET_PER_GAME))
else
	echo Gambler Lost
	money=$(($money-$BET_PER_GAME))
fi
