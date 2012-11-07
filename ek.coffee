___ = (x) -> console.log x

P = '/dev/ttyACM0'
color = (require 'onecolor') 'hsv(0,100%,100%)'

serialize = (hue) ->
  {_red:r, _green:g, _blue:b} = (color.hue hue).rgb()
  (''+(255-Math.floor chan*255) for chan in [r, g, b]).join ' '

State =
  left: 0
  right: 0

serial = null
update = (side, d) ->
  ___ [side, d]
  State[side] = d
  s = "#{serialize State.left} #{serialize State.right}\n"
  ___ s
  ___ fs.writeSync serial, s

fs = require 'fs'
serial = fs.openSync P, 'w'
fs.writeSync serial, '255 255 255 255 255 255\n'
setTimeout (-> fs.writeSync serial, '0 0 0 0 0 0\n'), 1000

io = (require 'socket.io').listen 4567
io.sockets.on 'connection', (s) ->
  s.on 'left', (d) -> update 'left', d
  s.on 'right', (d) -> update 'right', d