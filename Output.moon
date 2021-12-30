String = require("Util/String")

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

            if String.startsWith(name, "I")
                add "\\l\\<\\<interface\\>\\>"

            if #c.notes > 0
                add "\\l\\<\\<enumeration\\>\\>"

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

            if #c.notes > 0
                add "|"
                for _, note in ipairs(c.notes)
                    add note
                    add "\\l"

            addln "}\"\n]"

            if c.extends
                add "#{name} -> #{c.extends.name} [arrowhead=onormal"
                add ", style=dashed" if String.startsWith(c.extends.name, "I")
                addln "]"

            for _, field in ipairs(c.fields)
                if field.aggregation
                    add "#{field.type} -> #{name} [arrowhead=odiamond"
                    add ", taillabel=\"#{field.otherCardinality}  \"" if field.otherCardinality
                    add ", headlabel=\"#{field.selfCardinality}  \"" if field.selfCardinality
                    addln "]"
                else if field.association
                    addln "#{field.type} -> #{name} [arrowhead=none]"

        addln "}"

        return table.concat(lines, "")

return Output