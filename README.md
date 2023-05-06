
1.
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
2.
insert into CARTI values(1,'Povesti','Ion Creanga','Teora','200','12-MAR-2004',10);
select * from CARTI;
insert into CARTI values(2,'Basme','Petre Ispirescu','Teora','100','02-JAN-1990',9.99);
select * from CARTI;
insert into CARTI values(1,'Poezii','Mihai Eminescu','Caro','50','23-DEC-2003',5);
select * from CARTI;

3.
insert into CARTI values(4,'Mara','Ion Slavici','Mirton',NULL,'02-MAR-2001',11.50);
select * from CARTI;
insert into CARTI values(5,'Ion','Liviu Rebreanu',NULL,'300','04-JUL-1994',NULL);
select * from CARTI;
insert into CARTI values(6,'Poezii','Ion Barbu','BPT','250',NULL,55.02);
select * from CARTI;
4.
update CARTI set NR='3' where Autor='Mihai Eminescu';
select * from CARTI;
5.
update CARTI set PRET=PRET+0.1*PRET;
select * from CARTI;
6.
select distinct EDITURA from Carti where EDITURA IS NOT NULL;
7.
ALTER TABLE CARTI ADD CATEGORIA VARCHAR(30);

UPDATE CARTI SET CATEGORIA = 'beletristica';
8.

ALTER TABLE CARTI
ALTER COLUMN NR INT NOT NULL;

ALTER TABLE CARTI ADD CONSTRAINT c_nr PRIMARY KEY (NR);
insert into CARTI values(4,'HTML','John Doe','Mirton',NULL,'02-MAR-2005',20,'Tehnica');
insert into CARTI values(NULL,'HTML','John Doe','Mirton',NULL,'02-MAR-2005',20,'tehnica');
9.
insert into CARTI values(7,'HTML','John Doe','Mirton',NULL,'02-MAR-2005',20,'tehnica');
insert into CARTI values(8,'Roboti','Isac Asimov','Nemira',NULL,'23-JUL-1998',5,'SF');
 
10.
select * from CARTI 
where DATAP <='01-JAN-2000';
 
11.
SELECT TITLU, AUTOR
FROM CARTI
WHERE YEAR(DATAP) > 1995 AND CATEGORIA = 'beletristica';
 
12.
SELECT TITLU, AUTOR
FROM CARTI
WHERE YEAR(DATAP) > 1995 AND CATEGORIA = 'beletristica'
order by TITLU;
 
SELECT TITLU, AUTOR
FROM CARTI
WHERE YEAR(DATAP) < 1995 AND CATEGORIA = 'beletristica'
ORDER BY Titlu;
 
13.
SELECT EDITURA, MIN(PRET) AS minim, MAX(PRET) AS maxim, AVG(PRET) AS mediu 
FROM CARTI 
WHERE EDITURA IS NOT NULL 
GROUP BY EDITURA;
 

14.
SELECT CATEGORIA,
       MIN(DATEDIFF(day, DATAP, GETDATE())) AS minim,
       MAX(DATEDIFF(day, DATAP, GETDATE())) AS maxim,
       AVG(DATEDIFF(day, DATAP, GETDATE())) AS mediu,
       COUNT(*) AS exemplare
FROM CARTI
GROUP BY CATEGORIA;
 

15.
SELECT CATEGORIA, 
	MIN(DATEDIFF(year, DATAP, GETDATE())) AS minim, 
	MAX(DATEDIFF(year, DATAP, GETDATE())) AS maxim,
    AVG(DATEDIFF(year, DATAP, GETDATE())) AS mediu, 
	COUNT(CATEGORIA) AS exemplare
FROM CARTI
GROUP BY CATEGORIA
ORDER BY CATEGORIA;
 
16.
SELECT CATEGORIA, 
       MIN(DATEDIFF(YEAR, DATAP, GETDATE())) AS minim, 
       MAX(DATEDIFF(YEAR, DATAP, GETDATE())) AS maxim, 
       AVG(DATEDIFF(YEAR, DATAP, GETDATE())) AS mediu, 
       COUNT(CATEGORIA) AS exemplare 
FROM CARTI  
WHERE DATAP IS NOT NULL 
GROUP BY CATEGORIA 
ORDER BY CATEGORIA;

17.
DECLARE @first_date DATE;
DECLARE @last_date DATE;
DECLARE @v_titlu VARCHAR(20);
DECLARE @v_autor VARCHAR(20);


SET @first_date = '01-01-1900' -- Replace with desired value
SET @last_date = '12-31-2005' -- Replace with desired value

SELECT TITLU, AUTOR
FROM CARTI
WHERE DATAP BETWEEN CONVERT(DATETIME, @first_date, 105) AND CONVERT(DATETIME, @last_date, 105)

DECLARE c1 CURSOR FOR
SELECT TITLU, AUTOR FROM CARTI WHERE DATAP > @first_date AND DATAP < @last_date;

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
 
