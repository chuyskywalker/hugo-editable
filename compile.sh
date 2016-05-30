#!/bin/bash

# rebuild container, if needed
docker build -t hugo-editable .

# call hugo to statically compile the site to `public`
docker run -ti --rm -v `pwd`:/app -w /app/site hugo-editable hugo --verbose --destination=/app/nginx-static/public -b '/'

# Build the deployable nginx container
docker build -t hugo-static-nginx ./nginx-static

# Run it, if desired
echo -e "Build complete, run with:\n\n    docker run --name hugo-static-nginx -ti --rm -p 80 hugo-static-nginx\n"

