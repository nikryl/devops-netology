# Домашнее задание к занятию "4.2. Использование Python для решения типовых DevOps задач"

## Обязательная задача 1

Есть скрипт:
```python
#!/usr/bin/env python3
a = 1
b = '2'
c = a + b
```

### Вопросы:
| Вопрос  | Ответ |
| ------------- | ------------- |
| Какое значение будет присвоено переменной `c`?  | exception TypeError  |
| Как получить для переменной `c` значение 12?  |c = str(a) + b  |
| Как получить для переменной `c` значение 3?  | c = a + int(b)  |

## Обязательная задача 2
Мы устроились на работу в компанию, где раньше уже был DevOps Engineer. Он написал скрипт, позволяющий узнать, какие файлы модифицированы в репозитории, относительно локальных изменений. Этим скриптом недовольно начальство, потому что в его выводе есть не все изменённые файлы, а также непонятен полный путь к директории, где они находятся. Как можно доработать скрипт ниже, чтобы он исполнял требования вашего руководителя?

```python
#!/usr/bin/env python3

import os

bash_command = ["cd ~/netology/sysadm-homeworks", "git status"]
result_os = os.popen(' && '.join(bash_command)).read()
is_change = False
for result in result_os.split('\n'):
    if result.find('modified') != -1:
        prepare_result = result.replace('\tmodified:   ', '')
        print(prepare_result)
        break
```

### Ваш скрипт:
```python
#!/usr/bin/env python3

import os

path = '~/nikolai/devops-netology/'
bash_command = ["cd " + path, "git status"]
result_os = os.popen(' && '.join(bash_command)).read()
for result in result_os.split('\n'):
    if result.find('modified') != -1:
        prepare_result = result.replace('\tmodified:   ', '')
        print(path + prepare_result)
```

### Вывод скрипта при запуске при тестировании:
```
~/nikolai/devops-netology/README.md
~/nikolai/devops-netology/terraform/has_been_moved.txt
```

## Обязательная задача 3
1. Доработать скрипт выше так, чтобы он мог проверять не только локальный репозиторий в текущей директории, а также умел воспринимать путь к репозиторию, который мы передаём как входной параметр. Мы точно знаем, что начальство коварное и будет проверять работу этого скрипта в директориях, которые не являются локальными репозиториями.

### Ваш скрипт:
```python
#!/usr/bin/env python3

from subprocess import call, STDOUT
import os
import sys

if len(sys.argv) != 2:
    print('Please specify PATH (only one PATH accepted)')
    exit()

path = sys.argv[1]
if call(['git', '-C', path, 'status'], stderr=STDOUT, stdout=open(os.devnull, 'w')) != 0:
    print('Not a GIT directory')
    exit()

bash_command = ["cd " + path, "git status"]
result_os = os.popen(' && '.join(bash_command)).read()
for result in result_os.split('\n'):
    if result.find('modified') != -1:
        prepare_result = result.replace('\tmodified:   ', '')
        print(path + prepare_result)
```

### Вывод скрипта при запуске при тестировании:
```
#При неверном количестве аргументов
Please specify PATH (only one PATH accepted)

#При ошибке директории
Not a GIT directory

#При успешном запуске
~/nikolai/devops-netology/README.md
~/nikolai/devops-netology/terraform/has_been_moved.txt
```

## Обязательная задача 4
1. Наша команда разрабатывает несколько веб-сервисов, доступных по http. Мы точно знаем, что на их стенде нет никакой балансировки, кластеризации, за DNS прячется конкретный IP сервера, где установлен сервис. Проблема в том, что отдел, занимающийся нашей инфраструктурой очень часто меняет нам сервера, поэтому IP меняются примерно раз в неделю, при этом сервисы сохраняют за собой DNS имена. Это бы совсем никого не беспокоило, если бы несколько раз сервера не уезжали в такой сегмент сети нашей компании, который недоступен для разработчиков. Мы хотим написать скрипт, который опрашивает веб-сервисы, получает их IP, выводит информацию в стандартный вывод в виде: <URL сервиса> - <его IP>. Также, должна быть реализована возможность проверки текущего IP сервиса c его IP из предыдущей проверки. Если проверка будет провалена - оповестить об этом в стандартный вывод сообщением: [ERROR] <URL сервиса> IP mismatch: <старый IP> <Новый IP>. Будем считать, что наша разработка реализовала сервисы: `drive.google.com`, `mail.google.com`, `google.com`.

### Ваш скрипт:
```python
#!/usr/bin/env python3

import json
import socket

try:
    with open('ip_log', 'r') as file:
        hosts = json.load(file)
except:
    hosts = {'mail.google.com':'unknown', 'drive.google.com':'unknown', 'google.com':'unknown'}

for host, ip in hosts.items():
    new_ip = socket.gethostbyname(host)
    if new_ip == ip:
        print(f'{host} - {new_ip}')
    else:
        print(f'<[ERROR] <{host}> IP mismatch: old <{ip}> new <{new_ip}>>')
    hosts[host] = new_ip

with open('ip_log', 'w') as file:
    json.dump(hosts, file)
```

### Вывод скрипта при запуске при тестировании:
```
#Первый запуск
<[ERROR] <mail.google.com> IP mismatch: old <unknown> new <173.194.222.18>>
<[ERROR] <drive.google.com> IP mismatch: old <unknown> new <173.194.220.194>>
<[ERROR] <google.com> IP mismatch: old <unknown> new <64.233.162.138>>

#Повторный запуск
<[ERROR] <mail.google.com> IP mismatch: old <173.194.222.18> new <173.194.222.19>>
drive.google.com - 173.194.220.194
<[ERROR] <google.com> IP mismatch: old <64.233.162.138> new <64.233.162.101>>
```