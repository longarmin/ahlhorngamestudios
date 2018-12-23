--[[
8.1 Die require-Funktion
========================

Die require-Function übergibt das Argument an ANSI C (die abstrakte Platform, in der Lua läuft). Hierbei ist der Befehl so aufgebaut,
dass require in unterschiedlichen Pfaden nach der Datei sucht.
Die Reihenfolge ist wie folgt:

require "Konsonantenintervall"
1. Versuch: ? aufrufen
2. Versuch: ?.lua aufrufen
3. Versuch: C:\windows\? aufrufen
4. Versuch: /usr/local/lua/?.lua aufrufen

Die require-Funktion macht nicht viel (Gänsefüßchen entfernen, Semikoli entfernen). Alles andere ist im path definiert.
Um den PATH zu finden, schaut Lua zuerst in einer globalen Variable names LUA_PATH. Ist hier ein string hinterlegt, wird dieser als path interpretiert.
Wenn nicht vorhanden, checkt es die Umgebungsvariable LUA_PATH. Führt auch das nicht zum Erfolg, nutzt Lua einen fixen Pfad. Typischerweise "?;?.lua",
lässt sich aber leicht ändern, wenn man Lua kompiliert.

Darüber hinaus verhindert require, dass eine Datei doppelt geladen wird. Dies geschieht über eine Tabelle, in der die Namen der geladenen Dateien hinterlegt 
werden. Zu finden unter _LOADED. Möchte man Lua austricksen und z.B. ein doppeltes Laden der Datei "foo.lua" erzwingen, lässt sich das bewerkstelligen,
indem man einfach vor dem zweiten Laden _LOADED["foo"] = nil setzt.
]]--
m = require "6-2 Non-Global Functions"
print(LUA_PATH)
package.loaded[m]
--läuft irgemdwie alles nicht :(