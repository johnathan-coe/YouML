return class Method
    new: (line) =>
        @line = line

        visibility, @returnType, @name = line\match("([+-])%s*([^,]+)%s+([^,]+)%(%)%s*")
        if not @returnType
            visibility, @name = line\match("([+-])%s*([^,]+)%(%)%s*")
        @public = visibility == "+"
        @isReference = false

    copy: () =>
        return Method(@line)
