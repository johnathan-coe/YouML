#!/bin/sh
moonc -t out/ *.moon Entity/*.moon
cd out
lua main.lua ../example.you