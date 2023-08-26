CREATE TABLE musteri_tercihleri
( 
  urun_id CHAR(10),
  musteri_isim VARCHAR(50),
  urun_isim VARCHAR(50)
);

INSERT INTO musteri_tercihleri VALUES (10, 'Mark', 'Orange');
INSERT INTO musteri_tercihleri VALUES (50, 'Mark', 'Pineapple');
INSERT INTO musteri_tercihleri VALUES (60, 'John', 'Avocado');
INSERT INTO musteri_tercihleri VALUES (30, 'Lary', 'Cherries');
INSERT INTO musteri_tercihleri VALUES (20, 'Mark', 'Apple');
INSERT INTO musteri_tercihleri VALUES (10, 'Adem', 'Orange');
INSERT INTO musteri_tercihleri VALUES (40, 'John', 'Apricot');
INSERT INTO musteri_tercihleri VALUES (20, 'Eddie', 'Apple');

SELECT * FROM musteri_tercihleri;
DROP TABLE musteri_tercihleri;

--musteri_isim alanında "Lary" varsa, tüm musteri_isim alanlarını "İsim Yok" olarak güncelleyin.

UPDATE musteri_tercihleri
SET musteri_isim= 'İsim Yok'
WHERE EXISTS
(SELECT musteri_isim FROM musteri_tercihleri WHERE musteri_isim='Lary'); 

--Eger musteri_isim field inde 'Lary' degeri var ise o degeri 'No name' olarak guncelleyin

UPDATE musteri_tercihleri
SET musteri_isim='No name'
WHERE musteri_isim='Lary';

--Urun_id field inde 60 var ise butun urun_id leri 50 olarak guncelleyin.
UPDATE musteri_tercihleri
SET urun_id='50'
WHERE EXISTS
(SELECT urun_id FROM musteri_tercihleri WHERE urun_id='60');

--Eger kayıtlar arasında urun_isim olarak 'Orange' degeri var ise butun kayitlari siliniz.
DELETE FROM musteri_tercihleri
WHERE EXISTS
(SELECT urun_isim FROM musteri_tercihleri WHERE urun_isim='Orange');

CREATE TABLE workers(

	worker_id SMALLINT,
    worker_name VARCHAR(50),
    worker_salary NUMERIC,
	CONSTRAINT worker_id_pk PRIMARY KEY (worker_id)
)

INSERT INTO workers VALUES(101, 'Tom Hanks', 12000);
INSERT INTO workers VALUES(102, 'Brad Pitt', 2000);
INSERT INTO workers VALUES(103, 'Aisha Can', 7000);
INSERT INTO workers VALUES(104, 'Angie Ocean', 12000);

SELECT * FROM workers;

--Ortalamadan daha dusuk olan maaslari ortalama maaşa eşitleyin.
UPDATE workers
SET worker_salary= (SELECT AVG(worker_salary) FROM workers)
WHERE worker_salary < (SELECT AVG(worker_salary) FROM workers);

--Ortalamadan daha dusuk olan maaslari 1000 artırın

DROP TABLE workers;

UPDATE workers
SET worker_salary= worker_salary + 1000
WHERE worker_salary< (SELECT AVG(worker_salary) FROM workers);

--"Brad Pitt"in maaşını en yüksek maaşın yüzde 20 daha az olacak sekilde yukseltiniz.

UPDATE workers
SET worker_salary= (SELECT MAX(worker_salary)*0.80 FROM workers)
WHERE worker_name='Brad Pitt';

--Tom Hanks'in maaşını en düşük maaştan yüzde 30 daha fazla olacak sekilde guncelleyin
UPDATE workers
SET worker_salary= (SELECT MIN(worker_salary)*1.30 FROM workers)
WHERE worker_name= 'Tom Hanks';

SELECT * FROM workers;

--IS NULL Condition
CREATE TABLE people
(
ssn INT,
name VARCHAR(50),
address VARCHAR(80)     
);

INSERT INTO people VALUES(123456789, 'Mark Star', 'Florida');
INSERT INTO people VALUES(234567890, 'Angie Way', 'Virginia');
INSERT INTO people VALUES(345678901, 'Maryy Tien', 'New Jersey');
INSERT INTO people(ssn, address) VALUES(456789012, 'Michigan');
INSERT INTO people(ssn, address) VALUES(567890123, 'California');
INSERT INTO people(ssn, name) VALUES(567890123, 'California');

SELECT * FROM people;

--SSN degeri 234567890 olan kayıtın SSN degerini 456767890 olarak update ediniz.

UPDATE people
SET ssn= 456767890
WHERE ssn= 234567890;

--Tüm null değerleri "Isim daha sonra eklenecek" olarak değiştirin
UPDATE people
SET name= 'Isim daha sonra eklenecek'
WHERE name IS NULL;

--Tüm null adres değerlerini "Adres daha sonra eklenecek" olarak değiştirin

UPDATE people
SET address ='To Be Inserted'
WHERE address IS NULL;


--Tablodan kayıt nasıl silinir?

DELETE FROM people
WHERE name='Maryy Tien';

--Ad değeri olmayan kayıtlar nasıl silinir?

DELETE FROM people
WHERE name='Isim daha sonra eklenecek';

--Tüm kayıtlar nasıl silinir?
DELETE FROM people
DROP TABLE people;

--NULL olan tum kayıt yada adresleri siliniz

DELETE FROM people
WHERE name ISNULL OR address ISNULL;


SELECT * FROM people;

--SSN'si 123456789'dan büyük ve 345678901'den küçük olan tüm kayıtları silin
--1.yol:
DELETE FROM people
WHERE ssn>123456789 AND ssn<345678901;

--2.yol:
DELETE FROM people
WHERE ssn BETWEEN 123456789 AND 345678901;


--IS NOT NULL Condition
--Ad değeri null olmayan tüm kayıtları silin

DELETE FROM people
WHERE name IS NOT NULL;

SELECT * FROM people;

--TRUNCATE command
TRUNCATE TABLE people;

--DELETE ile TRUNCATE ve DROP sorgusu arasındaki fark nedir?
--DELETE komutu veritabanındaki tablodan bir veya daha fazla mevcut kaydı siler.
--DROP Komutu tablonun tamamını veritabanından çıkarır.
--TRUNCATE Komutu mevcut tablodaki tüm satırları siler ve satırı sütun adlarıyla bırakır.

-- Interview Question: Maaşı en düşük ve en yüksek olan kayıtlar nasıl seçilir?
--1.way:
SELECT * FROM workers;

SELECT * FROM workers
WHERE worker_salary= (SELECT MIN(worker_salary) FROM workers)
OR 
worker_salary=(SELECT MAX(worker_salary) FROM workers);

--2.yol
SELECT * FROM workers
WHERE worker_salary IN((SELECT MIN(worker_salary) FROM workers), (SELECT MAX(worker_salary) FROM workers));

--Interview Question: 2. en yuksek maasi bulunuz
SELECT MAX(worker_salary) FROM workers
WHERE worker_salary < (SELECT MAX(worker_salary) FROM workers);

--en yuksek 3. maas bulunuz

--ORDER BY verilen field deki data yi "natural order" a gore siralar. Default olarak kucukten buyuge yada harf ise A'dan Z'ye siralama yapar
--ORDER BY + field adi bize datayi default olarak kucukten buyuge siralar
--ORDER BY + field name+ 'ASC'--> bize datayi kucukten buyuge siralar
--ORDER BY + field name + 'DESC' --> bize datayi buyukten kucuge dogru siralar

SELECT * FROM workers
ORDER BY worker_salary DESC
OFFSET 2 ROW
FETCH NEXT 1 ROW ONLY;























