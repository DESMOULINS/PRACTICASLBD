-- ///////////////// PROCEDURE DE RELACION-PERSONAS CON CONTACTOS o PERSONAS FALTANTES DE CAPTURAR //////////////////////////////
use puntoventa
go
Create PROCEDURE pers_all
	@id_per int
 as
select id_cont,id_relcontper,correo_cont,id_per,nomcom_per,id_em,id_per,id_prov
from personas 
inner join contactos on personas.id_per = contactos.id_relcontper
inner join clientes on personas.id_per = clientes.id_cli
inner join proveedores on personas.id_per = proveedores.id_prov
inner join empleados on personas.id_per = empleados.id_em
WHERE id_per = @id_per;

EXEC pers_all @id_per = 13;
GO

--///////////// VISTA DE RELACION-PERSONAS-EMPLEADOS CON CONTACTOS o PERSONAS O EMPLEADO CAPTURADOS ////////////////////////
use puntoventa
go
Create PROCEDURE pers_emp
	@id_per int
 as
select id_cont,id_relcontper,nomcom_per,usuario_em
from personas 
inner join contactos on personas.id_per = contactos.id_relcontper
inner join empleados on personas.id_per = empleados.id_em
where id_per = @id_per;

EXEC pers_emp @id_per = 13;
GO

--///////////// VISTA DE RELACION-PERSONAS-PROVEEDORES CON CONTACTOS o PERSONAS O PROVEEDORES CAPTURADOS ////////////////////////
use puntoventa
go
Create PROCEDURE pers_prov
	@id_per int
 as
select id_cont,id_relcontper,correo_cont,nomcom_per,nom_prov
from personas 
inner join contactos on personas.id_per = contactos.id_relcontper
inner join proveedores on personas.id_per = proveedores.id_prov
where id_per = @id_per;

EXEC pers_prov @id_per = 13;
GO

--///////////// VISTA DE RELACION-PERSONAS-CLIENTES CON CONTACTOS o PERSONAS O CLIENTES CAPTURADOS ////////////////////////
use puntoventa
go
Create PROCEDURE pers_cli
	@id_per int
 as
select id_cont,id_relcontper,nomcom_per,rfc_cli
from personas 
inner join contactos on personas.id_per = contactos.id_relcontper
inner join clientes on personas.id_per = clientes.id_cli
where id_per = @id_per;

EXEC pers_cli @id_per = 13;
GO

-- ///////////////// VISTA DE RELACION-CONTACTOS CON TABLAS CON DATOS FALTANTES DE CAPTURAR //////////////////////////////
use puntoventa
go
Create PROCEDURE con_all
	@id_per int
 as
select id_cont,id_relcontper,correo_cont,usuario_em,rfc_prov
from contactos
left join clientes on contactos.id_relcontper = clientes.id_cli
left join proveedores on contactos.id_relcontper = proveedores.id_prov
left join empleados on contactos.id_relcontper = empleados.id_em
where id_con = @id_con;

EXEC con_all @id_con = 13;
GO

-- ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- ////////////////////////////////////////////// TRIGGERS ///////////////////////////////////////////////////////////////
-- ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

-- /////////////////////////////// CREAMOS UNA TABLA QUE GUARDARA LOS CAMBIOS ////////////////////////////////////////////
create table historial(
id_his int IDENTITY(1,1) primary key,
fechcamb_his datetime
)

-- /////////////////////////////// TRIGGER QUE INSERTA LA FECHA DEL CAMBIO ///////////////////////////////////////////////
CREATE TRIGGER historial_camb
ON personas
 AFTER INSERT ON personas
	FOR EACH ROW
 BEGIN
	insert into historial (fechcamb_his) values (getdate())
 END

-- //////////////////////// SI QUISIERAMOS QUE EL TRIGGER EVITE QUE EJECUTE LA ACCION USAMOS /////////////////////////////

create trigger historial_camb2
  on contactos
  instead of insert
  as
    insert into historial (fechcamb_his) values (getdate());

-- ///////////////////////////////// NO PERMITIR BORRAR TABLAS //////////////////////////////////////////////
CREATE TRIGGER nodroptable
       ON DATABASE FOR DROP_TABLE
       AS
       BEGIN
         RAISERROR ('NO PUEDES BORRAR CUALQUIER TABLAS' , 16, 1)
         ROLLBACK TRANSACTION
       END

-- ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- ////////////////////////////////////////////// FUNCIONES //////////////////////////////////////////////////////////////
-- ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

create function crear_user
 (@nombre varchar(20),
  @apelmat varchar(20),
  @apelpat varchar(20)
 )
 returns varchar(60)
 as
 begin 
   declare @resultado varchar(60)
   set @resultado = ( LTRIM(@nombre varchar(20)) + LTRIM(@apelmat varchar(20)) + LTRIM(@apelpat varchar(20) )
 )
   return @resultado
 end;

 select dbo.crear_user('Everardo','Molina','Saceuda');

 -- //////////////////////////////////////////// FUNCION DE CALCULAR RFC /////////////////////////////////////////////

 create function crear_rfc
 (@nombre varchar(20),
  @apelmat varchar(20),
  @apelpat varchar(20),
  @fecha time
 )
 returns varchar
 as
 begin 
   declare @resultado varchar(60)
   --DECLARE @fechanac VARCHAR(30) = CONVERT(VARCHAR(30),@fecha,112);
   set @resultado = ( LTRIM(@nombre varchar(20)) + LTRIM(@apelmat varchar(20)) + LTRIM(@apelpat varchar(20)) + @fechanac)
 )
   return @resultado
 end;

  select dbo.crear_rfc('Everardo','Molina','Saceuda','08/04/2018');