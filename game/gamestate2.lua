local t = 0
function game:enter()
  love.graphics.setCanvas(lane.canvas)
  love.graphics.clear()
  love.graphics.setBlendMode("alpha")
    for i=-2,(windowheight/lane.h),2 do
     love.graphics.setColor(255,0,255)    
     love.graphics.rectangle("fill", lane.xbanleft, lane.h*i, lane.w, lane.h)
     love.graphics.rectangle("fill", lane.xbanright, lane.h*i, lane.w, lane.h)
     love.graphics.setColor(255,255,255)
     love.graphics.rectangle("fill", (windowwidth/2-5), lane.h*i, 10, 40)
     love.graphics.setColor(0,255,0)
     love.graphics.rectangle("fill", lane.xbanleft, lane.h*(i+1), lane.w, lane.h)
     love.graphics.rectangle("fill", lane.xbanright, lane.h*(i+1), lane.w, lane.h)
  end
  love.graphics.setColor(255,255,255,255)
  love.graphics.setCanvas()
  racecar.animation:play()
  racecar.animation:setMode("loop")
end
function game:update(dt)
    -- set dt smaller for debugging purposes
    if(dt > 1) then
      dt =.1
    end
    dt_global = dt
    
--    if love.keyboard.isDown("right") and racecar.xvelo < 10 then
--      racecar.xvelo = racecar.xvelo + dt*16
--    elseif love.keyboard.isDown("left") and racecar.xvelo > -10 then
--      racecar.xvelo = racecar.xvelo - dt*16
--    elseif racecar.xvelo > 0 then
--      racecar.xvelo = racecar.xvelo - 8*dt
--    elseif racecar.xvelo < 0 then
--      racecar.xvelo = racecar.xvelo + 8*dt
--    end    
--    if love.keyboard.isDown("up") and racecar.yvelo < 256 then
--      racecar.yvelo = racecar.yvelo + 32*dt
--    end
--    if love.keyboard.isDown("down") and racecar.yvelo > 64 then
--      racecar.yvelo = racecar.yvelo - 32*dt
--    end
--    racecar.dim.x = racecar.dim.x + racecar.xvelo

    racecar:Update(dt)
    --calculate Distance for bypassing environment (z.B. Fahrbahnbegrenzung)
    dist = (dist + racecar.yvelo*dt)%(2*lane.h)
    totaldist = totaldist + racecar.yvelo*dt
    time = time + dt

   
  
  --Activate affected Entities (shift'em into ActiveEntities table)
      for i, entity in next, EntityList do --and i < MAXNUMENTITIES do
        --v.dim.y = v.dim.y + (v.velo + racecar.yvelo)*dt
        --if v.dim.y + v.dim.h > 0 then
        if entity.DistOfAppearance < totaldist then  
          table.insert(ActiveEntities, entity)
          table.remove(EntityList, i)
          i=i-1
          --hier fehlt eigentlich ein i = i-1
        end
      end
      
--Check for collisions and erase objects that already passed the screen
    if racecar.collider:collidesWith(lane.colliderLeft) or racecar.collider:collidesWith(lane.colliderRight) then
      gamestate.switch(gameover)
    end
      for i, entity in next, ActiveEntities do
        entity.dim.y = entity.dim.y + (entity.velo + racecar.yvelo)*dt
        if entity.dim.y > (windowheight + entity.dim.h) then
          table.remove(ActiveEntities, i)
          i=i-1
          HC.remove(entity.collider)
          -- i = i - 1 -- kann man machen, damit kein Eintrag übersprungen wird, sobald die Haselnuss aus der Tabelle gelöscht wird. 
          -- Spätestens beim nächsten Durchlauf wird dann alles aktualisiert
        else
          entity.collider:moveTo(entity.dim.x + entity.dim.w/2, entity.dim.y + entity.dim.h/2)
          if entity.collider:collidesWith(racecar.collider) then
            if entity.Name == "Opponent1" or entity.Name == "Banner" then
              gamestate.switch(gameover)
            elseif entity.Name == "Hazelnut" then
              racecar.hazelcount = racecar.hazelcount + 1
--              if racecar.hazelcount > 2 then
--                racecar = puschel
--              end
              table.remove(ActiveEntities, i)
              i=i-1
              HC.remove(entity.collider)
            end
          end
        end       
      end
       
    racecar.animation:update(dt)

    end
  
function game:draw()      
  love.graphics.translate(0,-lane.yban)
  love.graphics.setBlendMode("alpha")
  love.graphics.draw(lane.canvas, 0, dist)
  love.graphics.origin()
  love.graphics.push()
    racecar:Draw(dt)
    --love.graphics.draw(racecar.stdGraphic, -racecar.dim.w/2, -racecar.dim.h/2 )
  love.graphics.pop()

  racecar.collider:draw('line')
  lane.colliderRight:draw('line')
  lane.colliderLeft:draw('line')
  --love.graphics.polygon("line", C.Racecar._polygon.vertices[1].x, C.Racecar._polygon.vertices[1].y, C.Racecar._polygon.vertices[2].x, C.Racecar._polygon.vertices[2].y, C.Racecar._polygon.vertices[3].x, C.Racecar._polygon.vertices[3].y, C.Racecar._polygon.vertices[4].x, C.Racecar._polygon.vertices[4].y)
  love.graphics.setFont(debugFont)
  --Draw Active Enemies
  
  if ActiveEntities ~= nil then
    for i, entity in pairs(ActiveEntities) do
      if entity.stdGraphic ~= nil then
        love.graphics.draw(entity.stdGraphic, entity.dim.x, entity.dim.y)
        love.graphics.setCanvas(HUDCanvas)
          love.graphics.setColor(255, 255, 255)
          love.graphics.setBlendMode("alpha")
          love.graphics.print({"#: ", entity.const_time}, entity.dim.x, entity.dim.y+entity.dim.h)
        love.graphics.setCanvas()
        love.graphics.draw(HUDCanvas)
      end
      entity.collider:draw('line')
    end
  end

   t = HUD(t)
 --Fahrbahnbegrenzung malen 



end


function CheckCollision(a)
  local ColCheck = false
  for shape, delta in pairs(collider:collisions(a)) do
    ColCheck = true
    table.insert(racecar.collidedobjectshape, shape)
  end
  return ColCheck
  
end
--function CheckCollisionSimple(a, b)
--  local a_left = a.x
--  local a_right = a.x + a.w
--  local a_top = a.y
--  local a_bottom = a.y + a.h
  
--  local b_left = b.x
--  local b_right = b.x + b.w
--  local b_top = b.y
--  local b_bottom = b.y + b.h
  
--  return a_left < b_right and a_right > b_left and a_bottom > b_top and a_top < b_bottom
  
--end
function game:keypressed(key)
  if key == "p" then
    return gamestate.push(pause)
  end
end
function love.keypressed(key)
  if key == "escape" then
    ii = 1
    love.event.quit()
  end
end
function HUD(t)
  if t == 0 then
    love.graphics.setCanvas(HUDCanvas)
      love.graphics.clear()
      love.graphics.setColor(255, 255, 255)
      love.graphics.setBlendMode("alpha")
      love.graphics.printf("Madeleine's Polo Racing",250, 10, 300,"center")
      love.graphics.setColor(255,255,255)
      love.graphics.printf(windowheight, 40, 25, 500)
      love.graphics.printf({"yvelo:",racecar.yvelo}, 40, 50, 500)
      love.graphics.printf({"width:",racecar.dim.w}, 40, 75, 500)
      love.graphics.print({"ActiveEntities:", #ActiveEntities}, 40, 150)
     -- love.graphics.print({"ActiveEnemies:",#ActiveEnemies}, 100, 100)
      love.graphics.print({"Totaldist:", totaldist}, 40, 100)
      love.graphics.print({"Number of Entities:", #EntityList}, 40, 125)
--      love.graphics.print({"Number of Enemies:", #EnemyList}, 40, 125)
--      love.graphics.print({"Number of ActiveEnemies:", #ActiveEnemies}, 40, 150)
--      love.graphics.print({"ActiveEnemies: ", #ActiveEnemies}, 40, 175)
      love.graphics.print({"HazelCount: ", racecar.hazelcount}, 40, 200)
      love.graphics.print({"Framerate: ", 1/dt_global}, 40, 225)
      love.graphics.print({"Time:", time}, 40, 250)
      love.graphics.print({"ii = ", ii}, 40, 275)
    love.graphics.setCanvas()
    love.graphics.draw(HUDCanvas)    
  else
    love.graphics.draw(HUDCanvas)
  end
  return (t+1)%5
  --love.graphics.print({"Enemy 1 velo:", EnemyList[1].velo}, 100, 300)
 -- love.graphics.print({"enemytable[1][1]", enemytable[1][1]}, 100, 200)
end


