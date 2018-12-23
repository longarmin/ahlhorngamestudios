function pause:enter(from)
  self.from = from
end
function pause:draw()
  self.from.draw()
  love.graphics.setColor(0, 0, 0, 100)
  love.graphics.rectangle('fill', 0, 0, windowwidth, windowheight)
  love.graphics.setColor(255, 255, 255)
  love.graphics.printf('PAUSE', 0, windowheight/2, windowwidth, 'center')
end

function pause:keypressed(key)
  if key == 'p' then
    return gamestate.pop()
  end
end

