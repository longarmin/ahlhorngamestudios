function intro:update(dt)
  state1time = state1time + dt
  if state1time > 2 then
    --debug.debug()
    gamestate.switch(game)
  end
end

function intro:keypressed()
  gamestate.switch(game)
end

function intro:draw()
  love.graphics.setBackgroundColor(128,128,128, 255)
  local texty = love.graphics.newText(mainFont, "Madeleine's Polo Racing")
  love.graphics.draw(texty, (windowwidth-texty:getWidth())/2, (windowheight-texty:getHeight())/2)
end

  