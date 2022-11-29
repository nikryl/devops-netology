# Домашнее задание к занятию "1. Введение в Ansible"
___
## Основная часть
___
  
1. Попробуйте запустить playbook на окружении из test.yml, зафиксируйте какое значение имеет факт some_fact для указанного хоста при выполнении playbook'a:  
  
![some fact](images/hw-8.1-1.png)  
  
2. Найдите файл с переменными (group_vars) в котором задаётся найденное в первом пункте значение и поменяйте его на 'all default fact':  
  
![changed fact](images/hw-8.1-2.png)  
  
3. Воспользуйтесь подготовленным (используется docker) или создайте собственное окружение для проведения дальнейших испытаний:  
  
![docker](images/hw-8.1-3.png)  
  
4. Проведите запуск playbook на окружении из prod.yml. Зафиксируйте полученные значения some_fact для каждого из managed host:  
  
![some fact prod](images/hw-8.1-4.png)  
  
5. Добавьте факты в group_vars каждой из групп хостов так, чтобы для some_fact получились следующие значения: для deb - 'deb default fact', для el - 'el default fact':  
  
Изменены файлы `examp.yml` в директориях `group_vars/deb` и `group_vars/el`  
  
6. Повторите запуск playbook на окружении prod.yml. Убедитесь, что выдаются корректные значения для всех хостов:  
  
![changed fact prod](images/hw-8.1-6.png)  
  
7. При помощи ansible-vault зашифруйте факты в group_vars/deb и group_vars/el с паролем netology:  
  
![encrypt](images/hw-8.1-7.png)  
  
8. Запустите playbook на окружении prod.yml. При запуске ansible должен запросить у вас пароль. Убедитесь в работоспособности:  
  
![ask password](images/hw-8.1-8.png)  
  
9. Посмотрите при помощи ansible-doc список плагинов для подключения. Выберите подходящий для работы на control node  
  
![plugins](images/hw-8.1-9.png)  
  
10. В prod.yml добавьте новую группу хостов с именем local, в ней разместите localhost с необходимым типом подключения:  
  
Добавлена новая группа в файл `inventory/prod.yml`  
  
11. Запустите playbook на окружении prod.yml. При запуске ansible должен запросить у вас пароль. Убедитесь что факты some_fact для каждого из хостов определены из верных group_vars:  
  
![new group](images/hw-8.1-11.png)  

___
## Необязательная часть
___  
  
1. При помощи ansible-vault расшифруйте все зашифрованные файлы с переменными:
  
![decrypt](images/hw-8.1-13.png)  
  
2. Зашифруйте отдельное значение PaSSw0rd для переменной some_fact паролем netology. Добавьте полученное значение в group_vars/all/exmp.yml:
  
![encrypt_string](images/hw-8.1-14.png)  
  
3. Запустите playbook, убедитесь, что для нужных хостов применился новый fact:
  
![new fact](images/hw-8.1-15.png)  
  
4. Добавьте новую группу хостов fedora, самостоятельно придумайте для неё переменную:
  
![new fact](images/hw-8.1-16.png)  
  
5. Напишите скрипт на bash: автоматизируйте поднятие необходимых контейнеров, запуск ansible-playbook и остановку контейнеров:  
  
Подготовлен скрипт `playbook/deploy.sh`  

![script](images/hw-8.1-17.png)  