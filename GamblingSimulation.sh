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
moneyWonOrLostInDay=50

#FUNCTION TO SIMULATE GAMBLING FOR A DAY
function getMoneyWonOrLostForDay(){
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

#FOR LOOP TO SIMULATE GAMBLING FOR A MONTH
for (( i=1; i<=30; i++ ))
do
	moneyWonOrLostForDay=$(getMoneyWonOrLostForDay)
	if [ $moneyWonOrLostForDay -lt 0 ]
	then
		#STORING NO OF DAYS LOST AND NO OF DAYS WON
		((daysLost++))
	else
		((daysWon++))
	fi
	totalMoney=$(($totalMoney+$moneyWonOrLostForDay))
	dayAndMoneyDictionary[$i]=$totalMoney
done

#FINDING MONEY LOST AND WON IN MONTH
moneyLostInMonth=$(($daysLost*$moneyWonOrLostInDay))
moneyWonInMonth=$(($daysWon*$moneyWonOrLostInDay))
