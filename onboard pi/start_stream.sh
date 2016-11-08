#!/bin/bash

echo "starting stream!"


if [ ! -d /tstream ]
then
	mkdir /tstream/
	echo "defaulting to sd buffer."
fi

if pgrep python > /dev/null
then
	echo "python already running."
else
	python3 wsock_server3.py &
	echo "command server started."
	python pstream.py &
	echo "python stream started."
fi

if pgrep mjpg_streamer >/dev/null
then
	echo "mjpg_streamer already running."
else
	LD_LIBRARY_PATH=/usr/local/lib mjpg_streamer -i "input_file.so -f /tstream -n pic.jpg" -o "output_http.so -w /usr/local/www" > /dev/null 2>&1&
	echo "mjpg_streamer started."
fi
