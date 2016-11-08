import signal
import sys
from time import sleep
from picamera import PiCamera

def signal_handler(signal,frame):
	print('stopping')
	sys.exit(0)

signal.signal(signal.SIGINT, signal_handler)

def spoofer():
	while 1:
		yield '/tstream/pic.jpg'

#init cam
cam=PiCamera()
cam.resolution=(320,240)
cam.framerate=30
cam.iso=200
cam.hflip=True
cam.vflip=True
print "starting cam..."
sleep(2)
# fix settings
cam.shutter_speed=cam.exposure_speed
cam.exposure_mode='off'
g=cam.awb_gains
cam.awb_mode='off'
cam.awb_gains=g
#start stream
print "streaming..."
while 1:
	cam.capture('/tstream/pic.jpg',use_video_port=True)
