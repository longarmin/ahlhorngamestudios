--[[
8.5 Error Messages and Tracebacks
=================================

Eigentlich kannst du jeden Datentyp für eine Errormessage verwenden, aber gewöhnlich ist der Typ "String".
Beim internen Fehler generiert Lua eine Message. Ansonsten kannst du die Message der Error-Funktion übergeben:

]]--
local status, err = pcall(function() a ='a' + 1 end) --...e about functions\8.5 Error Messagese and Tracebacks.lua:9: attempt to perform arithmetic on a string value	false
print(err, status)

local status, err = pcall(function() error("FEHLER MEEEP") end) --...e about functions\8.5 Error Messagese and Tracebacks.lua:12: FEHLER MEEEP	false
print (err, status)

--[[
Die Ortungs-Information (Location Information) gibt den Dateinamen + Zeilennummer aus, wo der Fehler aufgetreten ist
Lua hat einen zweiten Parameter, der den Level des Fehlers angibt. Nehmen wir an, wir haben eine Funktion geschrieben, deren erste Aufgabe es ist zu überprüfen, ob ihre Argumente vom richtigen Typ sind:
]]--

function foo(bla)
  if type(bla) ~= "string" then
      error("MEEEP falscher Datentyp an foo() übergeben. Stelle sicher, dass hier ein string übergeben wird, dankeeee!")
    end
  end
 -- foo{x=1}
  
  -- mit error-level 2 sieht das dann so aus:
  
 function fool(bar)
   if type(bar) ~= "string" then
     error("wrong datatyp...", 2)
   end
 end
 
 --fool{c=1}
 
 --[[
 Wenn pcall seine Error-Nachricht zurückgibt, wird ein Teil des Stacks zerstört: Der Teil zwischen dem Aufruf der pcall-Funktion und dem Fehler.
 Wir möchten aber gerne einen Traceback zum Fehler. Um dieses Problem zu umschiffen, kann xpcall genutzt werden:
 Hier wird neben der aufzurufenden Funktion auch noch eine error handler function übergeben, die Lua dann aufruft, bevor der Stack sich zurückbildet.
 So kann über eine Debug-Library extra Information über den Fehler gesammelt werden. Zwei typische error handler Funktionen sind:
 debug.debug --> öffnet die Kommandozeile wenn ein Fehler auftritt und man kann selbst gucken was passiert ist, als der Fehler aufgetreten ist
 debug.traceback --> Speichert einen detailierten Traceback zu dem Fehler
 Letztere Funktion wird vom Interpreter aufgerufen, um die Fehler-Messages zu erzeugen.
 Du kannst ihn jederzeit aufrufen um von der aktuellen Ausführung einen -traceback zu erhalten über
 ]]--
 print(debug.traceback())