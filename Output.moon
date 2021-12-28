Output =
    uml: (f, classes) ->
        add = f\write

        add "digraph G {\n"
        add "node [ shape = \"record\" ]\n"

        for name, c in pairs(classes)
            add "#{name} [\n"
            add "label = \"{#{name}|"

            for _, field in ipairs(c.fields)
                add "- #{field.name} : #{field.type}\\l"
            
            add "|"

            for _, method in ipairs(c.methods)
                add "+ #{method.name}() : #{method.returnType}\\l"

            add "}\"\n]\n"

            if c.extends
                add "#{name} -> #{c.extends.name}\n"

            for _, field in ipairs(c.fields)
                if field.isReference
                    add "#{name} -> #{field.type}\n"

        add "}\n"

return Output