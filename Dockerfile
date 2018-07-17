FROM nginx:1.14.0-alpine
MAINTAINER example@test.com
copy ./nginx.conf /etc/nginx/nginx.conf
