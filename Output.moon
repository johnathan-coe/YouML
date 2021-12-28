Output =
    uml: (f, classes) ->
        add = f\write

        add "digraph G {\n"
        add "node [ shape = \"record\" ]\n"

        for name, c in pairs(classes)
            add "#{name} [\n"
            add "label = \"{#{name}|"

            for _, field in ipairs(c.fields)
                add if field.public then "+" else "-"
                add " #{field.name} : #{field.type}\\l"
            
            add "|"

            for _, method in ipairs(c.methods)
                add if method.public then "+" else "-"
                add " #{method.name}()"
                add " : #{method.returnType}" if method.returnType
                add "\\l"

            add "}\"\n]\n"

            if c.extends
                add "#{name} -> #{c.extends.name} [arrowhead=onormal"
                
                type = string.sub(c.extends.name,1, 1)
                if type == "I"
                    add ", style=dashed"

                add "]\n"

            for _, field in ipairs(c.fields)
                if field.isReference
                    add "#{name} -> #{field.type} [arrowhead=odiamond]\n"

        add "}\n"

return Output