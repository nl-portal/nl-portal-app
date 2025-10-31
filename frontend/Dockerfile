FROM --platform=$BUILDPLATFORM node:22-alpine AS build

COPY . .
ENV CI=true
RUN npm i -g pnpm && pnpm i && pnpm build

FROM nginx:stable-alpine-slim AS image

RUN rm /etc/nginx/conf.d/default.conf

COPY --from=build ./build /usr/share/nginx/html
COPY --from=build /conf/nginx.conf /etc/nginx/templates/nginx.conf.template
COPY --chmod=+x --from=build /entrypoint.sh /docker-entrypoint.d/entrypoint.sh

EXPOSE 8081

LABEL org.opencontainers.image.description="NL Portal App Frontend."

CMD ["nginx", "-g", "daemon off;"]
