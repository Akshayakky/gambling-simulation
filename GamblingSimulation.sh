#!/bin/bash -x

echo Welcome To Gambling Simulation Problem

#CONSTANTS
STAKE_PER_DAY=100
BET_PER_GAME=1
WIN=1
GOAL_PERCENT=50
MAX_LIMIT=$(($STAKE_PER_DAY+$STAKE_PER_DAY*$GOAL_PERCENT/100))
MIN_LIMIT=$(($STAKE_PER_DAY-$STAKE_PER_DAY*$GOAL_PERCENT/100))

#VARIABLES
money=$STAKE_PER_DAY
checkWin=$((RANDOM%2))

#CHECKING FOR WIN OR LOSE AND CALCULATE MONEY
while [ $money -gt $MIN_LIMIT -a $money -lt $MAX_LIMIT ]
do
	if [ $checkWin -eq $WIN ]
	then
		money=$(($money+$BET_PER_GAME))
	else
		money=$(($money-$BET_PER_GAME))
	fi
done
