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
CREATE PROCEDURE spu_list_addresses(IN _iddistrito INT)
BEGIN
	SELECT
		direcc.iddireccion,
        emp.ruc,
		emp.razon_social,
        emp.partida_elect,
        direcc.referencia,
        direcc.direccion,
        dist.distrito,
        prov.provincia,
        dept.departamento
		FROM direcciones AS direcc
        INNER JOIN empresas AS emp ON emp.idempresa = direcc.idempresa
        INNER JOIN distritos AS dist ON dist.iddistrito = direcc.iddistrito
        INNER JOIN provincias AS prov ON prov.idprovincia = dist.idprovincia
        INNER JOIN departamentos AS dept ON dept.iddepartamento = prov.iddepartamento
        WHERE direcc.iddistrito = _iddistrito;
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
        direcc.direccion,
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
CREATE PROCEDURE spu_list_projects_id(IN _idproyecto INT)
BEGIN
	SELECT * FROM vws_list_projects
    WHERE idproyecto = _idproyecto;
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
                
	SELECT ROW_COUNT() AS filasAfect; -- FILAS AFECTADAS
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
            
SELECT ROW_COUNT() AS filasAfect; -- FILAS AFECTADAS
END $$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE spu_inactive_projects(IN _idproyecto INT)
BEGIN

	UPDATE proyectos
		SET
			inactive_at = CURDATE()
		WHERE
			idproyecto = _idproyecto;
    
    SELECT ROW_COUNT() AS filasAfect;
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
CREATE PROCEDURE spu_list_assets_by_id(IN _idactivo INT)
BEGIN
		SELECT 
		act.idactivo,
        act.tipo_activo,
        proy.idproyecto,
        proy.denominacion,
        act.imagen,
        act.estado,
        act.codigo,
        act.sublote,
        act.direccion,
        dist.distrito,
        prov.provincia,
        dept.departamento,
        act.moneda_venta,
        act.area_terreno,
        act.zcomunes_porcent,
        act.partida_elect,
        act.latitud,
        act.longitud,
        act.perimetro,
        act.det_casa,
        act.precio_venta,
        usu.nombres AS usuario
		FROM activos AS act
        INNER JOIN proyectos AS proy ON proy.idproyecto = act.idproyecto
        INNER JOIN distritos AS dist ON dist.iddistrito = proy.iddistrito
        INNER JOIN provincias AS prov ON prov.idprovincia = dist.idprovincia
        INNER JOIN departamentos AS dept ON dept.iddepartamento = prov.iddepartamento
        INNER JOIN usuarios AS usu ON usu.idusuario = act.idusuario
        WHERE act.idactivo = _idactivo
        AND act.inactive_at IS NULL
        ORDER BY proy.denominacion;
END $$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE spu_list_assets_short_idpr(IN _idproyecto INT)
BEGIN
	SELECT * FROM vws_list_assets_short
    WHERE idproyecto = _idproyecto;
END $$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE spu_list_assets_by_code(IN _idproyecto INT, IN _codigo CHAR(5)) -- => POR CÓDIGO DE LOTE
BEGIN
	SELECT * 
		FROM vws_list_assets_short
        WHERE codigo LIKE CONCAT(_codigo,"%")
        AND idporyecto = _idproyecto;
END $$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE spu_list_inactive_assets()
BEGIN
	SELECT * FROM vws_list_inactive_assets ;
END $$
DELIMITER 

DELIMITER $$
CREATE PROCEDURE spu_list_inactive_assets_by_code(IN _codigo CHAR(5))
BEGIN
	SELECT * 
		FROM vws_list_inactive_assets
        WHERE codigo LIKE CONCAT(_codigo,"%");
END $$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE spu_add_assets
(
    IN _idproyecto		INT,
	IN _tipo_activo 	VARCHAR(10),
    IN _imagen  		VARCHAR(100),
    IN _estado	 		VARCHAR(10),
    IN _codigo 			CHAR(7),
    IN _sublote 		TINYINT,
    IN _direccion 		CHAR(70),
    IN _moneda_venta 	VARCHAR(10),
    IN _area_terreno 	DECIMAL(5,2),
    IN _zcomunes_porcent TINYINT,
    IN _partida_elect 	VARCHAR(100),
    IN _latitud			VARCHAR(20),
    IN _longitud 		VARCHAR(20),
    IN _perimetro      	JSON,
    IN _det_casa		JSON,
    IN _precio_venta	DECIMAL(8,2),
    IN _idusuario 		INT
)
BEGIN
	INSERT INTO activos (
						idproyecto, tipo_activo, imagen, estado, codigo, sublote, direccion, moneda_venta, area_terreno, zcomunes_porcent, partida_elect,
						latitud, longitud, perimetro, det_casa, precio_venta, idusuario
                        )
			VALUES
				(
                _idproyecto, _tipo_activo, NULLIF(_imagen,""), _estado, _codigo, _sublote, _direccion, _moneda_venta, _area_terreno, _zcomunes_porcent, partida_elect,
				NULLIF(_latitud,""), NULLIF(_longitud, ""), NULLIF(_perimetro,""),NULLIF(_det_casa,""), _precio_venta, _idusuario
                );
                
	SELECT ROW_COUNT() as filasAfect;
END $$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE spu_set_assets
(
	IN _idactivo  		INT,
    IN _idproyecto		INT,
	IN _tipo_activo 	VARCHAR(10),
    IN _imagen  		VARCHAR(100),
    IN _estado	 		VARCHAR(10),
    IN _codigo 			CHAR(7),
    IN _sublote 		TINYINT,
    IN _direccion 		CHAR(70),
    IN _moneda_venta 	VARCHAR(10),
    IN _area_terreno 	DECIMAL(5,2),
    IN _zcomunes_porcent TINYINT,
    IN _partida_elect 	VARCHAR(100),
    IN _latitud			VARCHAR(20),
    IN _longitud 		VARCHAR(20),
    IN _perimetro      	JSON,
    IN _det_casa		JSON,
    IN _precio_venta	DECIMAL(8,2),
    IN _idusuario 		INT
)
BEGIN
	UPDATE activos
		SET
			idproyecto		= _idproyecto,
            idproyecto		= _idproyecto,
            tipo_activo		= _tipo_activo,
            imagen 			= NULLIF(_imagen,""),
            estado			= _estado,
            codigo 			= _codigo,
            sublote 		= _sublote,
            direccion 		= _direccion,
            moneda_venta 	= _moneda_venta,
            area_terreno	= _area_terreno,
            zcomunes_porcent = _zcomunes_porcent,
            partida_elect 	= _partida_elect,
            latitud 		= NULLIF(_latitud,""),
            longitud		= NULLIF(_longitud,""),
            perimetro 		= NULLIF(_perimetro, ""),
            det_casa		= NULLIF(_det_casa,""),
            precio_venta	= _precio_venta,
            idusuario		= _idusuario,
            update_at		= CURDATE() 
		WHERE
			idactivo = _idactivo;
            
		SELECT ROW_COUNT() AS filasAfect;
END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE spu_inactive_assets(IN _idactivo INT)
BEGIN
	DECLARE _estadoActivo VARCHAR(10);
    
    -- CONSULTAR SI EL LOTE ESTA VENDIDO O SEPARDAO
    SET _estadoActivo = (
		SELECT estado
			FROM activos 
			WHERE idactivo = _idactivo
    );
    
	IF _estadoActivo = "SIN VENDER" THEN
		UPDATE activos
			SET
				inactive_at = CURDATE()
			WHERE idactivo = _idactivo;
	ELSE
		SIGNAL SQLSTATE "45000" SET MESSAGE_TEXT = "Error: el lote tiene un cliente";
    END IF;
    
    SELECT ROW_COUNT() AS filasAfect;
END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE spu_restore_assets(IN _idactivo INT)
BEGIN
	UPDATE activos
		SET 
			inactive_at = NULL,
            update_at 	= CURDATE()
		WHERE idactivo = _idactivo;
END$$
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
    WHERE documento_nro =_documento_nro;
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
CREATE PROCEDURE spu_lits_contracts_full_by_id(IN _idcontrato INT)
BEGIN
	-- CTE (EPRESION DE TABLA COMUN) ESTRUCTURA TEMPORAL QUE SE PUEDE USAR DENTRO DE UNA CONSULTA
    -- RECOLECTAMOS LA DATA
    
    -- DATA CLEINTE 1
	WITH ubigeo1 AS(
		SELECT 
			dist.iddistrito,
            dist.distrito,
            prov.provincia,
            dept.departamento
		FROM distritos AS dist
        INNER JOIN provincias AS prov ON prov.idprovincia = dist.idprovincia
        INNER JOIN departamentos AS dept ON dept.iddepartamento = prov.iddepartamento
    ),
    Client1 AS(
		SELECT 
			clien.idcliente,
            clien.nombres,
            clien.apellidos,
            clien.documento_tipo,
            clien.documento_nro,
            clien.estado_civil,
            ubdata.*,
            clien.direccion
			FROM clientes AS clien
            INNER JOIN ubigeo1 AS ubdata ON ubdata.iddistrito = clien.iddistrito
    ),
    
    -- DATA CLIENTE 2
    ubigeo2 AS(
		SELECT 
			dist.iddistrito AS iddistritoCL2,
            dist.distrito AS distrito2,
            prov.provincia AS provincia2,
            dept.departamento AS departamento2
		FROM distritos AS dist
        INNER JOIN provincias AS prov ON prov.idprovincia = dist.idprovincia
        INNER JOIN departamentos AS dept ON dept.iddepartamento = prov.iddepartamento
    ),
	Client2 AS(
		SELECT 
			clien.idcliente AS idconyugue,
            clien.nombres AS nombre2,
            clien.apellidos AS apellido2,
            clien.documento_tipo AS documento_tipo2,
            clien.documento_nro AS documento_nro2,
            clien.estado_civil AS estado_civil2,
            ubdata2.*,
            clien.direccion AS direccion2
			FROM clientes AS clien
            INNER JOIN ubigeo2 AS ubdata2 ON ubdata2.iddistritoCL2 = clien.iddistrito
    ),
    
    -- DATA REPRESENTANTE 1
	ubigeor1 AS(
		SELECT 
			dist.iddistrito AS iddistritoUB,
            dist.distrito AS distritor1,
            prov.provincia AS provinciar1,
            dept.departamento AS departamentor1
		FROM distritos AS dist
        INNER JOIN provincias AS prov ON prov.idprovincia = dist.idprovincia
        INNER JOIN departamentos AS dept ON dept.iddepartamento = prov.iddepartamento
    ),
    represen1 AS(
		SELECT 
				usu.idusuario AS idrepresentante_rpr,
				usu.nombres AS nombres_rpr,
                usu.apellidos AS apellidos_rpr,
                usu.documento_tipo AS documento_tipo_rpr,
                usu.documento_nro AS documento_nro_rpr,
                ubr1.*,
                usu.direccion AS direccion_rpr,
                usu.partida_elect AS partida_elect_rpr
			FROM vend_representantes AS vend  
            INNER JOIN usuarios AS usu ON usu.idusuario = vend.idrepresentante
            INNER JOIN ubigeor1 AS ubr1 ON ubr1.iddistritoUB = usu.iddistrito
		
    ),
    
    -- DATA REPRESENTANTE 2
	ubigeor2 AS(
		SELECT 
			dist.iddistrito AS iddistritoUB2,
            dist.distrito AS distritor2,
            prov.provincia AS provinciar2,
            dept.departamento AS departamentor2
		FROM distritos AS dist
        INNER JOIN provincias AS prov ON prov.idprovincia = dist.idprovincia
        INNER JOIN departamentos AS dept ON dept.iddepartamento = prov.iddepartamento
        ORDER BY dept.departamento ASC
    ),
	represen2 AS(
		SELECT 
				usu.idusuario AS idrepresentante_rps,
				usu.nombres AS nombres_rps,
                usu.apellidos AS apellidos_rps,
                usu.documento_tipo AS documento_tipo_rps,
                usu.documento_nro AS documento_nro_rps,
                ubr2.*,
                usu.direccion AS direccion_rps,
                usu.partida_elect AS partida_elect_rps
			FROM vend_representantes AS vend  
            INNER JOIN usuarios AS usu ON usu.idusuario = vend.idrepresentante
            INNER JOIN ubigeor2 AS ubr2 ON ubr2.iddistritoUB2 = usu.iddistrito

    )
    
	SELECT 
		dtc.iddetalle_contrato,
		cont.idcontrato,
        cont.tipo_cambio,
        cont.estado,        
		clien1.*, -- * IGUAL QUE SELECT * FROM INDICA TODOS LOS REGISTROS DE LA CTA
        clien2.*,
		rp1.*,
        rp2.*,
        proy.codigo,
        proy.denominacion,
        act.sublote,
		act.direccion,
        act.moneda_venta,
        act.area_terreno,
        act.zcomunes_porcent,
        act.partida_elect,
        act.det_casa,
        act.precio_venta, -- CREO QUE SE DEBERIA CALCULAR
        cont.detalles,
        cont.fecha_contrato,
        usu.nombres AS usuario
		FROM detalles_contratos AS dtc
        INNER JOIN contratos AS cont ON dtc.idcontrato = cont.idcontrato
        INNER JOIN activos AS act ON act.idactivo = dtc.idactivo
        INNER JOIN proyectos AS proy ON proy.idproyecto = act.idproyecto
        
        -- OBTENGO LOS DATOS DEL CLIENTE1 Y DEL CLIENTE2 (SI EXISTE)
        INNER JOIN Client1 AS clien1 ON clien1.idcliente = cont.idcliente
        LEFT JOIN Client2 AS clien2 ON clien2.idconyugue = cont.idconyugue
        
        -- OBTENGO LOS DATOS DEL REPRESENTANTE Y DEL REPRESENTANTE2 (SI EXISTE)
        INNER JOIN represen1 AS rp1 ON rp1.idrepresentante_rpr = cont.idrepresentante_primario
        LEFT JOIN represen2 AS rp2 ON rp2.idrepresentante_rps = cont.idrepresentante_secundario
        
        -- OBTENGO LOS DATOS DEL USUARIO 
        INNER JOIN usuarios AS usu ON usu.idusuario = cont.idusuario
        WHERE dtc.idcontrato = _idcontrato
        AND cont.inactive_at IS NULL
        ORDER BY denominacion;
END $$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE spu_add_contracts
(
	IN _idcliente 			INT,
    IN _idconyugue			INT,
    IN _idrepresentante_primario 	INT,
    IN _idrepresentante_secundario	INT,
    IN _tipo_cambio 		DECIMAL(4,3),
    IN _estado 				VARCHAR(10),
    IN _detalles			JSON,
    IN _fecha_contrato 		DATE,
    IN _idusuario 			INT
)
BEGIN

	INSERT INTO contratos(
				idcliente, idconyugue, idrepresentante_primario, idrepresentante_secundario, tipo_cambio, estado,
                detalles, fecha_contrato, idusuario
				)
			VALUES(
				_idcliente, NULLIF(_idconyugue, 0), _idrepresentante_primario, NULLIF(idrepresentante_secundario, 0), 
                _tipo_cambio, _estado, NULLIF(_detalles,""), _fecha_contrato, _idusuario
				);
                
	-- RETORNA EL ULTIMO IDCONTRATO
    SELECT @@LAST_INSERT_ID "idusuario";

END $$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE spu_set_contracts
(
	IN _idcontrato 			INT,
	IN _idcliente 			INT,
    IN _idconyugue			INT,
    IN _idrepresentante_primario 	INT,
    IN _idrepresentante_secundario	INT,
    IN _tipo_cambio 		DECIMAL(4,3),
    IN _estado 				VARCHAR(10),
    IN _detalles			JSON,
    IN _fecha_contrato 		DATE,
    IN _idusuario 			INT
)
BEGIN

	UPDATE contratos
		SET
			idcliente		= _idcliente,
            idconyugue		= NULLIF(_idconyugue,0),
            idrepresentante_primario = _idrepresentante_primario,
            idrepresentante_secundario = NULLIF(_idrepresentante_secundario,0),
            tipo_cambio		= _tipo_cambio,
			estado			= _estado,
            detalles 		= NULLIF(_detalles,""),
            fecha_contrato 	= _fecha_contrato,
            idusuario 		= _idusuario,
            update_at 		= CURDATE()
        WHERE
			idcontrato = _idcontrato;
END $$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE set_inactive_contracts(IN _idcontrato INT)
BEGIN

	DECLARE _numCot TINYINT;
    
    SET _numCot = (
		SELECT COUNT(*)
			FROM detalles_contratos
            WHERE idcontrato = _idcontrato
            AND inactive_at IS NULL
    );
    -- DESCATIVA EL LOTE
    
    IF _numCot = 0 THEN
    
		UPDATE contratos
			SET
				inactive_at = CURDATE()
			WHERE
				idcontrato = _idcontrato;
	ELSE 
		SIGNAL SQLSTATE "45000" SET MESSAGE_TEXT = "Error : existe información relacionada al contrato";
    END IF;
END $$
DELIMITER ;


-- DETALLES CONTRATOS
DELIMITER $$
CREATE PROCEDURE spu_list_det_contracts(IN _idactivo INT)
BEGIN
	DECLARE _idCont INT;
    
    -- OBTENGO EL IDCONTRATO
    SET _idCont =(
		SELECT idcontrato 
			FROM detalles_contratos
            WHERE idactivo = _idactivo
            AND inactive_at IS NULL
    );
    
	SELECT 
		dtc.iddetalle_contrato,
        act.idactivo,
		act.tipo_activo,
        act.sublote,
        act.direccion,
        act.moneda_venta,
        cont.idcontrato,
        cont.tipo_cambio,
        cont.estado,
        cont.fecha_contrato
		FROM detalles_contratos AS dtc
        INNER JOIN activos AS act ON act.idactivo = dtc.idactivo
        INNER JOIN contratos AS cont ON cont.idcontrato = dtc.idcontrato
        WHERE dtc.inactive_at IS NULL
        AND dtc.idcontrato = _idCont
        ORDER BY 3;
END $$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE spu_add_det_contracts(
	IN _idactivo 	INT,
    IN _idcontrato 	INT,
    IN _idusuario 	INT
)
BEGIN	
		DECLARE _tipo_activo	VARCHAR(10);
		DECLARE _estadoActivo 	VARCHAR(10);
        DECLARE _cantAct		TINYINT;
        
        -- CUANTOS REGISTROS  EXISTEN CON ESTE ACTIVO?
        SET _cantAct = (
			SELECT COUNT(*)
				FROM detalles_contratos
                WHERE idactivo = _idactivo
                AND inactive_at IS NULL
        );
    
		-- VERFICO EL TIPO DE ACTIVO
        SET _tipo_activo = (
			SELECT tipo_activo 
				FROM activos
				WHERE idactivo = _idactivo
                AND inactive_at IS NULL
        );
		
        -- VERFICO SI FUE SEPARADO EL ACTIVO(LOTE)
		SET _estadoActivo = (
			SELECT estado
				FROM activos
                WHERE idactivo = _idactivo
                AND inactive_at IS NULL
		);
        IF _cantAct = 0 THEN
			
            IF _tipo_activo = "LOTE" THEN
				
                IF 	_estadoActivo = "SEPARADO" 	THEN
						
                        -- INGRESA EL NUEVO REGISTRO
						INSERT INTO detalles_contratos(idactivo, idcontrato, idusuario)
									VALUES
									(_idactivo, _idcontrato, _idusuario);
        
						-- CAMBIO EL ESTADO DEL ACTIVO A "VENDIDO"
						UPDATE activos
							SET 
								estado = "VENDIDO",
								update_at = CURDATE()
							WHERE
								idactivo = _idactivo;
				ELSE 
					SIGNAL SQLSTATE "45000" SET MESSAGE_TEXT = "Error: separe el lote/ o verfique si hay duplicidad";
                END IF;
                
            ELSE
				
                -- INGRESA EL NUEVO REGISTRO
				INSERT INTO detalles_contratos(idactivo, idcontrato, idusuario)
							VALUES
							(_idactivo, _idcontrato, _idusuario);
        
				-- CAMBIO EL ESTADO DEL ACTIVO A "VENDIDO"
				UPDATE activos
					SET 
						estado = "VENDIDO",
						update_at = CURDATE()
					WHERE
						idactivo = _idactivo;
            END IF;
            
        ELSE 
			SIGNAL SQLSTATE "45000" SET MESSAGE_TEXT = "Error: ya existe un registro";
        END IF;
        
END $$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE spu_inactive_det_contracts(IN _iddetalle_contrato INT)
BEGIN
	UPDATE detalles_contratos
		SET
			inactive_at = CURDATE()
		WHERE
			iddetalle_contrato = _iddetalle_contrato;
END $$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE spu_list_separation_ByIdAsset(IN _idactivo INT)
BEGIN
	SELECT * FROM separaciones
    WHERE idactivo = _idactivo
    AND inactive_at IS NULL;
END $$
DELIMITER ;

-- PLANTILLA
DELIMITER $$
CREATE PROCEDURE ()
BEGIN
END $$
DELIMITER ;
