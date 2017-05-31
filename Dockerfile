FROM jwilder/nginx-proxy
COPY proxy.conf /etc/nginx/conf.d/my_proxy.conf