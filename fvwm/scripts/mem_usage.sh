#!/bin/sh
# 已使用内存百分比
mem=`free | grep Mem | awk '{print $3/$2 * 100.0}' | awk '{print int($1+0.5)}'`
echo "Mem:" $mem%
