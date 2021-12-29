String =
    lines: (s) ->
        s = s.."\n" if s\sub(-1) ~= "\n"
        return s\gmatch("(.-)\n")

return String
