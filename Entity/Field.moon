return class Field
    new: (line) =>
        visibility, @type, array, @name = line\match("([-+*])%s*([a-zA-Z]+)([%[%]]*)%s+([a-zA-Z]+)%s*")
        @public = visibility == "+"
        @array = #array == 2
        
        @aggregation = @array
        @association = false
