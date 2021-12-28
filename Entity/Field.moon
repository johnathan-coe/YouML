class Field
    new: (line) =>
        visibility, @type, @name = line\match("([-+])%s*([^,]+)%s+([^,]+)%s*")
        @isReference = false
        @public = visibility == "+"

return Field