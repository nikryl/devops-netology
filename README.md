# Домашнее задание к занятию "3.1. Работа в терминале, лекция 1"  

5. По умолчанию выделено 2 ядра ЦПУ, 1024МБ ОЗУ, 4МБ видеопамяти с отключенным 3D ускорением, 64ГБ ПЗУ с динамическим распределением  

6. Задать объем выделенной оперативной памяти или ресурсов процессора можно прописав в конфиге следующее:
   *config.vm.provider "virtualbox" do |v|*
     *v.memory = X*  где X - объем в МБ
     *v.cpus = Y*  где Y - количество ядер  
   *end*  
   
8. Какой переменной можно задать длину журнала history, и на какой строчке manual это описывается?  
   - **HISTSIZE** задает количество сохраняемых команд в истории (текущая сессия), строка 579  
   - **HISTFILESIZE** задает количество сохраняемых строк в файле истории, строка 570  
   - **ignoreboth** включает в себя как **ignorespace**, так и **ignoredup**. Установив **HISTCONTROL=ignoreboth** в истории не будут сохраняться команды начинающиеся с символа пробела и команды, которые полностью совпадают с последней выполненной  

9. Описывается в разделе *Brace expansion*, строка 725. Представляет собой механизм для генерации произвольных строк. Можно использовать со списком значений, разделенных запятой, либо указывать последовательность значений с помощью *..* .
   Также используются как *Parameter expansion*, строка 770. *${parameter}*  заменяет значение параметра на то, на которое оно указывает.
   
10. **touch file-{1..100000}** Создаст желаемое количество файлов
    **touch file-{1..300000}** Не сработает, т.к. превышено максимальное количества аргументов списка.
	
11. **[[ -d /tmp ]]** проверяет существование директории *tmp* в корне и возвращает код выхода 0, если она существует, либо 1 если нет. Т.к. она существует, то получим код выхода 0 (Истина)
	
12. **mkdir /tmp/new_path_directory**
    **cp /bin/bash /tmp/new_path_directory**
	**PATH=/tmp/new_path_directory/:$PATH**

13. Планирование с помощью *at* позволяет указать точное время для выполнения операции. 
    **Batch** не работает с точным временем выполнения команды. Вместо этого операции будут выполнены, когда LA системы не будет превышать 1.5. 
	*Batch* работает только в интерактинов режиме, а *at* можно использовать вместе с *|* для записи одной строкой.
	
