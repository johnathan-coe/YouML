#!/bin/sh
moonc -t out/ src/*.moon src/Entity/*.moon src/Util/*.moon

cd out

# Merge into a single file
lua-distill --input src/main.lua > /dev/null
echo $?

cd ..

rm -r bin
mkdir bin

cp embed/index.html bin/

# Pull in wasmoon
browserify embed/index.js -o bin/bundle.js

# Shove lua code into a global js string in YouML.js
echo "var YouML = \`" >> bin/YouML.js
cat out/out.min.lua >> bin/YouML.js
echo "\`" >> bin/YouML.js
sed -i 's/\\/\\\\/g' bin/YouML.js
