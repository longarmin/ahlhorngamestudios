Entity = {}
Entity.__index = Entity

function Entity:Create(object)
  object = self
  setmetatable(object, self)
  --self.__index = self
  
  return object
end

function Entity:New(Name, XPos, YPos, Velo, DistOfAppearance)
  object = {}
  object.Name = Name
  object.dim = {}
  object.dim.x = XPos
  object.velo = Velo
  object.const_time = DistOfAppearance
  object.DistOfAppearance = DistOfAppearance
  if Name == "Hazelnut" then
    object.stdGraphic = love.graphics.newImage("Hazelnut.png")
  elseif Name == "Opponent1" then
    if object.velo < 0 then
      object.stdGraphic = love.graphics.newImage("Opponent1neg.png")
    else
      object.stdGraphic = love.graphics.newImage("Opponent1.png")      
    end
  else
    object.stdGraphic = love.graphics.newImage("NotFound.png")
  end
  object.dim.w = object.stdGraphic:getWidth()
  object.dim.h = object.stdGraphic:getHeight()
  object.dim.y = -object.dim.h
  object.dim.ox = object.stdGraphic:getWidth()/2
  object.dim.oy = object.stdGraphic:getHeight()/2   
  object.collider = collider:rectangle(object.dim.x+object.dim.w/2, object.dim.y+object.dim.h/2, object.dim.w, object.dim.h)   
  return object
end