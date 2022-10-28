# Домашнее задание к занятию "6.4. PostgreSQL"
___
## Задача 1
___

```bash
# Запуск postresql в docker
docker run --name postgres -e POSTGRES_PASSWORD=postgres -v ${PWD}:/data/backup -d postgres:13

# Подключение к docker контейнеру
docker exec -it postgres bash

# Подключение к БД с помощью psql
psql -U postgres

# Вывод списка БД
# "+" отображает дополнительную информацию 
\l[+]

# Подключение к бд
\c db_name

# Вывод списка таблиц
# "S" отображает системные объекты
\d[S+]

# Описание содержмимого таблиц
\d[S+] table_name

# Выход из psql
\q
```
  
___
## Задача 2
___


```sql
-- Создание БД
create database test_database;
```
```bash
# Восстановление бэкапа
psql test_database -U postgres < /data/backup/test_dump.sql
```
```sql
-- Выполняем *analyze* на таблицу *orders*
analyze orders;

-- Выбираем столбец с максимальным средним значением размера элементов в байтах
select attname, avg_width 
from pg_stats 
where tablename = 'orders' 
order by avg_width desc 
limit 1;

 attname | max_avg_width
---------+---------------
 title   |            16
(1 row)
```

___
## Задача 3
___

Создаем 2 новые таблицы, в которые попадут данные из таблицы *orders*
```sql
create table orders_1 (check (price > 499)) inherits (orders);
create table orders_2 (check (price <= 499)) inherits (orders);
```

Копируем данные из таблицы *orders* в новые таблицы и затем удаляем в оригинальной таблице *orders*.
При удалении обязательно указать ключевое слово `ONLY`, в противном случае данные будут удалены во всех таблицах, наследовавшихся от *orders*.

```sql
insert into orders_1 select * from orders where price > 499;
insert into orders_2 select * from orders where price <= 499;
delete from only orders;
```

Eсли мы хотим, чтобы при вставке данных в *orders* наша логика разделения сохранялась, мы можем создать 2 новых правила:
```sql
CREATE RULE orders_1_insert AS
  ON INSERT TO orders WHERE (price > 499)
  DO INSTEAD INSERT INTO orders_1 VALUES (NEW.*);

CREATE RULE orders_2_insert AS
  ON INSERT TO orders WHERE (price <= 499)
  DO INSTEAD INSERT INTO orders_2 VALUES (NEW.*);
```

Такой подход можно было использовать с самого начала при создании таблицы *orders*. Также можно использовать *partitioning*:
```sql
CREATE TABLE orders (
  id integer NOT NULL,
  title character varying(80) NOT NULL,
  price integer DEFAULT 0
) PARTITION BY RANGE (price);

CREATE TABLE orders_1 PARTITION OF orders
    FOR VALUES FROM ('500') TO ('99999');

CREATE TABLE orders_2 PARTITION OF orders
    FOR VALUES FROM ('0') TO ('500');

```

В данном случае есть минус, при котором не удастся хранить значения превышающие верхний предел таблицы *orders_1*. Для использования *partitioning* следует убедиться, что параметр *enable_partition_pruning* не отключен в конфигурации *postgresql.conf*.

Для обоих подходов хорошей идеей будет создание индекса на столбце *price*.

___
## Задача 4
___

Редактируем файл test_dump.sql в разделе создания таблицы и добавляем `UNIQUE` для столбца *title*
```sql
CREATE TABLE public.orders (
  id integer NOT NULL,
  title character varying(80) UNIQUE NOT NULL,
  price integer DEFAULT 0
);
```