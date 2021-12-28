class Method
    new: (line) =>
        visibility, @returnType, @name = line\match("([+-])%s*([^,]+)%s+([^,]+)%(%)%s*")
        if not @returnType
            visibility, @name = line\match("([+-])%s*([^,]+)%(%)%s*")
        @public = visibility == "+"

return Method