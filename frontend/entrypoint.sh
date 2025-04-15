#!/bin/sh
echo "Start replacing env vars"

cd /usr/share/nginx/html/
envsubst < config.template.js > config.js
cd -

echo "Done replacing env vars"
