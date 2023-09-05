FROM alpine:3.14

# Устанавливаем PHP, Nginx и необходимые пакеты
RUN apk --update --no-cache add php7 php7-fpm nginx supervisor

# Копируем конфигурационные файлы
COPY nginx.conf /etc/nginx/nginx.conf
COPY php-fpm.conf /etc/php7/php-fpm.conf
COPY default.conf /etc/nginx/conf.d/default.conf
COPY supervisord.conf /etc/supervisord.conf

# Создаем директории для Nginx и PHP-FPM
RUN mkdir -p /run/nginx && mkdir -p /run/php7-fpm

# Копируем исходный код
COPY index.php /var/www/html/index.php

# Открываем порт 80 для доступа к Nginx
EXPOSE 80

# Запускаем supervisord, который будет управлять PHP-FPM и Nginx
CMD ["supervisord", "-c", "/etc/supervisord.conf"]
