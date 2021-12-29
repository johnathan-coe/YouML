Output =
    uml: (classes) ->
        lines = {}
        add = (l) -> table.insert(lines, l)
        addln = (l) -> table.insert(lines, l .. "\n")

        addln "digraph UML {"
        addln "node [ shape = \"record\" ]"

        for name, c in pairs(classes)
            addln "#{name} ["
            add "label = \"{#{name}"

            if #c.fields > 0
                add "|"
                for _, field in ipairs(c.fields)
                    add if field.public then "+" else "-"
                    add " #{field.name} : #{field.type}"
                    add "[]" if field.array
                    add "\\l"

            if #c.methods > 0
                add "|"
                for _, method in ipairs(c.methods)
                    add if method.public then "+" else "-"
                    add " #{method.name}()"
                    add " : #{method.returnType}" if method.returnType
                    add "\\l"

            addln "}\"\n]"

            if c.extends
                add "#{name} -> #{c.extends.name} [arrowhead=onormal"
                add ", style=dashed" if string.sub(c.extends.name,1, 1) == "I"
                addln "]"

            for _, field in ipairs(c.fields)
                if field.aggregation
                    addln "#{field.type} -> #{name} [arrowhead=odiamond]"

        addln "}"

        return table.concat(lines, "")

return Output