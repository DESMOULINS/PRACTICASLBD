-- ///////////////// VISTA DE RELACION-PERSONAS CON CONTACTOS o PERSONAS FALTANTES DE CAPTURAR //////////////////////////////
create view report_PerContEmPrCl as
select id_cont,id_relcontper,correo_cont,id_per,nomcom_per,id_em,id_per,id_prov
from personas 
inner join contactos on personas.id_per = contactos.id_relcontper
inner join clientes on personas.id_per = clientes.id_cli
inner join proveedores on personas.id_per = proveedores.id_prov
inner join empleados on personas.id_per = empleados.id_em;

--///////////// VISTA DE RELACION-PERSONAS-EMPLEADOS CON CONTACTOS o PERSONAS O EMPLEADO CAPTURADOS ////////////////////////
create view report_contperemp as
select id_cont,id_relcontper,id_per,nomcom_per,id_em,usuario_em
from personas 
inner join contactos on personas.id_per = contactos.id_relcontper
inner join empleados on personas.id_per = empleados.id_em;

--///////////// VISTA DE RELACION-PERSONAS-PROVEEDORES CON CONTACTOS o PERSONAS O PROVEEDORES CAPTURADOS ////////////////////////
create view report_contperprov as
select id_cont,id_relcontper,id_per,nomcom_per,id_prov,nom_prov
from personas 
inner join contactos on personas.id_per = contactos.id_relcontper
inner join proveedores on personas.id_per = proveedores.id_prov;

--///////////// VISTA DE RELACION-PERSONAS-PROVEEDORES CON CONTACTOS o PERSONAS O PROVEEDORES CAPTURADOS ////////////////////////
create view report_contpercli as
select id_cont,id_relcontper,id_per,nomcom_per,id_cli,rfc_cli
from personas 
inner join contactos on personas.id_per = contactos.id_relcontper
inner join clientes on personas.id_per = clientes.id_cli;

-- ///////////////// VISTA DE RELACION-PERSONAS CON CONTACTOS o PERSONAS FALTANTES DE CAPTURAR //////////////////////////////
create view report_PerContEmPrCl as
select id_cont,id_relcontper,correo_cont,id_em,id_prov
from contactos
inner join clientes on contactos.id_relcontper = clientes.id_cli
inner join proveedores on contactos.id_relcontper = proveedores.id_prov
inner join empleados on contactos.id_relcontper = empleados.id_em;