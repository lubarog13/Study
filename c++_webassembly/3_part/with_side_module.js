let memory = new WebAssembly.Memory({ initial: 1, maximum: 10 });

const importObject = {
    env: {
        memory: memory,
        __memory_base: 1,
        __table_base: 0,
    }
}

/*fetch("side_module.wasm").then((response) =>
    response.arrayBuffer()
).then((bytes) => 
    WebAssembly.instantiate(bytes, importObject)
).then((result) => {
    const value = result.instance.exports.Increment(17);
    console.log("value: " + value.toString());
});
*/

WebAssembly.instantiateStreaming(fetch("side_module.wasm"), importObject).then((result) => {
    const value = result.instance.exports.Increment(17);
    console.log("value: " + value.toString());
});