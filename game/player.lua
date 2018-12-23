player = {}
player.__index = player

setmetatable(player, {
  __call = function (cls, ...)
    return cls.Init(...)
  end,
 })

function player.Init(SpriteDir, ImgW, ImgH, delay, frames)
  local self = setmetatable({}, player)
  
  local puschelImg = love.graphics.newImage("animation/skateboard_squirrel.png")
  self.puschel={}
  self.polo={}
  self.puschel= newAnimation(puschelImg, 74, 126, 0.1, 7)
  --self.puschel.w = self.puschel.animation:getWidth()
  --self.puschel.h = self.puschel.animation:getHeight()
  self.animation = newAnimation(SpriteDir, ImgW, ImgH, delay, frames) 
  --self.puschel.w = self.polo.animation.getWidth(self.polo.animation)
  --self.puschel.h = self.polo.animation.getHeight(self.polo.animation)
    self.dim = { 
      x = 400,
      y = 400,
      w = ImgW,
      h = ImgH
      --w = self.stdGraphic:getWidth(),
      --h = self.stdGraphic:getHeight()
    }
  self.hazelcount = 0
  self.xvelo = 0
  self.yvelo = 0
  self.collider = {}
  --self.collider = collider:rectangle(self.dim.x, self.dim.y, self.dim.w, self.dim.h)
  self.collidedobjectshape = {}
  self.collider = collider:rectangle(self.dim.x, self.dim.y, self.dim.w, self.dim.h)
  return self
end

function player:StateInit(vehicle)
  self.animation = vehicle.animation
  vehicle.w, vehicle.h = vehicle.animation.getSpriteSize()
  self.collider = collider:rectangle(self.dim.x, self.dim.y, vehicle.w, vehicle.h)
end

function player:Update(dt)
   if love.keyboard.isDown("right") and self.xvelo < 10 then
      self.xvelo = self.xvelo + dt*16
    elseif love.keyboard.isDown("left") and self.xvelo > -10 then
      self.xvelo = self.xvelo - dt*16
    elseif self.xvelo > 0 then
      self.xvelo = self.xvelo - 8*dt
    elseif self.xvelo < 0 then
      self.xvelo = self.xvelo + 8*dt
  end    
  if love.keyboard.isDown("up") and self.yvelo < 256 then
    self.yvelo = self.yvelo + 32*dt
  end
  if love.keyboard.isDown("down") and self.yvelo > 64 then
    self.yvelo = self.yvelo - 32*dt
  end    
  self.dim.x = self.dim.x + self.xvelo
  
  self.TurningAngle = math.atan(self.xvelo*(math.abs(self.xvelo))/self.yvelo)  
    
  self.collider:moveTo(self.dim.x + self.dim.w/2, self.dim.y + self.dim.h/2)
  if(self.yvelo ~= 0) then
    self.collider:setRotation(self.TurningAngle)
  end
  
  if self.hazelcount > 0 then
--puschel = player( puschelImg, 128, 128, 0.1, 7)
    --self.StateInit(self.puschel)
    self.animation = self.puschel
    self.dim.w, self.dim.h = self.animation:getSpriteSize()
    self.collider = collider:rectangle(self.dim.x, self.dim.y, self.dim.w, self.dim.h)
    self.hazelcount = 0
  end
  
end

function player:Draw(dt)
  love.graphics.translate(racecar.dim.x + racecar.dim.w/2, racecar.dim.y + racecar.dim.h/2)
  love.graphics.rotate(racecar.TurningAngle) 
  racecar.animation:draw(-racecar.dim.w/2,-racecar.dim.h/2)
end

  
  --self.animation = newAnimation(SpriteDir, ImgW, ImgH, delay, frames)  