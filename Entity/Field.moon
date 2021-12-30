return class Field
    new: (line) =>
        visibility, @type, bracket, cardinality, @name = line\match("([-+*])%s*([a-zA-Z]+)(%[*)([%d%-,%*]*)%]*%s+([a-zA-Z]+)%s*")
        @public = visibility == "+"
        @array = bracket == "["

        @aggregation = @array
        
        @selfCardinality, @otherCardinality = cardinality\match("([%d%-%*]*),([%d%-%*]*)")
        @selfCardinality = @selfCardinality\gsub("*", "\\*") if @selfCardinality
        @otherCardinality = @otherCardinality\gsub("*", "\\*") if @otherCardinality

        @association = false
