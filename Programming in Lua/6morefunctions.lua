print("6 - More about functions")
io.stderr:write("Hure")
--~ io.stdin:read(file)
--~ io.stout:write(fileout)
file = assert(io.input("experimente.txt"), "could not open file")
print(file)
--file = io.read(experimente.txt)
s = file:read("*all")
--fileout = io.output("experimente.txt", "w")
s = string.gsub(s, "([\128-256=])", function (c) return string.format("%=02X", string.byte(c)) end)

s = s.." you're not getting bigger hö hö hö"
print(s)
io.write("höhöhö")
--f=io.output("experimente.txt")
assert(io.write(s), "konnte nicht schreiben, wahrscheinlich ist der Befehl falsch du dummes Kind!")
--file:close()
--fileout:close()
io.output("experimente2.txt")
	function eraseterminal ()
      io.write("\27[2j")
    end
    -- writes an `*' at column `x' , row `y'
    function mark (x,y)
      io.write(string.format("\27[%d;%dh*", y, x))
    end
    -- terminal size
    termsize = {w = 80, h = 24}

    -- plot a function
    -- (assume that domain and image are in the range [-1,1])
    function plot (f)
      eraseterminal()
      for i=1,termsize.w do
         local x = (i/termsize.w)*2 - 1
         local y = (f(x) + 1)/2 * termsize.h
         mark(i, y)
      end
      io.read()  -- wait before spoiling the screen
    end
  plot(function (x) return math.sin(x*2*math.pi) end)
