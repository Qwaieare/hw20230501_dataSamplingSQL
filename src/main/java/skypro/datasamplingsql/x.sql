
Server [localhost]:
Database [postgres]:
Port [5432]:
Username [postgres]:
Пароль пользователя postgres:
psql (14.7)
ПРЕДУПРЕЖДЕНИЕ: Кодовая страница консоли (866) отличается от основной
                страницы Windows (1251).
                8-битовые (русские) символы могут отображаться некорректно.
                Подробнее об этом смотрите документацию psql, раздел
                "Notes for Windows users".
Введите "help", чтобы получить справку.

postgres=# help
Вы используете psql - интерфейс командной строки к PostgreSQL.
Азы:   \copyright - условия распространения
\h - справка по операторам SQL
\? - справка по командам psql
\g или ; в конце строки - выполнение запроса
\q - выход
postgres=# \! chcp 1251
Текущая кодовая страница: 1251
postgres=# \l
                                          Список баз данных
    Имя    | Владелец | Кодировка |     LC_COLLATE      |      LC_CTYPE       |     Права доступа
-----------+----------+-----------+---------------------+---------------------+-----------------------
 postgres  | postgres | UTF8      | Russian_Russia.1251 | Russian_Russia.1251 |
 skypro    | postgres | UTF8      | Russian_Russia.1251 | Russian_Russia.1251 |
 template0 | postgres | UTF8      | Russian_Russia.1251 | Russian_Russia.1251 | =c/postgres          +
           |          |           |                     |                     | postgres=CTc/postgres
 template1 | postgres | UTF8      | Russian_Russia.1251 | Russian_Russia.1251 | =c/postgres          +
           |          |           |                     |                     | postgres=CTc/postgres
(4 строки)


postgres=# \c skypro
Вы подключены к базе данных "skypro" как пользователь "postgres".
skypro=# \dt
            Список отношений
 Схема  |   Имя    |   Тип   | Владелец
--------+----------+---------+----------
 public | employee | таблица | postgres
(1 строка)


skypro=# SELECT * FROM employee;
id | first_name | last_name | gender | age
----+------------+-----------+--------+-----
  3 | Vera       | Ocmina    | woman  |  19
  1 | Lena       | Katina    | woman  |  18
(2 строки)


skypro=# INSERT INTO employee (
skypro(# first_name, last_name, gender, age)
skypro-# VALUES ('Ivan', 'Ivanov', 'man', 51), ('Petr', 'Petrov', 'man', 32), ('Misha', 'Mishkin', 'man', 48);
INSERT 0 3
skypro=# SELECT * FROM employee;
 id | first_name | last_name | gender | age
----+------------+-----------+--------+-----
  3 | Vera       | Ocmina    | woman  |  19
  1 | Lena       | Katina    | woman  |  18
  4 | Ivan       | Ivanov    | man    |  51
  5 | Petr       | Petrov    | man    |  32
  6 | Misha      | Mishkin   | man    |  48
(5 строк)


skypro=# SELECT * FROM employee WHERE age < 30 OR age > 50;
 id | first_name | last_name | gender | age
----+------------+-----------+--------+-----
  3 | Vera       | Ocmina    | woman  |  19
  1 | Lena       | Katina    | woman  |  18
  4 | Ivan       | Ivanov    | man    |  51
(3 строки)


skypro=# SELECT * FROM employee WHERE age > 30 AND age < 50;
 id | first_name | last_name | gender | age
----+------------+-----------+--------+-----
  5 | Petr       | Petrov    | man    |  32
  6 | Misha      | Mishkin   | man    |  48
(2 строки)


skypro=# SELECT * FROM employee WHERE age BETWEEN 30 AND 50;
 id | first_name | last_name | gender | age
----+------------+-----------+--------+-----
  5 | Petr       | Petrov    | man    |  32
  6 | Misha      | Mishkin   | man    |  48
(2 строки)


skypro=# SELECT  * FROM employee ORDER BY last_name DESC;
 id | first_name | last_name | gender | age
----+------------+-----------+--------+-----
  5 | Petr       | Petrov    | man    |  32
  3 | Vera       | Ocmina    | woman  |  19
  6 | Misha      | Mishkin   | man    |  48
  1 | Lena       | Katina    | woman  |  18
  4 | Ivan       | Ivanov    | man    |  51
(5 строк)



skypro=# SELECT * FROM employee WHERE first_name LIKE '%____%';
 id | first_name | last_name | gender | age
----+------------+-----------+--------+-----
  3 | Vera       | Ocmina    | woman  |  19
  1 | Lena       | Katina    | woman  |  18
  4 | Ivan       | Ivanov    | man    |  51
  5 | Petr       | Petrov    | man    |  32
  6 | Misha      | Mishkin   | man    |  48
(5 строк)


skypro=# SELECT * FROM employee WHERE first_name LIKE '%_____%';
 id | first_name | last_name | gender | age
----+------------+-----------+--------+-----
  6 | Misha      | Mishkin   | man    |  48
(1 строка)


skypro=# UPDATE employee SET first_name = 'Ivan' WHERE id = 5;
UPDATE 1
skypro=# SELECT * FROM employee;
 id | first_name | last_name | gender | age
----+------------+-----------+--------+-----
  3 | Vera       | Ocmina    | woman  |  19
  1 | Lena       | Katina    | woman  |  18
  4 | Ivan       | Ivanov    | man    |  51
  6 | Misha      | Mishkin   | man    |  48
  5 | Ivan       | Petrov    | man    |  32
(5 строк)


skypro=# UPDATE employee SET first_name = 'Lena' WHERE id = 3;
UPDATE 1
skypro=# SELECT * FROM employee;
 id | first_name | last_name | gender | age
----+------------+-----------+--------+-----
  1 | Lena       | Katina    | woman  |  18
  4 | Ivan       | Ivanov    | man    |  51
  6 | Misha      | Mishkin   | man    |  48
  5 | Ivan       | Petrov    | man    |  32
  3 | Lena       | Ocmina    | woman  |  19
(5 строк)



skypro=# SELECT first_name AS имя,
skypro-# SUM(age) AS суммарный_возраст
skypro-# FROM employee
skypro-# GROUP BY имя;
  имя  | суммарный_возраст
-------+-------------------
 Misha |                48
 Ivan  |                83
 Lena  |                37
(3 строки)


skypro=# SELECT first_name AS имя, age AS самый_юный_возраст
skypro-# FROM employee WHERE age =(SELECT MIN(age) FROM employee);
 имя  | самый_юный_возраст
------+--------------------
 Lena |                 18
(1 строка)


skypro=# SELECT first_name AS имя, age AS максимальный_возраст
skypro-# FROM employee
skypro-# WHERE NOT first_name = 'Misha'
skypro-# ORDER BY имя, максимальный_возраст ASC;
 имя  | максимальный_возраст
------+----------------------
 Ivan |                   32
 Ivan |                   51
 Lena |                   18
 Lena |                   19
(4 строки)


skypro=#