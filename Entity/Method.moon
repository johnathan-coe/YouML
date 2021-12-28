class Method
    new: (line) =>
        @returnType, @name = line\match("+%s*([^,]+)%s+([^,]+)%(%)%s*")

return Method