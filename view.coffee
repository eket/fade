SIO = 'http://localhost:4568'
___ = (x) -> console.log x

_events =
  down: ['mousedown', 'touchstart']
  up: ['mouseup', 'touchend']
  move: ['mousemove', 'touchmove']
_get_x = (e, i=0) -> e.targetTouches?[i].pageX or e.clientX
_get_y = (e, i=0) -> e.targetTouches?[i].pageY or e.clientY
_add_event_listener = (el, event_key, fun) ->
  el.addEventListener event, fun, no for event in _events[event_key]

_init = () ->
  _add_event_listener (document.getElementById 'left'), 'move', (event) ->
    _sock.emit 'left', (_get_y event) / window.innerHeight
    event.preventDefault()
  _add_event_listener (document.getElementById 'right'), 'move', (event) ->
    _sock.emit 'right', (_get_y event) / window.innerHeight
    event.preventDefault()

___ 'initialize socket'
_sock = io.connect SIO
_sock.on 'connect', -> ___ 'connected'