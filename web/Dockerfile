FROM --platform=linux/amd64 nginx:1.24-alpine

EXPOSE 8080

ENV CATALOGUE_HOST=catalogue \
    USER_HOST=user \
    CART_HOST=cart \
    SHIPPING_HOST=shipping \
    PAYMENT_HOST=payment \
    RATINGS_HOST=ratings

COPY entrypoint.sh /root/
RUN chmod +x /root/entrypoint.sh

ENTRYPOINT ["/root/entrypoint.sh"]

COPY default.conf.template /etc/nginx/conf.d/default.conf.template
COPY static /usr/share/nginx/html