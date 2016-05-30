#!/bin/bash

# Build as needed
docker build -t hugo-editable .

# Run making some assumptions about what port/baseurl for hugo and port for C9
docker run -ti --rm \
 -p 7070:7070 \
 -e 'HUGO_PORT=7070' \
 -e 'HUGO_BASEURL=http://192.168.1.51' \
 -p 7171:7171 \
 -e 'C9_PORT=7171' \
 -v `pwd`:/app \
 hugo-editable
