#!/bin/bash

#Calculation delay. Without a delay, there is no way to determine current 
#values. The content or /proc/stat is cumulitative from last boot.  
# in seconds; sleep must be able to support float values
dly=0.25

function calculate {

#load arrays
IFS=' ' read -r -a firstarr <<< "$1"
IFS=' ' read -r -a secondarr <<< "$2"

#clear name fields in array so that calculations don't get messy
firstarr[0]=0 ;
secondarr[0]=0 ;

#clear values 
firsttotcpu=0
secondtotcpu=0

#calculate the begining interrupt counts
for f in ${firstarr[@]}; 
    do 
        let firsttotcpu+=$f; 
done
firstidle=$((${firstarr[4]}+${firstarr[5]})); 

#calculate the ending interrupt counts
for l in ${secondarr[@]}; 
    do
        let secondtotcpu+=$l; 
    done; 
secondidle=$((${secondarr[4]}+${secondarr[5]})); 

#calculate the relative change counts
insttotcpu=$(( secondtotcpu - firsttotcpu ))
instidle=$(( secondidle - firstidle ))

#calculate the utilization percentage. must be done external to bash as it's a
#floating calculation
cpu_load=$( echo | awk -v tot=$insttotcpu -v idl=$instidle ' { print ( ( ( tot - idl ) / tot ) * 100 ) } ' )

echo $cpu_load


} 
export -f calculate

#main execution

oldIFS=$IFS

IFS=$'\n' cpu_start=( $( grep cpu /proc/stat ) );

#must delay to get difference
sleep $dly

IFS=$'\n' cpu_end=( $( grep cpu /proc/stat ) );

cpucount=${#cpu_start[@]}

#uncomment this for loop to enable printing the cpu name above the percentages
#for i in ${cpu_start[@]};
#    do
#        IFS=' ' read -r -a name <<< "$i"
#        echo -n ${name[0]} " "
#done
#echo ""

data_list=()

for (( i=0; i<$cpucount; i++ ))
    do
	usage=`calculate "${cpu_start[$i]}" "${cpu_end[$i]}"`
	data_list+=( $(printf "%.0f" $usage) )

done

load=`echo "${data_list[*]}" | sort -nr | head -n1`
echo "CPU: $load"

IFS=$oldIFS
