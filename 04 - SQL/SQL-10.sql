--uzun yorumlar icin
/*
uzun yorum satırları icin kullanılır
*/

-- **************** DEGİSKEN TANIMLAMA **************************
--do ile anonymous(ismi olmayan,genel) bir prosedur uygula diyoruz 
               --dolar sign ile syntax iceriisnde kullanılacak (varchar, text gibi) 
			   --degiskenlerin tırnak isaretlerini pgAdmin ekleyecek demis oluyoruz

do $$ 
declare 
    counter integer :=1;  --counter isminde bir degisken olusturuldu ve 1 deger olarak atandı.
	first_name varchar(50) :='Ahmet';
	last_name varchar(50) := 'Gok';
	payment numeric(4, 2) := 20.5;
	
begin                       --1 Ahmet Gok has paid 20.5 USD
     raise notice '% % % has paid % USD',
	                counter,
					first_name,
					last_name,
					payment;
end $$;

--TASK 1:Degiskenler olusturarak ekrana "Ahmet ve Mehmet beyler 120 TL ye bilet aldilar. " cumlesini yazdırınız.

do $$
declare 
       first_person varchar(50) :='Ahmet';
	   second_person varchar(50) :='Mehmet';
	   payment numeric(3) :=120;
begin
     raise notice '% ve % beyler % TLye bilet aldilar.',
	               first_person,
				   second_person,
				   payment;
end $$;	--NOTICE:  Ahmet ve Mehmet beyler 120 TLye bilet aldilar.DO			   

--********************BEKLETME KOMUTU **************** 

do $$
declare 
       created_at time := now(); --local /db de olan simdiki zaman degerini created_at degiskenine atama yapar.
begin
     raise notice '%', created_at;
	 perform pg_sleep(5); --5 saniye bekle diye yazdık
	 raise notice '%', created_at;
	 
end $$;

-- ***************** TABLODAN DATA TYPE INI KOPYALAMA **********
do $$
declare
      film_title film.title%type; 