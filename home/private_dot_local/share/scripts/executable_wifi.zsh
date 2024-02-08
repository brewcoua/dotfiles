#!/bin/zsh

if [ $(nmcli radio wifi) = 'enabled' ]; then
	nmcli radio wifi off
	notify-send -i airplane-mode-symbolic "Wireless" "Wireless disabled"
	echo "wifi off"
else
	nmcli radio wifi on
	notify-send -i network-wireless "Wireless" "Wireless enabled"
	echo "wifi on"
fi
