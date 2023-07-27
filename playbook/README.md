
## Описание

Данный playbook предназначен на инсталляции Clickhouse, Vector и Lighthouse на выделенных хостах с ОС Ubuntu.

- [Play: Clickhouse](#play-clickhouse)
- [Play: Vector](#play-vector)
- [Play: Lighthouse](#play-lighthouse)
- [Inventory](#inventory)
- [Переменные](#переменные)
- [Теги](#теги)

### Play: Clickhouse

Предназначен для установки Clickhouse на хостах `clickhouse`. Содержит перечисленные `handler` и `tasks`:

1. *Handler*: `Start clickhouse service` - старт сервиса `clickhouse`
2. *Task*: `Install clickhouse packages` - установка необходимых .deb пакетов `clickhouse` c помощью пакетного менеджера apt и информирование *handler*. Установка производится в цикле c помощью `with_items`
3. *Task*: `Flush handlers` - исполнение *handler* `Start clickhouse service` не дожидаясь окончания текущего *play*
4. *Task*: `Create database` - создание базы данных `logs` в `clickhouse`. Сохраняет вывод STDOUT в переменную `create_db`, на основе которой отслеживаются изменения текущей *task*.

### Play: Vector

Предназначен для установки Vector на хостах `vector`. Содержит перечисленные `tasks`:

1. *Task*: `Install Vector` - установка `vector` с помощью пакетного менеджера apt
2. *Task*: `Create directory for Vector config` - создание директории для хранения *config* файла
3. *Task*: `Copy Vector config` - деплой конфигурационного файла для `vector` с помощью шаблона jinja2

### Play: Lighthouse

Предназначен для установки Vector и веб-сервера Nginx на хостах `vector`. Содержит перечисленные `handler` и `tasks`:

1. *Handler*: `Start nginx service` - старт сервера Nginx
2. *Task*: `Clone LightHouse GIT repository` - клонирование GIT репозитория `Lighthouse` (только ветка `master`)
3. *Task*: `Install Nginx` - установка веб-сервера `Nginx` с помощью пакетного менеджера apt
4. *Task*: `Copy Nginx config` - копирование конфигурационного файла для `Nginx` с локальной машины и информирование *handler* `Start nginx service` о запуске

## Inventory

3 группы хостов (`clickhouse`, `vector`, `lighthouse`) описаны в файле `invetory/prod.yml`

```yml
clickhouse:
  hosts:
    158.160.20.15:
      ansible_connection: ssh 
vector:
  hosts:
    84.201.179.34:
      ansible_connection: ssh
lighthouse:
  hosts:
    84.201.179.167:
      ansible_connection: ssh 
```

По умолчанию используется тип соединения `ssh` по ssh ключу. Для тестирования данного playbook локально хост и тип соединения может быть заменен на docker:
```yml
lighthouse:
  hosts:
    lighthouse:
      ansible_connection: docker
```
## Переменные

Все переменные заданы в файлах `group_vars/%hostname%/vars.yml`. В playbook используются следующие переменные, доступные для изменения:

|Переменная|Хост|Описание|Значение по умолчанию|
|---|---|---|---|
|clickhouse_version|clickhouse|версия Clickhouse|22.8.5.29|
|clickhouse_packages|clickhouse|Инсталлируемые пакеты|{clickhouse-common-static,clickhouse-client,clickhouse-server}|
|vector_version|vector|Версия Vector|0.31.0|
|clickhouse_addr|vector|Адрес endpoint для конфигурации Vector|158.160.20.15|
|vector_config_home|vector|Директория хранения конфигурационного файла Vector|{ ansible_user_dir }}/vector_config|
|vector_config|Vector|YML описание конфигурации Vector|см. group_vars/vector/vars.yml|
|lighthouse_config|lighthouse|Локальное расположение config файла для Nginx|files/nginx.conf|

## Теги

Теги в *playbook* заданы на уровне каждого *play* и наследуются всеми *tasks* в них:

|Tag|Play|
|---|---|
|clickhouse|Install Clickhouse|
|vector|Install Vector|
|lighthouse|Install and configure LightHouse|
