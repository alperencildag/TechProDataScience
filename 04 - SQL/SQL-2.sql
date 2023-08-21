--3)Primary Key: Eger bir field "primary key" olarak deklare edilmisse, field datalari "unique", "not null" olmali.
--Bir tabloda sadece 1 tane "primary key" olabilir.
--Primary Key atamasi icin 1.yol:
CREATE TABLE ogrenciler3(

       ogrenci_no char(7) PRIMARY KEY,
	  isim varchar(20) NOT NULL,
	  soyisim varchar(30) NOT NULL,
	  not_ort real, 
	   kayit_tarihi date
);

SELECT * FROM ogrenciler3;

--Primary Key atamasi 2.yol:

CREATE TABLE ogrenciler4(

       ogrenci_no char(7),
	  isim varchar(20) NOT NULL,
	  soyisim varchar(30) NOT NULL,
	  not_ort real, 
	   kayit_tarihi date,
	CONSTRAINT ogrenci_numarasi PRIMARY KEY (ogrenci_no)
	
);

INSERT INTO ogrenciler4 VALUES('1234567', 'Ali', 'Can', 90.45, '2020-12-20');
INSERT INTO ogrenciler4 VALUES('2345678', 'Tom', 'Hanks', 89.5, now());


SELECT * FROM ogrenciler4;

--2)Foreign Key:Tablolar arasında ilişki oluşturmak içindir.
-- Değer olarak "null" kabul eder
-- Tekrarlanan verileri kabul eder
-- Bir tablo birden çok "Foreign Key" alanına sahip olabilir.

/*
“tedarikciler3” isimli bir tablo olusturun. Tabloda “tedarikci_id”, “tedarikci_ismi”,  
“iletisim_isim” field’lari olsun ve “tedarikci_id” yi Primary Key yapin.
“urunler” isminde baska bir tablo olusturun “tedarikci_id” ve “urun_id” field’lari olsun ve
“tedarikci_id” yi Foreign Key yapin.
*/

CREATE TABLE tedarikciler3(

	tedarikci_id char(5) PRIMARY KEY,
    tedarikci_ismi varchar(20),
    iletisim_isim varchar(50)
);

SELECT * FROM tedarikciler3;
CREATE TABLE urunler(

	tedarikci_id char(5),
    urun_id char(5),

	FOREIGN KEY (tedarikci_id) REFERENCES tedarikciler3 (tedarikci_id)

);

CREATE TABLE urunler(

	tedarikci_id char(5),
    urun_id char(5),
   CONSTRAINT urn_fk FOREIGN KEY (tedarikci_id) REFERENCES tedarikciler3 (tedarikci_id)

);


SELECT * FROM urunler;

/*
“calisanlar” isimli bir Tablo olusturun. Icinde “id”, “isim”, “maas”, “ise_baslama”  
field’lari olsun. “id” yi Primary Key yapin, “isim” i Unique, “maas” i Not Null yapın. 
“adresler” isminde baska bir tablo olusturun.Icinde “adres_id”, “sokak”, “cadde” ve 
“sehir” fieldlari olsun.  “adres_id” field‘i ile Foreign Key oluşturun.
*/

CREATE TABLE calisanlar(

  id varchar(15) Primary Key,
  isim varchar(50) Unique,
  maas smallint Not Null,
  ise_baslama date	

);

CREATE TABLE adresler(
  
	adres_id varchar(15),
	sokak varchar (30),
	cadde varchar (30),
	sehir varchar(30),
   FOREIGN KEY (adres_id) REFERENCES calisanlar (id)
);

SELECT * FROM adresler;

INSERT INTO calisanlar VALUES('10002', 'Mehmet Yılmaz' ,12000, '2018-04-14'); 
INSERT INTO calisanlar VALUES('10008', null, 5000, '2018-04-14');
--INSERT INTO calisanlar VALUES('10010', 'Mehmet Yılmaz', 5000, '2018-04-14');--error verir cunku isim field 
--icin "Unique" constraint atanmis. 

INSERT INTO calisanlar VALUES('10004', 'Veli Han', 5000, '2018-04-14');
INSERT INTO calisanlar VALUES('10005', 'Mustafa Ali', 5000, '2018-04-14');



--INSERT INTO calisanlar VALUES('10006', 'Canan Yaz', NULL, '2019-04-12');--error verir cunku maas field i icin
-- "NOT NULL" constraint atanmistir.

INSERT INTO calisanlar VALUES('10003', 'CAN', 5000, '2018-04-14');

--INSERT INTO calisanlar VALUES('10007', 'CAN', 5000, '2018-04-14');--error verir cunku isim field i icin "Unique" constraint
--atamasi var.

--INSERT INTO calisanlar VALUES('10009', 'cem', '', '2018-04-14');--error verir cunku maas field i icin belirlenen smallint
--data type icin char/varchar dastasi insert ettigimiz icin


INSERT INTO calisanlar VALUES('', 'osman', 2000, '2018-04-14');

--INSERT INTO calisanlar VALUES('', 'osman can', 2000, '2018-04-14');--error verir cunku PK daha once bos deger
--'' olarak atanmıstı

--INSERT INTO calisanlar VALUES( '10002', 'ayse Yılmaz' ,12000, '2018-04-14');--error verir cunku PK daha once ayni degerde id kullanilmis.

SELECT * FROM calisanlar;

--INSERT INTO calisanlar VALUES( null, 'filiz ' ,12000, '2018-04-14');--error verir cunku PK 


INSERT INTO adresler VALUES('10003','Mutlu Sok', '40.Cad.','IST');
INSERT INTO adresler VALUES('10003','Can Sok', '50.Cad.','Ankara');
INSERT INTO adresler VALUES('10002','Aga Sok', '30.Cad.','Antep');

SELECT * FROM adresler;
-- Parent tabloda olmayan id ile child a ekleme yapamayiz
INSERT INTO adresler VALUES('10012','Aga Sok', '30.Cad.','Antep');

INSERT INTO adresler VALUES(NULL,'Aga Sok', '30.Cad.','Antep');
INSERT INTO adresler VALUES(NULL,'Aga Sok', '30.Cad.','Maras');

--5) CHECK CONSTRAINT:Girilen veriler için koyduğumuz koşulları kontrol eder.

CREATE TABLE calisanlar2
(
id varchar(15) PRIMARY KEY,
isim varchar(30) UNIQUE,
maas int CHECK (maas>10000) NOT NULL,
ise_baslama date    
);

INSERT INTO calisanlar2 VALUES('10002', 'Mehmet Yılmaz' ,19000, '2018-04-14'); 
--INSERT INTO calisanlar2 VALUES('10003', 'Ali Yılmaz' ,9000, '2018-04-14'); check constraintden dolayi hata verdi 
SELECT * FROM calisanlar2;

-- DQL -- WHERE KULLANIMI

SELECT * FROM calisanlar;
SELECT isim,maas FROM calisanlar;

-- Calisanlar tablosundan maası 5000 den buyuk olan isimleri listeleyiniz

SELECT isim,maas FROM calisanlar WHERE maas>5000;


-- Calisanlar tablosundan ismi Veli Han olan tüm verileri listeleyiniz
SELECT * FROM calisanlar WHERE isim='Veli Han';


-- Calisanlar tablosundan maası 5000 olan tüm verileri listeleyiniz

SELECT * FROM calisanlar WHERE maas=5000;

-- DML -- DELETE KOMUTU
DELETE FROM calisanlar;
DELETE FROM adresler;--sadece datalari siler table yapısı kalir.
DROP TABLE adresler;

SELECT * FROM adresler;

--Adresler tablosundan sehri Antep olan verileri silelim

DELETE FROM adresler WHERE sehir='Antep';












