CREATE DATABASE AISOFT;
USE AISOFT;

-- CREANDO EL UBIGEO --------------------------------

-- DEPARTAMENTOS
CREATE TABLE departamentos(
	iddepartamento		INT PRIMARY KEY AUTO_INCREMENT,
    departamento		VARCHAR(45) 	NOT NULL,
    CONSTRAINT uk_departamento_deps	UNIQUE(departamento)
)ENGINE = INNODB;

-- PROVINCIAS
CREATE TABLE provincias(
	idprovincia				INT PRIMARY KEY AUTO_INCREMENT,
    iddepartamento			INT 		NOT NULL,
    provincia				VARCHAR(45)	NOT NULL,
    CONSTRAINT fk_iddepartamento_provin FOREIGN KEY(iddepartamento) REFERENCES departamentos(iddepartamento) 
)ENGINE = INNODB;

-- DISTRITOS
CREATE TABLE distritos(
	iddistrito			INT PRIMARY KEY AUTO_INCREMENT,
    idprovincia			INT		NOT NULL,
    distrito			VARCHAR(45),
    CONSTRAINT fk_idprovincia_distr	FOREIGN KEY (idprovincia) REFERENCES provincias(idprovincia)
)ENGINE = INNODB;

-- EMPRESAS
CREATE TABLE empresas(
	idempresa			INT PRIMARY KEY AUTO_INCREMENT,
    razon_social		VARCHAR(60)	 	NOT NULL,
    ruc					CHAR(11) 		NOT NULL,
    partida_elect		VARCHAR(60) 	NOT NULL,
    latitud				VARCHAR(20) 	NULL,
    longitud			VARCHAR(20) 	NULL,
    create_at 			DATE 			NOT NULL	DEFAULT (CURDATE()),
    update_at			DATE 			NULL,
    inactive_at			DATE 			NULL,
	CONSTRAINT uk_ruc_empresas UNIQUE(ruc)
)ENGINE = INNODB;

-- DIRECCIONES
CREATE TABLE direcciones(
	iddireccion			INT PRIMARY KEY AUTO_INCREMENT,
    idempresa			INT  		NOT NULL,
    iddistrito 			INT 		NOT NULL,
    direccion			VARCHAR(70) NOT NULL,
    referencia			VARCHAR(45) NULL,
	create_at 			DATE 			NOT NULL	DEFAULT (CURDATE()),
    update_at			DATE 			NULL,
    inactive_at			DATE 			NULL,
    CONSTRAINT fk_idempresa_direccs FOREIGN KEY(idempresa) REFERENCES empresas(idempresa),
    CONSTRAINT fk_iddistrito_direccs FOREIGN KEY(iddistrito) REFERENCES distritos(iddistrito)
)ENGINE = INNODB;

-- ROLES
CREATE TABLE roles(
	idrol			INT PRIMARY KEY AUTO_INCREMENT,
    rol				VARCHAR(30) NOT NULL,
    estado			CHAR(1) 	NOT NULL DEFAULT 1,
	create_at 			DATE 			NOT NULL	DEFAULT (CURDATE()),
    update_at			DATE 			NULL,
    inactive_at			DATE 			NULL,
    CONSTRAINT uk_rol_roles UNIQUE(rol)
)ENGINE = INNODB;

-- PERMISOS
CREATE TABLE permisos(
	idpermiso			INT PRIMARY KEY AUTO_INCREMENT,
    idrol				INT   		NOT NULL,
    modulo				VARCHAR(60) NOT NULL,
	create_at 			DATE 			NOT NULL	DEFAULT (CURDATE()),
    update_at			DATE 			NULL,
    inactive_at			DATE 			NULL,
    CONSTRAINT fk_idrol_permis FOREIGN KEY(idrol) REFERENCES roles(idrol)
)ENGINE = INNODB;

-- modulo será el nombre de la vista (views en el proyecto = vista.html)
-- el modulo seria "LISTAR-LOTES", "EDITAR-LOTES", etc

-- USUARIOS
CREATE TABLE usuarios(
	idusuario			INT PRIMARY KEY AUTO_INCREMENT,
    imagen 				VARCHAR(100) 		NULL,
    nombres				VARCHAR(40) 		NOT NULL,
    apellidos			VARCHAR(20)			NOT NULL,
    documento_tipo		VARCHAR(20)			NOT NULL,
    documento_nro   	VARCHAR(12) 		NOT NULL,
    estado_civil		VARCHAR(20)			NOT NULL,
	iddistrito			INT					NOT NULL,
    direccion			VARCHAR(60) 		NOT NULL,
    correo	 			VARCHAR(60) 		NOT NULL,
    contraseña 			VARCHAR(60) 		NOT NULL,
    codigo				CHAR(9) 			NULL,
    idrol				INT 				NOT NULL,
    iddireccion 		INT 				NOT NULL,
    partida_elect 		VARCHAR(60) 		NULL,
	create_at 			DATE 			NOT NULL	DEFAULT (current_date()),
    update_at			DATE 			NULL,
    inactive_at			DATE 			NULL,
    CONSTRAINT uk_documento_nro_usu UNIQUE(documento_nro),
    CONSTRAINT fk_iddistrito_usu FOREIGN KEY(iddistrito) REFERENCES distritos(iddistrito),
    CONSTRAINT uk_correo_us UNIQUE(correo),
    CONSTRAINT fk_idrol_usu FOREIGN KEY(idrol) REFERENCES roles(idrol),
    CONSTRAINT fk_iddireccion_usu FOREIGN KEY(iddireccion) REFERENCES direcciones(iddireccion)
)ENGINE = INNODB;
	
-- PROYECTOS
CREATE TABLE proyectos(
	idproyecto 				INT PRIMARY KEY AUTO_INCREMENT,
    imagen					VARCHAR(100) NULL,
    iddireccion				INT			NOT NULL,
    codigo	 				VARCHAR(20) NOT NULL, -- "A-12 NOMBRE DEL PROYECTO" => VARIA
    denominacion 			VARCHAR(30) NOT NULL,
    latitud					VARCHAR(20) NULL,
    longitud 				VARCHAR(20) NULL,
    perimetro				JSON		NULL, -- GUARDARÁ UN ARRAY CON LAS COORDENADAS QUE MARQUEN EL PERÍMETRO
    iddistrito 				INT 		NOT NULL,
    direccion 				VARCHAR(70) NOT NULL,
	create_at 				DATE 			NOT NULL	DEFAULT (CURDATE()),
    update_at				DATE 			NULL,
    inactive_at				DATE 			NULL,
    idusuario				INT 			NOT NULL,
    CONSTRAINT fk_iddireccion_proyects FOREIGN KEY(iddireccion) REFERENCES direcciones(iddireccion),
    CONSTRAINT uk_codigo_proyects UNIQUE(codigo),
    CONSTRAINT uk_denominacion_proyects UNIQUE(denominacion),
    CONSTRAINT fk_iddistrito_proyects FOREIGN KEY(iddistrito) REFERENCES distritos(iddistrito),
    CONSTRAINT fk_idusuario_proyects FOREIGN KEY(idusuario) REFERENCES usuarios(idusuario)
)ENGINE = INNODB;

-- LOTES
CREATE TABLE lotes(
	idlote 				INT PRIMARY KEY AUTO_INCREMENT,
    imagen 				VARCHAR(100) 		NULL,
    idproyecto			INT  		NOT  NULL,
    estado_venta 		VARCHAR(10) NOT  NULL DEFAULT "SIN VENDER",
    codigo				CHAR(5)	NOT NULL,
    tipo_casa			CHAR(8) 	NOT NULL,
    sublote 			TINYINT 	NOT NULL,
    urbanizacion		VARCHAR(70) NOT NULL,
    latitud 			VARCHAR(20) NULL,
    longitud 			VARCHAR(20) NULL,
    perimetro			JSON		NULL,
    moneda_venta 		VARCHAR(10) NOT NULL,
    area_terremo   		DECIMAL(5,2) NOT NULL,
    area_construccion 	DECIMAL(5,2) NOT NULL,
    area_techada		DECIMAL(5,2) NOT NULL,
    airesm2          	DECIMAL(5,2) NULL,
    zcomunes_porcent	TINYINT		 NULL,
    estacionamiento_nro TINYINT		NULL,
    partida_elect 		VARCHAR(100) NOT NULL,
    detalles 			JSON 		NOT NULL,
	create_at 			DATE 		NOT NULL	DEFAULT(CURDATE()),
    update_at			DATE 		NULL,
    inactive_at			DATE 		NULL,
    idusuario 			INT 		NOT NULL,
    CONSTRAINT fk_idproyecto_lotes FOREIGN KEY(idproyecto)  REFERENCES proyectos(idproyecto),
    CONSTRAINT uk_codigo_lotes UNIQUE(codigo),
    CONSTRAINT uk_sublote_lotes UNIQUE(idproyecto, sublote),
    CONSTRAINT fk_idusuario_lotes FOREIGN KEY(idusuario) REFERENCES usuarios(idusuario)
)ENGINE = INNODB;

-- ALTER TABLE lotes MODIFY codigo CHAR(5);
/*
alter table lotes drop constraint fk_iddistrito_lotes;
alter table lotes
drop column iddistrito;
*/
-- ALTER TABLE lotes CHANGE area_terremo area_terreno DECIMAL(5,2) NOT NULL;
-- CLIENTES
CREATE TABLE clientes(
	idcliente			INT PRIMARY KEY AUTO_INCREMENT,
    nombres				VARCHAR(40) 	NOT NULL,
    apellidos			VARCHAR(40) 	NOT NULL,
    documento_tipo		VARCHAR(20) 	NOT NULL,
    documento_nro		VARCHAR(12)   	NOT NULL,
    estado_civil 		VARCHAR(20) 	NOT NULL,
    iddistrito 			INT 			NOT NULL,
    direccion 			VARCHAR(70) 	NOT NULL,
	create_at 			DATE 		NOT NULL	DEFAULT (CURDATE()),
    update_at			DATE 		NULL,
    inactive_at			DATE 		NULL,
    idusuario 			INT 		NOT NULL,
    CONSTRAINT uk_documento_nro_cli UNIQUE(documento_nro),
    CONSTRAINT fk_iddistrito_cli FOREIGN KEY(iddistrito) REFERENCES distritos(iddistrito),
    CONSTRAINT fk_idusuario_cli FOREIGN KEY(idusuario) REFERENCES usuarios(idusuario)
)ENGINE = INNODB;

-- CONTRATOS
CREATE TABLE contratos(
	idcontrato 				INT PRIMARY KEY AUTO_INCREMENT,
    idlote					INT  			NOT NULL,
    idcliente				INT  			NOT NULL,	-- EL CLIENTE
    idcliente2 				INT    			NULL,		-- EL CONYUGUE (SOLO SI ESTÁ CASADO)
    idrepresentante 		INT 			NOT NULL,	-- REPRESENTANTE DEL VENDEDOR
    idrepresentante2 		INT 			NULL,		-- REPRESENTANTE DEL VENDEDOR 2 (SOLO SI EXISTIERA)
    precio_total 			DECIMAL(8,2)  	NOT NULL,
    cuota_inicial 			DECIMAL(8,2) 	NOT NULL,
    bono 					DECIMAL(8,2)  	NOT NULL,
    financiamiento 			DECIMAL(8,2) 	NOT NULL,
    plazo_entrega 			DATE 			NOT NULL,
    penalidad_moneda 		VARCHAR(10) 	NOT NULL,	-- SOLES O DOLARES
    penalidad_periodo 		VARCHAR(10) 	NOT NULL, 	-- POR DIA, MES O AÑO
    penalidad 				DECIMAL(4,3) 	NOT NULL, 	-- 1.00 ....
	tipo_cambio 			DECIMAL(4,3) 	NOT NULL,
	estado 					VARCHAR(10)		NOT NULL,
    fecha_contrato			DATE 			NOT NULL,
	create_at 				DATE 			NOT NULL	DEFAULT (CURDATE()),
    update_at				DATE 			NULL,
    inactive_at				DATE 			NULL,
    idusuario 				INT 			NOT NULL,
    CONSTRAINT fk_idlote_cont FOREIGN KEY(idlote) REFERENCES lotes(idlote),
    CONSTRAINT fk_idcliente_cont FOREIGN KEY(idcliente) REFERENCES clientes(idcliente),
    CONSTRAINT fk_idcliente2_cont FOREIGN KEY(idcliente2) REFERENCES clientes(idcliente),
    CONSTRAINT fk_idrepresentante_cont FOREIGN KEY(idrepresentante) REFERENCES usuarios(idusuario),
    CONSTRAINT fk_idrepresentante2_cont FOREIGN KEY(idrepresentante2) REFERENCES usuarios(idusuario),
    CONSTRAINT fk_idusuario_cont FOREIGN KEY(idusuario) REFERENCES usuarios(idusuario)
)ENGINE = INNODB;

ALTER TABLE contratos
	ADD CONSTRAINT uk_cliente_lote_contra UNIQUE(idlote, idcliente);
-- VENDEDORES Y REPRESENTANTES
CREATE TABLE vend_representantes(
	idvend_representante 			INT PRIMARY KEY AUTO_INCREMENT,
    idvendedor						INT NOT NULL,
    idrepresentante 				INT NOT NULL,
	create_at 						DATE 			NOT NULL	DEFAULT (CURDATE()),
    update_at						DATE 			NULL,
    inactive_at						DATE 			NULL,
    idusuario 						INT 			NOT NULL,
    CONSTRAINT fk_idvendor_vend_represents FOREIGN KEY(idvendedor) REFERENCES usuarios(idusuario),
    CONSTRAINT fk_idrepresent_vend_represents FOREIGN KEY(idrepresentante) REFERENCES usuarios(idusuario),
    CONSTRAINT uk_vendRepresent_vend_representss UNIQUE(idvendedor, idrepresentante),
    CONSTRAINT fk_idusuario_vend_represents FOREIGN KEY(idusuario) REFERENCES usuarios(idusuario)
)ENGINE = INNODB;

-- SEPARACIONES
CREATE TABLE separaciones(
	idseparacion  			INT PRIMARY KEY AUTO_INCREMENT,
    idlote 					INT 			NOT NULL,
    idvend_representante 	INT  			NOT NULL,
    idcliente 				INT  			NOT NULL,
    separacion				DECIMAL(5,2) 	NOT NULL,
    fecha_pago				DATE 			NOT NULL,
    penalidad_porcent 		TINYINT 		NOT NULL,
    fecha_devolucion		DATE 			NULL,
    estado 					VARCHAR(10) 	NOT NULL,
	create_at 				DATE 			NOT NULL	DEFAULT (CURDATE()),
    update_at				DATE 			NULL,
    inactive_at				DATE 			NULL,
    idusuario 				INT 			NOT NULL,
    CONSTRAINT fk_idlote_sep FOREIGN KEY(idlote) REFERENCES lotes(idlote),
    CONSTRAINT fk_idvend_representante_sep FOREIGN KEY(idvend_representante) REFERENCES vend_representantes(idvend_representante),
    CONSTRAINT fk_idcliente_sep FOREIGN KEY(idcliente) REFERENCES clientes(idcliente),
    CONSTRAINT fk_idusuario_sep FOREIGN KEY(idusuario) REFERENCES usuarios(idusuario)
)ENGINE = INNODB;

-- SUSTENTOS SEPARACIONES
CREATE TABLE sustentos_sep(
	idsustento_sep 			INT PRIMARY KEY AUTO_INCREMENT,
    idseparacion			INT 			NOT NULL,
    ruta 					VARCHAR(100) 	NOT NULL,
	create_at 				DATE 			NOT NULL	DEFAULT (CURDATE()),
    update_at				DATE 			NULL,
    inactive_at				DATE 			NULL,
    idusuario 				INT 			NOT NULL,
    CONSTRAINT fk_idseparacion_sust_sep FOREIGN KEY(idseparacion) REFERENCES separaciones(idseparacion),
    CONSTRAINT fk_idusuario_sust_sep FOREIGN KEY(idusuario) REFERENCES usuarios(idusuario)
)ENGINE = INNODB;

-- FINANCIERAS
CREATE TABLE financieras(
	idfinanciera 			INT PRIMARY KEY AUTO_INCREMENT,
    ruc						CHAR(11) 		NOT NULL,
    razon_social 			VARCHAR(60) 	NOT NULL,
    direccion 				VARCHAR(70) 	NOT NULL,
    CONSTRAINT uk_ruc_finans UNIQUE(ruc)
)ENGINE = INNODB;

-- DESEMBOLSOS
CREATE TABLE desembolsos(
	iddesembolso			INT PRIMARY KEY AUTO_INCREMENT,
    idfinanciera			INT 			NOT NULL,
    idlote	 				INT 			NOT NULL,
    monto_desemb 			DECIMAL(8,2) 	NOT NULL,
    porcentaje				TINYINT			NOT NULL,
    fecha_desembolso 		DATETIME		NOT NULL,
	create_at 				DATE 			NOT NULL	DEFAULT (CURDATE()),
    update_at				DATE 			NULL,
    inactive_at				DATE 			NULL,
    idusuario 				INT 			NOT NULL,
    CONSTRAINT fk_idfinanciera_desemb FOREIGN KEY(idfinanciera) REFERENCES financieras(idfinanciera),
    CONSTRAINT fk_idlote_desemb	FOREIGN KEY(idlote) REFERENCES lotes(idlote),
    CONSTRAINT fk_idusuario_desemb FOREIGN KEY(idusuario) REFERENCES usuarios(idusuario)
)ENGINE = INNODB;

-- PRESUPUESTOS
CREATE TABLE presupuestos(
	idpresupuesto			INT PRIMARY KEY AUTO_INCREMENT,
    idlote 					INT 			NOT NULL,
    descripcion	 			VARCHAR(70)		NOT NULL,
    fecha_program 			DATE 			NOT NULL,
	create_at 				DATE 			NOT NULL	DEFAULT (CURDATE()),
    update_at				DATE 			NULL,
    inactive_at				DATE 			NULL,
    idusuario 				INT 			NOT NULL,
    CONSTRAINT fk_idlote_presup FOREIGN KEY(idlote) REFERENCES lotes(idlote),
    CONSTRAINT fk_idusuario_presup FOREIGN KEY(idusuario) REFERENCES usuarios(idusuario)
)ENGINE = INNODB;

-- DETALLE GASTOS
CREATE TABLE detalle_gastos(
	iddetalle_gasto 		INT PRIMARY KEY AUTO_INCREMENT,
    idpresupuesto			INT 			NOT NULL,
    tipo_gasto				VARCHAR(20)		NOT NULL,	-- "CSOSTO DIRECTO" O "COSTO INDIRECTO"
    nombre_gasto			VARCHAR(40)		NOT NULL, 	-- "GASTOS ADMINISTRATIVOS", "ACCESORIOS DE BAÑO", ETC...
    descripcion				VARCHAR(100) 	NOT NULL,
    cantidad				TINYINT 		NOT NULL,
    precio_unitario 		DECIMAL(8,2) 	NOT NULL,
	create_at 				DATE 			NOT NULL	DEFAULT (CURDATE()),
    update_at				DATE 			NULL,
    inactive_at				DATE 			NULL,
    idusuario				INT 			NOT NULL,
    CONSTRAINT fk_idpresupuesto_dtgastos FOREIGN KEY(idpresupuesto) REFERENCES presupuestos(idpresupuesto),
    CONSTRAINT fk_idusuario_dtgastos FOREIGN KEY(idusuario) REFERENCES usuarios(idusuario)
)ENGINE = INNODB;

-- CUOTAS
CREATE TABLE cuotas(
	idcuota 				INT PRIMARY KEY AUTO_INCREMENT,
    idcontrato				INT  			NOT NULL,
    monto_cuota 			DECIMAL(8,2) 	NOT NULL,
    fecha_vencimiento 		DATE 			NOT NULL,
    fecha_pago 				DATE 			NULL,
    detalles  	 			VARCHAR(100) 	NULL,
    tipo_pago 				VARCHAR(20) 	NULL,
    entidad_bancaria 		VARCHAR(20) 	NULL,
	create_at 				DATE 			NOT NULL	DEFAULT (CURDATE()),
    update_at				DATE 			NULL,
    inactive_at				DATE 			NULL,
    idusuario				INT 			NOT NULL,
    CONSTRAINT fk_idcontrato_cuotas FOREIGN KEY(idcontrato) REFERENCES contratos(idcontrato),
    CONSTRAINT fk_idusuario_cuotas FOREIGN KEY(idusuario) REFERENCES usuarios(idusuario)
)ENGINE = INNODB;

-- SUSTENTOS CUOTAS
CREATE TABLE sustentos_cuotas(
	idsustento_cuota 		INT PRIMARY KEY AUTO_INCREMENT,
    idcuota					INT 			NOT NULL,
    ruta 					VARCHAR(100) 	NOT NULL,
	create_at 				DATE 			NOT NULL	DEFAULT (CURDATE()),
    update_at				DATE 			NULL,
    inactive_at				DATE 			NULL,
    idusuario 				INT 			NOT NULL,
    CONSTRAINT fk_idcuota_sust_cuo FOREIGN KEY(idcuota) REFERENCES cuotas(idcuota),
    CONSTRAINT fk_idusuario_sust_cuo FOREIGN KEY(idusuario) REFERENCES usuarios(idusuario)
)ENGINE = INNODB;


