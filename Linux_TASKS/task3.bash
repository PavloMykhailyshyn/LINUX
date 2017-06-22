#!/bin/bash
echo "Enter dividend :"
read a
echo "Enter divisor : "
read b
echo "Enter precision calculation : "
read e
#finding dot index
DotIndex_a="${a//.*}"
DotIndex_b="${b//.*}"
[[ "$DotIndex_a" = "$a" ]] && DotIndex_a=-1 || DotIndex_a="${#DotIndex_a}"
[[ "$DotIndex_b" = "$b" ]] && DotIndex_b=-1 || DotIndex_b="${#DotIndex_b}"
#finding minus index
MinusIndex_a="${a//-*}"
MinusIndex_b="${b//-*}"
[[ "$MinusIndex_a" = "$a" ]] && MinusIndex_a=-1 || MinusIndex_a="${#MinusIndex_a}"
[[ "$MinusIndex_b" = "$b" ]] && MinusIndex_b=-1 || MinusIndex_b="${#MinusIndex_b}"
if [ $DotIndex_a -ne -1 ] #if dot has been found
then
	length=${#a} #getting length of the string number
	let "amount_of_numbers_after_the_decimal_point_a=length-DotIndex_a-1"
	a=${a/.} #removing dot
	if [ $MinusIndex_a -ne -1 ] #if minus has been found
	then
		a=${a/-} #removing minus
		a=$((10#$a)) #getting clear number (without leading zeros)
		let "a=-a"
	else
		a=$((10#$a))
	fi
else
	amount_of_numbers_after_the_decimal_point_a=0
fi
if [ $DotIndex_b -ne -1 ]
then
	length=${#b}
	let "amount_of_numbers_after_the_decimal_point_b=length-DotIndex_b-1"
	b=${b/.}
	if [ $MinusIndex_b -ne -1 ]
	then
		b=${b/-}
		b=$((10#$b))
		let "b=-b"
	else
		b=$((10#$b))
	fi
else
	amount_of_numbers_after_the_decimal_point_b=0
fi
if [ $amount_of_numbers_after_the_decimal_point_a -gt $amount_of_numbers_after_the_decimal_point_b ]
then
	let "b=b*(10**(amount_of_numbers_after_the_decimal_point_a-amount_of_numbers_after_the_decimal_point_b))"
elif [ $amount_of_numbers_after_the_decimal_point_b -gt $amount_of_numbers_after_the_decimal_point_a ]
then
	let "a=a*(10**(amount_of_numbers_after_the_decimal_point_b-amount_of_numbers_after_the_decimal_point_a))"
fi
#getting smth like an absolute value
if (( a < 0 )) && (( b < 0 ))
then
	let "a=-a"
	let "b=-b"
else
	if (( a < 0 ))
	then
		let "a=-a"
		result_str='-'
	fi
	if  (( b < 0 ))
	then
		let "b=-b"
		result_str='-'
	fi
fi
let "result=a/b"
result_str+="$result"
result_str+='.'
#dividing integer numbers up to a certain accuracy
for (( i=0; i<e; ++i ))
do
	let "remainder=(a-((a/b)*b))"
	let "remainder=remainder*10"
	a=remainder
	let "result=a/b"
	result_str+="$result"
done
echo "_______________"
echo "R E S U L T - > " "$result_str"
