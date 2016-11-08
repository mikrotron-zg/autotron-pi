#!/bin/bash

if pgrep python
then
	kill $(pgrep python) > /dev/null 2>&1
	echo "python dieded."
else
	echo "python already ded."
fi

if pgrep mjpg_streamer
then
	kill $(pgrep mjpg_streamer) > /dev/null 2>&1
	echo "mjpg_streamer dieded."
else
	echo "mjpg_streamer already ded."
fi
