--[[
7.5 True Iterators
==================

Eigentlich ist die Bezeichnung "Iterator" nicht ganz korrekt, weil es letztlich die for-Schleife ist, die die Iterationsschritte aufruft.
Die Bezeichnung "Generator" wäre korrekter, aber das hat sich eben so eingebürgert. Dafür bezeichnet man einen Iterator, der tatsächlich
iteriert als "True Iterator"
Er genügt sich selbst und benötigt die for-Schleife nicht. Die Iterator- bzw. Generatorfunktion wird dabei als (meist anonymes) Argument an den
True Iterator übergeben.
Hier nochmal der Allwords-Iterator als True Iterator:
]]--

function allwords( f )
  --für jede Zeile in der Datei wiederholen
  for l in io.lines() do
    --für jedes gefundene Wort die anonyme Funktion aufrufen:
    for w in string.gmatch(l, "%w+") do
      f ( w )
    end
  end
end

file = io.open("71iterators.txt", "r")
io.input(file)
local count = 0
allwords( function ( w )
    count = count + 1
  end)

print(count)
--allwords(print)

--[[
Echte Iteratoren wurden früher sehr häufig in Lua genutzt, als es noch keine for-Schleife gab.
Generator-Style Iteratoren sind flexibler. Wenn man zum Beispiel zwei Texte miteinander vergleichen möchte,
kann man durch Generator-Iteratoren super zwei Funktionen parallel ausführen, die den Texte durchsuchen.
Auch break- und return-Befehle können sinnvoll im Iterator-Body eingesetzt werden, während dieser Befehl beim
Echten Iterator nur die anonyme Funktion verlässt.