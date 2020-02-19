#!/bin/bash -x

echo Welcome To Gambling Simulation Problem

#CONSTANTS
STAKE_PER_DAY=100
BET_PER_GAME=1
WIN=1
GOAL_PERCENT=50
MAX_LIMIT=$(($STAKE_PER_DAY+$STAKE_PER_DAY*$GOAL_PERCENT/100))
MIN_LIMIT=$(($STAKE_PER_DAY-$STAKE_PER_DAY*$GOAL_PERCENT/100))

#FUNCTION TO SIMULATE GAMBLING FOR A DAY
function moneyWonOrLostForDay(){
	local money=$STAKE_PER_DAY
	checkWin=$((RANDOM%2))
	while [ $money -gt $MIN_LIMIT -a $money -lt $MAX_LIMIT ]
	do
		if [ $checkWin -eq $WIN ]
		then
			money=$(($money+$BET_PER_GAME))
		else
			money=$(($money-$BET_PER_GAME))
		fi
	done
	moneyAtEndOfDay=$(($money-$STAKE_PER_DAY))
	echo $moneyAtEndOfDay
}

for (( i=1; i<=20; i++ ))
do
	totalMoney=$(($totalMoney+$(moneyWonOrLostForDay)))
done

if [ $totalMoney -lt 0 ]
then
	totalMoneyLost=$((-1*$totalMoney))
else
	totalMoneyWon=$totalMoney
fi
