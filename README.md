# Домашнее задание к занятию "3.3. Операционные системы, лекция 1"

1. `strace /bin/bash -c 'cd /tmp' 2>&1 | grep /tmp`
   **chdir("/tmp")** относится к **cd**

2. 'strace -e trace=openat file /bin/bash'
   Выдает следующий список открытых файлов:
   ```
   openat(AT_FDCWD, "/etc/ld.so.cache", O_RDONLY|O_CLOEXEC) = 3
   openat(AT_FDCWD, "/lib/x86_64-linux-gnu/libmagic.so.1", O_RDONLY|O_CLOEXEC) = 3
   openat(AT_FDCWD, "/lib/x86_64-linux-gnu/libc.so.6", O_RDONLY|O_CLOEXEC) = 3
   openat(AT_FDCWD, "/lib/x86_64-linux-gnu/liblzma.so.5", O_RDONLY|O_CLOEXEC) = 3
   openat(AT_FDCWD, "/lib/x86_64-linux-gnu/libbz2.so.1.0", O_RDONLY|O_CLOEXEC) = 3
   openat(AT_FDCWD, "/lib/x86_64-linux-gnu/libz.so.1", O_RDONLY|O_CLOEXEC) = 3
   openat(AT_FDCWD, "/lib/x86_64-linux-gnu/libpthread.so.0", O_RDONLY|O_CLOEXEC) = 3
   openat(AT_FDCWD, "/usr/lib/locale/locale-archive", O_RDONLY|O_CLOEXEC) = 3
   openat(AT_FDCWD, "/etc/magic.mgc", O_RDONLY) = -1 ENOENT (No such file or directory)
   openat(AT_FDCWD, "/etc/magic", O_RDONLY) = 3
   openat(AT_FDCWD, "/usr/share/misc/magic.mgc", O_RDONLY) = 3
   openat(AT_FDCWD, "/usr/lib/x86_64-linux-gnu/gconv/gconv-modules.cache", O_RDONLY) = 3
   openat(AT_FDCWD, "/bin/bash", O_RDONLY|O_NONBLOCK) = 3
   ```
   Где в самом конце открывается файл, переданный в команду `file`. Также не был найден файл /etc/magic.mgc. Все остальные вернули значение 3, которое представлет собой новый файловый дескриптор.
   За саму проверку соответсвия файлов конкретным типам, судя по всему, отвечает **/usr/share/misc/magic.mgc**.
3. 
   ```
   ping 8.8.8.8 > ping_file & 
   # Вывод PID
   rm ping_file
   lsof -p PID | grep ping_file
   # Вывод открытого файла с его дескриптором и пометкой deleted
   cat /dev/null > /proc/PID/fd/DESCPRIPTOR
   # Обнуляет открытый файл, но в него продолжает идти запись, т.к. процесс все еще работает.
   ```

4. Зомби процессы не занимают никаких системных ресурсов, если не считать незначительного количества системной памяти, необходимое для хранения PID.
   Но поскольку зомби процессы сохраняют PID, теоретически возможна ситуация, при которой они появляются в огромных количествах и могут достигнуть максимального количества процессов в системе (`cat /proc/sys/kernel/pid_max`). После этого запуск новых процессов станет невозожен.
   
5. `sudo opensnoop-bpfcc -d 1`
   **opensnoop** отслеживает все системные вызовы **open()**, отображая какие процессы пытаюсь открыть какие файлы. Флаг **-d** позволяет указать  время выполнения. Получился следующий результат:
   ```
   PID    COMM               FD ERR PATH
   831    vminfo              4   0 /var/run/utmp
   630    dbus-daemon        -1   2 /usr/local/share/dbus-1/system-services
   630    dbus-daemon        21   0 /usr/share/dbus-1/system-services
   630    dbus-daemon        -1   2 /lib/dbus-1/system-services
   630    dbus-daemon        21   0 /var/lib/snapd/dbus-1/system-services/
   ```
	
6. `strace uname -a`
   Ближе к концу видим 3 записи системного вызова `uname`, после чего делается вызов `write` выдаваемого результата:
   ```
   uname({sysname="Linux", nodename="vagrant", ...}) = 0
   fstat(1, {st_mode=S_IFCHR|0620, st_rdev=makedev(0x88, 0), ...}) = 0
   uname({sysname="Linux", nodename="vagrant", ...}) = 0
   uname({sysname="Linux", nodename="vagrant", ...}) = 0
   write(1, "Linux vagrant 5.4.0-110-generic "..., 108Linux vagrant 5.4.0-110-generic #124-Ubuntu SMP Thu Apr 14 19:46:19 UTC 2022 x86_64 x86_64 x86_64 GNU/Linux
   ) = 108
   ```
   Второй раздел man изначально не был доступен. `apt install manpages-dev` решило проблему. Выдержка из `man 2 uname`:
   **Part of the utsname information is also accessible via /proc/sys/kernel/{ostype, hostname, osrelease, version, domainname}.**
   
7. С помощью `;` shell выполняет команды поочередно одну за другой вне зависимости от exit code. В случае `&&` следующая за ним команда будет выполнена только в том случае, если первая была завершена успешно.
   Использование `&&` в случае применения `set -e` не имеет смысла, т.к. выполнение будет преравно в случае, если exit code отличен от нуля.
   **UPD 07.07.2022**
   Как верно было замечено в комментарии к ДЗ, `set -e` и && вполне могут работать вместе. Поэтому опишу исключения.  
   `set -e` немедленно прекращает выполнение в случае **простой** команды. Выполнение не прекратится если:
   - команда является частью цикла **until** или **while**
   - является частью оператора **if**
   - является частью списка **&&** или **||**
   - к статусу выхода команды применяется отрицание (**!**)
   
8. -e прекращает выполнение, если получен код выхода отличный от нуля
   -u прекращает выполнение, если используется переменная, которая не определена
   -x выводит команды и их аргументы по мере их выполнения
   -o pipefail возвращает exit code последней команды, которая возвращает ненулевое значение. Если все команды выполнены успешно, возвращает 0. Без pipefail возвращается exit code последней команды.
   Их использование позволит проще и точнее определить в каком именно месте и с какими вводными данными работа скрипта происходит с ошибками.
   
9. `ps -o stat` Выдает один результат **S**(прерываемый сон) и один **R**(исполняемый).в виртуальной машине Vagrant.
   `ps -eo stat` выдает 59 процессов в статусе **S**, 46 процессов статуса **I**(процессы в простое) и один **R**.
   Присутствуют следующие дополнительные статусы, в соответствии с `man ps` :
   - <    Высокий приоритет
   - N    Низкий приоритет
   - L    присутствуют заблокированные страницы в памяти)
   - s    лидер сессии
   - l    многопоточный)
   - +    в группе процессов foreground
   