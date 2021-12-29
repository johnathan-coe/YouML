#!/bin/sh
moonc -t out/ *.moon Entity/*.moon Util/*.moon

cd out

# Merge into a single file
lua-distill --input main.lua > /dev/null
echo $?

cd ../embed

# Pull in wasmoon
browserify index.js -o bundle.js

# Shove lua code into a global js string in YouML.js
rm YouML.js
echo "var YouML = \`" >> YouML.js
cat ../out/out.min.lua >> YouML.js
echo "\`" >> YouML.js
sed -i 's/\\/\\\\/g' YouML.js
#sed -i ':a;N;$!ba;s/\n/\\n/g' YouML.js