#!/usr/bin/env bash

set -e

mkdir -p build
export ELM_VERSION=0.19.1
export JS=bingo.js 
export JSMIN=build/bingo.min.js

npm install elm@$ELM_VERSION
npm install uglify-js

elm make src/Main.elm --optimize --output=$JS
uglifyjs $JS --compress 'pure_funcs="F2,F3,F4,F5,F6,F7,F8,F9,A2,A3,A4,A5,A6,A7,A8,A9",pure_getters,keep_fargs=false,unsafe_comps,unsafe' | uglifyjs --mangle > $JSMIN

cp config.json d3plus-text.full.min.js index.html offline.js saveSvgAsPng.js style.css build/
