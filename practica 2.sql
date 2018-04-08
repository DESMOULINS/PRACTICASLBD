-- agregamos los campos de las relaciones en las bd
use puntoventa
-- Tabla de contactos
create table contactos(
	id_cont int IDENTITY(1,2) PRIMARY KEY,
	id_relcontper int,
	tel_cont varchar(20),
	calle_cont varchar(35),
	num_cont int,
	codpost_cont int,
	correo_cont varchar(40)
)

-- TABLA DE PERSONAS
create table personas(
	id_per int IDENTITY(2,2) PRIMARY KEY,
	nom_per varchar(20),
	apelpat_per varchar(20),
	apelmat_per varchar(20),
	nomcom_per as (nom_per+apelpat_per+apelmat_per),
	fechanac_per date,
	edad_per AS DATEDIFF(YEAR,fechanac_per,GETDATE())
)

-- TABLA DE EMPLEADOS
	create table empleados(
		id_em int PRIMARY KEY,
		usuario_em varchar(12) NOT NULL,
		password_em varchar(12) NOT NULL,
		salario_em int,
	)

-- TABLA DE PROVEEDORES
	create table proveedores(
		id_prov int PRIMARY KEY,
		nom_prov varchar(20) NOT NULL,
		rfc_prov varchar(20)
	)

-- Tabla de clientes
	create table clientes(
		id_cli int PRIMARY KEY,
		rfc_cli varchar(20)
	)

-- //// Declaramos los indices

CREATE INDEX idx_rfc
ON clientes (rfc_cli); 
CREATE INDEX idx_us
ON empleados (usuario_em); 
CREATE INDEX idx_nomprov
ON proveedores (nom_prov); 