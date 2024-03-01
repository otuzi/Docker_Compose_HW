# Используем официальный образ nginx
FROM nginx:1.21.1

# Удаляем дефолтную страницу nginx
RUN rm /usr/share/nginx/html/index.html

# Копируем наш файл index.html в контейнер
COPY index.html /usr/share/nginx/html/index.html