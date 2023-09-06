-- ******** Case Statement *****************
--syntax:

case search-expression
     when expression_1 [, expression_2, ... ] then
	 statement
	 when expression then
	 statement
	 
	 else 
	  statement;
end case;	  


--Task: id si 0 olan Filmin turune gore cocuklar icin uygun olup olmadıgını ekrana yazınız

do $$
declare
 film_turu film.type%type;
 uyarı_mesajı varchar(50);

begin
   select type from film
   into film_turu
   where id=14;
   
   if found then
      
	  case film_turu 
	      when 'Korku' then
		      uyarı_mesajı:='Cocuklar icin uygun degil';
 		  when 'Macera' then
		      uyarı_mesajı:='Cocuklar icin uygun';
		  when 'Animasyon' then
		      uyarı_mesajı:='Cocuklar icin uygun'; 
		  when 'Aksiyon' then
		      uyarı_mesajı:='Cocuklar icin uygun degil';  		  
    else 
	    uyarı_mesajı:= 'Tanımlamadı';
	end case;	
	raise notice '%', uyarı_mesajı;
	end if;
	
	if not found then
	raise notice 'Gecersiz film id';
	end if;
	
end $$;


-- *********** LOOP ***********************************

-- tekrarlı data islenmesini istedigimizde loop kullanılır

<<label>>
loop 

statement -- bu sekilde yazarsak infinite/sonsuz loop riski vardır.

end loop;

-- loop u sonlandırmak icin loop un icine if yapisini kullanabiliriz

loop

  if condition then
  statement
  
  end if;
 exit; -- loop dan cıkmayı saglayan keyword
 
end loop; 

-- ic ice yapılar/ nested loop

<<outer>>
loop

<<inner>>
loop
 statement
end <<inner>> loop;

end <<outer>> loop;


-- Fibonacci Sayıları: 0 dan baslandıgı dusunulur. Kendisinden bir sonraki gelen rakam ile toplama degeri toplanır.
-- 0+1 =1
-- 1+2 =3
-- 2+3 =5
-- 3 + 5= 8
-- 5+ 8 =13

-- Task: n sayıda integer icin Fibonacci sayılarını ekrana yazdırınız
--burada toplama baslangıc degeri olarak 1 icin bir degisken
--ve toplanan sayının bir fazlası icin toplama degeri icin bir degisken
--ve her iki sayının toplmını alan bir degisken gerekli

--1 den baslar ve kendisinden sonra gelen sayı ile toplanmaya devam eder ama toplama sounucu ile 2.toplama isleminden sonra baslar

DO $$
DECLARE

	n integer :=-8;
	counter integer :=0;
	ilkdeger integer :=0;
	sonrakideger integer :=1;
	fib integer :=0;

BEGIN	
	
	LOOP
		EXIT WHEN counter=n OR n<0;
		counter := counter+1;
		SELECT sonrakideger, ilkdeger + sonrakideger
		INTO ilkdeger, sonrakideger;
		fib :=ilkdeger;
		RAISE NOTICE '%', fib;
	END LOOP;


END $$;

-- ********** For Loop ******************************

--syntax: 
[<<label>>]

for loop_counter in [reverse] from ...to[ by step] loop

		statement

end loop<<label>>;

-- Ornek: (in) 1 den 5 e kadar ekrana yazdırınız

do $$
begin

for counter in 1..5 loop

raise notice 'counter: %',counter;

end loop;
end $$;

--Ornek: (in) ve by ile for loop kullanımı
do $$
begin

for counter in 0..1000  by 5 loop

raise notice 'counter: %',counter;

end loop;
end $$;

--Ornek: (reverse)--ters

do $$
begin
for harf in reverse 90..65 loop

raise notice '%', chr(harf);
end loop;

end $$;

--DB den data alırken loop kullanımı

for target in query loop
statement
end loop;

--Task: Filmleri süresine gore sıraladıgımızda en uzun 2 filmi gosterelim

do $$
declare
      film_length record;

begin
      for film_length in 
	          
		   select title, length
		   from film
		   order by length desc
		   limit 2
	  loop 
	  
	  raise notice '% (% dakika)', film_length.title, film_length.length;
end loop;	  

end $$;
