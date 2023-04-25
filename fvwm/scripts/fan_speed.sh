#!/bin/bash
CPU_FAN=fan2

sensors | grep $CPU_FAN | sed -n 's/RPM.*//; s/.*[:]//; p; q' | bc
