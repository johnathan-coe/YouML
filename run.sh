#!/bin/sh
moonc -t out/ *.moon Entity/*.moon
cd out
luajit main.lua ../example.you