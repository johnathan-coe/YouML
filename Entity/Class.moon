return class Class
    new: (line) =>
        @name, @extends = line\match("([^,]+) : ([^,]+)")
        @name = line if not @name
            
        @fields = {}
        @methods = {}
        @notes = {}

    toString: =>
        return "#{@name} extends #{@extends}"
