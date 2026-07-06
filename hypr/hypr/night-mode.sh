#!/bin/bash

if pgrep -x "hyprsunset" > /dev/null; then
	killall -9 hyprsunset
	notify-send "Night mode" "Off" -u "low"
else
	hyprsunset -t 4000 &
	notify-send "Night mode" "On" -u "low"
fi
