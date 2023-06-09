

----1
create table carti
(
nr INTEGER CHECK (nr >= 0 AND  nr <= 9999),
titlu VARCHAR(20),
autor VARCHAR(20),
editura VARCHAR(20),
pagini INT,
datap DATE,
pret DECIMAL(5,2)  CHECK (pret <= 999.99),
);
--2
insert into CARTI values(1,'Povesti','Ion Creanga','Teora','200','12-MAR-2004',10);
select * from CARTI;
insert into CARTI values(2,'Basme','Petre Ispirescu','Teora','100','02-JAN-1990',9.99);
select * from CARTI;
insert into CARTI values(1,'Poezii','Mihai Eminescu','Caro','50','23-DEC-2003',5);
select * from CARTI;
----3
insert into CARTI values(4,'Mara','Ion Slavici','Mirton',NULL,'02-MAR-2001',11.50);
select * from CARTI;
insert into CARTI values(5,'Ion','Liviu Rebreanu',NULL,'300','04-JUL-1994',NULL);
select * from CARTI;
insert into CARTI values(6,'Poezii','Ion Barbu','BPT','250',NULL,55.02);
select * from CARTI;
----4
update CARTI set NR='3' where Autor='Mihai Eminescu';
select * from CARTI;
----5
update CARTI set PRET=PRET+0.1*PRET;
select * from CARTI;
----6
select distinct EDITURA from Carti where EDITURA IS NOT NULL;
----7
ALTER TABLE CARTI ADD CATEGORIA VARCHAR(30);

UPDATE CARTI SET CATEGORIA = 'beletristica';

----8 Adauga constrangeri coloanei nr de tip PRIMARY KEY

ALTER TABLE CARTI
ALTER COLUMN NR INT NOT NULL;

ALTER TABLE CARTI ADD CONSTRAINT c_nr PRIMARY KEY (NR);

insert into CARTI values(4,'HTML','John Doe','Mirton',NULL,'02-MAR-2005',20,'Tehnica');
insert into CARTI values(NULL,'HTML','John Doe','Mirton',NULL,'02-MAR-2005',20,'tehnica');


----9
insert into CARTI values(7,'HTML','John Doe','Mirton',NULL,'02-MAR-2005',20,'tehnica');
insert into CARTI values(8,'Roboti','Isac Asimov','Nemira',NULL,'23-JUL-1998',5,'SF');

----10
select * from CARTI 
where DATAP <='01-JAN-2000';


--11
select TITLU,AUTOR from CARTI 
where DATAP >='31-DEC-1995' AND CATEGORIA='beletristica';

--SELECT TITLU, AUTOR
select TITLU,AUTOR FROM CARTI
WHERE YEAR(DATAP ) > 1995 AND CATEGORIA = 'beletristica';

----12
select TITLU,AUTOR from CARTI where DATAP >='31-DEC-1995' AND CATEGORIA='beletristica' order by TITLU;

SELECT TITLU, AUTOR
FROM CARTI
WHERE YEAR(DATAP) < 1995 AND CATEGORIA = 'beletristica'
ORDER BY Titlu;

----13
SELECT EDITURA, MIN(PRET) AS minim, MAX(PRET) AS maxim, AVG(PRET) AS mediu 
FROM CARTI 
WHERE EDITURA IS NOT NULL 
GROUP BY EDITURA;


----14
SELECT CATEGORIA,
       MIN(DATEDIFF(day, DATAP, GETDATE())) AS minim,
       MAX(DATEDIFF(day, DATAP, GETDATE())) AS maxim,
       AVG(DATEDIFF(day, DATAP, GETDATE())) AS mediu,
       COUNT(*) AS exemplare
FROM CARTI
GROUP BY CATEGORIA;


----15
SELECT CATEGORIA, 
	MIN(DATEDIFF(year, DATAP, GETDATE())) AS minim, 
	MAX(DATEDIFF(year, DATAP, GETDATE())) AS maxim,
    AVG(DATEDIFF(year, DATAP, GETDATE())) AS mediu, 
	COUNT(CATEGORIA) AS exemplare
FROM CARTI
GROUP BY CATEGORIA
ORDER BY CATEGORIA;


----16
SELECT CATEGORIA, 
       MIN(DATEDIFF(YEAR, DATAP, GETDATE())) AS minim, 
       MAX(DATEDIFF(YEAR, DATAP, GETDATE())) AS maxim, 
       AVG(DATEDIFF(YEAR, DATAP, GETDATE())) AS mediu, 
       COUNT(CATEGORIA) AS exemplare 
FROM CARTI 
WHERE DATAP IS NOT NULL 
GROUP BY CATEGORIA 
ORDER BY CATEGORIA;


----17
--set serveroutput on
--accept first_date prompt 'Introduceti valoarea pentru first_date:';
--accept last_date prompt 'Introduceti valoarea pentru last_date:';

--declare
--v_titlu VARCHAR2(20);
--v_autor VARCHAR2(20);
--cursor c1 is 
--	select TITLU,AUTOR from CARTI 
--	where DATAP>to_date('&first_date','DD-MM-YYYY') AND DATAP<to_date('&last_date','DD-MM-YYYY');
--begin
--dbms_output.put_line('TITLU' || ' ' || 'AUTOR');
--open c1;
--loop
--fetch c1 into v_titlu,v_autor;
--exit when c1%NOTFOUND;
--dbms_output.put_line(v_titlu || ' ' || v_autor);
--end loop;
--end;
/



DECLARE @first_date DATE;
DECLARE @last_date DATE;
DECLARE @v_titlu VARCHAR(20);
DECLARE @v_autor VARCHAR(20);


SET @first_date = '01-01-1900' -- Replace with desired value
SET @last_date = '01-01-2005' -- Replace with desired value

SELECT TITLU, AUTOR
FROM CARTI
WHERE DATAP BETWEEN CONVERT(DATETIME, @first_date, 105) AND CONVERT(DATETIME, @last_date, 105)

DECLARE c1 CURSOR FOR
	SELECT TITLU, AUTOR 
	FROM CARTI
	WHERE DATAP > @first_date AND DATAP < @last_date;

PRINT 'TITLU' + ' ' + 'AUTOR';

OPEN c1;

FETCH NEXT FROM c1 INTO @v_titlu, @v_autor;

WHILE @@FETCH_STATUS = 0
BEGIN
    PRINT @v_titlu + ' ' + @v_autor;
    FETCH NEXT FROM c1 INTO @v_titlu, @v_autor;
END;

CLOSE c1;
DEALLOCATE c1;

----18
set serveroutput on
accept first_date prompt 'Introduceti valoarea pentru first_date:';
accept last_date prompt 'Introduceti valoarea pentru last_date:';

declare
v_titlu VARCHAR2(20);
v_autor VARCHAR2(20);

cursor c1 is 
	select TITLU,AUTOR from CARTI 
		where DATAP>to_date('&&first_date','DD-MM-YYYY') AND DATAP<to_date('&&last_date','DD-MM-YYYY');

begin
dbms_output.put_line('TITLU' || ' ' || 'AUTOR');
open c1;
loop
fetch c1 into v_titlu,v_autor;
exit when c1%NOTFOUND;
dbms_output.put_line(v_titlu || ' ' || v_autor);
end loop;
end;
/


----19
--define first_date;
--define last_date;
----variabilele se sterg din memorie doar dupa ce se inchide sesiunea

----20
--set serveroutput on
--accept t prompt 'Introduceti un titlu:';
--declare
--v_titlu VARCHAR2(20);
--v_autor VARCHAR2(20);
--cursor c1 is select  TITLU,AUTOR from CARTI where TITLU='&t';
--begin
--dbms_output.put_line('TITLU' || ' ' || 'AUTOR');
--open c1;
--loop
--fetch c1 into v_titlu,v_autor;
--exit when c1%NOTFOUND;
--dbms_output.put_line(v_titlu || ' ' || v_autor);
--end loop;
--end;
--/
----21
--declare
--fara_tva FLOAT;
--v_titlu VARCHAR2(20);
--cursor c1 is select TITLU, PRET/1.19 from CARTI where PRET/1.19>10;
--begin
--dbms_output.put_line('TITLU' || ' ' || 'PRET/1.19');
--open c1;
--loop
--fetch c1 into v_titlu,fara_tva;
--exit when c1%NOTFOUND;
--dbms_output.put_line(v_titlu || ' ' || fara_tva);
--end loop;
--end;
--/
----22
--create table beletristica
--(
--nr NUMBER(3),
--titlu VARCHAR2(20),
--autor VARCHAR2(20),
--editura VARCHAR2(20),
--pagini NUMBER(4),
--datap DATE,
--pret FLOAT
--);
----23
--insert INTO BELETRISTICA(NR,TITLU,AUTOR,EDITURA,PAGINI,DATAP,PRET) select NR,TITLU,AUTOR,EDITURA,PAGINI,DATAP,PRET from CARTI where GEN='beletristica';
--ALTER TABLE CARTI drop column GEN;
----24
--drop table CARTI;
--drop table BELETRISTICA;