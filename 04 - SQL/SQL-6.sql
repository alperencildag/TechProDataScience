CREATE TABLE employees 
(  
  id CHAR(9), 
  name VARCHAR(50), 
  state VARCHAR(50), 
  salary SMALLINT,
  company VARCHAR(20)
);

INSERT INTO employees VALUES(123456789, 'John Walker', 'Florida', 2500, 'IBM');
INSERT INTO employees VALUES(234567890, 'Brad Pitt', 'Florida', 1500, 'APPLE');
INSERT INTO employees VALUES(345678901, 'Eddie Murphy', 'Texas', 3000, 'IBM');
INSERT INTO employees VALUES(456789012, 'Eddie Murphy', 'Virginia', 1000, 'GOOGLE');
INSERT INTO employees VALUES(567890123, 'Eddie Murphy', 'Texas', 7000, 'MICROSOFT');
INSERT INTO employees VALUES(456789012, 'Brad Pitt', 'Texas', 1500, 'GOOGLE');
INSERT INTO employees VALUES(123456710, 'Mark Stone', 'Pennsylvania', 2500, 'IBM');

SELECT * FROM employees;

CREATE TABLE companies 
(  
  company_id CHAR(9), 
  company VARCHAR(20),
  number_of_employees SMALLINT
);

INSERT INTO companies VALUES(100, 'IBM', 12000);
INSERT INTO companies VALUES(101, 'GOOGLE', 18000);
INSERT INTO companies VALUES(102, 'MICROSOFT', 10000);
INSERT INTO companies VALUES(103, 'APPLE', 21000);

SELECT * FROM companies;

--Herbir company için company, number_of_employees ve ortalama salary değerlerini bulun.

SELECT company, number_of_employees,
(SELECT AVG(salary) FROM employees WHERE companies.company=employees.company)
AS average_salary
FROM companies;
 
--Herbir company için company_id, company,  en yüksek ve en düşük salary değerlerini bulun. 

SELECT company_id, company,

(SELECT MAX(salary) FROM employees WHERE companies.company=employees.company) as max_salary,
(SELECT MIN(salary) FROM employees WHERE companies.company=employees.company) as min_salary

FROM companies;

--WILDCARDS in SQL(SQL de Joker Karakterler)
--LIKE Condition: Wildcard ile kullanılır.

--1) % : percentage sign wildcard: sifir yada birden fazla karakterin olup olmadigini sorgular

-- 'E' ile başlayan employee 'name' değerlerini çağırın.--E%

SELECT name FROM employees
WHERE name LIKE 'E%';

--'e' ile biten employee 'name' değerlerini çağırın.

SELECT name FROM employees
WHERE name LIKE '%e';

--name field inde herhangi bir sirada 'e' olan name degerlerini cagırınız
SELECT name FROM employees
WHERE name LIKE '%e%';

--E%e%

--'B' ile başlayıp 't' ile biten employee 'name' değerlerini çağırın.

SELECT name FROM employees
WHERE name LIKE 'B%t';

-- Herhangi bir yerinde 'a' bulunan employee 'name' değerlerini çağırın.

SELECT name FROM employees
WHERE name LIKE '%a%';

--Herhangi bir yerinde 'e' ve 'r' bulunan employee 'name' değerlerini çağırın.

SELECT name FROM employees
WHERE name LIKE '%e%r%' OR name LIKE '%r%e%'; 

--2) _ Wildcard: Tek herhangi bir karakteri temsil eder.
--İkinci karakteri 'e' ve dördüncü karakteri 'n' olan "state" değerlerini çağırın. 
SELECT * FROM employees;

SELECT state FROM employees
WHERE state LIKE '_e_n%';

--Sondan ucuncu karakteri 'i' olan "state" değerlerini çağırın.
SELECT state FROM employees
WHERE state LIKE '%i__';

--İkinci karakteri 'e' olan ve en az 6 karakteri bulunan "state" değerlerini çağırın.
SELECT state FROM employees
WHERE state LIKE '_e____%';

--İkinci karakterinden sonra herhangi bir yerinde 'i' bulunan "state" değerlerini çağırın.
SELECT state FROM employees
WHERE state LIKE '__%i%';


CREATE TABLE words
( 
  word_id CHAR(10) UNIQUE,
  word VARCHAR(50) NOT NULL,
  number_of_letters SMALLINT
);

INSERT INTO words VALUES (1001, 'hot', 3);
INSERT INTO words VALUES (1002, 'hat', 3);
INSERT INTO words VALUES (1003, 'hit', 3);
INSERT INTO words VALUES (1004, 'hbt', 3);
INSERT INTO words VALUES (1008, 'hct', 3);
INSERT INTO words VALUES (1005, 'adem', 4);
INSERT INTO words VALUES (1006, 'selena', 6);
INSERT INTO words VALUES (1007, 'yusuf', 5);

SELECT * FROM words;

--NOT LIKE Condition
--Herhangi bir yerinde 'h' bulunmayan "word" değerlerini çağırın.
SELECT word FROM words
WHERE word NOT LIKE '%h%';


--'t' veya 'f' ile bitmeyen "word" değerlerini çağırın. 

SELECT word FROM words
WHERE word NOT LIKE '%t' AND word NOT LIKE '%f';

--Herhangi bir karakterle başlayıp 'a' veya 'e' ile devam etmeyen "word" değerlerini çağırın.
SELECT word FROM words
WHERE word NOT LIKE '_a%' AND word NOT LIKE '_e%';

--Regular Expression Condition:
--İlk karakteri 'h', ikinci karakteri 'o', 'a' veya 'i', son karakteri 't'  olan "word" değerlerini çağırın.
--1.yol: LIKE kullanarak
SELECT word FROM words
WHERE word LIKE 'ho%t' OR word LIKE 'ha%t' OR word LIKE 'hi%t';

--2.yol: REGEXP kullanarak

SELECT word FROM words
WHERE word  ~ 'h[oai](.*)t';

--İlk karakteri 'h', son karakteri 't' ve ikinci karakteri 'a'dan 'e'ye herhangi bir karakter olan "word" değerlerini çağırın.

SELECT word FROM words
WHERE word  ~ 'h[a-e](.*)t';




























































