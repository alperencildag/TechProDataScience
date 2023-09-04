--DQL-->Data Query Language
--DML -->Data Manipulation Language : Sadece verileri CRUD operations ile kullandik.
--DDL --> Data Definition Language

--ALTER TABLE :This command is used to add, delete or update field of an existing table.
--ALTER TABLE command is used to add, delete or update the data type of a field in an existing table

--ALTER TABLE komutu var olan tabloda bir field eklemek, silmek yada field de guncelleme yapmak icin kullanılır.
--ALTER TABLE komutu aynı zamanda bir field de guncelleme yapmak icin (data type, size degistirmek, size)

--1)How to add a column to an existing table
ALTER TABLE workers
ADD worker_address VARCHAR(80);

--2) How to add a field with default value
ALTER TABLE my_companies
ADD employee_salary_company TEXT DEFAULT 'Miami, FL, USA';

--3) How to add multiple fields into a table
ALTER TABLE my_companies
ADD number_of_employees NUMERIC DEFAULT 0, 
ADD name_of_ceo TEXT;

--4)How to drop fields from a table
--COLUMN == FIELD
ALTER TABLE my_companies
DROP COLUMN name_of_ceo;

--5)How to rename a field in an existing table
--Var olan bir tabloda field ismi degistirme (RENAME --> yeniden adlandir)
ALTER TABLE my_companies
RENAME employee_address TO worker_address; 

--6)How to rename an existing table
--Var olan bir tablonun adını degistirme
ALTER TABLE my_companies
RENAME TO your_companies;


--7)How to modify(Add constraint, change data type or change the size) of a field
--Bir field in modifiye islemi nasıl yapılır(constraint eklemek, data type degistirmek yada size degistirmek)
--How to add a constraint into a field(bir field e constraint ekleme)
--Add "NOT NULL" constraint for employee_id (id field ine 'NOT NULL' constraint ekleyiniz)
ALTER TABLE workers
ALTER COLUMN id SET NOT NULL;

--How to add UNIQUE constraint(UNIQUE constraint ekleme)
ALTER TABLE employees
ADD CONSTRAINT employee_id_unique UNIQUE (employee_id);
--SQL de databse constraint lerini deklare ederken bunu genellikle 2 defa yazarız.

--Add UNIQUE constraiınt for worker_address in the workers table
--workers table ında worker_address icin UNIQUE constraint ekleyiniz
ALTER TABLE workers
ADD UNIQUE (title);

--Change the data type of worker_address to CHAR(5)
--worker_address field inin data type ni CHAR(50)
ALTER TABLE workers
ALTER COLUMN worker_address TYPE CHAR(50);

--When we modify a field new size must be greater than or equal to the maximum value of existing value
--Bir field i modify ettigimizde var olan size degerinin en ust  degerine yada ondan daha buyuk bir degerde olması gerekir.

INSERT INTO workers (id, worker_address) VALUES (5,'Miami');

--How to drop a constraint from a field
ALTER TABLE workers
ALTER COLUMN id DROP NOT NULL;

ALTER TABLE employees
DROP CONSTRAINT employee_id_unique;

SELECT * FROM your_companies;
SELECT * FROM employees;
SELECT * FROM workers;

----------------------------------------------------------------------------------------

--CREATING FUNCTIONS(FUNCTION OLUSTURMA)
--Bazı gorevleri daha hızlı ve daha kolay yapmamız icin function lara ihtiyacımız vardır.
--CRUD opareasyonları icin de FUNCTION olusturabiliriz.
--SQL de her function bir data type ile return eder
--Phyton daki none nasıl ki  data dondermiyorsa SQL de bazen 'Procedures' denilen data type inde datalar donderebilir

CREATE OR REPLACE FUNCTION addF(x NUMERIC, y NUMERIC)
RETURNS NUMERIC
LANGUAGE plpgsql
AS

$$
BEGIN
 RETURN x+ y;

END
$$

SELECT addF(3, 4) AS addition;

