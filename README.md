# Домашнее задание к занятию 2.1 *Системы контроля версий*
### Изменение файла после добавления в коммит

После добавления файла .gitignore в каталог terraform в нем будут проигнорированы следующие файлы и директории:
1. все скрытые локальные директории .terraform вне зависимости от уровня вложенности
2. все файлы расширения .tfstate и .tfstate.*
3. Крэш логи crash.log и crash.*.log
4. Файлы расширения .tfvars и .tfvars.json содержащие конфиденциальные данные
5. Файлы override.tf, override.tf.json и файлы, названия которых оканчивается на _override форматов .tf и .tf.json
6. Файлы .terraformrc и terraform.rc

Строка изменена

Внесены изменения в ветке recursive-merge

Данная строка останется и заменит строку внесенную в ветке conflict-branch при разрешении конфликтов

Комментарий перед перебазированием из ветки rebase-branch
