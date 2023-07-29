Nginx role
=========

Данная роль предназначена для установки и конфигурации `Nginx` для сервера с `Lighthouse` на устройствах под управлением ОС Ubuntu.

Требования
------------

Выполнение роли производится после установки `Lighthouse` на устройстве. Необходимая роль доступна по [ссылке](https://github.com/nikryl/lighthouse-role)

Описание
------------

1. *Handler*: `Start nginx service` - старт сервера Nginx
2. *Task*: `Install Nginx` - установка веб-сервера `Nginx` с помощью пакетного менеджера apt
3. *Task*: `Copy Nginx config` - копирование конфигурационного файла для `Nginx` с локальной машины и информирование *handler* `Start nginx service` о запуске

Переменные
--------------

Данная роль содержит 1 доступную для изменения пользователем переменную

|Переменная|Описание|Значение по умолчанию|
|---|---|---|
|lighthouse_config|Локальное расположение config файла для Nginx|files/nginx.conf|

Теги
--------------

|Тег|Действие|
|---|--------|
|install|Только установка Nginx|
|config|Копирование конфигурации и запуск Nginx сервера|


Пример использования
---------------- 
Требуется добавить роль в файл `requirements.yml`

```yml
  - src: git@github.com:nikryl/nginx-role.git
    scm: git
    version: "1.0.0"
    name: nginx 
```
После чего ее можно использовать в `playbook`

```yml
  - hosts: servers
    roles:
       - { role: nginx }
```  

License
-------

MIT

Автор
------------------

Nikolai Krylov