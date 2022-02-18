return class Field
    new: (line) =>
        --        +              type             [1,*]                                                    name
        pattern = "([-+])%s*" .. "([a-zA-Z]+)" .. "([%[<%(]*)" .. "([%d%-,%*]*)" .. "[%]>%)]*" .. "%s+" .. "([a-zA-Z]+)"
        visibility, @type, lbracket, cardinality, @name = line\match(pattern)
        @public = visibility == "+"

        @association = lbracket == "("
        @composition = lbracket == "<"
        @aggregation = lbracket == "["
        @array = lbracket != ""
        
        @selfCardinality, @otherCardinality = cardinality\match("([%d%-%*]*),([%d%-%*]*)")
