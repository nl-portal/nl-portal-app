FROM --platform=$BUILDPLATFORM node:22-alpine AS build

COPY . .
ENV CI=true
RUN npm i -g pnpm@10 && pnpm i && pnpm build

FROM nginxinc/nginx-unprivileged:stable-alpine AS image

# Remove default config that listens on 8080
RUN rm /etc/nginx/conf.d/default.conf

# Copy static files (owned by nginx user 101)
COPY --chown=101:101 --from=build ./build /usr/share/nginx/html

# Copy nginx config template
COPY --chown=101:101 --from=build /conf/nginx.conf /etc/nginx/templates/nginx.conf.template

# Copy entrypoint script
COPY --chown=101:101 --chmod=+x --from=build /entrypoint.sh /docker-entrypoint.d/40-envsubst-config.sh

EXPOSE 8081

LABEL org.opencontainers.image.description="NL Portal App Frontend."

CMD ["nginx", "-g", "daemon off;"]
