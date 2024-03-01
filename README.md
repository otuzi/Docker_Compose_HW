# Домашнее задание к занятию 4 «Оркестрация группой Docker контейнеров на примере Docker Compose»
---
## Задача 1

Сценарий выполнения задачи:
- Установите docker и docker compose plugin на свою linux рабочую станцию или ВМ.
- Зарегистрируйтесь и создайте публичный репозиторий  с именем "custom-nginx" на https://hub.docker.com;
- скачайте образ nginx:1.21.1;
- Создайте Dockerfile и реализуйте в нем замену дефолтной индекс-страницы(/usr/share/nginx/html/index.html), на файл index.html с содержимым:
```
<html>
<head>
Hey, Netology
</head>
<body>
<h1>I will be DevOps Engineer!</h1>
</body>
</html>
```
- Соберите и отправьте созданный образ в свой dockerhub-репозитории c tag 1.0.0 . 
- Предоставьте ответ в виде ссылки на https://hub.docker.com/<username_repo>/custom-nginx/general .

**Ответ:**

https://hub.docker.com/repository/docker/oakachan/custom-nginx/general 

## Задача 2
1. Запустите ваш образ custom-nginx:1.0.0 командой docker run в соответвии с требованиями:
- имя контейнера "ФИО-custom-nginx-t2"
- контейнер работает в фоне
- контейнер опубликован на порту хост системы 127.0.0.1:8080
2. Переименуйте контейнер в "custom-nginx-t2"
3. Выполните команду ```date +"%d-%m-%Y %T.%N %Z" && sleep 0.150 && docker ps && ss -tlpn | grep 127.0.0.1:8080  && docker logs custom-nginx-t2 -n1 && docker exec -it custom-nginx-t2 base64 /usr/share/nginx/html/index.html```
4. Убедитесь с помощью curl или веб браузера, что индекс-страница доступна.

В качестве ответа приложите скриншоты консоли, где видно все введенные команды и их вывод.

**Ответ:**

![alt text](<images/Screenshot 2024-03-01 at 18.52.10.png>)

![alt text](<images/Screenshot 2024-03-01 at 18.52.19.png>)

## Задача 3
1. Воспользуйтесь docker help или google, чтобы узнать как подключиться к стандартному потоку ввода/вывода/ошибок контейнера "custom-nginx-t2".
2. Подключитесь к контейнеру и нажмите комбинацию Ctrl-C.
3. Выполните ```docker ps -a``` и объясните своими словами почему контейнер остановился.
4. Перезапустите контейнер
5. Зайдите в интерактивный терминал контейнера "custom-nginx-t2" с оболочкой bash.
6. Установите любимый текстовый редактор(vim, nano итд) с помощью apt-get.
7. Отредактируйте файл "/etc/nginx/conf.d/default.conf", заменив порт "listen 80" на "listen 81".
8. Запомните(!) и выполните команду ```nginx -s reload```, а затем внутри контейнера ```curl http://127.0.0.1:80 ; curl http://127.0.0.1:81```.
9. Выйдите из контейнера, набрав в консоли  ```exit``` или Ctrl-D.
10. Проверьте вывод команд: ```ss -tlpn | grep 127.0.0.1:8080``` , ```docker port custom-nginx-t2```, ```curl http://127.0.0.1:8080```. Кратко объясните суть возникшей проблемы.
11. * Это дополнительное, необязательное задание. Попробуйте самостоятельно исправить конфигурацию контейнера, используя доступные источники в интернете. Не изменяйте конфигурацию nginx и не удаляйте контейнер. Останавливать контейнер можно. [пример источника](https://www.baeldung.com/linux/assign-port-docker-container)
12. Удалите запущенный контейнер "custom-nginx-t2", не останавливая его.(воспользуйтесь --help или google)

В качестве ответа приложите скриншоты консоли, где видно все введенные команды и их вывод.

**Ответ:**
```
docker attach custom-nginx-t2
```
После подключения к контейнеру и выполнения комбинации клавиш Ctrl-C, контейнер будет остановлен. При завершении работы контейнера, он переходит в статус "Exited", мы видем статус при выполнении команды docker ps -a. Причина завершение работы сервиса в контейнере. При этом контейнер сохраняет свое состояние и можно запустить его снова при необходимости.

![alt text](<images/Screenshot 2024-03-01 at 19.06.16.png>)

```
# cd /etc/nginx/conf.d/default.conf
/bin/sh: 34: cd: can't cd to /etc/nginx/conf.d/default.conf
# 
# 
# cat /etc/nginx/conf.d/default.conf
server {
    listen       81;
    listen  [::]:81;
    server_name  localhost;

    #access_log  /var/log/nginx/host.access.log  main;

    location / {
        root   /usr/share/nginx/html;
        index  index.html index.htm;
    }

    #error_page  404              /404.html;
```
после корректировки номера порта, который слушает Nginx, web cервер стал не доступен, так как при запуске контейнера мы пробросили порт 8080 в порт 80 внутри контейнера. 

## Задача 4


- Запустите первый контейнер из образа ***centos*** c любым тегом в фоновом режиме, подключив папку  текущий рабочий каталог ```$(pwd)``` на хостовой машине в ```/data``` контейнера, используя ключ -v.
- Запустите второй контейнер из образа ***debian*** в фоновом режиме, подключив текущий рабочий каталог ```$(pwd)``` в ```/data``` контейнера. 
- Подключитесь к первому контейнеру с помощью ```docker exec``` и создайте текстовый файл любого содержания в ```/data```.
- Добавьте ещё один файл в текущий каталог ```$(pwd)``` на хостовой машине.
- Подключитесь во второй контейнер и отобразите листинг и содержание файлов в ```/data``` контейнера.


В качестве ответа приложите скриншоты консоли, где видно все введенные команды и их вывод.

**Ответ:**

```
❯ 
❯ docker run -it -d -v $(pwd):/data centos:latest
16db55279af399dec0c053d9d0ecefbc13da1a8405affc0758353b0243e7b1f7
❯ 
❯ 
❯ ls -la
total 0
drwxr-xr-x@ 2 oakachan  staff   64 Mar  1 19:19 .
drwxr-xr-x@ 9 oakachan  staff  288 Mar  1 19:19 ..
❯ 
❯ 
❯ docker ps -a
CONTAINER ID   IMAGE           COMMAND       CREATED          STATUS          PORTS     NAMES
16db55279af3   centos:latest   "/bin/bash"   12 seconds ago   Up 11 seconds             vigorous_bartik
❯ 
❯ docker run -it -d -v $(pwd):/data debian:latest
Unable to find image 'debian:latest' locally
latest: Pulling from library/debian
c2964e85ea54: Pull complete 
Digest: sha256:4482958b4461ff7d9fabc24b3a9ab1e9a2c85ece07b2db1840c7cbc01d053e90
Status: Downloaded newer image for debian:latest
a68f24d63988544712b9c9c0f3e9cf4e5a92dfcab29b85601ae668c6ce686a05
❯ docker ps -a
CONTAINER ID   IMAGE           COMMAND       CREATED          STATUS          PORTS     NAMES
a68f24d63988   debian:latest   "bash"        4 seconds ago    Up 3 seconds              gifted_gould
16db55279af3   centos:latest   "/bin/bash"   49 seconds ago   Up 48 seconds             vigorous_bartik
❯ 
❯ 
❯ docker exec -it 16db55279af3 /bin/sh
sh-4.4# 
sh-4.4# 
sh-4.4# echo "Hello from Centos container" > /data/textfile.txt
sh-4.4# 
sh-4.4# exit
exit
❯ 
❯ 
❯ ls -la
total 8
drwxr-xr-x@ 3 oakachan  staff   96 Mar  1 19:30 .
drwxr-xr-x@ 9 oakachan  staff  288 Mar  1 19:19 ..
-rw-r--r--  1 oakachan  staff   28 Mar  1 19:30 textfile.txt
❯ 
❯ touch additional_file.txt
❯ 
❯ ls -la
total 8
drwxr-xr-x@ 4 oakachan  staff  128 Mar  1 19:30 .
drwxr-xr-x@ 9 oakachan  staff  288 Mar  1 19:19 ..
-rw-r--r--@ 1 oakachan  staff    0 Mar  1 19:30 additional_file.txt
-rw-r--r--  1 oakachan  staff   28 Mar  1 19:30 textfile.txt
❯ docker exec -it a68f24d63988 /bin/sh
# 
# ls /data
additional_file.txt  textfile.txt
# 
# cat /data/textfile.txt
Hello from Centos container
# 
# 
# 
# exit
❯ 
```


## Задача 5

1. Создайте отдельную директорию(например /tmp/netology/docker/task5) и 2 файла внутри него.
"compose.yaml" с содержимым:
```
version: "3"
services:
  portainer:
    image: portainer/portainer-ce:latest
    network_mode: host
    ports:
      - "9000:9000"
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
```
"docker-compose.yaml" с содержимым:
```
version: "3"
services:
  registry:
    image: registry:2
    network_mode: host
    ports:
    - "5000:5000"
```

И выполните команду "docker compose up -d". Какой из файлов был запущен и почему? (подсказка: https://docs.docker.com/compose/compose-application-model/#the-compose-file )

2. Отредактируйте файл compose.yaml так, чтобы были запущенны оба файла. (подсказка: https://docs.docker.com/compose/compose-file/14-include/)

3. Выполните в консоли вашей хостовой ОС необходимые команды чтобы залить образ custom-nginx как custom-nginx:latest в запущенное вами, локальное registry. Дополнительная документация: https://distribution.github.io/distribution/about/deploying/
4. Откройте страницу "https://127.0.0.1:9000" и произведите начальную настройку portainer.(логин и пароль адмнистратора)
5. Откройте страницу "http://127.0.0.1:9000/#!/home", выберите ваше local  окружение. Перейдите на вкладку "stacks" и в "web editor" задеплойте следующий компоуз:

```
version: '3'

services:
  nginx:
    image: 127.0.0.1:5000/custom-nginx
    ports:
      - "9090:80"
```
6. Перейдите на страницу "http://127.0.0.1:9000/#!/2/docker/containers", выберите контейнер с nginx и нажмите на кнопку "inspect". В представлении <> Tree разверните поле "Config" и сделайте скриншот от поля "AppArmorProfile" до "Driver".

7. Удалите любой из манифестов компоуза(например compose.yaml).  Выполните команду "docker compose up -d". Прочитайте warning, объясните суть предупреждения и выполните предложенное действие. Погасите compose-проект ОДНОЙ(обязательно!!) командой.

В качестве ответа приложите скриншоты консоли, где видно все введенные команды и их вывод, файл compose.yaml , скриншот portainer c задеплоенным компоузом.

**Ответ:**

Был запущен файл compose.yaml, хотя docker-compose поддерживает написание файла двумя спосабами, но при нахождении двух файлов в одной папке запустит канонический файл compose.yaml 


---