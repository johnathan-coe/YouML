return class Field
    new: (line) =>
        -- + type[1,*] name
        pattern = "([-+])%s*" .. "([a-zA-Z]+)" .. "([%[<%(]*)" .. "([%d%-,%*]*)" .. "[%]>%)]*" .. "%s+" .. "([a-zA-Z]+)"
        visibility, @type, lbracket, cardinality, @name = line\match(pattern)
        @public = visibility == "+"

        @association = false
        @composition = false
        @aggregation = false

        switch lbracket
            when "<"
                @composition = true
            when "["
                @aggregation = true
            when "("
                @association = true

        @array = true if lbracket
        
        @selfCardinality, @otherCardinality = cardinality\match("([%d%-%*]*),([%d%-%*]*)")
        @selfCardinality = @selfCardinality\gsub("*", "\\*") if @selfCardinality
        @otherCardinality = @otherCardinality\gsub("*", "\\*") if @otherCardinality

