FROM alpine:3.18

ARG NGINX_RUNTIME_DIR=/run/nginx/

RUN apk update && apk upgrade && apk add --no-cache \
  nginx

RUN mkdir -p ${NGINX_RUNTIME_DIR}

EXPOSE 443

ENTRYPOINT ["nginx", "-g", "daemon off;"]
