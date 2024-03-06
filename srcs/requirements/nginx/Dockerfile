FROM alpine:3.18

RUN apk update && apk upgrade && apk add --no-cache \
  nginx \
  openssl

# open ssl certificate
RUN mkdir /etc/nginx/ssl
RUN openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes \
  -out /etc/nginx/ssl/inception.crt \
  -keyout /etc/nginx/ssl/inception.key \
  -subj "/C=JP/ST=Tokyo/L=Minato-Ku/O=42Tokyo/CN=www.example.com"

# nginx
RUN mkdir -p /run/nginx
COPY ./conf/default.conf /etc/nginx/default.conf
EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
