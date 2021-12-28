class Class
    new: (line) =>
        @name, @extends = line\match("([^,]+) : ([^,]+)")
        @name = line if not @name
        @fields = {}
        @methods = {}

    toString: =>
        return "#{@name} extends #{@extends}"

return Class