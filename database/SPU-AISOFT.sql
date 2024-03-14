USE AISOFT;

-- DEPARTAMENTOS
DELIMITER $$
CREATE PROCEDURE spu_list_departaments()
BEGIN
	SELECT * FROM departamentos
    ORDER BY 2 ASC;
END $$
DELIMITER ;

-- PROVINCIAS
DELIMITER $$
CREATE PROCEDURE spu_list_provinces(IN _iddepartamento INT)
BEGIN
	SELECT * 
    FROM provincias 
    WHERE iddepartamento = _iddepartamento
    ORDER BY 3 ASC;
END $$
DELIMITER ;

-- DISTRITOS
DELIMITER $$
CREATE PROCEDURE spu_list_districts(IN _idprovincia INT)
BEGIN
	SELECT * 
    FROM distritos
    WHERE idprovincia = _idprovincia
    ORDER BY 3 ASC;
END $$
DELIMITER ;

-- EMPRESAS
DELIMITER $$
CREATE PROCEDURE spu_list_companies()
BEGIN
	SELECT * FROM vws_list_companies
    ORDER BY 2;
END $$
DELIMITER ;

-- EMPRESAS POR RUC
DELIMITER $$
CREATE PROCEDURE spu_list_companies_ruc(IN _ruc VARCHAR(11))
BEGIN
	SELECT * FROM vws_list_companies
    WHERE ruc LIKE CONCAT(_ruc, "%")
    ORDER BY 2;
END $$
DELIMITER ;

-- DIRECCIONES
DELIMITER $$
CREATE PROCEDURE spu_list_addresses()
BEGIN
	SELECT
		direcc.iddireccion,
        emp.ruc,
		emp.razon_social,
        emp.partida_elect,
        direcc.referencia,
        dist.distrito,
        prov.provincia,
        dept.departamento
		FROM direcciones AS direcc
        INNER JOIN empresas AS emp ON emp.idempresa = direcc.idempresa
        INNER JOIN distritos AS dist ON dist.iddistrito = direcc.iddistrito
        INNER JOIN provincias AS prov ON prov.idprovincia = dist.idprovincia
        INNER JOIN departamentos AS dept ON dept.iddepartamento = prov.iddepartamento;
END $$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE spu_list_addresses_ruc(IN _ruc VARCHAR(11))
BEGIN
	DECLARE _idempresa INT;

    -- OBTENGO LA EMPRESA
    SET _idempresa = (
						SELECT idempresa FROM vws_list_companies
						WHERE ruc LIKE CONCAT(_ruc, "%")
				);
	SELECT
		direcc.iddireccion,
        emp.ruc,
		emp.razon_social,
        emp.partida_elect,
        direcc.referencia,
        dist.distrito,
        prov.provincia,
        dept.departamento
		FROM direcciones AS direcc
        INNER JOIN empresas AS emp ON emp.idempresa = direcc.idempresa
        INNER JOIN distritos AS dist ON dist.iddistrito = direcc.iddistrito
        INNER JOIN provincias AS prov ON prov.idprovincia = dist.idprovincia
        INNER JOIN departamentos AS dept ON dept.iddepartamento = prov.iddepartamento
        WHERE direcc.idempresa = _idempresa;
END $$
DELIMITER ;

-- PROYECTOS
DELIMITER $$
CREATE PROCEDURE spu_list_projects()
BEGIN
	SELECT * FROM vws_list_projects;
END $$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE spu_list_projects_by_code(IN _codigo VARCHAR(20)) -- POR CÓDIGO DEL PROYECTO
BEGIN
		SELECT * FROM vws_list_projects
        WHERE codigo LIKE CONCAT("%", _codigo,"%");
END $$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE spu_list_drop_projects()
BEGIN
	SELECT * FROM vws_list_drop_projects;
END $$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE spu_list_drop_projects_by_code(IN _codigo VARCHAR(20)) -- POR CÓDIGO DEL PROYECTO
BEGIN
		SELECT * FROM vws_list_drop_projects
        WHERE codigo LIKE CONCAT("%", _codigo,"%");
END $$
DELIMITER ;


DELIMITER $$
CREATE PROCEDURE spu_add_projects
(
	IN _imagen			VARCHAR(100),
	IN _iddireccion 	INT,
    IN _codigo 			VARCHAR(20),
    IN _denominacion 	VARCHAR(30),
    IN _latitud 		VARCHAR(20),
    IN _longitud 		VARCHAR(20),
    IN _perimetro 		JSON,
    IN _iddistrito		INT,
    IN _direccion		VARCHAR(70),
    IN _idusuario 		INT
)
BEGIN
	INSERT INTO proyectos(imagen, iddireccion, codigo, denominacion, latitud, longitud, perimetro, iddistrito, direccion, idusuario)
			VALUES
				(NULLIF(_imagen,""), _iddireccion, _codigo, _denominacion, NULLIF(_latitud, ""), NULLIF(_longitud, ""), NULLIF(_perimetro, ""), _iddistrito, _direccion, _idusuario);
END $$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE spu_set_projects
(
	IN _idproyecto		INT,
    IN _imagen 			VARCHAR(100),
	IN _iddireccion 	INT,
    IN _codigo 			VARCHAR(20),
    IN _denominacion 	VARCHAR(30),
    IN _latitud 		VARCHAR(20),
    IN _longitud 		VARCHAR(20),
    IN _perimetro 		JSON,
    IN _iddistrito		INT,
    IN _direccion		VARCHAR(70),
    IN _idusuario 		INT
)
BEGIN
	UPDATE proyectos
		SET
			imagen 		= NULLIF(_imagen,""),
            iddireccion	= _iddireccion,
            codigo 		= _codigo,
            denominacion = _denominacion,
            latitud 	= NULLIF(_latitud,""),
            longitud	= NULLIF(_longitud,""),
            perimetro 	= NULLIF(_perimetro,""),
            iddistrito	= _iddistrito,
            direccion	= _direccion,
            idusuario	= _idusuario,
            update_at	= CURDATE()
		WHERE 
			idproyecto = _idproyecto;
END $$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE spu_inactive_projects(IN _idproyecto INT)
BEGIN
	DECLARE _lotes SMALLINT;
    
    -- CUENTA SI EL PROJECTO NO TIENE LOTES
    SET _lotes = (
		SELECT COUNT(*) 
        FROM lotes 
        WHERE idproyecto = _idproyecto
        AND inactive_at IS NULL
    );
    
    IF _lotes = 0 THEN
		UPDATE proyectos
			SET
				inactive_at = CURDATE()
			WHERE
				idproyecto = _idproyecto;
	ELSE 
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: El proyecto tiene lotes';
	END IF;
END $$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE spu_restore_projects(IN _idproyecto INT)
BEGIN
	UPDATE proyectos
		SET
			inactive_at = NULL,
            update_at = CURDATE()
			WHERE
				idproyecto = _idproyecto;
END $$
DELIMITER ;

-- LOTES

DELIMITER $$
CREATE PROCEDURE spu_list_lots_by_id(IN _idlote INT)
BEGIN
	SELECT * FROM vws_list_lots
    WHERE idlote = _idlote;
END $$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE spu_list_lots_short()
BEGIN
	SELECT * FROM vws_list_lots_short;
END $$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE spu_list_lots_short_by_code(IN _codigo CHAR(5)) -- => POR CÓDIGO DE LOTE
BEGIN
	SELECT * 
		FROM vws_list_lots_short
        WHERE codigo LIKE CONCAT(_codigo,"%");
END $$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE spu_inactive_list_short()
BEGIN
	SELECT * FROM vws_list_inactive_lots_short;
END $$
DELIMITER 

DELIMITER $$
CREATE PROCEDURE spu_inactive_list_short_by_code(IN _codigo CHAR(5))
BEGIN
	SELECT * 
		FROM vws_list_inactive_lots_short
        WHERE codigo LIKE CONCAT(_codigo,"%");
END $$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE spu_add_lots
(
    IN _idproyecto		INT,
    IN _estado_venta 	VARCHAR(10),
    IN _codigo 			CHAR(5),
    IN _sublote 		TINYINT,
    IN _urbanizacion 	VARCHAR(70),
    IN _latitud 		VARCHAR(20),
    IN _longitud		VARCHAR(20),
    IN _perimetro 		JSON,
    IN _moneda_venta 	VARCHAR(10),
    IN _area_terreno	DECIMAL(5,2),
    IN _partida_elect	VARCHAR(100),
    IN _idusuario 		INT
)
BEGIN
	INSERT INTO lotes ( idproyecto, estado_venta, codigo, sublote, urbanizacion, latitud, longitud, perimetro, moneda_venta, area_terreno, 
						partida_elect, idusuario)
			VALUES
				(_idproyecto, _estado_venta, _codigo, _sublote, NULLIF(_urbanizacion, ""),NULLIF(_latitud, ""), NULLIF(_longitud, ""), NULLIF(perimetro,""), _moneda_venta, _area_terreno, 
                _partida_elect, _idusuario);
END $$
DELIMITER 

DELIMITER $$
CREATE PROCEDURE spu_set_lots
(
	IN _idlote  		INT,
    IN _idproyecto		INT,
    IN _estado_venta 	VARCHAR(10),
    IN _codigo 			CHAR(5),
    IN _sublote 		TINYINT,
    IN _urbanizacion 	VARCHAR(70),
    IN _latitud 		VARCHAR(20),
    IN _longitud		VARCHAR(20),
    IN _perimetro 		JSON,
    IN _moneda_venta 	VARCHAR(10),
    IN _area_terreno	DECIMAL(5,2),
    IN _partida_elect	VARCHAR(100),
    IN _idusuario 		INT
)
BEGIN
	UPDATE lotes
		SET
			idproyecto		= _idproyecto,
			estado_venta 	= _estado_venta,
			codigo			= _codigo,
			sublote			= _sublote,
			urbanizacion	= NULLIF(_urbanizacion, ""),
			latitud			= NULLIF(_latitud, ""),
			longitud		= NULLIF(_longitud, ""),
			perimetro		= NULLIF(_perimetro, ""),
			moneda_venta	= _moneda_venta,
			area_terreno 	= _area_terreno,
			partida_elect	= _partida_elect,
			idusuario 		= _idusuario,
            update_at		= CURDATE()
		WHERE
			idlote = _idlote;
END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE spu_inactive_lots(IN _idlote INT)
BEGIN
	DECLARE _estadoLote VARCHAR(10);
    
    -- CONSULTAR SI EL LOTE ESTA VENDIDO O SEPARDAO
    SET _estadoLote = (
		SELECT estado_venta 
			FROM lotes 
			WHERE idlote = _idlote
    );
    
	IF _estadoLote = "NO VENDIDO" THEN
		UPDATE lotes
			SET
				inactive_at = CURDATE()
			WHERE idlote = _idlote;
	ELSE
		SIGNAL SQLSTATE "45000" SET MESSAGE_TEXT = "Error: el lote tiene un cliente";
    END IF;
END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE spu_restore_lotes(IN _idlote INT)
BEGIN
	UPDATE lotes
		SET 
			inactive_at = NULL,
            update_at 	= CURDATE()
		WHERE idlote = _idlote;
END$$
DELIMITER ;

-- VIVIENDAS
DELIMITER $$
CREATE PROCEDURE spu_add_houses
(

	IN _idlote				INT,
	IN _imagen				VARCHAR(100),
    IN _tipo_casa  			CHAR(8),
	IN _area_construccion 	DECIMAL(5,2),
    IN _area_techada		DECIMAL(5,2),
    IN _airesm2 			DECIMAL(5, 2),
    IN _zcomunes_porcent 	TINYINT,
    IN _estacionamiento_nro TINYINT,
    IN _detalles 			JSON,
    IN _idusuario 			INT
)
BEGIN
	DECLARE _activos  TINYINT;
    SET _activos  = (
		SELECT COUNT(idlote) 
        FROM viviendas WHERE idlote = _idlote
        AND inactive_at IS NULL
        );
        
        IF _activos = 0 THEN
        
			INSERT INTO viviendas(idlote, imagen, tipo_casa, area_construccion, area_techada, airesm2, zcomunes_porcent, estacionamiento_nro, detalles, idusuario)
					VALUES
						(_idlote, NULLIF(_imagen, ""),  _tipo_casa, _area_construccion, _area_techada, _airesm2, _zcomunes_porcent, _estacionamiento_nro, _detalles, _idusuario);
		ELSE 
			SIGNAL SQLSTATE "45000" SET MESSAGE_TEXT ="Error, ya hay un registro con ese nombre";
        END IF ;
END $$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE spu_set_houses
(
	IN _idvivienda 			INT,
    IN _idlote 				INT,
    IN _imagen				VARCHAR(100),
    IN _tipo_casa  			CHAR(8),
    IN _area_construccion 	DECIMAL(5,2),
    IN _area_techada		DECIMAL(5,2),
    IN _airesm2 			DECIMAL(5, 2),
    IN _zcomunes_porcent 	TINYINT,
    IN _estacionamiento_nro TINYINT,
    IN _detalles 			JSON,
    IN _idusuario			INT
)
BEGIN
	UPDATE viviendas
		SET
			idlote 				= _idlote,
			imagen 				= NULLIF(_imagen, ""),
            tipo_casa			= _tipo_casa,
            area_construccion 	= _area_construccion,
			area_techada		= _area_techada,
			airesm2				= _airesm2,
			zcomunes_porcent 	= _zcomunes_porcent,
			estacionamiento_nro =_estacionamiento_nro,
            detalles			= _detalles,
			idusuario 			= _idusuario,
            update_at			= CURDATE()
        WHERE
			idvivienda = _idvivienda;
END $$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE spu_inactive_houses(IN _idvivienda  INT)
BEGIN
	
    DECLARE _idlote INT;
    DECLARE _registros TINYINT;
    
    -- 	OBTENGO EL IDLOTE
    SET _idlote = (SELECT idlote FROM viviendas WHERE idvivienda = _idvivienda);
    
    -- VERIFICO SI EXISTE ALGUNN REGISTRO EN LOS PRESUPUESTOS
     SET _registros = (
		SELECT COUNT(*) FROM presupuestos
        WHERE idlote = _idlote
        AND inactive_at IS NULL
     );
     
	IF _registros = 0 THEN
		UPDATE viviendas
			SET
				inactive_at = CURDATE()
			WHERE
				idvivienda = _idvivienda;
	ELSE 
		SIGNAL SQLSTATE "45000" SET MESSAGE_TEXT = "Error: la vivienda cuenta con un presupuesto";
    END IF;
END $$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE spu_restore_houses(IN _idvivienda INT)
BEGIN
	DECLARE _activos TINYINT;
    DECLARE _idlote TINYINT;
    
    SET _idlote = (SELECT idlote FROM viviendas WHERE idvivienda = _idvivienda);
    
    SET _activos = (
		SELECT COUNT(*) FROM viviendas
        WHERE idlote = _idlote
        AND inactive_at IS NULL
    );
    
    IF _activoS = 0 THEN
        UPDATE viviendas
			SET
				inactive_at = NULL,
				update_at = CURDATE()
			WHERE
				idvivienda = _idvivienda;
    ELSE
		SIGNAL SQLSTATE "45000" SET MESSAGE_TEXT = "Error, ya estiste otro registro con ese lote";
    END IF;
END $$
DELIMITER ;

-- CLIENTES
DELIMITER $$
CREATE PROCEDURE spu_list_clients()
BEGIN
	SELECT * FROM vws_list_clients;
END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE spu_list_inactive_clients()
BEGIN
	SELECT * FROM vws_list_inactive_clients;
END $$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE spu_list_clients_by_docNro(IN _documento_nro VARCHAR(12))
BEGIN
	SELECT * FROM vws_list_clients
    WHERE documento_nro LIKE CONCAT("%",_documento_nro, "%");
END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE spu_add_clients
(
	IN _nombres 		VARCHAR(40),
    IN _apellidos 		VARCHAR(40),
    IN _documento_tipo 	VARCHAR(20),
    IN _documento_nro 	VARCHAR(12),
    IN _estado_civil 	VARCHAR(20),
    IN _iddistrito 		INT,
    IN _direccion		VARCHAR(70),
    IN _idusuario 		INT
)
BEGIN
	INSERT INTO clientes(nombres, apellidos, documento_tipo, documento_nro, estado_civil, iddistrito, direccion, idusuario)
				VALUES
					(_nombres, _apellidos, _documento_tipo, _documento_nro, _estado_civil, _iddistrito, _direccion, _idusuario);
END $$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE spu_set_clients
(
	IN _idcliente		INT,
	IN _nombres 		VARCHAR(40),
    IN _apellidos 		VARCHAR(40),
    IN _documento_tipo 	VARCHAR(20),
    IN _documento_nro 	VARCHAR(12),
    IN _estado_civil 	VARCHAR(20),
    IN _iddistrito 		INT,
    IN _direccion		VARCHAR(70),
    IN _idusuario 		INT
)
BEGIN
	UPDATE clientes
		SET
			nombres 	= _nombres,
            apellidos	= _apellidos,
            documento_tipo	= _documento_tipo,
            documento_nro	= _documento_nro,
            estado_civil	= _estado_civil,
            iddistrito		= _iddistrito,
            direccion		= _direccion,
            idusuario		= _idusuario,
            update_at		= CURDATE()
		WHERE 
			idcliente = _idcliente;
END $$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE spu_inactve_clients(IN _idcliente INT)
BEGIN
	DECLARE _clienContrato INT;
    DECLARE _clienSeparacion INT;
    
    -- VERFICO QUE SI EXISTE EN UNA SEPARACIÓN O CONTRATO
    SET _clienContrato = (
		SELECT COUNT(*)
			FROM contratos
            WHERE idcliente = _idcliente
            AND inactive_at IS NULL    
            );
            
	SET _clienSeparacion = (
		SELECT COUNT(*)
			FROM separaciones
            WHERE idcliente = _idcliente
            AND inactive_at IS NULL
    );
    
    -- EJECUTO EL PROCEDIMIENTO
    
    IF _clienContrato  = 0 OR _clienSeparacion = 0 THEN
		UPDATE clientes
			SET
				inactive_at = CURDATE()
			WHERE
				idcliente = _idcliente;
	ELSE 
		SIGNAL SQLSTATE "45000" SET MESSAGE_TEXT = "Error: tiene registros este cliente";
	END IF;
END $$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE spu_restore_clientes(IN _idcliente INT)
BEGIN
	UPDATE clientes
		SET
			inactive_at = NULL ,
            update_at 	= CURDATE()
		WHERE
			idcliente = _idcliente;
END $$
DELIMITER ;

-- CONTRATOS
DELIMITER $$
CREATE PROCEDURE spu_list_contracts_short()
BEGIN
	SELECT * FROM vws_list_contracts_short;
END $$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE spu_lits_contracts_short_by_code(IN _codigo VARCHAR(5))
BEGIN
		SELECT * 
			FROM vws_list_contracts_short
			WHERE codigo LIKE CONCAT(_codigo,"%");
END $$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE spu_lits_contracts_full_by_id(IN _idcontrato INT)
BEGIN
	SELECT * 
		FROM vws_list_contracts_full
        WHERE idcontrato = _idcontrato;
END $$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE spu_add_contracts
(
	IN _idlote				INT,
	IN _idcliente 			INT,
    IN _idcliente2 			INT,
    IN _idrepresentante 	INT,
    IN _idrepresentante2	INT,
    IN _precio_total 		DECIMAL(8,2),
    IN _tipo_cambio 		DECIMAL(4,3),
    IN _estado 				VARCHAR(10),
    IN _tipo_contrato 		VARCHAR(45),
    IN _detalles			JSON,
    IN _fecha_contrato 		DATE,
    IN _idusuario 			INT
)
BEGIN
	DECLARE _loteSeparado TINYINT;
    
    -- VERFICO SI FUE SEPARADO EL LOTE
    SET _loteSeparado = (
			SELECT COUNT(*)
				FROM separaciones
                WHERE idlote = _idlote
    );
	-- CAMBIO EL ESTADO DEL LOTE A "VENDIDO"
	UPDATE lotes
		SET 
			estado_venta = "VENDIDO",
            update_at = CURDATE()
		WHERE
			idlote = _idlote;
	
    -- REGISTRA EL NUEVO CONTRATO
    IF _loteSeparado = 1 THEN
		INSERT INTO contratos(
					idlote, idcliente, idcliente2, idrepresentante, idrepresentante2, precio_total, tipo_cambio, estado, tipo_contrato, 
                    detalles, fecha_contrato, idusuario
				)
				VALUES(
					_idlote, _idcliente, NULLIF(_idcliente2, 0), _idrepresentante, NULLIF(_idrepresentante2, 0), _precio_total, 
                    _tipo_cambio, _estado, _tipo_contrato, _detalles, _fecha_contrato, _idusuario
				);
	ELSE
		SIGNAL SQLSTATE "45000" SET MESSAGE_TEXT = "Error: separe el lote";
    END IF;
END $$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE spu_set_contracts
(
	IN _idcontrato 			INT,
	IN _idlote				INT,
	IN _idcliente 			INT,
    IN _idcliente2 			INT,
    IN _idrepresentante 	INT,
    IN _idrepresentante2	INT,
    IN _precio_total 		DECIMAL(8,2),
    IN _tipo_cambio 		DECIMAL(4,3),
    IN _estado 				VARCHAR(10),
    IN _tipo_contrato 		VARCHAR(45),
    IN _detalles			JSON,
    IN _fecha_contrato 		DATE,
    IN _idusuario 			INT
)
BEGIN
	UPDATE contratos
		SET
			idlote				= _idlote,
            idcliente 			= _idcliente,
            idcliente2			= NULLIF(_idcliente2,""),
            idrepresentante 	= _idrepresentante,
            idrepresentante2	= NULLIF(_idrepresentante2, ""),
            precio_total		= _precio_total,
            tipo_cambio			= _tipo_cambio,
            estado 				= _estado,
            tipo_contrato		= _tipo_contrato,
            detalles			= NULLIF(_detalles,""),
            fecha_contrato		= _fecha_contrato,
            idusuario			= _idusuario,
            update_at 			= CURDATE()
        WHERE
			idcontrato = _idcontrato;
END $$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE set_inactive_contracts(IN _idcontrato INT)
BEGIN
	DECLARE _idlote INT;
    
    -- OBTENGO EL ID LOTE PARA SABER QUE LOTE MODIFICAR
    SET _idlote = (
		SELECT idlote 
			FROM contratos
            WHERE idcontrato = _idcontrato
    );
    
    -- MODIFICO EL ESTADO DEL LOTE
	UPDATE lotes 
		SET
			estado_venta = "NO VENDIO",
            update_at = CURDATE()
		WHERE
			idlote = _idlote;
	
    -- DESCATIVA EL LOTE
	UPDATE contratos
		SET
			estado 		= "DEVOLUCIÓN", 
			inactive_at = CURDATE()
		WHERE
			idcontrato = _idcontrato;
END $$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE spu_list_inactive_contracts_short()
BEGIN
	SELECT * FROM vws_list_inactive_contracts_short;
END $$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE spu_resotres_contracts(IN _idcontrato INT)
BEGIN
	DECLARE _idlote SMALLINT;
	DECLARE _contratosActivos SMALLINT;
    
    -- OBTENGO EL IDLOTE
    SET _idlote = (
		SELECT idlote FROM contratos
        WHERE idcontrato = _idcontrato
    );
    
    -- VEREIFICO SI EXISTE ALGUN CONTRTO ACTIVO CON ESE IDLOTE
    SET _contratosActivos = (
		SELECT COUNT(*) FROM contratos
        WHERE idlote = _idlote
        AND inactive_at IS NULL
    );
    
    -- EJECUTO LA CONSULTA
    IF _contratosActivos = 0 THEN
		UPDATE contratos
			SET
				estado = "ACTIVO",
                update_at = CURDATE(),
                inactive_at =  NULL
			WHERE 
				idcontrato = _idcontrato;
	ELSE
		SIGNAL SQLSTATE "45000" SET MESSAGE_TEXT = "Error: Ya existe un contrato con este lote";
    END IF;
END $$
DELIMITER ;

-- PLANTILLA
DELIMITER $$
CREATE PROCEDURE ()
BEGIN
END $$
DELIMITER ;
