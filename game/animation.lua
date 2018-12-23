local animation = {}
animation.__index = animation
function Animation:New(image, timeperframe, fh, fw, frames)
    local a = {}
    a.img = image
    a.delay = timeperframe
    a.fw = fw
    a.fh = fh
    a.position = 0
    a.playing = true
    a.speed = 1
    local imgw = a.img:getWidth()
    local imgh = a.img:getHeight()
    local rowlength = (imgw/fw)
    a.frames = {}
    for i= 0, frames do
      col = i%cols
      row = i/cols
      temp = love.graphics.newQuad(i*fw, i*fh, fw, fh, imgw, imgh)
      table.insert(a.frames, temp)
    end
    