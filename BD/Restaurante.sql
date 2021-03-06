/**
 *
 * DBMS           :  ORACLE
 * Base de Datos  :  RESTAURANTE
 * Descripci�n    :  
 * Script         :  Crea la esquema
 * Creado por     :  Prosoft
 * Email          :  yoshitomimaehara@gmail.com
 *
**/
-- ==========================================================
-- Inicio de Proceso
-- ==========================================================
SET TERMOUT ON
SET ECHO OFF
SET SERVEROUTPUT ON
BEGIN
	DBMS_OUTPUT.PUT_LINE('Inicio del proceso...');
END;
/
SET TERMOUT OFF

--================================
-- Creando el Esquema
--================================

-- Verificar Cuenta

declare
  n number(3);
begin
  select count(*) into n from dba_users where username = 'restaurante';
  if(n = 1) then
    execute immediate 'drop user restaurante cascade';
  end if;
  execute immediate 'create user restaurante identified by admin';  
end;
/

-- Asignar Privilegios
grant connect,resource to restaurante;

-- Conexi�n con la base de datos
connect restaurante/admin

--=====================================
-- Crear la Tabla de Productos:producto
--=====================================
create table producto(
codproducto char(4) not null,
descrproducto varchar2(100)not null,
preciounitario number(5,2) not null,
stock number(3,0) not null,
constraint pk_producto
	primary key (codproducto),
constraint u_descr_producto
	unique(descrproducto),
constraint chk_producto_codproducto
	check( REGEXP_LIKE(codproducto,'[PEB][IAONE][0-9][0-9]')),
constraint chk_producto_preciounitario
  check(preciounitario>0),
constraint chk_producto_stock
	check(stock>=0)		
);

--===================================
-- Crear la Tabla de Clientes:cliente
--===================================
create table cliente(
dni char(8) not null,
nomcliente varchar2(100) not null,
Direccioncliente varchar2(100) not null,
constraint pk_cliente
	primary key(dni),
constraint u_nomcliente
	unique(nomcliente)
);


--===================================
-- Crear la Tabla de Pedidos:pedido
--===================================
create table pedido(
nropedido char(7) not null,
dni char(8) not null,
fecha date not null,
subtotalpedido number(5,2) not null,
igv    number(5,2) not null,
servicio number(5,2) not null,
totalpedido  number(5,2) not null,
constraint pk_pedido
	primary key(nropedido),
constraint fk_dni
	foreign key(dni)
	references cliente,
constraint chk_subtotal
	check(subtotalpedido>0.0),
constraint chk_igv
	check(igv>0.0),
constraint chk_servicio
	check(servicio>0.0),	
constraint chk_totalpedido
	check(totalpedido>0.0)	
);


--====================================================
-- Crear la Tabla de Detalle de Pedido:detallepedido
--====================================================

create table detallepedido(
nropedido	char(7) not null,
codproducto char(4) not null,
preciounitario number(5,2) not null,
cant int not null,
preciototal number(5,2) not null,
constraint fk_nropedido
	foreign key (nropedido)
	references pedido,
constraint fk_codproducto
	foreign key (codproducto)
	references producto,
constraint chk_detpedido_preuni
	check(preciounitario>0),
constraint chk_detpedido_cant
	check(cant>=0),
constraint chk_detpedido_pretot
	check(preciounitario>0)
);

-- ====================================
-- Crear la Tabla de Usuarios:usuario
-- ====================================
create table usuario(
usuario varchar2(6) not null,
contrasenia varchar2(20) not null,
tipo char not null,
constraint pk_usuario
primary key(usuario)
);

-- ====================================
-- Crear la Tabla de Control:control
-- ====================================
create table control(
  parametro varchar2(20) not null,
  valor varchar2(6) not null
);

-- ====================================
-- Crear la tabla de Auditoria
-- ====================================
create table auditoria(
 codseguimiento integer not null,
 cambio varchar2(500) not null,
 valor_inicio varchar2(50)not null,
 valor_modif varchar2(50)not null,
 usuario varchar2(6)not null,
 constraint pk_auditoria
 primary key(codseguimiento),
 constraint fk_usuario
 foreign key(usuario)
 references usuario
);

-- ========================================
-- Crear la tabla de Mensaje
-- ========================================
create table mensaje(
	codmensaje char(6) not null,
	mensaje varchar2(100) not null,
	constraint pk_mensaje 
		primary key(codmensaje)
  );




SET TERMOUT ON
SET ECHO OFF
SET SERVEROUTPUT ON
BEGIN
	DBMS_OUTPUT.PUT_LINE('Fin del proceso...');
END;
/
SET TERMOUT OFF