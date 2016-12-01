# autotron-pi
Software for robotic car based on Rasberry Pi 3

# Setup

First step is to connect to RPi to your network. First connection is done via a lan cable, after which access to RPi via ssh is possible. Once logged in, refer to https://www.raspberrypi.org/documentation/configuration/wireless/wireless-cli.md for info on how to set up the wifi.

Once desired network connectivity is achieved, one may start up streaming and control server scripts. It is possible to start each individually, but for standard operation, scripts start_stream and stop_stream are provided. If running other python functionality on the same device, please remember that start_stream and stop_stream do not discriminate between python scripts and may cause unexpected behaviour in your other applications.

For any practical application, ssh to your autotron, log into it and start up the servers by typing in sudo sh start_stream.sh. If you wish to stop the servers, do the same with stop_stream.sh script.

Note however that start_stream script runs automatically at startup. This can changed by removing the corresponding command in crontab (access by crontab -e).

# Usage

Once running, the stream is available on :8080/?action=stream as an MJPG stream. A simple preview can be accessed at :8080/stream_simple.html.

Command server using websocket (wsock_server3.py) listens for commands on port 9000. For details on available commands and how to use them, please refer to the example code.
