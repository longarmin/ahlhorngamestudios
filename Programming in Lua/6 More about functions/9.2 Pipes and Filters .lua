--[[
9.2 Coroutines Pipes
====================

Kommunikation zwischen Funktionen ist nicht so trivial: in Linux gibt es Pipes, die aus einem Puffer bestehen, auf den beide Funktionen zugreifen können.
Hier ist es etwas anders: Der Empfänger gibt dem Sender ein Signal, dass er senden soll und wartet auf eine Antwort. Ist die Nachricht rausgegangen, wartet er, bis der Empfänger ihm mitteilt, er soll das nächste Paket prozessieren.

]]--

file = io.open("71iterators.txt", "r")
io.input(file)

function receive(prod)
  local status, val = coroutine.resume(prod)
  return val
end

function send(val)
  coroutine.yield(val)
end


function producer()
  return coroutine.create(function ()
        while true do
          local v = io.read()
          if v == nil then break end
          send(v)
        end
      end)
end

function consumer(prod)
  while true do
  if coroutine.status(prod) == "dead" then break end
    print(coroutine.status(prod))
    print(tostring(receive(prod)) .. "\n")
  end
end

p = producer()
consumer(p)

--was hier noch fehlt ist der filter(), den man noch zwischen consumer und producer schalten kann, um den produzierten Stoff zu filtern und gezielt nur gewünschte Ausgaben erzeugt. Zum Beispiel "füge die Line-Nummer jeder ausgegebenen Zeile der Ausgabe hinzu". Ein Filter ist damit mehr oder weniger gleichzeitig consumer (weil er Werte aus dem Producer bekommt), als auch producer ( weil er die Werte an den consumer weitergibt)