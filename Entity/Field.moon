class Field
    new: (line) =>
        @type, @name = line\match("-%s*([^,]+)%s+([^,]+)%s*")
        @isReference = false

return Field