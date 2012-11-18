#intended API: constructor, move, x, y
class Puck
  constructor: (@x, @y, @radius) ->
    @color = 'black'
    socket.on 'puck_pos', (x, y, dx, dy) =>
      @x = x
      @y = y
      @dx = dx
      @dy = dy

  move: (paddle1, paddle2) ->
    @x += @dx
    @y += @dy

    if @x < @radius
      @x = @radius
      @dx *= -1
    if @x > global.canvas_width - @radius
      @x = global.canvas_width - @radius
      @dx *= -1
    if @y < @radius
      @_reset()
    if @y > global.canvas_height - @radius
      @_reset()

    if @_collidedWith(paddle1)
      @_bouncePuck(paddle1)
    else if @_collidedWith(paddle2)
      @_bouncePuck(paddle2)

  _collidedWith: (paddle) ->
    if @x - @radius < paddle.x + paddle.width/2 && @x + @radius > paddle.x - paddle.width/2
      if (@y - @radius < paddle.y + paddle.height/2 && @y > paddle.y) || (@y + @radius > paddle.y - paddle.height/2 && @y < paddle.y)
        return true
    return false

  _bouncePuck: (paddle) ->
    @dx += (Math.random()*10 - 5)
    #surely there's some way to get rid of this duplication
    if paddle.y < canvas.height
      @dy = Math.abs(@dy)
      @dy += 0.2
      @y = paddle.y + paddle.height + @radius
    else
      @dy = Math.abs(@dy) * -1
      @dy -= 0.2
      @y = paddle.y - paddle.height/2 - @radius

  _reset: ->
    @x = global.canvas_width/2
    @y = global.canvas_height/2
    @dx = Math.random()*10 - 5
    @dy = Math.random()*10 - 5
    #make sure it's not super slow
    if Math.abs(@dy) < 0.5 then @dy *= 10
    if Math.abs(@dy) < 2.5 then @dy *= 2
module.exports = Puck