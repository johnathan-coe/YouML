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
                        table.insert(parsed[currentClass].methods, Method(l))
                    else
                        table.insert(parsed[currentClass].fields, Field(l))
                when ":"
                    table.insert(parsed[currentClass].notes, l\match(":%s*([a-zA-Z]+)"))
                when "#", ""
                    nil
                else
                    c = Class(l)
                    parsed[c.name] = c
                    currentClass = c.name

        for _, c in pairs(parsed)
            c.extends = parsed[c.extends] if c.extends
            
            for _, f in pairs(c.fields)
                if parsed[f.type]
                    f.association = true
                
        return parsed

return Parser