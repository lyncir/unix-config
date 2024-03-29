#!/bin/bash

# 1. get temperature

## a. split response
## Core 0:        +39.0°C  (high = +82.0°C, crit = +100.0°C)
IFS=')' read -ra core_temp_arr <<< $(sensors | grep '^Core\s[[:digit:]]\+:') #echo "${core_temp_arr[0]}"

## b. find cpu usage
total_cpu_temp=0
index=0
for i in "${core_temp_arr[@]}"; do :
    echo $i
    temp=$(echo $i | sed -n 's/°C.*//; s/.*[+-]//; p; q')
    echo $temp
    let index++
    total_cpu_temp=$(echo "$total_cpu_temp + $temp" | bc)
done
avg_cpu_temp=$(echo "scale=2; $total_cpu_temp / $index" | bc)

## c. build entry
temp_status="$avg_cpu_temp°C"
echo $temp_status

exit 0
