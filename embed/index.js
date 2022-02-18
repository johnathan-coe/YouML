const { LuaFactory } = require("wasmoon")

const input = document.getElementById("input")
const graph = document.getElementById("graph")
let parser, output

const factory = new LuaFactory()
factory.createEngine({traceAllocations: false}).then(async (l) => await run(l))

async function run(lua) {
    await lua.doString(YouML)
    const dist = lua.global.get("__DISTILLER")

    parser = dist.require("parser")
    output = dist.require("Output")
}

function render() {
    const out = parser.parse(input.value)
    const dot = output.uml(out)
    console.log(dot)
    
    hpccWasm.graphviz.layout(dot, "svg", "dot").then(svg => {
        graph.innerHTML = svg;
    });
}

input.onkeyup = render
