-- /////////////////////////////////// SELECT INNER WITH /////////////////////////////////////////////
use puntoventa;
with percont as(
select contactos.id_relcontper as id_persona, contactos.tel_cont, contactos.correo_cont, personas.nomcom_per, personas.edad_per 
from contactos
inner join personas on contactos.id_relcontper = personas.id_per
)
select top 4 * from percont;

-- /////////////////////////////////// SELECT RIGHT /////////////////////////////////////////////
use puntoventa
select contactos.id_relcontper  as id_persona, contactos.calle_cont,contactos.codpost_cont,contactos.num_cont, personas.nomcom_per, personas.edad_per 
from contactos
right join personas on contactos.id_relcontper = personas.id_per;

-- /////////////////////////////////// SELECT LEFT /////////////////////////////////////////////
use puntoventa
select personas.id_per,contactos.calle_cont,contactos.codpost_cont,contactos.num_cont,personas.nomcom_per,personas.edad_per,empleados.usuario_em,empleados.salario_em
from personas
left join contactos on contactos.id_relcontper = personas.id_per
left join empleados on empleados.id_em = personas.id_per;

-- ////////////////////////////// SELECT FULL INTO WITH SUBCONSULTA ////////////////////////////////////
use puntoventa;
with infocompleta as(
select personas.id_per,contactos.calle_cont,contactos.codpost_cont,contactos.num_cont,personas.nomcom_per,personas.edad_per,empleados.usuario_em,empleados.salario_em, clientes.rfc_cli, proveedores.rfc_prov
from personas 
full join contactos on contactos.id_relcontper = personas.id_per
full join empleados on empleados.id_em = personas.id_per
full join clientes on clientes.id_cli = personas.id_per
full join proveedores on proveedores.id_prov = personas.id_per
WHERE empleados.salario_em > (select avg(salario_em) from empleados)
)
select * into personal from infocompleta;

-- /////////////////////////////////// UNION SUBCONSULTA /////////////////////////////////////////////
use puntoventa;
WITH empleado AS (SELECT * FROM empleados)
SELECT * FROM empleado WHERE empleado.salario_em < 5000
UNION ALL
SELECT * FROM empleado WHERE empleado.usuario_em like 'R%'

-- /////////////////////////////////////// CROSS JOIN ///////////////////////////////////////////////
use puntoventa;
select personas.id_per,personas.nomcom_per,personas.edad_per,empleados.usuario_em,empleados.salario_em
from personas 
CROSS join empleados
WHERE empleados.salario_em > (select avg(salario_em) from empleados)

-- /////////////////////////////////////// INNER y FULL JOIN ///////////////////////////////////////////////
use puntoventa;
select personas.id_per,contactos.calle_cont,contactos.codpost_cont,contactos.num_cont,personas.nomcom_per,personas.edad_per, proveedores.rfc_prov
from personas 
inner join contactos on contactos.id_relcontper = personas.id_per
full join proveedores on proveedores.id_prov = personas.id_per

-- /////////////////////////////////////// INNER y FULL JOIN ///////////////////////////////////////////////
use puntoventa;
select personas.id_per,contactos.calle_cont,contactos.codpost_cont,contactos.num_cont,personas.nomcom_per,personas.edad_per, clientes.rfc_cli
from personas 
full join contactos on contactos.id_relcontper = personas.id_per
inner join clientes on clientes.id_cli = personas.id_per

-- /////////////////////////////////////// left y right JOIN ///////////////////////////////////////////////
use puntoventa;
select personas.id_per,contactos.calle_cont,contactos.codpost_cont,contactos.num_cont,personas.nomcom_per,personas.edad_per,empleados.usuario_em,empleados.salario_em
from personas 
left join contactos on contactos.id_relcontper = personas.id_per
right join empleados on empleados.id_em = personas.id_per

-- /////////////////////////////////////// FULL JOIN ///////////////////////////////////////////////

use puntoventa;
select contactos.calle_cont,contactos.codpost_cont,contactos.num_cont,empleados.usuario_em,empleados.salario_em
from empleados
full join contactos on contactos.id_relcontper = empleados.id_em