Class = require("Entity.Class")
Method = require("Entity.Method")
Field = require("Entity.Field")

Parser =
    parse: (file) ->
        parsed = {}
        currentClass = ""

        l = file\read("*l")
        while l    
            switch string.sub(l, 1, 1)
                when "-"
                    -- Field
                    table.insert(parsed[currentClass].fields, Field(l))
                when "+"
                    -- Method
                    table.insert(parsed[currentClass].methods, Method(l))
                when "#"
                    nil -- Comment
                when ""
                    nil -- Empty line
                else
                    -- Class
                    c = Class(l)
                    parsed[c.name] = c
                    currentClass = c.name

            l = file\read("*l")

        for _, c in pairs(parsed)
            if c.extends
                c.extends = parsed[c.extends]
                for _, m in ipairs(c.extends.methods)
                    table.insert(c.methods, m)
            
            for _, f in ipairs(c.fields)
                if parsed[f.type]
                    f.isReference = true
                
        return parsed

return Parser