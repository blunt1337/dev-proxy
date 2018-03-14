FROM jwilder/nginx-proxy:alpine

# Add a self signed ssl to /etc/nginx/ssl, and edit the nginx.tmpl to use it
RUN sed -i -E 's/set -e/openssl req -new -newkey rsa:2048 -days 1 -nodes -x509 -subj "\/C=US\/ST=Denial\/L=Springfield\/O=Dis\/CN=blunt.sh" -keyout \/etc\/nginx\/certs\/default.key -out \/etc\/nginx\/certs\/default.crt/' /app/docker-entrypoint.sh \
	&& sed -i -E 's/\{\{ \$is_https :=.*\}\}/{{ $is_https := ne $https_method "nohttps" }}{{ $cert := when (and (exists (printf "\/etc\/nginx\/certs\/%s.crt" $cert)) (exists (printf "\/etc\/nginx\/certs\/%s.key" $cert))) $cert "default" }}/g' /app/nginx.tmpl \
	&& sed -i -E 's/proxy_http_version 1\.1;/\0 proxy_ssl_verify off; proxy_ssl_server_name on;/' /app/nginx.tmpl

COPY proxy.conf /etc/nginx/conf.d/my_proxy.conf