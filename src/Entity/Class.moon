return class Class
    new: (line) =>
        -- Class : Interface
        @name, @extends = line\match("([a-zA-Z]+)%s*:%s*([a-zA-Z]+)%s*")
        @name = line if not @name
            
        @fields = {}
        @methods = {}
        @notes = {}

    toString: =>
        return "#{@name} extends #{@extends}"
