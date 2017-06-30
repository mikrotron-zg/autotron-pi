# WebSock klijent za jednostavno upravljanje WiFi robotom
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

#from msvcrt import getch
from getch import getch

from autobahn.asyncio.websocket import WebSocketClientProtocol, \
    WebSocketClientFactory

try:
    import asyncio
except ImportError:
    import trollius as asyncio


class MyClientProtocol(WebSocketClientProtocol):

    def onConnect(self, response):
        print("Server connected: {0}".format(response.peer))

    async def onOpen(self):
        print("WebSocket connection open.")

        # slanje komandi
        while True:
            key=getch()
            
            if ord(key)==113:
                self.sendMessage('ss'.encode('ascii'))
                quit()
            if ord(key)==120:
                cmd='ss'
            if ord(key)==119:
                print("fwd")
                cmd='f'+chr(100)
            if ord(key)==115:
                print("back")
                cmd='b'+chr(100)
            if ord(key)==97:
                print("left")
                cmd='l'+chr(100)
            if ord(key)==100:
                print("right")
                cmd='r'+chr(100)
            self.sendMessage(cmd.encode('ascii'))

    def onMessage(self, payload, isBinary):
        if isBinary:
            print("Binary message received: {0} bytes".format(len(payload)))
        else:
            print("Text message received: {0}".format(payload.decode('utf8')))

    def onClose(self, wasClean, code, reason):
        print("WebSocket connection closed: {0}".format(reason))


if __name__ == '__main__':

    factory = WebSocketClientFactory(u"ws://192.168.0.161:9000")
    factory.protocol = MyClientProtocol

    loop = asyncio.get_event_loop()
    coro = loop.create_connection(factory, '192.168.0.161', 9000)
    loop.run_until_complete(coro)
    loop.run_forever()
    loop.close()
