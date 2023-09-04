--Query Operators
SELECT * FROM workers;

INSERT INTO workers VALUES ('789098764', 'Brad Pitt', '', 1800, 'GOOGLE', 32000);

--UNION operator --> 2 query sonucunu birlestirip sunar.
--Maaşı 3000'den fazla olan eyaleti, maasi 2000'den az çalışan adını tekrarlı data olmayacak sekilde bulun.

--1)2 sorgunun sonucunu birleştirmek için kullanılır
--2)UNION Operatörü her seferinde benzersiz/unique kayıtları döndürür, tekrarlanan kayıtlar varsa tekrarlananları kaldırır
--3)"UNION Operatörü" kullanarak aşağıdaki örnekte olduğu gibi farklı alanları tek bir alana yerleştirebiliyoruz.
SELECT state AS State_OR_Employee_Name, salary
FROM workers WHERE salary>3000

UNION

SELECT name AS State_OR_Employee_Name, salary
FROM workers WHERE salary<2000;


--UNION ALL Operator
--UNION ALL operatoru 2 query nin sonucunu birlestirmek icin kullanılır ve tekrarlı data varsa eleme yapmadan sunar.
--Maaşı 3000'den fazla olan eyaleti, maasi 2000'den az çalışan adını tekrarlı data olacak sekilde bulun.


SELECT state AS State_OR_Employee_Name, salary
FROM workers WHERE salary>3000

UNION ALL --tekrarlı data donderebilir

SELECT name AS State_OR_Employee_Name, salary
FROM workers WHERE salary<2000;

--INTERSECT Operator
--2 query nin sonunucnda ortak(common) datayı (kesisim) donderir ve unique/tekrarsiz data donderir 
--Find all common employee names whose salary is greater than 1000, less than 2000
--Butun ortak calisan isimlerini maasları 1000 den buyuk ve 2000 den kucuk olanları bulunuz
SELECT name, salary 
FROM workers
WHERE salary>1000

INTERSECT

SELECT name, salary
FROM workers
WHERE salary<2000;


--Find all common employee names whose salary is greater than 2000 and company name is IBM, APPLE or GOOGLE
--salary si 2000 den fazla ve company adi IBM, APPLE yada GOOGLE olan ortak calisan isimlerini bulunuz.


SELECT name
FROM workers
WHERE salary>2000

INTERSECT

SELECT  name
FROM workers
WHERE company IN('IBM', 'APPLE', 'GOOGLE');

SELECT * FROM workers;

--Query leri birlestirirken(Union, Union All, Intersect) birlestirmek istedigimiz query sonuclarinin getirildigi field data type lari
--aynı olmalıdır yoksa asagidaki gibi bir hata aliriz.
--ERROR:  INTERSECT types smallint and character varying cannot be matched

--EXCEPT Operator:Baska bir query den tek sonuc elde etmek icin kullanılır
--                 Unique records donderir.
--Find the employee names whose salary is less than 3000 and not working in GOOGLE
--Maasi 3000 den az olan ve GOOGLE da calismayan iscileri bulunuz

SELECT name
FROM workers
WHERE salary<3000

EXCEPT

SELECT name
FROM workers
WHERE company='GOOGLE';

--JOINS
--1)INNER JOIN: It returns common data from two tables. (2 table dan ortak data yı donderir)
--2)LEFT JOIN: Returns all data from the first table. (1.tablodan butun datayı ve ortak olanları donderir)
--3)RIGHT JOIN: Returns all data from the second table (2. tablodan butun datayı ve ortak datyı donderir)
--4)FULL JOIN: Returns all data from both table (2 tablodan da butun datyı donderir)
--5)SELF JOIN: You will have a single table but you will use it as 2 tables( 1 tablonun copy sini olusturup aynı tablodan data elde etmektir.)


--JOINS
--1)INNER JOIN: It returns common data from two tables. 
--2)LEFT JOIN: Returns all data from the first table
--3)RIGHT JOIN: Returns all data from the second table 
--4)FULL JOIN: Returns all data from both table 
--5)SELF JOIN: You will have a single table but you will use it as 2 tables

CREATE TABLE my_companies 
(  
  company_id CHAR(3), 
  company_name VARCHAR(20)
);

INSERT INTO my_companies VALUES(100, 'IBM');
INSERT INTO my_companies VALUES(101, 'GOOGLE');
INSERT INTO my_companies VALUES(102, 'MICROSOFT');
INSERT INTO my_companies VALUES(103, 'APPLE');

SELECT * FROM my_companies;

CREATE TABLE orders 
(  
  company_id CHAR(3),   
  order_id CHAR(3),
  order_date DATE
);

INSERT INTO orders VALUES(101, 11, '17-Apr-2020');
INSERT INTO orders VALUES(102, 22, '18-Apr-2020');
INSERT INTO orders VALUES(103, 33, '19-Apr-2020');
INSERT INTO orders VALUES(104, 44, '20-Apr-2020');
INSERT INTO orders VALUES(105, 55, '21-Apr-2020');

SELECT * FROM orders;

--INNER JOIN
--2 table dan common(ortak) olan data ve onlara ait field degerlerini 
--dondurur(kesisim noktasındaki data ve onlarla ilgili diger field degerleri)
--SELECT company name, order id and order date common companies
--company name, order id and order date ortak sirket isimleri donderiniz

SELECT mc.company_name, o.order_id, o.order_date
FROM my_companies mc INNER JOIN orders o
ON mc.company_id=o.company_id;

--2) LEFT JOIN: Returns all data from first table and common data from the second table
--Get company_name,  order id and order date for the companies in my_companies table
--my companies table ındaki company names icin company_name,  order id ve order date i bulunuz

SELECT mc.company_name, o.order_id, o.order_date
FROM my_companies mc LEFT JOIN orders o
ON mc.company_id= o.company_id;


--3)RIGHT JOIN: Returns all data from second table and common data from the first table
--Get company_name,  order id and order date for the companies in my_companies table
--my companies table ındaki comapny names icin company_name,  order id ve order date i bulunuz 
SELECT mc.company_name, o.order_id, o.order_date, o.company_id
FROM orders o RIGHT JOIN my_companies mc 
ON mc.company_id= o.company_id;


--FULL JOIN:Returns all data from two tables(2 tablo dan da butun datayı donderir)
--Get company_name,  order id and order date for the companies in my_companies table
SELECT mc.company_name, o.order_id, o.order_date, o.company_id
FROM orders o FULL JOIN my_companies mc 
ON mc.company_id= o.company_id;

--SELF JOIN:Returns the common data from the table itself

CREATE TABLE workers 
(  
  id CHAR(2), 
  name VARCHAR(20),
  title VARCHAR(60),
  manager_id CHAR(2) 
);

INSERT INTO workers VALUES(1, 'Ali Can', 'SDET', 2);
INSERT INTO workers VALUES(2, 'John Walker', 'QA', 3);
INSERT INTO workers VALUES(3, 'Angie Star', 'QA Lead', 4);
INSERT INTO workers VALUES(4, 'Amy Sky', 'CEO', 5);

SELECT * FROM workers;


--SELF JOIN: IN POSTGRESQL, we can join the same table's fields with "INNER JOIN" but for some other SQL using databases
--like ORACLESQL you should combie the fields of original and copy table by using "SELF JOIN"

--SELF JOIN: PostgreSQL'de biz aynı table dan alacagımız field leri 'Inner Join' ile birlestirebiliriz
--ORACLESQL'de tablo nun field lerini orjinal ve copy table dan 'SELF JOIN' kullanarak birlestirmelisiniz. 

--Create a table which displays the manager of employees
--İscilerin yonetici lerini gosteren bir tablo olusturunuz

SELECT w1.name AS worker_name, w2.name AS manager_name
FROM workers w1 INNER JOIN workers w2
ON w1.manager_id=w2.id;



























