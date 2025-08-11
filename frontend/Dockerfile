FROM nginx:stable-alpine-slim

RUN rm /etc/nginx/conf.d/default.conf

COPY ./build /usr/share/nginx/html
COPY /conf/nginx.conf /etc/nginx/templates/nginx.conf.template
COPY --chmod=+x entrypoint.sh /docker-entrypoint.d/entrypoint.sh

EXPOSE 8081

CMD ["nginx", "-g", "daemon off;"]
