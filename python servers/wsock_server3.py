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

from autobahn.asyncio.websocket import WebSocketServerProtocol, \
    WebSocketServerFactory


class MyServerProtocol(WebSocketServerProtocol):

    def onConnect(self, request):
        print("Client connecting: {0}".format(request.peer))

    def onOpen(self):
        print("WebSocket connection open.")

    def onMessage(self, payload, isBinary):
        print("got", payload)
        msg=payload.decode(encoding='ascii')
        spd=ord(msg[1])
        if msg[0]=='f':
            fwd(spd)
            print("fwd@",spd)
        elif msg[0]=='b':
            back(spd)
            print("back@",spd)
        elif msg[0]=='l':
            left(spd)
            print("left@",spd)
        elif msg[0]=='r':
            right(spd)
            print("right@",spd)
        else:
            stop()
            print("stop")

    def onClose(self, wasClean, code, reason):
        print("WebSocket connection closed: {0}".format(reason))


if __name__ == '__main__':
    import asyncio

    factory = WebSocketServerFactory(u"ws://127.0.0.1:9000")
    factory.protocol = MyServerProtocol

    loop = asyncio.get_event_loop()
    coro = loop.create_server(factory, '0.0.0.0', 9000)
    server = loop.run_until_complete(coro)

    try:
        loop.run_forever()
    except KeyboardInterrupt:
        pass
    finally:
        server.close()
        loop.close()
