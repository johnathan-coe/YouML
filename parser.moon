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

        return parsed

return Parser