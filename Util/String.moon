String =
    lines: (s) ->
        s = s.."\n" if s\sub(-1) ~= "\n"
        return s\gmatch("(.-)\n")

    startsWith: (s, prefix) ->
        return string.sub(s, 1, string.len(prefix)) == prefix

return String
