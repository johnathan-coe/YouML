Class = require("Entity/Class")
Method = require("Entity/Method")
Field = require("Entity/Field")
String = require("Util/String")

Parser =
    parse: (string) ->
        parsed = {}
        currentClass = ""

        for l in String.lines(string)    
            switch string.sub(l, 1, 1)
                when "-", "+", "*"
                    if string.sub(l, -2) == "()"
                        e, m = pcall(Method, l)
                        if e
                            table.insert(parsed[currentClass].methods, m)
                        else
                            print("Couldn't parse #{l}")
                    else
                        e, f = pcall(Field, l)
                        if e
                            table.insert(parsed[currentClass].fields, f)
                        else
                            print("Couldn't parse #{l}")
                when ":"
                    table.insert(parsed[currentClass].notes, l\match(":%s*([a-zA-Z]+)"))
                when "#", ""
                    nil
                else
                    e, c = pcall(Class, l)
                    if e
                        parsed[c.name] = c
                        currentClass = c.name
                    else
                        print("Couldn't parse #{l}")

        for _, c in pairs(parsed)
            c.extends = parsed[c.extends] if c.extends
            
            for _, f in pairs(c.fields)
                if parsed[f.type]
                    f.association = true
                
        return parsed

return Parser