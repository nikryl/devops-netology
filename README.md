# Домашнее задание к занятию 4 «Работа с roles»

[Playbook](playbook/site.yml) был переработан для работы с ролями.  Все ранее используемые `play` были вынесены в отдельные роли:  
  
1. Play `Install Clickhouse` -> заменен на роль [AlexeySetevoi/ansible-clickhouse](https://github.com/AlexeySetevoi/ansible-clickhouse), указанную в домашнем задании  
  
2. Play `Install Vector` -> вынесен в новую [роль](https://github.com/nikryl/vector-role) `vector-role` в отдельном репозитории  
  
3. Play `Install and configure LightHouse` -> разделен на 2 отдельные роли, для которых созданы новые репозитории:  
  
    - [роль](https://github.com/nikryl/lighthouse-role) `lighthouse-role` для установки `Lighthouse`  
  
    - [роль](https://github.com/nikryl/nginx-role) `nginx-role` для установки и конфигурации `Nginx`  
___
  
Все используемые роли описаны в файле `requirements.yml`:

```yml
    - src: git@github.com:AlexeySetevoi/ansible-clickhouse.git
    scm: git
    version: "1.13"
    name: clickhouse 
    - src: git@github.com:nikryl/vector-role.git
    scm: git
    version: "1.0.0"
    name: vector
    - src: git@github.com:nikryl/lighthouse-role.git
    scm: git
    version: "1.0.0"
    name: lighthouse
    - src: git@github.com:nikryl/nginx-role.git
    scm: git
    version: "1.0.0"
    name: nginx
```
___
  