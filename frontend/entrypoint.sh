#!/bin/sh
echo "[NL Portal] Substituting configuration from env vars"

cd /usr/share/nginx/html/
envsubst < config.template.js > config.js
cd -

echo "[NL Portal] Done replacing variables in config.js"
