--[[
9.3 Coroutines as Iterators
===========================

Iteratoren generieren Gegenstände, die vom Loop-Body konsumiert werden sollen. Um einen Iterator zu erstellen, eignen sich auch wieder Koroutinen.
Das Ganze soll hier am Beispiel einer Permutation verdeutlicht werden.

]]--
--[[
function permgen (a, n)
  if n == 0 then
    printResult(a)
  else
    for i=1,n do
      a[i], a[n] =  a[n], a[i]
      permgen (a, n-1)
      a[i], a[n] = a[n], a[i]
    end
  end
end
  
  --um das Ganze arbeiten zu sehen, müssen wir eine Print-Funktion schreiben
  
  function printResult(a)
    for i,v in ipairs(a) do
      io.write(v, " ")
    end
    io.write("\n")
  end
  
  permgen({1, 2, 3, 4}, 4)
--]]  
  --um daraus jetzt einen Iterator zu machen, ersetzen wir das printResult(a) durch ein coroutine.yield()
  
  function permgen (a, n)
  if n == 0 then
    coroutine.yield(a)
  else
    for i=1,n do
      a[i], a[n] =  a[n], a[i]
      permgen (a, n-1)
      a[i], a[n] = a[n], a[i]
    end
  end
end

  --um das Ganze arbeiten zu sehen, müssen wir eine Print-Funktion schreiben
  
  function printResult(a)
    for i,v in ipairs(a) do
      io.write(v, " ")
    end
    io.write("\n")
  end
  
  --permgen({1, 2, 3, 4}, 4)
  
  --jetzt machen wir folgendes:
  
  --[[
  function perm(a)
    local n = table.getn(a)
    local co= coroutine.create(function () permgen(a, n) end)
    return function () 
      local code, res = coroutine.resume(co)
      return res
    end
  end
  ]]--
--[[ 
Hier gibt's jetzt die Möglichkeit in Lua, coroutine.wrap zu nutzen. 
Anstatt eine Koroutine zu erstellen und eine Funktion mit coroutine.resume() zurück zu geben, kann man auch schreiben:
]]--
  
  function perm(a)
    local n = table.getn(a)
    return coroutine.wrap(function () permgen(a, n) end)
  end
  
  --[[ 
  Das sieht einfacher aus, ist aber weniger flexibel. So kann man zum Beispiel nicht den aktuellen Status ausgeben lassen und man kann keine Fehler ausgeben.
  ]]--
  
  for i in perm{"a","b","c"} do
    print(i)
    printResult(i)
  end
  
  

    