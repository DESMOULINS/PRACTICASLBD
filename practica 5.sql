-- ///////////////////////////////////// con where  ///////////////////////////////////////

select id_cont, calle_cont from contactos
where id_cont = 11 ;

select id_cli,rfc_cli from clientes
where id_cli = 12;

select id_em, salario_em from empleados
where id_em = 12;

select id_per, nomcom_per, edad_per from personas 
where nom_per = 'Romo';

select id_prov, nom_prov from proveedores
where id_prov = 12;

-- ///////////////////////////////////// con group by  ///////////////////////////////////////

select id_cont, calle_cont from contactos
group by id_cont ;

select id_cli,rfc_cli from clientes
group by id_cli;

select id_em, salario_em from empleados
group by id_em;

select id_per, nomcom_per, edad_per from personas 
group by nom_per;

select id_prov, nom_prov from proveedores
group by id_prov;

-- ///////////////////////////////////// con funciones  ///////////////////////////////////////
use puntoventa

select count(id_cont) cantidad_contactos from contactos;

select sum(salario_em) as salario_suma from empleados;

select avg(salario_em) as salario_prom from empleados;

select MAX(edad_per) AS edad_maxima from personas;

select var(salario_em) as varianza_salario from empleados;

-- ///////////////////////////////////// con having ////////////////////////////////////////////
use puntoventa

select id_cont from contactos
group by id_cont 
having id_cont > 10;

select id_cli from clientes
group by id_cli
having id_cli > 14;

select id_em from empleados
group by id_em
having id_em > 14;

select id_per from personas 
group by id_per
having id_per > 14;

select id_prov from proveedores
group by id_prov
having id_prov > 14;

-- ///////////////////////////////////// con TOP /////////////////////////////////////////////////
use puntoventa
select top 3 id_cont, calle_cont from contactos;

select top 4 id_cli,rfc_cli from clientes;

select top 2 id_em, salario_em from empleados;

select top 5 id_per, nomcom_per, edad_per from personas;

select top 4 id_prov, nom_prov from proveedores;