-- ******************* WHILE LOOP ***************
-- syntax:

[<<label>>]

while condition loop

statements;

end loop;

--Task: 0 dan 4 e kadara counter degerlerini ekrana yazdırınız.

do $$
declare
 counter integer:=0;

begin 
    
	while counter<5 loop
	
	raise notice 'Counter: %', counter;
	counter=counter+1;
 
   end loop;
   
end $$;

-- ********************* EXIT KEYWORD *************************
-- loop dan belli bir kosul true oldugunda loop dan cıkılmasını saglar. Java daki "break" keyword gibi
--syntax;
--1.syntax:
exit when counter>10;  --best practice cunku az kelime cok fonksiyon yaptırabiliriz.

--2.syntax:
if counter>10 then
   exit;
   
end if; 

-- Ornek:

do $$

begin
    <<inner_block>>
	begin
	    exit inner_block;  --ilk basta exit keyword baslatılacak ve inner block taki kodlar okunmayacak
		raise notice 'inner block calisti';
		
	end ;
	
	raise notice 'outer block calisti';

end $$;


-- *************** CONTINUE (DEVAM ET/BEKLEME YAPMA) *******************
--verilen kod satırından atlanılmasını istedigimiz kısımları belirtmek icin 

--0 dan 10 a kadar cift sayıları atlayarak tek sayıları yazdırınız.

do $$

declare

counter integer:=0;

begin
	 loop
	 counter:=counter+1;
	 
	 continue when mod(counter, 2)=0;
	 exit when counter>10; 
	 raise notice 'Tek Sayılar: %', counter;

   end loop;

end $$;

-- ************** FOR LOOP *********************

--Task: Update all rows where the expense amount is above 5000 per month and reqiure a message for the client to receive a message to pass on
-- to a premium membership in a bank application. 

CREATE TABLE bank(

  client_id integer Primary Key,	
  client_name varchar(50),
  monthly_expense integer,
  mes_req varchar(80),
  membership varchar(20)	

);


INSERT INTO bank VALUES(456456456, 'Tom Hanks', 6000);
INSERT INTO bank VALUES(456456457, 'Brad Pitt', 3000);
INSERT INTO bank VALUES(456456458, 'Hug Grant', 2000);
INSERT INTO bank VALUES(456456459, 'Tom Junior', 45000);
INSERT INTO bank VALUES(456456453, 'John Walker', 2500);

SELECT * FROM bank;


-- Task: Bir banka uygulamasında; aylık "Monthly Expense" u 5000 uzerinde olan musteriler icin membership field bilgisini 
--"Premium Membership" olarak guncelleyiniz
--ve mes_req (gerekli mesaj)field ini "Premium Membership mesaj gondermek gerekli" olarak guncelleyiniz ve bu guncelleme islenmis olan musterielrin isimlerini
--ve aylık harcamalarını ekrana yazdırınız.

do $$
declare

client bank%rowtype;
message_required varchar(50):='Premium Membership mesaj gondermek gerekli';
membership_value varchar(50):='Premium Membership';

begin
     update bank 
	 set mes_req=message_required,
	     membership= membership_value	     
	 where monthly_expense>2000;	 
    
	for client in
	           select client_id, client_name, monthly_expense
			   from bank
			   where mes_req=message_required AND membership=membership_value
    loop
	
	raise notice 'Client details: %, %, %', client.client_id, client.client_name, client.monthly_expense;
	
	end loop;

end $$;


-- Actor tablosundan gelen first_name ve last_name degerlerini birarada olacak sekilde ekrana yazdırınız.

do $$
declare 
      full_name record;

begin
     for full_name in
	 select first_name || ' '|| last_name 
	
	 from actor 
	
	 loop
	 raise notice 'Actor name: %', full_name;
	 end loop;
	 
end $$;

 /*If the gender is "Male" and the age is less than 13 print "Boy" otherwise print "Man".
        If the gender is "Female" and the age is less than 13 print "Girl" otherwise print "Woman".
        If the gender is different from "Male" and "Female" print "No information".
        If you put another statement into an if statement you need to use 'nested if'
        //to prevent any difference cause any problem with the enterance of the data
         */
​
/*Cinsiyet "Erkek" ise ve yaş 13'ten küçükse "Erkek Cocuk" yazdır, aksi takdirde "Erkek" yazdır.
        Cinsiyet "Kadın" ise ve yaş 13'ten küçükse "Kız Cocuk" yazın, aksi halde "Kadın" yazın.
        Cinsiyet "Erkek" ve "Kadın"dan farklıysa "Bilgi yok" yazdırın.
        Bir if ifadesinin içine başka bir ifade koyarsanız 'iç içe if' kullanmanız gerekir.
        //veri girişinde herhangi bir farklılık oluşmasını önlemek için
*/
		 
do $$
declare
gender_input varchar(20)='Masa';
gender_result varchar(20);
user_age integer=13;
		 
begin
		if(gender_input='Erkek' AND user_age<=13) then
		   gender_result:='Erkek Cocuk';

        else if (gender_input='Erkek' AND user_age>13) then
		   gender_result='Erkek';
		elseif (gender_input='Kadın' AND user_age<=13) then  
            gender_result='Kız cocuk';
		elseif (gender_input='Kadın' AND user_age>13) then  
            gender_result='Kadın';
        else
		   gender_result='Bilgi yok';
		  
		end if;
		
		end if;
		
raise notice '%', gender_result;		

end $$;
		 	  