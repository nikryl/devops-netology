# Домашнее задание к занятию "4.3. Языки разметки JSON и YAML"


## Обязательная задача 1
Мы выгрузили JSON, который получили через API запрос к нашему сервису:
```
    { "info" : "Sample JSON output from our service\t",
        "elements" :[
            { "name" : "first",
            "type" : "server",
            "ip" : 7175 
            }
            { "name" : "second",
            "type" : "proxy",
            "ip : 71.78.22.43
            }
        ]
    }
```
  Нужно найти и исправить все ошибки, которые допускает наш сервис

### Исправленная версия:
```
    { "info" : "Sample JSON output from our service\t",
        "elements" : [
            { "name" : "first",
            "type" : "server",
            "ip" : "Сервис передает IP адрес с ошибкой" 
            },
            { "name" : "second",
            "type" : "proxy",
            "ip" : "71.78.22.43"
            }
        ]
    }
```

## Обязательная задача 2
В прошлый рабочий день мы создавали скрипт, позволяющий опрашивать веб-сервисы и получать их IP. К уже реализованному функционалу нам нужно добавить возможность записи JSON и YAML файлов, описывающих наши сервисы. Формат записи JSON по одному сервису: `{ "имя сервиса" : "его IP"}`. Формат записи YAML по одному сервису: `- имя сервиса: его IP`. Если в момент исполнения скрипта меняется IP у сервиса - он должен так же поменяться в yml и json файле.

### Ваш скрипт:
```python
#!/usr/bin/env python3

import json
import socket
import yaml

default_values = {'mail.google.com':'unknown', 'drive.google.com':'unknown', 'google.com':'unknown'}

#Читаем файлы логов
#Если файл не существует или не соотвествует формату, возвращаются значения по умолчанию
def read_log(lang: str):
    try:
        with open(lang + '_ip_log', 'r') as file:
            if lang == "json":
                hosts = json.load(file)
            elif lang == "yaml":
                hosts = yaml.safe_load(file)
            else:
                hosts = default_values
    except:
        print(lang + " file doesn't exist or corrupted. Overwriting...")
        hosts = default_values

    return hosts

#Выбираем какой файл использовать для сравнения
#Если значения отличаются, выбираем файл с отличающимися от дефолтных значений
#По умолчанию испльзуем json
def select_file(val1: dict, val2: dict):
    if val1 != val2:
        if val1 == default_values:
            print("Different values in YAML and JSON files. YAML is used...")
            return val2
        else:
            print("Different values in YAML and JSON files. JSON is used...")
    return val1


hosts_json = read_log("json")
hosts_yaml = read_log("yaml")

hosts = select_file(hosts_json, hosts_yaml)

for host, ip in hosts.items():
    new_ip = socket.gethostbyname(host)
    if new_ip == ip:
        print(f'{host} - {new_ip}')
    else:
        print(f'<[ERROR] <{host}> IP mismatch: old <{ip}> new <{new_ip}>>')
    hosts[host] = new_ip

with open('json_ip_log', 'w') as file:
    json.dump(hosts, file)
with open('yaml_ip_log', 'w') as file:
    yaml.dump(hosts, file)
    #В задании почему то указан формат yaml файла в виде `- имя сервиса: его IP`
    #Что говорит о записи значений в виде массива, либо массива словарей
    #Если это принципиально, можно сделать так:
    #yaml.dump([hosts], file), а при чтении hosts = yaml.safe_load(file)[0]
```

### Вывод скрипта при запуске при тестировании:
```
В зависимости от условий проверки будут выводиться различные сообщения, например:

json file doesn't exist or corrupted. Overwriting...
Different values in YAML and JSON files. YAML is used...
drive.google.com - 142.250.27.194
google.com - 216.58.214.14
mail.google.com - 142.251.39.101

yaml file doesn't exist or corrupted. Overwriting...
Different values in YAML and JSON files. JSON is used...
drive.google.com - 142.250.27.194
google.com - 216.58.214.14
mail.google.com - 142.251.39.101

mail.google.com - 142.251.39.101
<[ERROR] <drive.google.com> IP mismatch: old <142.250.102.194> new <142.250.27.194>>
google.com - 216.58.214.14
```

### json-файл(ы), который(е) записал ваш скрипт:
```json
{"drive.google.com": "142.250.27.194", "google.com": "216.58.214.14", "mail.google.com": "142.251.39.101"}
```

### yml-файл(ы), который(е) записал ваш скрипт:
```yaml
drive.google.com: 142.250.27.194
google.com: 216.58.214.14
mail.google.com: 142.251.36.5
```
