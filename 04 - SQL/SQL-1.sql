--Database olusturma
CREATE database b168;

--Tablo olusturma

CREATE TABLE ogrenciler(

	ogrenci_no char(7),
    isim varchar(20),
	soyisim varchar(30),
	not_ort real, --Ondalikli sayilari belirtmek icin kullanilir
	kayit_tarihi date
);

SELECT * FROM ogrenciler;

--SQL de bir tabloyu olusturmanın 2 yolu vardır.İlki sıfırdan tablo olusturmaktır ve ikincisi de baska bir tablodan belirlenmis 
--"field" leri kopyalayarak yeni bir tablo olusturmaktır. 

--Var olan tablodan yeni bir tablo olusturma

CREATE TABLE ogrenci_notlari
AS
SELECT isim, soyisim, not_ort FROM ogrenciler;

SELECT * FROM ogrenci_notlari;

-- DML (Data MAnipulation Language)-->veri yi tablo icine yerlestirme
CREATE TABLE ogrenciler(

	ogrenci_no char(7),
    isim varchar(20),
	soyisim varchar(30),
	not_ort real, --Ondalikli sayilari belirtmek icin kullanilir
	kayit_tarihi date
);


INSERT INTO ogrenciler VALUES('1234567', 'Tom', 'Hanks', 85.5, '2020-12-11'); 
INSERT INTO ogrenciler VALUES('2345678', 'Ali', 'Can', 90.2, now());--default format --> yyyy/ay/gun

SELECT * FROM ogrenciler;

--Bir tabloya parcali veri yerlestirme
INSERT INTO ogrenciler (isim, soyisim) VALUES ('Brad', 'Pitt');

--DQL(Data Query Language) -->SELECT keyword u ile data okumasi yapabiliriz. "*" butun veriler demektir.
SELECT * FROM ogrenciler;

--CONSTRAINTS/ KISITLAMALAR/BELİRLEYİCİLER

--UNIQUE
--NOT NULL 

CREATE TABLE ogrenciler2(

      ogrenci_no char(7) UNIQUE,
	  isim varchar(20) NOT NULL,
	  soyisim varchar(30) NOT NULL,
	  not_ort real, 
	   kayit_tarihi date

);

INSERT INTO ogrenciler2 VALUES('1234567', 'Ali', 'Can', 90.45, '2020-12-20');
INSERT INTO ogrenciler2 VALUES('2345678', 'Tom', 'Hanks', 89.5, now());
INSERT INTO ogrenciler2 (isim, soyisim) VALUES('Veli', 'Han');
INSERT INTO ogrenciler2 (isim, soyisim) VALUES('Ayse', 'Han');

SELECT * FROM ogrenciler2;

--PRIMARY KEY