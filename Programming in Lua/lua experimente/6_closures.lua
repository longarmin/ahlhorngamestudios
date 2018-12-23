print("=== Kapitel 6.1 - Closures ===")
function closure ()
  local m = 0
  return function () m=m+1 return m end
end
c=closure()
print(c())
print(c())
c1=closure()
print(c1())
print(c())
oldsin = math.sin
function math.sin (x)
  return oldsin(x*math.pi/180)
end

print("=== Kapitel 6.2 - Non-Global Funtions ===")
local function fact (n)
  if n == 0 then return 1
  else return n*fact(n-1)
  end
end
print("Fakultät 7 = ", fact(7))

print("=== Kapitel 6.3 - Proper Tail Calls ===")

function room1()
  print("Du bist in Raum 1 - welche Richtung schlägst du ein? N, S, O, W? (Press Q for skip)")
  decision = string.upper(io.read()) --Abfrage soll Case-Insensitiv sein
  if decision == "N" then return room2()
  elseif decision == "S" then return room3()
elseif decision == "Q" then print("Du hast abgebrochen")
  else
    print("Hier geht's nicht lang du dämlicher Vollidiot!")
    return room1()
  end
end


function room2()
  print("Du bist in Raum 2 - welche Richtung schlägst du ein? N, S, O, W?")
  decision = io.read()
  decision = string.upper(decision)
  if decision == "W" then return room4()
  elseif decision == "O" then return room3()
  else
    return room1()
  end
end

function room3()
  print("Du bist in Raum 3 - welche Richtung schlägst du ein? N, S, O, W?")
  decision = string.upper(io.read())
  if decision == "S" then room2()
  elseif decision == "N" then room1()
  else
    print("Hier geht's nicht lang. Du bist so dämlich, das gibt's gar nicht!")
    return room3()
  end
end

function room4()
  print("Du bist in Raum 4 - welche Richtung schlägst du ein? N, S, O, W?")
  decision = string.upper(io.read())
  if decision == "O" then
    print("Korrekt. Du bist durch - war ja auch einfach, also kein Grund zur Freude!")
  else
    return room1()
  end
end

room1()
print("Gmatch:", string.gmatch('Its a test', 'its'))

print(math.sin(0))
print("=== Kapitel 7.1 - Iterators and Closures ===")
function allwords()
  local line = io.read()
  local pos = 1
  return function ()
    while line do
      local s,e = string.find(line, "/p+", pos)
      if s then
        pos = e + 1
        return string.sub(line, s, e)
      else
        line = io.read()
        pos = 1
      end
    end
    return nil
  end
end
io.input("experimente.txt")
for word in allwords() do
  print(word)
end
