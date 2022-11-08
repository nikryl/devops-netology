# Домашнее задание к занятию "7.1. Инфраструктура как код"
___
## Задача 1
___

1. Ответить на четыре вопроса представленных в разделе "Легенда".
  
  - Какой тип инфраструктуры будем использовать для этого проекта: изменяемый или не изменяемый?
  
    Исходя из легенды, можно предположить, что изменяемый тип подойдет лучше, т.к. нет четкого понимания требований и ожидается большое количество изменений. Однако я бы все же склонялся к неизменяемому типу, т.к. он более предсказуем и прост в управлении. Скорость развертывания, пусть и ниже, но это время с большой долей вероятности будет с лихвой компенировано экономией в поиске решений потенциальных проблем, связанных с дрейфом конфигурации и отловом различных ошибок.
  
  - Будет ли центральный сервер для управления инфраструктурой?
  
    Наличие центрального сервера для управления инфрастуктурой в первую очередь диктуется выбором используемых инструментов, которые описываются далее. В нашем случае он не потребуется.
  
  - Будут ли агенты на серверах?
  
    То же самое, что и в пункте 2, диктуется выбором используемых инструментов. Ansible и Terraform не требуют наличия агентов.
  
  - Будут ли использованы средства для управления конфигурацией или инициализации ресурсов?
  
    Т.к. данные инструменты уже используются в компании и по ним есть наработки, то логичным будет выбор Terraform для инициализации ресурсов, а Ansible для управления конфигурацией.
  
2. Какие инструменты из уже используемых вы хотели бы использовать для нового проекта?
  
  - Packer для создания образов
  - Terraform для инициализации
  - Ansible для управления конфигурацией
  - Docker для контейнеризации, к тому же и разработчики привыкли
  - Kubernetes для оркестрации, имеется большое количество конфигураций
  - Teamcity для CI/CD процессов и тестов
  
  От "остатков" Cloud Formation можем отказаться, это явно неспроста :) Продукт довольно старый и с закрытым исходным кодом. Bash скрипты теоретически могут пригодиться, но я бы их передалал в Ansible плейбуки.  
  
3. Хотите ли рассмотреть возможность внедрения новых инструментов для этого проекта?
  
  На данный момент набор имеющихся инструментов кажется достаточным и не требующим дополнений. При допущении, что GIT уже используется, как разработчиками, так и для хранения различных версий конфигов девопс инженерами.
___
## Задачи 2 и 3
___

Основная версия установлена с помощью пакетного менеджера. Вторую версию terraform установил скачав бинарный файл более старой версии с официального сайта, после чего создал симлинк для этого файла в `/usr/bin`

![terraform](/images/hw-7.1-2.png)
