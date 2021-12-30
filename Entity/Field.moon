return class Field
    new: (line) =>
        -- + type[1,*] name
        pattern = "([-+])%s*" .. "([a-zA-Z]+)" .. "(%[*)" .. "([%d%-,%*]*)" .. "%]*%s+" .. "([a-zA-Z]+)"
        visibility, @type, bracket, cardinality, @name = line\match(pattern)
        @public = visibility == "+"
        @array = bracket == "["

        @aggregation = @array
        
        @selfCardinality, @otherCardinality = cardinality\match("([%d%-%*]*),([%d%-%*]*)")
        @selfCardinality = @selfCardinality\gsub("*", "\\*") if @selfCardinality
        @otherCardinality = @otherCardinality\gsub("*", "\\*") if @otherCardinality

        @association = false
