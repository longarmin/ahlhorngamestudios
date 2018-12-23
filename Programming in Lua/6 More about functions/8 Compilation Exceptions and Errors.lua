--[[
8 Compilation, Execution and Errors
===================================

Kompilierung von loadfile, loadstring: Diese beiden Funktionen kompilieren einen Code, den von einem externen User kommen kann.
Das ist sehr langsam und sollte, wenn möglich, weitestgehend vermieden werden, wenn nicht unbedingt Code zur Laufzeit kompiliert werden muss.
Darüber hinaus gibt es noch dofile, welches den Code direkt ausführt. Auch löst es Errors aus, während loadfile nur errorcode zurückgibt,
den man dann verarbeiten kann.
Dofile lässt sich etwa so definieren:

function dofile ( file )
  f = assert(loadfile(file))
  return f()
end

loadfile ist aber u.U. deutlich effizienter. Wenn man die mit loadfile geladenen chunks wiederholt aufrufen möchte, kann man einfach das fertige
Kompilat nehmen, dass man in einer Variablen abgelegt hat. Bei dofile() geht das nicht und das File muss immer wieder neu eingelesen und kompiliert werden.

]]--
i = 0
f = loadstring("i = i + 1")

for m = 0,12 do
  f()
  print(i)
end

--[[
Vorsicht sei geboten bei Funktionen: Ein üblicher übler Fehler ist es zu glauben, dass man in loadfile/string Funktionen definieren könne. 
Dies ist nicht der Fall: In Lua sind Funktionen Assgnment und sie werden somit immer erst zur Laufzeit erstellt, nicht während der Compile-Zeit.
Es muss also nach dem Assignment immer noch die Funktion aufgerufen werden, welches als Definition gilt. 
Quick and Dirty geht aber auch:
loadfile("bla.lua")()
um Syntaxfehler zu sehen, muss man assert nutzen:
assert(loadfile("bla.lua")()

Vorsicht sei auch mit lokalen Variablen geboten, denn loadfile/string greifen immer auf globale Variablen zu!
local i = 0
loadstring("i = i + 1")
print(i) --> 0
]]--
fick="ficköööön"
print("Enter your expression:")
local l = io.read()
local func = assert(loadstring("return " .. l))
print("The Val of your expr is " .. func())