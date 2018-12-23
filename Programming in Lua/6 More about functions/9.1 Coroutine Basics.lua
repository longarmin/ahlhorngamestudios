--[[
9.1 Coroutine-Basics
====================

eine Koroutine kann unterschiedliche Stati haben:
-suspended
-running
-dead
]]--

co = coroutine.create( function() print("foo") end )
print(co)
print(coroutine.status(co))
print(coroutine.resume(co))
print(coroutine.status(co))

--[[
Besondere Kraft erhält die Koroutine durch die yield-Funktion. Damit kann die Koroutine angehalten werden und zu einem späteren Zeitpunkt wieder fortgesetzt werden:
]]--
cor = coroutine.create(function()
    for i=1,10 do
      print(tostring(i) .. "ter Durchlauf der for-Schleife")
      coroutine.yield()
    end
  end)
print(cor)
print(coroutine.resume(cor))
coroutine.resume(cor)
print(coroutine.resume(cor))

--Resume läuft im Protected Mode. Das bedeutet, dass Fehlermeldungen, die hier generiert werden, nicht ausgegeben werden, sondern an resume zurück gegeben werden 
--sinnvolle Möglichkeit in Lua: Zwischen resume() und yield() können Daten übergeben werden. Das erste resume() (welches kein dazugehöriges yield() besitzt) gibt zusätzlich übergebene Argumente an die Funktion innerhalb der Coroutine weiter:

coro = coroutine.create(function(a,b,c)
    print(tostring(a) .. " " .. tostring(b) .. " " .. tostring(c))
  end)
coroutine.resume(coro, "geil", "e", "Scheisse")
--ein resume() gibt die Werte zurück, die dem entsprechenden yield() übertragen wurden:
corou = coroutine.create(function(a,b)
    coroutine.yield(a+b, a-b)
  end)
print(coroutine.resume(corou, 20, 10))
-- yield() gibt auch alle Werte zurück, die zursätzlich resume() übergeben wurden:
corout = coroutine.create(function()
    print("corout", coroutine.yield())
    end)
  coroutine.resume(corout)
  coroutine.resume(corout, 2, 5)
  
  --[[
  Wie so oft in der Informatik gibt es auch was Lua-coroutines betrifft böse Zungen, die behaupten, es seien genau genommen gar keine Koroutinen. Deshalb spricht man auch von "semi-coroutines". Im Grunde handelt es sich um asymmetrische Koroutinen. Bei Symmetrischen kann immer nur eine Funktion die Kontrolle von einer Koroutine zur anderen übergeben.]]--