--[[
7.1 - Iterators and Closures
============================

Iteratoren dienen dazu, über Daten (Tabellen, Streams, ...) zu itererieren. Sie sind meist eher kompliziert zu schreiben, aber einfach anzuwenden.
Endnutzer schreiben diese meist nicht selbst, aber setzen sie häufig ein.
Ein Iterator ist meist so aufgebaut:

Iteratorfunktion ( Daten zum Iterieren )
  local lokaleVariablen = 0 -- mit den lokalen Variablen definiert sich der State des Iterators, der sich bei jedem Iterationsschritt verändert
  return closurefunktion (lokaleVariablen)
          hier werden Datenstücke aus den Daten extrahiert
          return Datenstück
          
Beispiele:
--]]

--Iterator um alle Tabellendaten abzurufen:

function iterator ( t )
  local i = 0
  n = table.getn(t)
  return function ()
    i = i + 1
    if i <=n then return t[i] end
  end
end
function allwords ()
  local line = io.read()
  local pos = 1
  return function ()
    while line do
      local s,e = string.find(line, "%w+", pos)
      if s then
        pos = e + 1
        return string.sub(line, s, e)
      else
        line=io.read()
        pos = 1
      end
    end
    return nil
  end
end

t = {1, 2, 3, 4, 5, 6, 7, 9, 12 }

for entry in iterator(t) do
  print(entry)
end

file = io.open("71iterators.txt", r)
io.input(file)
--print(io.read())

for word in allwords() do
  print(word)
end
