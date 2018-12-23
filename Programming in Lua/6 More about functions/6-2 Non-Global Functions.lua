--[[ Non-Global Functions
Wann werden locale Funktionen eingesetzt? Zum Beispiel beim Erstellen einer Lib, die interne Funktionen
besitzt, die nicht von außen aufgerufen werden sollen.
Dieser Abschnitt wird insbesondere bei rekursiven Functionen interessant:
Die Deklaration
local func = function(blub)
  if blub == 1 return 1
  else return func(blub-1)
  end
end
funktioniert nicht, weil func erst mit "end" zuende deklariert ist und zum return-Zeitpunkt noch nicht existiert.
Der syntaktische Zucker
local function func (blub)
...
end
erlaubt den rekursiven Aufruf zwar, am besten nutzt man aber Vorwärts-Deklarationen:
local func
func = function(blub)
...
end
]]--