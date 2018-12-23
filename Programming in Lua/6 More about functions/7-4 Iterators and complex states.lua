--[[
7.4 Iteratoren mit komplexem Zustand
====================================

Diese Art von Iteratoren verwirft das zweite von der for-Schleife zur Verfügung gestellte Argument, weil es dieses bereits in einer eigenen Tabelle hinterlegt hat.

]]--

local iterator --wird später definiert

function allwords()
  local state = { line = io.read(), pos = 0 }
  return iterator, state
end
  
function iterator(state)
  while state.line do
    local s, e = string.find(state.line, "%w+", state.pos)
    if s then
      state.pos = e + 1
      return string.sub(state.line, s, e)
    else
      state.line = io.read()
      state.pos = 1
    end
  end
  return nil
end
file = io.open("71iterators.txt", "r")
io.input(file)
for word in allwords() do
  print(word)
end
--[[
Folgende Priorisierung sollte eingehalten werden bei der Wahl der Iteratoren:
1. Stateless Iterators (es wird kein neues Objekt erzeugt beim Start der Schleife)
2. Closures (Zugriff auf upvalues ist schneller als Zugriff auf Tabellenwerte)
3. Iterator-Tables

Weitere Möglichkeit: Nutzung von Coroutines, dazu später mehr. Stark aber teuer (was auch immer das heißen soll...)
]]--