#!/bin/bash
IN="eDP-1"
EXT="HDMI-1"
if (xrandr | grep "$EXT disconnected")
then
    xrandr --output $IN --auto --output $EXT --off
else
    xrandr --output $IN --mode 1366x768 --primary --output $EXT --mode 1360x768 --same-as $IN
fi
