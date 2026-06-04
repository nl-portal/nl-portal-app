#!/bin/sh
echo "[NL Portal] Substituting configuration from env vars"

envsubst < /usr/share/nginx/html/config.template.js > /tmp/config.js

echo "[NL Portal] Done replacing variables in config.js"
