--  === Includes ===    
  require('lib/AnAl')
  HC = require 'HC'
  gamestate = require("hump.gamestate")
  pause      = {}
  intro      = {}
  game       = {}
  gamelevel2 = {}
  gameover   = {}
  require("gamestate1")
  require("gamestate2")
  require("gamestate3")
  require("player")
  require("pause")
  require("entity")

-- Load some default values for our rectangle.
function love.load(arg)
  if arg and arg[#arg] == "-debug" then require("mobdebug").start() end

  
--  === some general Definitions ===
  MAXNUMENTITIES = 20
  windowwidth, windowheight = love.graphics.getDimensions()
  mainFont = love.graphics.newFont("Carnevalee Freakshow.ttf", 50)
  debugFont = love.graphics.newFont("arialbd.ttf", 15)
  
--  === Variables needed for Update-Routines ===    
  dt_global = 1
  dist = 0
  time = 0
  totaldist = 0
  --gamestate = 1
  state1time = 0
  state3time = 0
  i=1    
  TurningAngle = 0
  pTurningAngle = TurningAngle
--  === Definition of Collider ===
  
  collider = HC.new(150)

--  ===Definition of Racecar===
local puschelImg = love.graphics.newImage("animation/skateboard_squirrel.png")
local poloImg = love.graphics.newImage("racecar.png")

polo = player(poloImg, 128, 128, 1, 1) 
puschel = player( puschelImg, 128, 128, 0.1, 7)
racecar = polo

  
--  === Definition of Track, Lanes and Banners ===
  lane = {}
  lane.xbanleft = 20
  lane.xbanright = (windowwidth-40)
  lane.yban = 120
  lane.w = 20
  lane.h = 60
  lane.colliderRight = collider:rectangle(lane.xbanright, 0, lane.w, windowheight)
  lane.colliderLeft = collider:rectangle(lane.xbanleft, 0, lane.w, windowheight)
  lane.canvas = love.graphics.newCanvas(windowwidth, windowheight+lane.yban)
  HUDCanvas = love.graphics.newCanvas(windowwidth,windowheight)
  --lane.bannerrightentity =Entity:New('Banner', lane.xbanright, windowheight, 0)
  --lane.bannerleftentity = Entity:New('Banner', lane.xbanleft, windowheight, 0)

--  === Definitions of generic Entity Class ===

  ActiveEntities = {}
  EntityPositionTable = {
    {Name="Hazelnut",  200, -700,  0  , 100},
    {Name="Hazelnut",  200, -1400, 0  , 3000},
    {Name="Hazelnut",  600, -2500, 0  , 1300},
    {Name="Opponent1", 200, -500,  64 , 500},
    {Name="Opponent1", 300, -2500, 128, 1000},
    {Name="Opponent1", 300, -3500, 150, 1500},
    {Name="Opponent1", 100, -3500, 140, 2000},
    {Name="Opponent1", 400, -2500, 200, 2500},
    {Name="Opponent1", 200, -2000, 200, 3000},
    {Name="Opponent1", 600, -500, -20,  3500}
  }

  EntityList = {}
  --table.insert(EntityList, lane.bannerrightentity)
  --table.insert(EntityList. lane.bannerleftentity)
  for j,current in next,EntityPositionTable do
    local NewEntity = {}
    --local NewEntity = Entity:Create()
    NewEntity = Entity:New(current.Name, current[1], current[2], current[3], current[4])
    table.insert(EntityList, NewEntity)
  end
    
gamestate.registerEvents()
gamestate.switch(intro)

end
 


--function love.keypressed(key)
--  if gamestate.current() == game and key == 'p' then
--    return gamestate.push(pause)
--  end
--end

--   function NewVehicle(SpriteDir, ImgW, ImgH, delay, frames)
--    racecar = player( SpriteDir, ImgW, ImgH, delay, frames ) 
--    --racecar.animation = newAnimation(SpriteDir, ImgW, ImgH, delay, frames)
--    --local puschelImg = love.graphics.newImage("animation/skateboard_squirrel.png")
--    --local poloImg = love.graphics.newImage("racecar.png")
--    --racecar.stdGraphic= love.graphics.newImage("racecar.png")
--    --racecar.polo = newAnimation(poloImg, 128, 128, 1, 1)
--    --racecar.animation = racecar.polo
----    racecar.dim =
----    { 
----      x = 400,
----      y = 400,
----      w = ImgW,
----      h = ImgH
----      --w = racecar.stdGraphic:getWidth(),
----      --h = racecar.stdGraphic:getHeight()
----    }
----    racecar.hazelcount = 0
----    racecar.xvelo = 0
----    racecar.yvelo = 0
----    racecar.collider = {}
----    racecar.collider = collider:rectangle(racecar.dim.x, racecar.dim.y, racecar.dim.w, racecar.dim.h)
----    racecar.collidedobjectshape = {}
--    return racecar
--  end 