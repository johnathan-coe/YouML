Class = require("Entity/Class")
Method = require("Entity/Method")
Field = require("Entity/Field")

Parser =
    parse: (string) ->
        parsed = {}
        currentClass = ""

        for l in string\gmatch("%s*(.-)\n")    
            switch string.sub(l, 1, 1)
                when "-", "+"
                    if string.sub(l, -2) == "()"
                        -- Method
                        table.insert(parsed[currentClass].methods, Method(l))
                    else
                        -- Field
                        table.insert(parsed[currentClass].fields, Field(l))  
                when "#", ""
                    nil -- Comment
                else
                    -- Class
                    c = Class(l)
                    parsed[c.name] = c
                    currentClass = c.name

        for _, c in pairs(parsed)
            c.extends = parsed[c.extends] if c.extends
            
            for _, f in ipairs(c.fields)
                if parsed[f.type]
                    f.isReference = true

            for _, m in ipairs(c.methods)
                if parsed[m.returnType]
                    m.isReference = true
                
        return parsed

return Parser