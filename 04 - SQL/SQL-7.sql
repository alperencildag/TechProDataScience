
--İlk karakteri 's', 'a' veya 'y' olan "word" değerlerini çağırın.

SELECT word FROM words
WHERE word ~ '^[say](.*)';

--Son karakteri 'm', 'a' veya 'f' olan "word" değerlerini çağırın.
SELECT word FROM words
WHERE word ~ '(.*)[maf]$';

--İlk karakteri 's' ve son karakteri 'a' olan "word" değerlerini çağırın.

SELECT word FROM words
WHERE word ~ 's(.*)a'; --'^[s](.*)[a]$' bu sekilde de olur ama best practice degil

--Herhangi bir yerinde 'a' olan "word" değerlerini çağırın.

SELECT word FROM words
WHERE word ~ 'a'; --'a' == %a%


--İlk karakteri 'd' den 't' ye olan, herhangi bir karakter ile devam edip üçüncü karakteri 'l' olan "word" değerlerini çağırın.

SELECT word FROM words
WHERE word ~ '^[d-t].l(.*)';

--İlk karakteri 'd' den 't' ye olan,  herhangi iki karakter ile devam edip dördüncü karakteri 'e' olan "word" değerlerini çağırın.

SELECT word FROM words
WHERE word ~ '^[d-t]..e(.*)';


CREATE TABLE workers
(  
  id CHAR(9), 
  name VARCHAR(50), 
  state VARCHAR(50), 
  salary SMALLINT,
  company VARCHAR(20)
);

INSERT INTO workers VALUES(123456789, 'John Walker', 'Florida', 2500, 'IBM');
INSERT INTO workers VALUES(234567890, 'Brad Pitt', 'Florida', 1500, 'APPLE');
INSERT INTO workers VALUES(345678901, 'Eddie Murphy', 'Texas', 3000, 'IBM');
INSERT INTO workers VALUES(456789012, 'Eddie Murphy', 'Virginia', 1000, 'GOOGLE');
INSERT INTO workers VALUES(567890123, 'Eddie Murphy', 'Texas', 7000, 'MICROSOFT');
INSERT INTO workers VALUES(456789012, 'Brad Pitt', 'Texas', 1500, 'GOOGLE');
INSERT INTO workers VALUES(123456710, 'Mark Stone', 'Pennsylvania', 2500, 'IBM');
SELECT * FROM workers;


--'E' başlayıp ve 'y' biten "name" değerleri dışındaki "name" değerlerini çağırın.
--^ eger koseli parantez dısında yazılmıs ise ilk harf demektir
--^ eger koseli parantez icinde yazılmıssa bu karakterden baska(haricinde) herhangi karakter demektir
SELECT name FROM workers
WHERE name ~ '^[^E](.*)[^y]$';


--'J', 'B' yada 'E' ile başlayan VE 'r' yada 't' ile biten "name" değerlerini çağırın.

SELECT name FROM workers
WHERE name ~ '^[JBE](.*)[rt]$';


-- Son karakteri 'r' yada 't' olan VEYA ilk karakteri 'J','B', yada 'E' olan "name" değerlerini çağırın.


SELECT name FROM workers
WHERE name ~ '^[JBE]' OR name ~ '[rt]$';


--Son karakteri 'r' yada 't' olmayan VE ilk karakteri 'J','B', yada 'E' olmayan "name" değerlerini çağırın.

SELECT name FROM workers
WHERE name ~ '^[^JBE]' OR name ~ '[^rt]$';

--Herhangi bir yerinde 'a' yada 'r' bulunan "name" değerlerini çağırın.
SELECT name FROM workers
WHERE name ~ '[ar]';

SELECT name
FROM workers WHERE name LIKE '%a%r%' OR name LIKE '%r%a%';--ar karakterlerini ardarda bulundukları degerde arar

--İlk harfi 'A' dan 'F' ye bir karakter olan ve ikinci harfi herhangi bir karakter olup üçüncü harfi 'a' olan "name" değerlerini çağırın. 
SELECT name FROM workers
WHERE name ~ '^[A-F].a(.*)';

--Üçüncü karakteri 'o' yada 'x' olan "state" değerlerini çağırın.
SELECT state
FROM workers
WHERE state ~ '..[ox]';

-- Üçüncü karakteri 'o' yada 'x' olmayan "state" değerlerini çağırın.
SELECT state
FROM workers
WHERE state ~ '^..[^ox]';

--Tek bir sütuna çoklu sütun nasıl konulur

CREATE TABLE employees 
(  
  employee_id numeric(9), 
  employee_first_name VARCHAR(20),
  employee_last_name VARCHAR(20)
); 

INSERT INTO employees VALUES(14, 'Chris', 'Tae');
INSERT INTO employees VALUES(11, 'John', 'Walker');
INSERT INTO employees VALUES(12, 'Amy', 'Star');
INSERT INTO employees VALUES(13, 'Brad', 'Pitt');
INSERT INTO employees VALUES(15, 'Chris', 'Way');

SELECT * FROM employees;

CREATE TABLE addresses 
(  
  employee_id CHAR(9), 
  street VARCHAR(20),
  city VARCHAR(20),
  state CHAR(2),
  zipcode CHAR(5)
);

INSERT INTO addresses VALUES(11, '32nd Star 1234', 'Miami', 'FL', '33018');
INSERT INTO addresses VALUES(12, '23rd Rain 567', 'Jacksonville', 'FL', '32256');
INSERT INTO addresses VALUES(13, '5th Snow 765', 'Hialeah', 'VA', '20121');
INSERT INTO addresses VALUES(14, '3rd Man 12', 'Weston', 'MI', '12345');
INSERT INTO addresses VALUES(15, '11th Chris 12', 'St. Johns', 'FL', '32259');

SELECT * FROM addresses;

--employee_id değerlerini "id" adıyla,  employee_first_name ve employee_last_name değerlerini tek sütunda "full_name" adıyla çağırın.
SELECT employee_id AS id, employee_first_name || ' ' ||employee_last_name AS full_name
FROM employees;

SELECT employee_id AS id, employee_first_name || ' ' ||employee_last_name || ' ' ||  employee_id AS fullname_id
FROM employees;

--SQL farklı field leri birlestirebilir farklı data type ları olsa da...

--GROUP BY
CREATE TABLE workers 
(  
  id CHAR(9), 
  name VARCHAR(50), 
  state VARCHAR(50), 
  salary SMALLINT,
  company VARCHAR(20),
	number_of_employees numeric(5)
	
);

INSERT INTO workers VALUES(123456789, 'John Walker', 'Florida', 2500, 'IBM', 34500);
INSERT INTO workers VALUES(234567890, 'Brad Pitt', 'Florida', 1500, 'APPLE', 45500);
INSERT INTO workers VALUES(345678901, 'Eddie Murphy', 'Texas', 3000, 'IBM', 23700);
INSERT INTO workers VALUES(456789012, 'Eddie Murphy', 'Virginia', 1000, 'GOOGLE', 90000);
INSERT INTO workers VALUES(567890123, 'Eddie Murphy', 'Texas', 7000, 'MICROSOFT', 60000);
INSERT INTO workers VALUES(456789012, 'Brad Pitt', 'Texas', 1500, 'GOOGLE', 90000);
INSERT INTO workers VALUES(123456710, 'Mark Stone', 'Pennsylvania', 2500, 'IBM', 23700);

SELECT * FROM workers;


--Her bir  name değeri için toplam salary değerlerini bulun.

SELECT name, SUM(salary) AS total_salary
FROM workers
GROUP BY name
ORDER BY total_salary DESC;


--Her bir state değeri için çalışan sayısını bulup azalan düzende sıralayınız.
SELECT state, SUM (number_of_employees) AS total_num_of_employees
FROM workers
GROUP BY state
ORDER BY total_num_of_employees DESC;

SELECT * FROM workers;

--Her bir company için 2000$ üzeri maaş alan çalışan sayısını bulun.

SELECT company, COUNT(name)
FROM workers
WHERE salary>2000 
GROUP BY company;

--Her bir company için en düşük ve yüksek salary değerlerini bulun.
SELECT company, MIN(salary) AS min_salary, MAX(salary) AS max_salary
FROM workers
GROUP BY company;

--HAVING Clause

--Toplam salary değeri 2500 üzeri olan her bir çalışan için salary toplamını bulun.

SELECT name, SUM(salary) AS total_salary
FROM workers
GROUP BY name
HAVING SUM(salary) > 2500; --GROUP BY keyword unden sonra WHERE kullanılmaz.GROPU BY dan sonra filtreleme icin HAVING clause kullanılır

SELECT * FROM workers;

--SELECT name, SUM(salary) AS total_salary
--FROM workers
--WHERE SUM(salary) > 2500 --ERROR:  aggregate functions are not allowed in WHERE
--GROUP BY name;           --WHERE den sonra aggregate function kullanılmaz.

--Birden fazla çalışanı olan, her bir state için çalışan toplamlarını bulun.
SELECT state, COUNT(name) AS total_num_of_workers
FROM workers
GROUP BY state
HAVING COUNT(name)>1;

--Her bir company için değeri 2000'den fazla olan minimum salary değerlerini bulun. 
SELECT company, MIN(salary) AS min_salary
FROM workers
GROUP BY company
HAVING MIN(salary) >2000;


--Her bir state için değeri 3000'den az olan maximum salary değerlerini bulun.
SELECT state, MAX(salary) AS max_salary_per_state
FROM workers
GROUP BY state
HAVING MAX(salary) <3000
ORDER BY max_salary_per_state ASC;

--LIMIT keyword
SELECT * FROM movies ORDER BY year ASC LIMIT 5;

--LIMIT ORDER BY ile kulanılır ve kac tane data verilmesini istiyorsak o kadar limit ile soyleriz.

--DISTINCT keyword u eger aynı field icerisinde tekrarlı deger var ise tekrarlı datayı tek bir data olarak donderir. 
























