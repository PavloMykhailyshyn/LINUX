#!/bin/bash
SUN1="  |/_";
SUN2="   /_";
SUN3="    _";
SUN4="_    ";
SUN5="_\   ";
SUN6="_\|  ";
SUN7="_\|/ ";
SUN8="_\|/_";
SUN9=" \|/_";
SUNNY=("$SUN1" "$SUN2" "$SUN3" "$SUN4" "$SUN5" "$SUN6" "$SUN7" "$SUN8" "$SUN9");
#MSG=("Copying files..." "Copying files .." "Copying files  ." "Copying files.  " "Copying files.. "); 
COLS=$(tput cols);
LINES=$(tput lines); 
FILES_AMOUNT=$(find $1 -type f | wc -l);
LENGTH_FILES_AMOUNT=$(expr length "$FILES_AMOUNT");
for ((i=0; i<$LINES; ++i))
do
	printf "\n";
done
for ((i=0; i<$COLS; ++i))
do
	underscore+="_";
done
printf "Copying files...\n";
echo $underscore
let "str_length=COLS-2*LENGTH_FILES_AMOUNT-12";
for ((i=0; i<$str_length; ++i))
do
	str+=" ";
done
element_count=${#SUNNY[*]};
j=0;
k=1;
if [ $FILES_AMOUNT -gt $str_length ]
then
	let "stars_amount=FILES_AMOUNT/str_length";
	let "remainder=stars_amount*str_length";
else
	stars_amount=1;
	remainder=0;
fi
check="true";
new_str=$str;
find $1 -type f | while read FILENAME;
do
	if [ $j -eq $element_count ]
	then
		j=0;
	fi
	if [ $(($k - $remainder)) -eq 0 ]
	then
		check="false";
	fi
	if [ $(($k % $stars_amount)) -eq 0 ]
	then
		if [[ $check == "true" ]]
		then
			star+="*";
			str="${str%?}";
			new_str=$star$str;
		fi
	fi
	cp "$FILENAME" /dev/null
	printf "%s%s%s%s%d/%d\r" "${SUNNY[j]}" " | " "$new_str" "| " "$k" "$FILES_AMOUNT";
	let j=$[j+1];
	let k=$[k+1];
	#sleep 1;
done

