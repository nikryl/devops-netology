
## Описание

Данный playbook предназначен на инсталляции Clickhouse, Vector и Lighthouse на выделенных хостах с ОС Ubuntu.

- [Play: Install Clickhouse](#play-install-clickhouse)
- [Play: Install Vector](#play-install-vector)
- [Play: Install and configure LightHouse](#play-install-and-configure-lighthouse)
- [Inventory](#inventory)
- [Переменные](#переменные)
- [Теги](#теги)

### Play: Install Clickhouse

Предназначен для установки Clickhouse на хостах `clickhouse`.  
Использует роль [AlexeySetevoi/ansible-clickhouse](https://github.com/AlexeySetevoi/ansible-clickhouse).

### Play: Install Vector

Предназначен для установки Vector на хостах `vector` c помощью собственной роли [vector-role]((https://github.com/nikryl/vector-role)).

### Play: Install and configure LightHouse

Предназначен для установки Vector и веб-сервера Nginx на хостах `vector`. Использует 2 роли:  
- [lighthouse-role]((https://github.com/nikryl/lighthouse-role)) - для установки Lighthouse из GIT репозитория.
- [nginx-role]((https://github.com/nikryl/nginx-role)) - для установки APT пакета Nginx и конфигурации веб-сервера.

## Inventory

3 группы хостов (`clickhouse`, `vector`, `lighthouse`) описаны в файле `invetory/prod.yml`

```yml
clickhouse:
  hosts:
    158.160.15.243:
      ansible_connection: ssh 
vector:
  hosts:
    158.160.29.22:
      ansible_connection: ssh
lighthouse:
  hosts:
    158.160.79.28:
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

Все используемые переменные вынесены в файлы `vars/main.yml` и `defaults/main.yml`в соответствующих ролях.

