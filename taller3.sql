
--creacion de tablas
create table alumnos (
rut varchar2(10) not null,
nombres varchar2(20) not null,
apaterno varchar2(20) not null,
amaterno varchar2(20) not null);
--creacion de pks
alter table alumnos add constraint pk_ruta primary key (rut);

create table notas(
codigot number not null,
nota number not null,
rut varchar(10) null,
codigo number null);

alter table notas add constraint pk_cn primary key (codigot);

create table ramos (
codigo number not null,
descripcion varchar2(30) not null);

alter table ramos add constraint pk_codi primary key (codigo);


--creacion de fks
alter table notas add constraint fk_cod foreign key (codigo) references ramos (codigo);
alter table notas add constraint fk_rut foreign key (rut) references alumnos (rut);

--creacion de procesos almacenados
create or replace procedure ingresoalumno (rut1 varchar2,nombres varchar2,apaterno varchar2,amaterno varchar2)
as
conrut number;
begin
select count (rut) into conrut from alumnos where rut1=rut; 
if conrut = 0 then
insert into alumnos values(rut1,nombres,apaterno,amaterno);
commit;
end if;
end;


create or replace procedure ingresoramos (codigor number,descripcion varchar2)
as
conr number;
begin
select count (codigo) into conr from ramos where codigor=codigo; 
if conr = 0 then
insert into ramos values(codigor,descripcion);
commit;
end if;
end;


create or replace procedure ingresonota (codigot1 number,nota2 number,rut2 varchar2,codigo2 number)
as
sumrut number;
sumcodigot number;
sumcodi number;
begin
select count (codigot) into sumcodi from  notas where codigot1=codigot;
select count (codigo)into sumcodigot from ramos where codigo2=codigo;
select count (rut) into sumrut from alumnos where rut2=rut;
if sumrut = 1 and sumcodigot = 1 and sumcodi= 0 then
insert into notas values (codigot1,nota2,rut2,codigo2);
commit;
end if;
end;


--ejecucion de procedimientos
execute ingresoramos (1,'modelamiento base de datos');
execute ingresoramos (2,'matematica aplicada');
execute ingresoramos (3,'lenguaje');
execute ingresoalumno ('188404821','felipe sempaii','bravo','arriola');
execute ingresoalumno ('193735423','jose ivan','cancino','valdes');
execute ingresoalumno ('194746652','luis esteban','cespedes','sepulveda');
execute ingresoalumno ('386523726','daniela fernanda','diaz','gonzales');
execute ingresonota (1,5,'194746652',1);
execute ingresonota (2,5,'188404821',1);
execute ingresonota (5,4,'194746652',1);
execute ingresonota (3,6,'188404821',2);
execute ingresonota (4,4,'386523726',3);
select * from notas;
commit;


-- creacion de vistas
create view muestratodo as
select a.rut,a.nombres,a.apaterno,a.amaterno,n.codigot,n.nota,r.codigo,r.descripcion
from alumnos a,notas n,ramos r;

select * from muestratodo;

create view cantnotaram1 as
select count (*) as notas from  notas where codigo=1
;

create or replace view cantnotaram2 as
select count (*) notas from  notas where codigo=2
;

create or replace view cantnotaram3 as
select count (*) notas from  notas where codigo=3
;

create view promedioramo1 as
select avg (nota)as notas from notas where codigo=1; 

create view promedioramo2 as
select avg (nota)as notas from notas where codigo=2; 

create view promedioramo3 as
select avg (nota)as notas from notas where codigo=3; 

select a.nombres,a.apaterno,n.nota from alumnos a, notas n where a.rut='194746652';

purge recyclebin;

--esas son todo el sql que puse hacer por mi cuenta sin pedir codigo a nadie
