#!/bin/sh
moonc -t out/ *.moon Entity/*.moon
cd out
lua-distill --input main.lua
time lua out.merged.lua ../example.you