FROM alpine:3.18

ARG CERTS_DIR=/etc/ssl/certs/
ARG NGINX_RUNTIME_DIR=/run/nginx/
ARG NGINX_HTTP_CONF_DIR=/etc/nginx/http.d/

RUN apk update && apk upgrade && apk add --no-cache \
  nginx

# nginx
RUN mkdir -p ${NGINX_RUNTIME_DIR}

EXPOSE 443 80

ENTRYPOINT ["nginx", "-g", "daemon off;"]
