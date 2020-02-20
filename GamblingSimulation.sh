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
daysLost=0
daysWon=0

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

#FUNCTION TO SIMULATE GAMBLING FOR A MONTH AND STORE RESULTS IN ARRAY
function getDayAndMoneyWonArrayForMonth(){
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
		dayAndMoneyWonArray[$i]=$totalMoney
	done
}

#FUNCTION TO FIND LUCKIEST AND UNLUCKIEST DAY FOR GAMBLER
function getLuckiestDayAndUnluckiestDay(){
	local maximumLostAmount=$((2**63-1))
	local maximumWonAmount=$((-1*$((2**63-1))))
	for (( i=1; i<=$((${#dayAndMoneyWonArray[@]})); i++ ))
	do
		if [ ${dayAndMoneyWonArray[i]} -gt $maximumWonAmount ]
		then
			luckiestDay=""
			maximumWonAmount=${dayAndMoneyWonArray[i]}
			luckiestDay=$i
		elif [ ${dayAndMoneyWonArray[i]} -eq $maximumWonAmount ]
		then
			luckiestDay=$luckiestDay" "$i
		fi

		if [ ${dayAndMoneyWonArray[i]} -lt $maximumLostAmount ]
		then
			unLuckiestDay=""
			maximumLostAmount=${dayAndMoneyWonArray[i]}
			unLuckiestDay=$i
		elif [ ${dayAndMoneyWonArray[i]} -eq $maximumLostAmount ]
		then
			unLuckiestDay=$unLuckiestDay" "$i
		fi
	done
}


getDayAndMoneyWonArrayForMonth
getLuckiestDayAndUnluckiestDay

#FINDING MONEY LOST AND WON IN MONTH
moneyLostInMonth=$(($daysLost*$moneyWonOrLostInDay))
moneyWonInMonth=$(($daysWon*$moneyWonOrLostInDay))
