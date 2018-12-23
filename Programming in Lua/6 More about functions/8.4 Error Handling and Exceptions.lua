--[[
8.4 Error Handling and Exceptions
=================================

Ein Error-Handling ist meist nicht von nöten, weil das der Interpreter übernimmt (was soll da der Interpreter übernehmen???)
Error Handling sieht in Lua wie folgt aus:
1. ein error() wird definiert, der "geworfen" werden kann
2. mit pcall wird der gethrowte Error gecatcht
3. Die error-message identifiziert den Fehlertyp
Das geht wie folgt:
]]--


print("gibt eine Zahl <= 10 ein")
b = tonumber(io.read())
--Beispiele:
--io.read-input: "hallo"
--Rückgabewerte: false	...re about functions\8.4 Error Handling and Exceptions.lua:17: attempt to compare number with nil
--io.read-input: 23
--Rückgabewerte: false nil
--io.read-input: 2
--Rückgabewerte: true 2300
function foo()
  if b > 10 then return(error()) else return 2300 end
  print(b)
end
print(pcall(foo))
if pcall(foo) then --gibt "true" zurück, wenn kein Fehler aufgetreten ist, sonst "false"
  print("Alles fein")
else
  print("Alles Scheise")
end

--anonymous functions gehen auch:
print("gibt eine Zahl <= 10 ein")
b = tonumber(io.read())

if pcall(function () if b > 10 then error() end end) then
  print("Alles geil") --error() gibt "true" zurück
else
  print("Alles doof") --> error() gibt "false" zurück
end

local status, err = pcall(function () error({code=112}) end)
print(err.code)
print(tostring(err.status))
