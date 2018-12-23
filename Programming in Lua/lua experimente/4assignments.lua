--4.1 Assignments
--Assignment is the basic means of changing the value of a variable or a table field
print("Chapter 4 (raise your head and taste the courage)")
x, y = 1, "c"
print(y, x)
--swaps are made possible because lua evaluates all values first and only then executes the assignments
x, y = y, x
print(y, x)

--dicard of values:
a, b, c = 1, 2, 3
print(a,b,c)
a, b, c = 1
print(a,b,c)

print("=== Chapter 5 - Functions ===")

--return of multiple values
a=1
b=2

function foo()  return end
function foo2() return a end
function foo3() return a,b end

--recursion own unpacking-function:
function unpack(t,i)
  i= i or 1
  if t[i]  ~= nil then
    return t[i], unpack(t, i+1)
  end
end


print("foo(), foo2(), foo3():", foo(),"; ", foo2(), "; ", foo3())
print("foo3(), foo2(), foo():", foo3(),"; ", foo2(),"; ", foo())
print("{foo3()}, foo2(), foo():", {foo3()},"; ", foo2(),"; ", foo())

vec = {1, 2, 3, 4}

--functionpointer:
f= foo3
print("f=foo3() = ",f())

--own unpack-function:
print("unpack(vec) = ", unpack(vec))

print("Chapter 5.2 - Variable Number of Arguments")

function printi(printiti, printititi)
  print(printiti)
  print(printititi)
  print(arg)
end
function prin(...)
  print(tostring(arg[1]))
  print(arg[2])
  print(arg)
end
  rslt = ""
function pr(...)
  return arg
end
  
function pri(...)
  for i,v in ipairs(arg) do
    rslt = rslt..tostring(v).."\t"
  end
  rslt = rslt .. "\n"
  return rslt
end
    
printi("kacke", "scheiße")
prin("kacke", "scheiße")
prin("kacke", "scheiße")
print(pri("kacke", 2))
print(pr("kacke", "scheiße"))

    function seleect (n, ...)
      return select(1,...)
    end
    
    r= {1,2,3,5,6}
    print(seleect(3,1,2,7,4))
--function drucken(k,...)
--  out = ""
--  for i,v in ipairs(select(1,...)) do
--    out = out .. tostring(v) .. "\t"
--  end
--end

--print(drucken("k","a","c","k","e"))

  