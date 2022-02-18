return class Method
    new: (line) =>
        -- + type name()
        pattern = "([+-])%s*" .. "([^,]+)%s+" .. "([^,]+)" .. "%(%)%s*"
        visibility, @returnType, @name = line\match(pattern)

        if not @returnType
            pattern = "([+-])%s*" .. "([^,]+)" .. "%(%)%s*"
            visibility, @name = line\match(pattern)

        @public = visibility == "+"
