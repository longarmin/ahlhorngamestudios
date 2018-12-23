    
     Account = {balance = 0}
    
    function Account.withdraw (self, v)
      self.balance = self.balance - v
      self.deposit = 100
    end


Entity = {} 
function Entity:Create()  
  object = {}
  setmetatable(object, self)
  self.__index = self
  return object
end

function Entity.New(self, Name, XPos, YPos, W, H, Type, Velo)
  self.Name = Name
  self.dim = {}
  self.dim.x = XPos
  self.dim.y = YPos
  self.velo = Velo
  if Name == "Hazelnut" then
    self.stdGraphic = "Hazelnut.png"
  elseif Name == "Opponent1" then
    self.stdGraphic = "Opponent1.png"
  else
    self.stdGraphic = "error.png"
  end
  self.dim.w = 10--self.stdGraphic:getWidth()
  self.dim.h = 10--self.stdGraphic:getHeight()
  self.dim.ox = 5--self.stdGraphic:getWidth()/2
  self.dim.oy = 5--self.stdGraphic:getHeight()/2
end  
    
    a=Account
    a.withdraw(a,100)
    
    print("Kontostand: ", a.balance, "\n", "Deposit: ", a.deposit, "\n")
    
          EntityPositionTable = {
        {Name="Hazelnut",  200, -700,  0  },
        {Name="Hazelnut",  200, -1400, 0  },
        {Name="Hazelnut",  600, -2500, 0  },
        {Name="Opponent1", 200, -500,  64 },
        {Name="Opponent1", 400, -2500, 128},
        {Name="Opponent1", 600, -3500, 150},
        {Name="Opponent1", 600, -3500, 140},
        {Name="Opponent1", 400, -2500, 200},
        {Name="Opponent1", 200, -2000, 200}
      }

EntityList = {}
for j in ipairs(EntityPositionTable) do
  local NewEntity = Entity:Create()
  NewEntity:New(EntityPositionTable[j].Name, EntityPositionTable[j][1], EntityPositionTable[j][2], EntityPositionTable[j][3])
  table.insert(EntityList, NewEntity)
end


    
