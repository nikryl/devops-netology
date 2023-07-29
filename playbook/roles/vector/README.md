Vector-role
=========

Данная роль предназначена для установки и конфигурации `Vector` на устройствах под управлением ОС Ubuntu.

Описание
------------

1. *Task*: `Install Vector` - установка `vector` с помощью пакетного менеджера apt
2. *Task*: `Create directory for Vector config` - создание директории для хранения *config* файла
3. *Task*: `Copy Vector config` - деплой конфигурационного файла для `vector` с помощью шаблона jinja2

Переменные
--------------

Все переменные доступны для изменения пользователем и хранятся в файле `defaults.yml`.

|Переменная|Хост|Описание|Значение по умолчанию|
|---|---|---|---|
|vector_version|vector|Версия Vector|0.31.0|
|clickhouse_addr|vector|Адрес endpoint для конфигурации Vector|158.160.20.15|
|vector_config_home|vector|Директория хранения конфигурационного файла Vector|{ ansible_user_dir }}/vector_config|
|vector_config|Vector|YML описание конфигурации Vector|см. group_vars/vector/vars.yml|

Теги
--------------

|Тег|Действие|
|---|--------|
|install|Только установка Vector|
|config|Создание директории и копирование конфига|


Пример использования
---------------- 
Требуется добавить роль в файл `requirements.yml`

```yml
  - src: git@github.com:nikryl/vector-role.git
    scm: git
    version: "1.0.0"
    name: vector 
```
После чего ее можно использовать в `playbook`

```yml
  - hosts: servers
    roles:
       - { role: vector }
```  

License
-------

MIT

Автор
------------------

Nikolai Krylov
