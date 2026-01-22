#!/bin/sh
# Configure Nginx environment variables
envsubst '$CATALOGUE_HOST $USER_HOST $CART_HOST $SHIPPING_HOST $PAYMENT_HOST $RATINGS_HOST' < /etc/nginx/conf.d/default.conf.template > /etc/nginx/conf.d/default.conf
# Start Nginx
exec nginx -g 'daemon off;'
