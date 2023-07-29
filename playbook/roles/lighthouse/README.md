Lighthouse role
=========

Данная роль предназначена для клонирования GIT репозитория [Lighthouse](https://github.com/VKCOM/lighthouse).

Требования
------------

Для работы Lighthouse необходима установка любого веб-сервера и настройка его конфигурации на открытие файла `index.html` в корне скачанного репозитория. Подготовлена [соответствующая роль](https://github.com/nikryl/nginx-role) для установки и конфигурации `Nginx`.

Описание
------------

1. *Task*: `Clone LightHouse GIT repository` - клонирование GIT репозитория `Lighthouse` (только ветка `master`)

Переменные
--------------

Не используются в данной роли

Пример использования
---------------- 
Требуется добавить роль в файл `requirements.yml`

```yml
  - src: git@github.com:nikryl/lighthouse-role.git
    scm: git
    version: "1.0.0"
    name: lighthouse 
```
После чего ее можно использовать в `playbook`

```yml
  - hosts: servers
    roles:
       - { role: lighthouse }
```  

License
-------

MIT

Автор
------------------

Nikolai Krylov
