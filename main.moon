Parser = require("parser")
Output = require("Output")

file = io.open(arg[1], "r")
parsed = Parser.parse(file)

out = io.open("e.dot", "w")
Output.uml(out, parsed)
out\close()
