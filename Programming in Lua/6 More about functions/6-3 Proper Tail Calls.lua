--[[ Proper Tail Calls
Lua unterstützt Proper Tail Calls. Das heißt, wenn in
bla  = function(a)
return g(x)
end
die Funktion g(x) aufgerufen wird, müssen im Stack keine Ressourcen mehr für bla vorgehalten werden, da die Funktion bereits komplett durchgelaufen ist.
Unterstützt eine Programmiersprache diese Funktion nicht, so kann man einen Stackoverflow erzeugen, weil die Infos über die callenden Funktion vorgehalten werden, bis auch g(x) beendet ist.

es gibt auch Beispiele für non-Proper-Tail Calls:
return g(x)+1 --> nach der Ausführung von g(x) wird eine weitere Operation durchgeführt
return 1 or g(x) --> g(x) muss komplett durchlaufen werden, um über das OR eine Aussage zu fällen
return (g(x)) --> kann super genutzt werden, um einen Proper Tail Call zu unterbinden...wenn das jemals notwendig sein sollte.

Grundsätzlich lässt sich sagen, dass die Form return g(...) einen Proper Tail Call erzeugt.
Mit Proper Tail Calls lassen sich auch gut State-Machines umsetzen:
--]]

function room1 ()
  print("Raum 1 - Mitte")
  local move = io.read()
  if move == "n" then
    return room2()
  elseif move == "s" then
    return room3()
  else return room1()
  end
end


function room2 ()
  print("Raum 2 - Norden")
  local move = io.read()
  if move == "n" then
    return room2()
  elseif move == "s" then
    return room1()
  else return room1()
  end
end


function room3 ()
  print("Raum 3 - Süden")
  local move = io.read()
  if move == "n" then
    return room1()
  elseif move == "s" then
    return room3()
  else return room1()
  end
end

room1()