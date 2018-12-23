    --Chapter 3.6 Table Constructors
    
    function printtable(table)
     local out = "{"
     local e = ", "
     for i,v in pairs(table) do
       --debug.debug()
       if next(table, i) == nil then
         e = "}"
       end
      out = out .. tostring(v)..e
     end
     print(out) --> {1, 2, 3, 8}
     print(vec1[x]) --> nil
     print(vec1["x"]) --> 8
   end    

vec1 = {1, "2", "3", x=8}
printtable(vec1)
print("hello world")

--   list = nil
--    for line in io.lines() do
--      list = {next=list, value=line}
--    end
--       l = list
--    while l do
--      print(l.value)
--      l = l.next
--    end
    
