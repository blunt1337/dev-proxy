FROM jwilder/nginx-proxy:alpine
COPY proxy.conf /etc/nginx/conf.d/my_proxy.conf