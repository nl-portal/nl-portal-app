FROM node:22-alpine as build
COPY . .
RUN npm i -g pnpm
ENV CI=true
RUN pnpm i
RUN pnpm build

FROM nginx:stable-alpine-slim as image

RUN rm /etc/nginx/conf.d/default.conf

COPY --from=build ./build /usr/share/nginx/html
COPY --from=build /conf/nginx.conf /etc/nginx/templates/nginx.conf.template
COPY --chmod=+x --from=build /entrypoint.sh /docker-entrypoint.d/entrypoint.sh

EXPOSE 8081

LABEL org.opencontainers.image.title="NL Portal App Frontend" \
      org.opencontainers.image.version="3.0.0-RC" \
      org.opencontainers.image.description="The frontend image of the NL Portal App."

CMD ["nginx", "-g", "daemon off;"]
