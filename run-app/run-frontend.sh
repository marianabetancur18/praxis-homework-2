#!/usr/bin/env bash

#Build front end
#Use of yum : yum is the primary tool for getting, installing, deleting, querying, and managing Red Hat Enterprise Linux RPM 
#-y is use to assume yes if its prompted during installation 
#Part 1: Search and decompress .dist
cd /shared
tar -xvf dist.tar.gz

#Part 2: Install NGNIX
sudo yum install epel-release -y
sudo yum install nginx -y

#Part 3: Start the server
sudo systemctl start nginx
sudo systemctl enable nginx

#Part 4: replace default site with our site
#replace the directory with the directory of index.html
cat <<-'default_config' > /etc/nginx/nginx.conf
user  nginx;
worker_processes  1;
error_log  /var/log/nginx/error.log warn;
pid        /var/run/nginx.pid;
events {
  worker_connections  1024;
}
http {
  include       /etc/nginx/mime.types;
  default_type  application/octet-stream;
  log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
                    '$status $body_bytes_sent "$http_referer" '
                    '"$http_user_agent" "$http_x_forwarded_for"';
  access_log  /var/log/nginx/access.log  main;
  sendfile        on;
  keepalive_timeout  65;
  server {
    listen       80;
    server_name  localhost;
    location / {
      root   /shared/dist;
      index  index.html;
      try_files $uri $uri/ /index.html;
    }
    error_page   500 502 503 504  /50x.html;
    location = /50x.html {
      root   /usr/share/nginx/html;
    }
  }
} 
default_config
#Part 5: Save that file and restart nginx. 
sudo systemctl reload nginx

