--[[
Begriffe:
-Lexical Scoping
-external local variable
-upvalue
LUA unterstütz ein Feature names "Lexical Scoping":
eine Funktion, die von einer anderen Funktion umklammert  ist, hat vollen Zugriff auf die lokalen Variablen der übergeordneten Funktion.
Ein Closure ist - in Kombination mit first-class-values - ein mächtiges Tool.
Es arbeitet mit external local variables, oder lua-typisch oft upvalue genannt.
Damit sind locale Variablen gemeint, die außerhalb der lokalen Umgebung aufgerufen werden können, weil sie von dem return-statement (letzter Befehl der
jeweiligen Umgebung) aus der Umgebung heraus gegeben werden können.
]]--

names = {"Peter", "Paul", "Mary"}
grades = {Peter=3, Paul=10, Mary=6}
table.sort(names, function(n1, n2) return grades[n1] > grades[n2] end)
for i,v in ipairs(names) do
  print(v)
end
