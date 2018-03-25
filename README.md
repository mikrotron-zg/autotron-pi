# Autotron Pi
Software for robotic car based on Rasberry Pi. Old version was based on RPi 3, the new one is ported to Zero W, introducing some software and hardware changes in the progress. The project status can be checked out at [Hackaday project page](https://hackaday.io/project/94433-autotron-pi-zero).

# Versions

Current version of Autotron Pi is based on Pi Zero W, and is currently under development. For stable version (based on RPi 3) please check v1.0 release.

# Setup

On board servers (video and command server) installation basics are available under v1.0. As the Zero W setup differes slightly, it will be documented as the project progresses.

# Usage

Once running, the stream is available on :8080/?action=stream as an MJPG stream. A simple preview can be accessed at :8080/stream_simple.html.

Command server using websocket (wsock_server3.py) listens for commands on port 9000. For details on available commands and how to use them, please refer to the example code.
