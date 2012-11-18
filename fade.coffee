# serial port of the arduino
TTY = '/dev/ttyACM0'
# socket.io port
SIO = 4568
# LEDs off
LED_OFF = '255 255 255 255 255 255\n'
# LEDs on
LED_ON = '0 0 0 0 0 0\n'

___ = (x) -> console.log x
color = (require 'onecolor') 'hsv(0,100%,100%)'
fs = require 'fs'

counter = 0
leds = [0, 0]
serial = fs.openSync TTY, 'w'
___ "opened #{TTY} #{serial}"

# startup sequence
setTimeout (->
  w = fs.writeSync serial, LED_OFF
  ___ "off #{w}"
  setTimeout (->
    w = fs.writeSync serial, LED_ON
    ___ "on #{w}"), 1000), 500

serialize = (hue) ->
  {_red:r, _green:g, _blue:b} = (color.hue hue).rgb()
  (''+(255-Math.floor chan*255) for chan in [r, g, b]).join ' '

update = (side, d) ->
  leds[side] = d
  s = "#{serialize leds[0]} #{serialize leds[1]}\n"
  w = fs.writeSync serial, s
  ___ "written #{w}"

io = (require 'socket.io').listen SIO
io.sockets.on 'connection', (s) ->
  s.on 'left', (d) -> update 0, d
  s.on 'right', (d) -> update 1, d
___ "opened socket.io #{SIO}"
