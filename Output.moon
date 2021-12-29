Output =
    uml: (classes) ->
        lines = {}
        add = (l) -> {
            table.insert(lines, l)
        }

        add "digraph G {\n"
        add "node [ shape = \"record\" ]\n"

        for name, c in pairs(classes)
            add "#{name} [\n"
            add "label = \"{#{name}"

            if #c.fields > 0
                add "|"
                for _, field in ipairs(c.fields)
                    add if field.public then "+" else "-"
                    add " #{field.name} : #{field.type}\\l"

            if #c.methods > 0
                add "|"
                for _, method in ipairs(c.methods)
                    add if method.public then "+" else "-"
                    add " #{method.name}()"
                    add " : #{method.returnType}" if method.returnType
                    add "\\l"

            add "}\"\n]\n"

            if c.extends
                add "#{name} -> #{c.extends.name} [arrowhead=onormal"
                add ", style=dashed" if string.sub(c.extends.name,1, 1) == "I"
                add "]\n"

            for _, field in ipairs(c.fields)
                if field.isReference
                    add "#{name} -> #{field.type} [arrowhead=odiamond]\n"

            for _, method in ipairs(c.methods)
                if method.isReference
                    add "#{name} -> #{method.returnType} [arrowhead=odiamond]\n"

        add "}\n"

        return table.concat(lines, "")

return Output