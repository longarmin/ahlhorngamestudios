--[[
7.2 Zustandslose Iteratoren
Ein Iterator ist dann zustandslos, wenn er seinen Zustand an die Aufrufende Funktion zurück gibt.
Ein Beispiel für einen zustandslosen Iterator ist ipairs:
]]--


function iter (t, i)
  i = i + 1
  local v = t[i]
  if v then return i, v end
end

function iparis( t )
  return iter, t, 0
end

a = {"one", "tho", "Threr"}
for i, v in iparis(a) do
  print(i, v)
end
--[[
wenn die For-Schleife iparis(a) aufruft, bekommt sie als Rückgabewerte die Iteratorfunktion, den invarianten Zustand (=die Tabelle, über die iteriert werden soll) und den Startwert der Control Variable.

die pairs-Funktion ist ähnlich. Hier ist der Iterator die Next-Funktion (primitive Funktion in Lua)
]]--

function paris ( t )
  return next, t, nil
end
for v in paris ( a ) do
  print("Mit pairs() iteriert:" , v)
end

--[[
in next(t,k) ist t die Tabelle und k der aktuelle Key. Mit t, nil wird der erste Wert von t zurückgegeben. existiert kein weiterer Wert mehr in t, so wird nil zurückgegeben und die for-schleife kann beendet werden.
next(t,k) gibt next_key, t[next_key] zurück. Die Reihenfolge der Tabellenwerte ist dabei beliebig und wenn man ein geordnete Reihenfolge durchlaufen möchte,
sollte man ipairs nutzen.
