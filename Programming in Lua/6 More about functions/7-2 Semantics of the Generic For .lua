--[[
Die Semantik der Generischen For-Schleife
=========================================

Wenn man einen overhead verhindern möchte (z.B. im allwords-Beispiel aus 7.1, dass die Closure-Funktion mit jeder Linie erneut aufgerufen werden muss),
kann man die generische for-Schleife nutzen, um den Iteration-State zu behalten.

Die For-Schleife hält drei Werte während des Durchlaufens intern:
-Iterator-Funktion
-Invariant State (=unveränderlicher Zustand)
-control variable

Die Syntax der for-Schleife sieht wie folgt aus:
for <var-list> in <expr-list> do
  <body>
end

<var-list>: Variablen-Liste, kommasepariert
<expr-list>:Ausdruck-Liste,  kommasepariert

control variable: erstes Element der <var-list>, zu Anfang nie nil. Wenn control variable = nil ist die Schleife zuende

Als erstes evaluiert die for-Schleife die <expr-list> hinter "in". Daraus sollten dann die drei Werte resultieren, die die for-Schleife hält, um
den State zu beschreiben: iterator-Funktion, unveränderlicher Zustand, control variable.
Wie bei multiple Assignments kann nur der letzte Wert mehr als einen Wert beinhalten. Der Zustand wird immer mit drei Werten gebildet, alles darüber hinaus
wird von der for-Schleife ignoriert. Werden weniger als drei Werte zur Verfügung gestellt, setzt die for-Schleife die fehlende Werte zu "nil".

Nach der Initialisierung ruft die for-Schleife die Iterator-Funktion mit zwei Argumenten auf: dem Invariant State und Control Variable.
Danach teilt die For-Schleife die return-Werte der Iterator-Funktion den Variablen der Variablen-Liste <var-list> zu.
Wenn der erste Rückgabewert = nil ist, wird die for-Schleife beendet. Ansonsten wird die Iteratorfunktion wieder aufgerufen.
]]--
--[[
--Eine For-Schleife ist damit äquivalent zu folgender do-while-Schleife:
for var_1,...var_n in explist do
  block
end

--f=Iterator-Funktion
--s=Invariant State
--c=control variable

do 
  local _f, _s, _c = explist
  while true do
    local var1, ..., var_n = _f(__s, _c)
    if var1 == nil then break end
    block
  end
end
]]--



function iterator ( t )
  local i = 0
  n = table.getn(t)
  return function ()
    i = i + 1
    if i <=n then return t[i] end
  end
end
t = {1, 2, 3, 4, 5, 6}

--Praxis-Beispiel: do-while-Äquivalent der For-Schleife aus 7.1:
do
  local _c = 0
  local _s = table.getn(t)
  local _f = function()
    _c = _c + 1
    if _c <= _s then return t[_c] end
  end
  while true do
    local var_1 = _f()
    if var_1 == nil then break end
    print(var_1)
  end
end
-- Zur Erinnerung, hier die For-Schleife:
for entry in iterator(t) do
  print(entry)
end

--Vermutung: Invarianter Zustand beschreibt die Abbruch-Bedingung. Wenn diese erfüllt ist, muss "nil" zurück gegeben werden, damit die For-Schleife beendet wird.
--Korrektur: o.g. Vermutung ist falsch, Invariant ist die Tabelle, über die iteriert wird