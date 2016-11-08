
# TCP klijent za jednostavno upravljanje WiFi robotom
# 2-bajtne naredbe, 1. bajt je naredba, 2. bajt je argument
# Dostupne naredbe:
# s - argument nevazan, zaustavlja motore
# f* - oba motora prema naprijed brzinom *, dopusten raspon 0-255 odgovara vrijednostima PWM izlaza na arduino platformi, 255=100% cycle
# b* - oba motora nazad
# l* - skretanje lijevo brzinom *, nacin ovisi o programu na robotu
# r* - skretanje desno
# Robot moze skretati oko proizvoljne pivot tocke!
# Ukoliko oba motora rade u suprotnim smjerovima, pivot tocka je na pola puta izmedju pogonskih kotaca
# Ako jedan motor stoji, a drugi radi, pivot tocka je kotac koji stoji
# Mijenjanjem relativne brzine kotaca moguce je postici proizvoljan luk zaokreta

# Tomislav Mamic, MIKROTRON d.o.o. 10.2.2016.

import socket
import os
import time
import pygame, sys
from pygame.locals import *

# pygame prozor koristim za hvatanje dogadjaja s tipkovnice na razini OS-a

pygame.init()
bg = (0,0,0)
w = 100
h = 100
windowSurface = pygame.display.set_mode((w, h), 0, 32)

windowSurface.fill(bg)

# podaci o serveru na robotu - moze ih se ocitati pri paljenju iz serial monitora (Arduino IDE)

host = "192.168.0.161"
port = 9988

# funkcija za slanje naredbe robotu

def Command(command):
	try:									# hvataj gresku!
		time.sleep(0.05)					# recimo ne spamu
		print "connecting..."
		sock=socket.socket()				# stvori novi socket
		sock.settimeout(1.2)				# maksimalno dopusteno cekanje u sekundama, proizvoljno/empirijski - server ponekad uspije odreagirati
		sock.connect((host,port))			# spoji socket na server na robotu
		print "sending..."
		sock.sendall(command)				# posalji naredbu
		sock.close()						# zatvori vezu
		print "closed connection."
	except socket.error, msg:				# ako je uhvacena greska na socketu, ispisi je
		print msg

# glavna petlja programa		
		
run=True

while run:
	cmd="s"										# naredba "s"(stop), ostaje nepromjenjena ako ne diramo tipke smjera
	if pygame.event.peek(QUIT):					# zatvorimo li pygame prozor, program staje
		run=False
	for event in pygame.event.get():			# praznjenje OS event queuea - vrlo vazno jer u protivnom OS misli da se program zablokirao
		None
	keys=pygame.key.get_pressed()				# ocitaj stanje tipkovnice
	if keys[pygame.K_UP]!=0:
		cmd="f"+chr(150)						# ako je pritisnuta tipka gore, naredba je "f"(forward) i char 100 ("d") koji se tumaci kao brzina
	if keys[pygame.K_DOWN]!=0:
		cmd="b"+chr(150)						# analogno "b"(back)
	if keys[pygame.K_LEFT]!=0:
		cmd="l"+chr(150)						# "l"(left)
	if keys[pygame.K_RIGHT]!=0:
		cmd="r"+chr(150)						# "r"(right)
	Command(cmd)								# posalji odabranu naredbu
	print "request: ", cmd

os.system("pause")