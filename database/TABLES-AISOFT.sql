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
	create_at 			DATE 			NOT NULL	DEFAULT (CURDATE()),
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
    longitud 				VARCHAR(20) NOT NULL DEFAULT '{"clave" :[""], "valor":[""]}',
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

-- ALTER TABLE proyectos DROP COLUMN perimetro; 
-- ALTER TABLE proyectos ADD COLUMN perimetro JSON NOT NULL DEFAULT '{"clave" :[""], "valor":[""]}';
-- MÉTRICAS => TABLA QUE TENDRA LA CANTIDAD DE LOTES VENDIDOS, NO VENDIDOS, 
CREATE TABLE metricas(
	idmetrica 			INT PRIMARY KEY AUTO_INCREMENT,
    idproyecto			INT 		NOT NULL,
    l_vendidos	 		INT 		NOT NULL DEFAULT 0,
    l_noVendidos 		INT      	NOT NULL DEFAULT 0,
    l_separados			INT 		NOT NULL DEFAULT 0,
    update_at 			DATETIME 	NOT NULL DEFAULT(NOW()),
    CONSTRAINT fk_idproyecto_metr FOREIGN KEY(idproyecto) REFERENCES proyectos(idproyecto)
)ENGINE = INNODB;

-- ALTER TABLE metricas CHANGE create_at update_at DATETIME	NOT NULL DEFAULT(NOW());
-- ACTIVOS
-- PUEDEN SER LOS LOTES O CASAS
CREATE TABLE activos(
	idactivo 			INT PRIMARY KEY AUTO_INCREMENT,
    idproyecto			INT  				NOT  NULL,
    tipo_activo 		VARCHAR(10) 		NOT NULL,
    imagen 				VARCHAR(100) 		NULL,
    estado 				VARCHAR(10) 		NOT NULL DEFAULT '{"calve" :[], "valor":[]}', 
    codigo				CHAR(7)				NOT NULL,
    sublote 			TINYINT 			NOT NULL,
    direccion			VARCHAR(70) 		NOT NULL,
    moneda_venta 		VARCHAR(10) 		NOT NULL,
    area_terreno   		DECIMAL(5,2) 		NOT NULL,
    zcomunes_porcent	TINYINT		 		NULL,
    partida_elect 		VARCHAR(100) 		NOT NULL,
    latitud 			VARCHAR(20) 		NULL,
    longitud 			VARCHAR(20) 		NULL,
    perimetro			JSON				NULL,
    det_casa 			JSON 				NULL 		DEFAULT '{"clave" :[""], "valor":[""]}',
    precio_venta 		DECIMAL(8,2)		NOT NULL,
	create_at 			DATE 				NOT NULL	DEFAULT(CURDATE()),
    update_at			DATE 				NULL,
    inactive_at			DATE 				NULL,
    idusuario 			INT 				NOT NULL,
    CONSTRAINT fk_idproyecto_lotes FOREIGN KEY(idproyecto)  REFERENCES proyectos(idproyecto),
    CONSTRAINT uk_codigo_lotes UNIQUE(codigo),
    CONSTRAINT fk_idusuario_lotes FOREIGN KEY(idusuario) REFERENCES usuarios(idusuario)
)ENGINE = INNODB;

-- ALTER TABLE activos DROP CONSTRAINT fk_idproyecto_lotes;
-- ALTER TABLE activos ADD CONSTRAINT fk_idproyecto_lotes FOREIGN KEY(idproyecto)  REFERENCES proyectos(idproyecto);
-- ALTER TABLE activos DROP COLUMN det_casa; 
-- ALTER TABLE activos ADD COLUMN det_casa JSON NOT NULL DEFAULT '{"clave" :[""], "valor":[""]}';
-- ALTER TABLE activos MODIFY COLUMN codigo CHAR(7);
-- ALTER TABLE activos CHANGE urbanizacion direccion VARCHAR(60);
-- ALTER TABLE activos DROP COLUMN idlote;
SELECT * FROM activos ORDER BY create_at asc;
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

-- CONTRATOS
CREATE TABLE contratos(
	idcontrato 				INT PRIMARY KEY AUTO_INCREMENT,
    tipo_contrato 			VARCHAR(40)		NOT NULL,
    idcliente				INT  			NOT NULL,	-- EL CLIENTE
    idconyugue 				INT    			NULL,		-- EL CONYUGUE (SOLO SI ESTÁ CASADO)
    idrepresentante_primario 		INT 			NOT NULL,	-- REPRESENTANTE DEL VENDEDOR
    idrepresentante_secundario 		INT 			NULL,		-- REPRESENTANTE DEL VENDEDOR 2 (SOLO SI EXISTIERA)
	tipo_cambio 			DECIMAL(4,3) 	NOT NULL,
	estado 					VARCHAR(10)		NOT NULL,
    detalles				JSON 			NULL, -- BONOS, FINACIAMIENTOS, PENALIDAD, PLAZO ENTREGA, CUOTA INICIAL ..
    fecha_contrato			DATE 			NOT NULL,
	create_at 				DATE 			NOT NULL	DEFAULT (CURDATE()),
    update_at				DATE 			NULL,
    inactive_at				DATE 			NULL,
    idusuario 				INT 			NOT NULL,
    CONSTRAINT fk_idcliente_cont FOREIGN KEY(idcliente) REFERENCES clientes(idcliente),
    CONSTRAINT fk_idcliente2_cont FOREIGN KEY(idconyugue) REFERENCES clientes(idcliente),
    CONSTRAINT fk_idrepresentante_cont FOREIGN KEY(idrepresentante_primario) REFERENCES vend_representantes(idvend_representante),
    CONSTRAINT fk_idrepresentante2_cont FOREIGN KEY(idrepresentante_secundario) REFERENCES vend_representantes(idvend_representante),
    CONSTRAINT fk_idusuario_cont FOREIGN KEY(idusuario) REFERENCES usuarios(idusuario)
)ENGINE = INNODB;

SELECT * FROM contratos;
-- ALTER TABLE contratos ADD COLUMN tipo_contrato VARCHAR(40) NOT NULL;
-- ALTER TABLE contratos DROP COLUMN detalles;
-- ALTER TABLE contratos ADD COLUMN detalles JSON NOT NULL DEFAULT '{"clave": "", "valor":  ""}';

-- DETALLES CONTRATOS
CREATE TABLE detalles_contratos(
	iddetalle_contrato		INT PRIMARY KEY AUTO_INCREMENT,
    idactivo				INT  			NOT NULL,
    idcontrato 				INT 			NOT NULL,
	create_at 				DATE 			NOT NULL	DEFAULT (CURDATE()),
    update_at				DATE 			NULL,
    inactive_at				DATE 			NULL,
    idusuario 				INT 			NOT NULL,
    CONSTRAINT fk_idactivo_dt_contratos FOREIGN KEY(idactivo) REFERENCES activos(idactivo),
    CONSTRAINT fk_idcontrato_dt_contratos FOREIGN KEY(idcontrato) REFERENCES contratos(idcontrato),
    CONSTRAINT fk_idusuario_dt_contrato FOREIGN KEY(idusuario) REFERENCES usuarios(idusuario)
)ENGINE = INNODB;

-- SEPARACIONES
CREATE TABLE separaciones(
	idseparacion  			INT PRIMARY KEY AUTO_INCREMENT,
    idactivo				INT 			NOT NULL,
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
    CONSTRAINT fk_idactivo_sep FOREIGN KEY(idactivo) REFERENCES activos(idactivo),
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
    idactivo 				INT 			NOT NULL,
    monto_desemb 			DECIMAL(8,2) 	NOT NULL,
    porcentaje				TINYINT			NOT NULL,
    fecha_desembolso 		DATETIME		NOT NULL,
	create_at 				DATE 			NOT NULL	DEFAULT (CURDATE()),
    update_at				DATE 			NULL,
    inactive_at				DATE 			NULL,
    idusuario 				INT 			NOT NULL,
    CONSTRAINT fk_idfinanciera_desemb FOREIGN KEY(idfinanciera) REFERENCES financieras(idfinanciera),
    CONSTRAINT fk_idactivo_desemb	FOREIGN KEY(idactivo) REFERENCES activos(idactivo),
    CONSTRAINT fk_idusuario_desemb FOREIGN KEY(idusuario) REFERENCES usuarios(idusuario)
)ENGINE = INNODB;

-- PRESUPUESTOS
CREATE TABLE presupuestos(
	idpresupuesto			INT PRIMARY KEY AUTO_INCREMENT,
    idactivo 					INT 			NOT NULL,
    descripcion	 			VARCHAR(70)		NOT NULL,
    fecha_program 			DATE 			NOT NULL,
	create_at 				DATE 			NOT NULL	DEFAULT (CURDATE()),
    update_at				DATE 			NULL,
    inactive_at				DATE 			NULL,
    idusuario 				INT 			NOT NULL,
    CONSTRAINT fk_idactivo_presup FOREIGN KEY(idactivo) REFERENCES activos(idactivo),
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
    idcontrato		INT  			NOT NULL,
    monto_cuota 			DECIMAL(8,2) 	NOT NULL,
    fecha_vencimiento 		DATE 			NOT NULL,
    fecha_pago 				DATE 			NULL,
    detalles  	 			VARCHAR(100) 	NULL,
    tipo_pago 				VARCHAR(20) 	NOT NULL,
    entidad_bancaria 		VARCHAR(20) 	NOT NULL,
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


-- DROP TABLE sustentos_cuotas, cuotas, detalle_gastos, presupuestos, desembolsos, sustentos_sep, separaciones, contratos, viviendas, lotes;