if arg and arg[#arg] == "-debug" then require("mobdebug").start() end
Set = {}
Set.mt = {}

function Set.new(t)
  local set = {}
  setmetatable(set, Set.mt)
  for _,l in pairs(t) do set[l]=true end
  return set
end

function Set.union(a, b)
  local res =set.new{}
  for _,l in pairs(a) do res[l]=true end
  for _,l in pairs(b) do res[l]=true end
  return res
end
--function Set.union(a, b)
--  local set = {}
--  for _,l in pairs(a) do table.insert(set, l) end
--  for _,l in pairs(b) do table.insert(set, l) end
--  return set
--end
function Set.tostring(table)
  string = "{"
  sep = ""
  for s in pairs(table) do
    string = string .. sep .. s
    sep = ","
  end
  return string .. "}"
end

Set.mt.__add = Set.union
bla=Set.new{1, 2, 3, 4, 5}
ble=Set.new{6,7,8}
print("hi")
print(Set.tostring(bla+ble))
print("ho")