FROM php:8.2-fpm-alpine

ARG user=dev
WORKDIR /var/www/html

#install php extensions and removes cache
ADD ./config/install.sh .
RUN sh install.sh && rm -rf /var/cache/apk/*


#create user to run inside container
RUN adduser -D $user && \
    adduser $user www-data && \
    chown -R $user:www-data /var/www/html

#define user of container
USER dev
