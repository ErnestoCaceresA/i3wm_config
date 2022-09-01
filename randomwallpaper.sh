#!/bin/env bash

############################################################
# Written by JayVii                                        #
# Script for setting background in a simple, lightweight   #
# manner. Features include:                                #
# - Online sources                                         #
# - Slide show                                             #
# Makes use of "feh" to set the wallpaper in an ESETROOT   #
# fashion, compatible with most windowmanagers             #
############################################################

## CONFIG ##################################################
# wallpaper-style: "bg-scale","bg-center"                  #
FEH_STYLE="bg-scale"
# wallpaper-source-type: "url","directory","single"        #
FEH_SOURCE_TYPE="directory"
# wallpaper-source: full path or direct URL                #
FEH_SOURCE="${HOME}/wallpapers/"
# wallpaper-interval: in seconds (5 minutes: "300")        #
FEH_INTERVALL="200"
# change-notify: "true","false" (requires libnotify)       #
FEH_NOTIFY="false"
############################################################

# DIRECTORY
if [ $FEH_SOURCE_TYPE = "directory" ]; then
	FEH_IMAGES=$(find "$FEH_SOURCE" | grep -i ".jpg\|.jpeg\|.png\|.bmp\|.gif")
	FEH_NUMBER=$(echo "$FEH_IMAGES" | wc -l)
	while ((1 > 0)); do
		FEH_THISONE=$((RANDOM%${FEH_NUMBER}+1))
		FEH_WALLPAPER=$(echo "$FEH_IMAGES" | sed -n "${FEH_THISONE}","${FEH_THISONE}"p)
		feh --${FEH_STYLE} "$FEH_WALLPAPER" &
		# Notification (requires libnotify)
		if [ $FEH_NOTIFY = "true" ]; then
			notify-send -t 3 "FEH" "Changed Wallpaper"
		fi
		sleep $FEH_INTERVALL
	done
# SINGLE and URL
elif [ $FEH_SOURCE_TYPE = "single" ] || [ $FEH_SOURCE_TYPE = "url" ]; then
	feh --${FEH_STYLE} "$FEH_SOURCE" &
	# Notification (requires libnotify)
	if [ $FEH_NOTIFY = "true" ] && [ -z "/usr/bin/notify-send" ]; then
		notify-send -t 3 "FEH" "Changed Wallpaper"
	fi
else
	# Error-Notification (requires libnotify)
	if [ -z "/usr/bin/notify-send" ]; then
		notify-send -t 0 "FEH" "Error! Please check your config!"
	fi	
	echo "FEH ERROR!"
	echo "Something is wrong with your configuration! Please check the \"CONFIG\" section of the script!"
fi	
