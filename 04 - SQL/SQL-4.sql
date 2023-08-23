--Subquery
-- Çalisan sayisi 15.000’den cok olan markalarin isimlerini ve bu markada calisanlarin
-- isimlerini ve maaşlarini listeleyin.

SELECT * FROM calisanlar2;
SELECT * FROM markalar;

SELECT isyeri, isim, maas FROM calisanlar2 WHERE isyeri IN 
(SELECT marka_isim FROM markalar WHERE calisan_sayisi>15000);

--Ankara’da calisani olan markalarin marka id'lerini ve calisan sayilarini listeleyiniz.
SELECT marka_id, calisan_sayisi FROM markalar WHERE marka_isim IN
(SELECT isyeri FROM calisanlar2 WHERE sehir='Ankara' );

--AGGREGATE FUNCTIONS
--Calisanlar2 tablosunda maksimum maası listeleyiniz
SELECT MAX(maas) AS max_maas FROM calisanlar2; 

--Eger bir sorgu sonucu icin gecici olarak sorgu tablosuna baslık atamak istiyorsak 'Alias' kullanabiliriz.
--Calisanlar tablosundan minimum maası listeleyiniz
--MIN()
SELECT MIN(maas) AS minimum_maas FROM calisanlar2;

SELECT * FROM calisanlar2 WHERE maas= (SELECT MIN(maas) FROM calisanlar2);
--MAX()
--Calisanlar tablosundaki maasların toplamını listeleyiniz

SELECT SUM(maas) AS sum_of_maas FROM calisanlar2;
--AVG()
--Calisanlar tablosundaki maasların ortalamasını listeleyiniz

SELECT AVG(maas) AS average_maas FROM calisanlar2;
--ROUND()
--AVG() function icin ondalik kısımı azaltmak adına round() function kullanabiliriz
SELECT ROUND(AVG(maas), 2) AS average_maas FROM calisanlar2;

--COUNT() datalarin kac tane oldugunu sayar
--Calisanlar tablosundaki maasların sayısı

SELECT COUNT(maas) FROM calisanlar2;

SELECT COUNT(*) FROM calisanlar2;

--AGGREGATE FUNCTION LARDA SUBQUERY
-- Her markanin id’sini, ismini ve toplam kaç şehirde 
-- bulunduğunu listeleyen bir SORGU yaziniz

SELECT * FROM calisanlar2

SELECT * FROM markalar;

SELECT marka_id, marka_isim,
(SELECT COUNT(sehir) FROM calisanlar2 WHERE isyeri=marka_isim) FROM markalar; 

-- Her markanin ismini, calisan sayisini ve o markaya ait calisanlarin 
-- maksimum maaşini listeleyen bir Sorgu yaziniz.

SELECT marka_isim, calisan_sayisi, (SELECT MAX(maas) FROM calisanlar2 WHERE isyeri=marka_isim) FROM markalar;

-- VIEW Kullanımı
/*
Yaptığımız sorguları hafızaya alır ve tekrar bizden istenen sorgulama yerine
view'e atadığımız ismi SELECT komutuyla çağırırız
*/

---- Her markanin ismini, calisan sayisini ve o markaya ait calisanlarin 
-- maksimum ve minimum maaşini listeleyen bir Sorgu yaziniz.
CREATE VIEW max_min_maas
AS 
SELECT marka_isim, calisan_sayisi, (SELECT MAX(maas) FROM calisanlar2 WHERE isyeri=marka_isim) AS max_maas,
                                   (SELECT MIN(maas)  FROM calisanlar2 WHERE isyeri=marka_isim) AS min_maas
									FROM markalar;
 
 SELECT * FROM max_min_maas;
 
-- EXISTS CONDITION

CREATE TABLE mart
(	
urun_id int,	
musteri_isim varchar(50), 
urun_isim varchar(50)
);

INSERT INTO mart VALUES (10, 'Mark', 'Honda');
INSERT INTO mart VALUES (20, 'John', 'Toyota');
INSERT INTO mart VALUES (30, 'Amy', 'Ford');
INSERT INTO mart VALUES (20, 'Mark', 'Toyota');
INSERT INTO mart VALUES (10, 'Adam', 'Honda');
INSERT INTO mart VALUES (40, 'John', 'Hyundai');
INSERT INTO mart VALUES (20, 'Eddie', 'Toyota');

CREATE TABLE nisan 
(	
urun_id int ,
musteri_isim varchar(50), 
urun_isim varchar(50)
);

INSERT INTO nisan VALUES (10, 'Hasan', 'Honda');
INSERT INTO nisan VALUES (10, 'Kemal', 'Honda');
INSERT INTO nisan VALUES (20, 'Ayse', 'Toyota');
INSERT INTO nisan VALUES (50, 'Yasar', 'Volvo');
INSERT INTO nisan VALUES (20, 'Mine', 'Toyota');

select * from mart
select * from nisan


/*
--MART VE NİSAN aylarında aynı URUN_ID ile satılan ürünlerin
  URUN_ID’lerini listeleyen ve aynı zamanda bu ürünleri MART ayında alan
  MUSTERI_ISIM 'lerini listeleyen bir sorgu yazınız. 
*/

SELECT urun_id, musteri_isim FROM mart WHERE EXISTS

(SELECT urun_id,musteri_isim FROM nisan WHERE mart.urun_id= nisan.urun_id);

/*
--Her iki ayda birden satılan ürünlerin URUN_ISIM'lerini ve bu ürünleri
NİSAN ayında satın alan MUSTERI_ISIM'lerini listeleyen bir sorgu yazınız.
*/

SELECT urun_isim, musteri_isim FROM nisan WHERE EXISTS
(SELECT urun_isim FROM mart WHERE mart.urun_isim=nisan.urun_isim);























