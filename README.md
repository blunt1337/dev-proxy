# Development reverse proxy

Development nginx reverse proxy based on jwilder/nginx-proxy,
with a small difference, the buffered headers, to allow Monolog's ChromePHPHandler to send big headers.