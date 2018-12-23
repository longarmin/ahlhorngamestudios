  function gameover:update(dt)
   if state3time < .2 then
    love.graphics.setColor(0,255,255)
    else
      love.graphics.setColor(255,255,255)
    end
    if state3time < .4 then
       state3time = state3time + dt
     else
       state3time = 0
     end
     function love.keypressed(key)
      if key == "escape" then
        love.event.push('quit')
      end
    end
  end

function gameover:draw()
  --texti=love.graphics.printf({"GAME OVER!"}, (windowwidth-500)/2, (windowheight-50)/2, 500, "center")
  love.graphics.setBlendMode("alpha")
  texty = love.graphics.newText(mainFont, "Game Over!")
  love.graphics.draw(texty, (windowwidth-texty:getWidth())/2, (windowheight-texty:getHeight())/2)
end