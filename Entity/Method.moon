return class Method
    new: (line) =>
        -- + type name()
        pattern = "([+-])%s*([^,]+)%s+([^,]+)%(%)%s*"
        visibility, @returnType, @name = line\match(pattern)
        if not @returnType
            visibility, @name = line\match("([+-])%s*([^,]+)%(%)%s*")
            
        @public = visibility == "+"
