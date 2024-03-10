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
CREATE PROCEDURE spu_list_companies_ruc(IN _ruc CHAR(11))
BEGIN
	SELECT * FROM vws_list_companies
    WHERE ruc LIKE CONCAT(_ruc, "%")
    ORDER BY 2;
END $$
DELIMITER ;

-- DIRECCIONES
DELIMITER $$
CREATE PROCEDURE spu_list_adresses(IN _ruc CHAR(11))
BEGIN
	DECLARE _idempresa INT;
    DECLARE _iddistrito INT;

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
CREATE PROCEDURE spu_list_lots()
BEGIN
	SELECT * FROM vws_list_lots;
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
	IN _imagen			VARCHAR(100),
    IN _idproyecto		INT,
    IN _estado_venta 	VARCHAR(10),
    IN _codigo 			CHAR(5),
    IN _tipo_casa  		CHAR(8),
    IN _sublote 		TINYINT,
    IN _iddistrito 		INT,
    IN _urbanizacion 	VARCHAR(70),
    IN _latitud 		VARCHAR(20),
    IN _longitud		VARCHAR(20),
    IN _perimetro 		JSON,
    IN _moneda_venta 	VARCHAR(10),
    IN _area_terreno	DECIMAL(5,2),
    IN _area_construccion DECIMAL(5,2),
    IN _area_techada	DECIMAL(5,2),
    IN _airesm2 		DECIMAL(5, 2),
    IN _zcomunes_porcent TINYINT,
    IN _estacionamiento_nro TINYINT,
    IN _partida_elect	VARCHAR(100),
	IN _detalles 		JSON,
    IN _idusuario 		INT
)
BEGIN
	INSERT INTO lotes (imagen, idproyecto, estado_venta, codigo, tipo_casa, sublote, iddistrito, urbanizacion, latitud, longitud, perimetro, moneda_venta, area_terreno, 
						area_construccion, area_techada, airesm2, zcomunes_porcent, estacionamiento_nro, partida_elect, detalles, idusuario)
			VALUES
				(NULLIF(_imagen, ""), _idproyecto, _estado_venta, _codigo, _tipo_casa, _sublote, _iddistrito, NULLIF(_urbanizacion, ""),NULLIF(_latitud, ""), NULLIF(_longitud, ""), NULLIF(perimetro,""), _moneda_venta, _area_terreno, 
						_area_construccion, _area_techada, _airesm2, _zcomunes_porcent, _estacionamiento_nro, _partida_elect, _detalles, _idusuario);
END $$
DELIMITER 

DELIMITER $$
CREATE PROCEDURE spu_set_lots
(
	IN _idlote  		INT,
	IN _imagen			VARCHAR(100),
    IN _idproyecto		INT,
    IN _estado_venta 	VARCHAR(10),
    IN _codigo 			CHAR(5),
    IN _tipo_casa  		CHAR(8),
    IN _sublote 		TINYINT,
    IN _iddistrito 		INT,
    IN _urbanizacion 	VARCHAR(70),
    IN _latitud 		VARCHAR(20),
    IN _longitud		VARCHAR(20),
    IN _perimetro 		JSON,
    IN _moneda_venta 	VARCHAR(10),
    IN _area_terreno	DECIMAL(5,2),
    IN _area_construccion DECIMAL(5,2),
    IN _area_techada	DECIMAL(5,2),
    IN _airesm2 		DECIMAL(5, 2),
    IN _zcomunes_porcent TINYINT,
    IN _estacionamiento_nro TINYINT,
    IN _partida_elect	VARCHAR(100),
	IN _detalles 		JSON,
    IN _idusuario 		INT
)
BEGIN
	UPDATE lotes
		SET
			imagen 			= NULLIF(_imagen, ""),
			idproyecto		= _idproyecto,
			estado_venta 	= _estado_venta,
			codigo			= _codigo,
			tipo_casa		= _tipo_casa,
			sublote			= _sublote,
			iddistrito 		= _iddistrito,
			urbanizacion	= NULLIF(_urbanizacion, ""),
			latitud			= NULLIF(_latitud, ""),
			longitud		= NULLIF(_longitud, ""),
			perimetro		= NULLIF(_perimetro, ""),
			moneda_venta	= _moneda_venta,
			area_terreno 	= _area_terreno,
			area_construccion = _area_construccion,
			area_techada	= _area_techada,
			airesm2			= _airesm2,
			zcomunes_porcent = _zcomunes_porcent,
			estacionamiento_nro =_estacionamiento_nro,
			partida_elect	= _partida_elect,
			detalles		= _detalles,
			idusuario 		= _idusuario,
            update_at		= CURDATE()
		WHERE
			idlote = _idlote;
END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE ()
BEGIN
END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE ()
BEGIN
END$$
DELIMITER ;
