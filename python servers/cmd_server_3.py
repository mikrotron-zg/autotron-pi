# command server for driving
import socket
from gpiozero import Motor

# motor control

m1=Motor(17,18)
m2=Motor(4,14)

def stop():
	m1.stop()
	m2.stop()

def fwd(speed):
	m1.forward(speed/255.0)
	m2.forward(speed/255.0)

def back(speed):
	m1.backward(speed/255.0)
	m2.backward(speed/255.0)

def left(speed):
	m1.forward(speed/255.0)
	m2.backward(speed/255.0)

def right(speed):
	m1.backward(speed/255.0)
	m2.forward(speed/255.0)

# cmd listener loop

HOST=''
PORT=9988
sock=socket.socket(socket.AF_INET, socket.SOCK_STREAM)
sock.bind((HOST, PORT))
sock.listen(1)
while True:
	con,add=sock.accept()
	with con:
		con.settimeout(0.2)
		print('accepted', add)
		data=con.recv(1024)
		print('got', data)
		con.close()
		con=None
	if not data:
		print('skipping')
	elif data[0]==ord('s'):
		print('stop')
		stop()
	elif data[0]==ord('f'):
		spd=data[1]
		print('fwd@',spd)
		fwd(spd)
	elif data[0]==ord('b'):
		spd=data[1]
		print('back@',spd)
		back(spd)
	elif data[0]==ord('l'):
		spd=data[1]
		print('left@',spd)
		left(spd)
	elif data[0]==ord('r'):
		spd=data[1]
		print('right@',spd)
		right(spd)
