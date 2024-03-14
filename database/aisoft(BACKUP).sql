-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1:3307
<<<<<<< HEAD
-- Tiempo de generación: 14-03-2024 a las 07:22:30
=======
-- Tiempo de generación: 12-03-2024 a las 08:11:35
>>>>>>> ca6099654595b5c98d022d8ed3f87d6dc84c0ba1
-- Versión del servidor: 11.2.2-MariaDB
-- Versión de PHP: 8.2.13

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `aisoft`
--

DELIMITER $$
--
-- Procedimientos
--
DROP PROCEDURE IF EXISTS `set_inactive_contracts`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `set_inactive_contracts` (IN `_idcontrato` INT)   BEGIN
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
END$$

DROP PROCEDURE IF EXISTS `spu_add_clients`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_add_clients` (IN `_nombres` VARCHAR(40), IN `_apellidos` VARCHAR(40), IN `_documento_tipo` VARCHAR(20), IN `_documento_nro` VARCHAR(12), IN `_estado_civil` VARCHAR(20), IN `_iddistrito` INT, IN `_direccion` VARCHAR(70), IN `_idusuario` INT)   BEGIN
	INSERT INTO clientes(nombres, apellidos, documento_tipo, documento_nro, estado_civil, iddistrito, direccion, idusuario)
				VALUES
					(_nombres, _apellidos, _documento_tipo, _documento_nro, _estado_civil, _iddistrito, _direccion, _idusuario);
END$$

DROP PROCEDURE IF EXISTS `spu_add_contracts`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_add_contracts` (IN `_idlote` INT, IN `_idcliente` INT, IN `_idcliente2` INT, IN `_idrepresentante` INT, IN `_idrepresentante2` INT, IN `_precio_total` DECIMAL(8,2), IN `_tipo_cambio` DECIMAL(4,3), IN `_estado` VARCHAR(10), IN `_tipo_contrato` VARCHAR(45), IN `_detalles` JSON, IN `_fecha_contrato` DATE, IN `_idusuario` INT)   BEGIN
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
END$$

DROP PROCEDURE IF EXISTS `spu_add_houses`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_add_houses` (IN `_idlote` INT, IN `_imagen` VARCHAR(100), IN `_tipo_casa` CHAR(8), IN `_area_construccion` DECIMAL(5,2), IN `_area_techada` DECIMAL(5,2), IN `_airesm2` DECIMAL(5,2), IN `_zcomunes_porcent` TINYINT, IN `_estacionamiento_nro` TINYINT, IN `_detalles` JSON, IN `_idusuario` INT)   BEGIN
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
END$$

DROP PROCEDURE IF EXISTS `spu_add_lots`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_add_lots` (IN `_idproyecto` INT, IN `_estado_venta` VARCHAR(10), IN `_codigo` CHAR(5), IN `_sublote` TINYINT, IN `_urbanizacion` VARCHAR(70), IN `_latitud` VARCHAR(20), IN `_longitud` VARCHAR(20), IN `_perimetro` JSON, IN `_moneda_venta` VARCHAR(10), IN `_area_terreno` DECIMAL(5,2), IN `_partida_elect` VARCHAR(100), IN `_idusuario` INT)   BEGIN
	INSERT INTO lotes ( idproyecto, estado_venta, codigo, sublote, urbanizacion, latitud, longitud, perimetro, moneda_venta, area_terreno, 
						partida_elect, idusuario)
			VALUES
				(_idproyecto, _estado_venta, _codigo, _sublote, NULLIF(_urbanizacion, ""),NULLIF(_latitud, ""), NULLIF(_longitud, ""), NULLIF(perimetro,""), _moneda_venta, _area_terreno, 
                _partida_elect, _idusuario);
END$$

DROP PROCEDURE IF EXISTS `spu_add_projects`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_add_projects` (IN `_imagen` VARCHAR(100), IN `_iddireccion` INT, IN `_codigo` VARCHAR(20), IN `_denominacion` VARCHAR(30), IN `_latitud` VARCHAR(20), IN `_longitud` VARCHAR(20), IN `_perimetro` JSON, IN `_iddistrito` INT, IN `_direccion` VARCHAR(70), IN `_idusuario` INT)   BEGIN
	INSERT INTO proyectos(imagen, iddireccion, codigo, denominacion, latitud, longitud, perimetro, iddistrito, direccion, idusuario)
			VALUES
				(NULLIF(_imagen,""), _iddireccion, _codigo, _denominacion, NULLIF(_latitud, ""), NULLIF(_longitud, ""), NULLIF(_perimetro, ""), _iddistrito, _direccion, _idusuario);
END$$

DROP PROCEDURE IF EXISTS `spu_inactive_houses`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_inactive_houses` (IN `_idvivienda` INT)   BEGIN
	
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
END$$

DROP PROCEDURE IF EXISTS `spu_inactive_list_short`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_inactive_list_short` ()   BEGIN
	SELECT * FROM vws_list_inactive_lots_short;
END$$

DROP PROCEDURE IF EXISTS `spu_inactive_list_short_by_code`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_inactive_list_short_by_code` (IN `_codigo` CHAR(5))   BEGIN
	SELECT * 
		FROM vws_list_inactive_lots_short
        WHERE codigo LIKE CONCAT(_codigo,"%");
END$$

DROP PROCEDURE IF EXISTS `spu_inactive_lots`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_inactive_lots` (IN `_idlote` INT)   BEGIN
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

DROP PROCEDURE IF EXISTS `spu_inactive_projects`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_inactive_projects` (IN `_idproyecto` INT)   BEGIN
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
END$$

DROP PROCEDURE IF EXISTS `spu_inactve_clients`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_inactve_clients` (IN `_idcliente` INT)   BEGIN
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
END$$

DROP PROCEDURE IF EXISTS `spu_list_addresses`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_list_addresses` ()   BEGIN
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
END$$

DROP PROCEDURE IF EXISTS `spu_list_addresses_ruc`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_list_addresses_ruc` (IN `_ruc` VARCHAR(11))   BEGIN
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
END$$

DROP PROCEDURE IF EXISTS `spu_list_clients`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_list_clients` ()   BEGIN
	SELECT * FROM vws_list_clients;
END$$

DROP PROCEDURE IF EXISTS `spu_list_clients_by_docNro`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_list_clients_by_docNro` (IN `_documento_nro` VARCHAR(12))   BEGIN
	SELECT * FROM vws_list_clients
    WHERE documento_nro LIKE CONCAT("%",_documento_nro, "%");
END$$

DROP PROCEDURE IF EXISTS `spu_list_companies`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_list_companies` ()   BEGIN
	SELECT * FROM vws_list_companies
    ORDER BY 2;
END$$

DROP PROCEDURE IF EXISTS `spu_list_companies_ruc`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_list_companies_ruc` (IN `_ruc` VARCHAR(11))   BEGIN
	SELECT * FROM vws_list_companies
    WHERE ruc LIKE CONCAT(_ruc, "%")
    ORDER BY 2;
END$$

DROP PROCEDURE IF EXISTS `spu_list_contracts_short`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_list_contracts_short` ()   BEGIN
	SELECT * FROM vws_list_contracts_short;
END$$

DROP PROCEDURE IF EXISTS `spu_list_departaments`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_list_departaments` ()   BEGIN
	SELECT * FROM departamentos
    ORDER BY 2 ASC;
END$$

DROP PROCEDURE IF EXISTS `spu_list_districts`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_list_districts` (IN `_idprovincia` INT)   BEGIN
	SELECT * 
    FROM distritos
    WHERE idprovincia = _idprovincia
    ORDER BY 3 ASC;
END$$

DROP PROCEDURE IF EXISTS `spu_list_drop_projects`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_list_drop_projects` ()   BEGIN
	SELECT * FROM vws_list_drop_projects;
END$$

DROP PROCEDURE IF EXISTS `spu_list_drop_projects_by_code`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_list_drop_projects_by_code` (IN `_codigo` VARCHAR(20))   BEGIN
		SELECT * FROM vws_list_drop_projects
        WHERE codigo LIKE CONCAT("%", _codigo,"%");
END$$

DROP PROCEDURE IF EXISTS `spu_list_inactive_clients`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_list_inactive_clients` ()   BEGIN
	SELECT * FROM vws_list_inactive_clients;
END$$

DROP PROCEDURE IF EXISTS `spu_list_inactive_contracts_short`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_list_inactive_contracts_short` ()   BEGIN
	SELECT * FROM vws_list_inactive_contracts_short;
END$$

DROP PROCEDURE IF EXISTS `spu_list_lots_by_id`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_list_lots_by_id` (IN `_idlote` INT)   BEGIN
	SELECT * FROM vws_list_lots
    WHERE idlote = _idlote;
END$$

DROP PROCEDURE IF EXISTS `spu_list_lots_short`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_list_lots_short` ()   BEGIN
	SELECT * FROM vws_list_lots_short;
END$$

DROP PROCEDURE IF EXISTS `spu_list_lots_short_by_code`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_list_lots_short_by_code` (IN `_codigo` CHAR(5))   BEGIN
	SELECT * 
		FROM vws_list_lots_short
        WHERE codigo LIKE CONCAT(_codigo,"%");
END$$

DROP PROCEDURE IF EXISTS `spu_list_projects`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_list_projects` ()   BEGIN
	SELECT * FROM vws_list_projects;
END$$

DROP PROCEDURE IF EXISTS `spu_list_projects_by_code`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_list_projects_by_code` (IN `_codigo` VARCHAR(20))   BEGIN
		SELECT * FROM vws_list_projects
        WHERE codigo LIKE CONCAT("%", _codigo,"%");
END$$

DROP PROCEDURE IF EXISTS `spu_list_provinces`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_list_provinces` (IN `_iddepartamento` INT)   BEGIN
	SELECT * 
    FROM provincias 
    WHERE iddepartamento = _iddepartamento
    ORDER BY 3 ASC;
END$$

DROP PROCEDURE IF EXISTS `spu_lits_contracts_full_by_id`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_lits_contracts_full_by_id` (IN `_idcontrato` INT)   BEGIN
	SELECT * 
		FROM vws_list_contracts_full
        WHERE idcontrato = _idcontrato;
END$$

DROP PROCEDURE IF EXISTS `spu_lits_contracts_short_by_code`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_lits_contracts_short_by_code` (IN `_codigo` VARCHAR(5))   BEGIN
		SELECT * 
			FROM vws_list_contracts_short
			WHERE codigo LIKE CONCAT(_codigo,"%");
END$$

DROP PROCEDURE IF EXISTS `spu_resotres_contracts`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_resotres_contracts` (IN `_idcontrato` INT)   BEGIN
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
END$$

DROP PROCEDURE IF EXISTS `spu_restore_clientes`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_restore_clientes` (IN `_idcliente` INT)   BEGIN
	UPDATE clientes
		SET
			inactive_at = NULL ,
            update_at 	= CURDATE()
		WHERE
			idcliente = _idcliente;
END$$

DROP PROCEDURE IF EXISTS `spu_restore_houses`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_restore_houses` (IN `_idvivienda` INT)   BEGIN
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
END$$

DROP PROCEDURE IF EXISTS `spu_restore_lotes`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_restore_lotes` (IN `_idlote` INT)   BEGIN
	UPDATE lotes
		SET 
			inactive_at = NULL,
            update_at 	= CURDATE()
		WHERE idlote = _idlote;
END$$

DROP PROCEDURE IF EXISTS `spu_restore_projects`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_restore_projects` (IN `_idproyecto` INT)   BEGIN
	UPDATE proyectos
		SET
			inactive_at = NULL,
            update_at = CURDATE()
			WHERE
				idproyecto = _idproyecto;
END$$

DROP PROCEDURE IF EXISTS `spu_set_clients`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_set_clients` (IN `_idcliente` INT, IN `_nombres` VARCHAR(40), IN `_apellidos` VARCHAR(40), IN `_documento_tipo` VARCHAR(20), IN `_documento_nro` VARCHAR(12), IN `_estado_civil` VARCHAR(20), IN `_iddistrito` INT, IN `_direccion` VARCHAR(70), IN `_idusuario` INT)   BEGIN
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
END$$

DROP PROCEDURE IF EXISTS `spu_set_contracts`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_set_contracts` (IN `_idcontrato` INT, IN `_idlote` INT, IN `_idcliente` INT, IN `_idcliente2` INT, IN `_idrepresentante` INT, IN `_idrepresentante2` INT, IN `_precio_total` DECIMAL(8,2), IN `_tipo_cambio` DECIMAL(4,3), IN `_estado` VARCHAR(10), IN `_tipo_contrato` VARCHAR(45), IN `_detalles` JSON, IN `_fecha_contrato` DATE, IN `_idusuario` INT)   BEGIN
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
END$$

DROP PROCEDURE IF EXISTS `spu_set_houses`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_set_houses` (IN `_idvivienda` INT, IN `_idlote` INT, IN `_imagen` VARCHAR(100), IN `_tipo_casa` CHAR(8), IN `_area_construccion` DECIMAL(5,2), IN `_area_techada` DECIMAL(5,2), IN `_airesm2` DECIMAL(5,2), IN `_zcomunes_porcent` TINYINT, IN `_estacionamiento_nro` TINYINT, IN `_detalles` JSON, IN `_idusuario` INT)   BEGIN
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
END$$

DROP PROCEDURE IF EXISTS `spu_set_lots`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_set_lots` (IN `_idlote` INT, IN `_idproyecto` INT, IN `_estado_venta` VARCHAR(10), IN `_codigo` CHAR(5), IN `_sublote` TINYINT, IN `_urbanizacion` VARCHAR(70), IN `_latitud` VARCHAR(20), IN `_longitud` VARCHAR(20), IN `_perimetro` JSON, IN `_moneda_venta` VARCHAR(10), IN `_area_terreno` DECIMAL(5,2), IN `_partida_elect` VARCHAR(100), IN `_idusuario` INT)   BEGIN
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

DROP PROCEDURE IF EXISTS `spu_set_projects`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_set_projects` (IN `_idproyecto` INT, IN `_imagen` VARCHAR(100), IN `_iddireccion` INT, IN `_codigo` VARCHAR(20), IN `_denominacion` VARCHAR(30), IN `_latitud` VARCHAR(20), IN `_longitud` VARCHAR(20), IN `_perimetro` JSON, IN `_iddistrito` INT, IN `_direccion` VARCHAR(70), IN `_idusuario` INT)   BEGIN
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
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clientes`
--

DROP TABLE IF EXISTS `clientes`;
CREATE TABLE IF NOT EXISTS `clientes` (
  `idcliente` int(11) NOT NULL AUTO_INCREMENT,
  `nombres` varchar(40) NOT NULL,
  `apellidos` varchar(40) NOT NULL,
  `documento_tipo` varchar(20) NOT NULL,
  `documento_nro` varchar(12) NOT NULL,
  `estado_civil` varchar(20) NOT NULL,
  `iddistrito` int(11) NOT NULL,
  `direccion` varchar(70) NOT NULL,
  `create_at` date NOT NULL DEFAULT curdate(),
  `update_at` date DEFAULT NULL,
  `inactive_at` date DEFAULT NULL,
  `idusuario` int(11) NOT NULL,
  PRIMARY KEY (`idcliente`),
  UNIQUE KEY `uk_documento_nro_cli` (`documento_nro`),
  KEY `fk_iddistrito_cli` (`iddistrito`),
  KEY `fk_idusuario_cli` (`idusuario`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Volcado de datos para la tabla `clientes`
--

INSERT INTO `clientes` (`idcliente`, `nombres`, `apellidos`, `documento_tipo`, `documento_nro`, `estado_civil`, `iddistrito`, `direccion`, `create_at`, `update_at`, `inactive_at`, `idusuario`) VALUES
(1, 'Juan Carlos', 'Pérez García', 'DNI', '12345678', 'Soltero', 1007, 'Av. Primavera 123', '2024-03-13', NULL, NULL, 1),
(2, 'María Luisa', 'Gómez Fernández', 'DNI', '23456789', 'Casada', 1007, 'Calle Flores 456', '2024-03-13', NULL, NULL, 2),
(3, 'Pedro José', 'Ramírez Sánchez', 'DNI', '34567890', 'Soltero', 1007, 'Jr. Libertad 789', '2024-03-13', '2024-03-14', NULL, 3),
(4, 'Juan Carlos', ' Perez Gomez', 'DNI', '77345678', 'Soltero', 1, 'Calle 123', '2024-03-14', NULL, NULL, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `contratos`
--

DROP TABLE IF EXISTS `contratos`;
CREATE TABLE IF NOT EXISTS `contratos` (
  `idcontrato` int(11) NOT NULL AUTO_INCREMENT,
  `idlote` int(11) NOT NULL,
  `idcliente` int(11) NOT NULL,
  `idcliente2` int(11) DEFAULT NULL,
  `idrepresentante` int(11) NOT NULL,
  `idrepresentante2` int(11) DEFAULT NULL,
  `precio_total` decimal(8,2) NOT NULL,
  `tipo_cambio` decimal(4,3) NOT NULL,
  `estado` varchar(10) NOT NULL,
  `tipo_contrato` varchar(45) NOT NULL,
  `detalles` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`detalles`)),
  `fecha_contrato` date NOT NULL,
  `create_at` date NOT NULL DEFAULT curdate(),
  `update_at` date DEFAULT NULL,
  `inactive_at` date DEFAULT NULL,
  `idusuario` int(11) NOT NULL,
  PRIMARY KEY (`idcontrato`),
  UNIQUE KEY `uk_cliente_lote_contra` (`idlote`,`idcliente`),
  KEY `fk_idcliente_cont` (`idcliente`),
  KEY `fk_idcliente2_cont` (`idcliente2`),
  KEY `fk_idrepresentante_cont` (`idrepresentante`),
  KEY `fk_idrepresentante2_cont` (`idrepresentante2`),
  KEY `fk_idusuario_cont` (`idusuario`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Volcado de datos para la tabla `contratos`
--

INSERT INTO `contratos` (`idcontrato`, `idlote`, `idcliente`, `idcliente2`, `idrepresentante`, `idrepresentante2`, `precio_total`, `tipo_cambio`, `estado`, `tipo_contrato`, `detalles`, `fecha_contrato`, `create_at`, `update_at`, `inactive_at`, `idusuario`) VALUES
(1, 1, 1, NULL, 1, NULL, 150000.00, 3.500, 'VIGENTE', 'FINANCIAMIENTO', '{\"cuota_inicial\":5000.00,\"bono\":1500.00,\"financiamiento\":8000.00,\"plazo_entrega\":\"2024-12-31\",\"penalidad_moneda\":\"USD\",\"penalidad_periodo\":\"mensual\",\"penalidad\":100.00}', '2024-03-10', '2024-03-13', NULL, NULL, 1),
(2, 2, 2, NULL, 2, NULL, 120000.00, 3.500, 'VIGENTE', 'FINANCIAMIENTO', '{\"cuota_inicial\":5000.00,\"bono\":1500.00,\"financiamiento\":8000.00,\"plazo_entrega\":\"2024-12-31\",\"penalidad_moneda\":\"USD\",\"penalidad_periodo\":\"mensual\",\"penalidad\":100.00}', '2024-03-11', '2024-03-13', NULL, NULL, 2),
(3, 3, 3, NULL, 3, NULL, 135000.00, 3.500, 'DEVOLUCIÓN', 'FINANCIAMIENTO', '{\"cuota_inicial\":5000.00,\"bono\":1500.00,\"financiamiento\":8000.00,\"plazo_entrega\":\"2024-12-31\",\"penalidad_moneda\":\"USD\",\"penalidad_periodo\":\"mensual\",\"penalidad\":100.00}', '2024-03-12', '2024-03-13', NULL, '2024-03-14', 3),
(4, 4, 1, NULL, 4, NULL, 145000.00, 3.500, 'VIGENTE', 'FINANCIAMIENTO', '{\"cuota_inicial\":5000.00,\"bono\":1500.00,\"financiamiento\":8000.00,\"plazo_entrega\":\"2024-12-31\",\"penalidad_moneda\":\"USD\",\"penalidad_periodo\":\"mensual\",\"penalidad\":100.00}', '2024-03-13', '2024-03-13', NULL, NULL, 4),
(5, 5, 2, NULL, 5, NULL, 160000.00, 3.500, 'VIGENTE', 'FINANCIAMIENTO', '{\"cuota_inicial\":5000.00,\"bono\":1500.00,\"financiamiento\":8000.00,\"plazo_entrega\":\"2024-12-31\",\"penalidad_moneda\":\"USD\",\"penalidad_periodo\":\"mensual\",\"penalidad\":100.00}', '2024-03-14', '2024-03-13', NULL, NULL, 5),
(7, 3, 1, NULL, 2, NULL, 50000.00, 3.500, 'ACTIVO', 'VENTA', '{\"detalle\": \"Información adicional\", \"detalles construccion\":\"varios\"}', '2024-03-15', '2024-03-14', '2024-03-14', NULL, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cuotas`
--

DROP TABLE IF EXISTS `cuotas`;
CREATE TABLE IF NOT EXISTS `cuotas` (
  `idcuota` int(11) NOT NULL AUTO_INCREMENT,
  `idcontrato` int(11) NOT NULL,
  `monto_cuota` decimal(8,2) NOT NULL,
  `fecha_vencimiento` date NOT NULL,
  `fecha_pago` date DEFAULT NULL,
  `detalles` varchar(100) DEFAULT NULL,
  `tipo_pago` varchar(20) DEFAULT NULL,
  `entidad_bancaria` varchar(20) DEFAULT NULL,
  `create_at` date NOT NULL DEFAULT curdate(),
  `update_at` date DEFAULT NULL,
  `inactive_at` date DEFAULT NULL,
  `idusuario` int(11) NOT NULL,
  PRIMARY KEY (`idcuota`),
  KEY `fk_idcontrato_cuotas` (`idcontrato`),
  KEY `fk_idusuario_cuotas` (`idusuario`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Volcado de datos para la tabla `cuotas`
--

INSERT INTO `cuotas` (`idcuota`, `idcontrato`, `monto_cuota`, `fecha_vencimiento`, `fecha_pago`, `detalles`, `tipo_pago`, `entidad_bancaria`, `create_at`, `update_at`, `inactive_at`, `idusuario`) VALUES
(1, 1, 500.00, '2024-03-10', NULL, NULL, NULL, NULL, '2024-03-13', NULL, NULL, 1),
(2, 1, 500.00, '2024-04-10', NULL, NULL, NULL, NULL, '2024-03-13', NULL, NULL, 1),
(3, 2, 500.00, '2024-03-18', NULL, NULL, NULL, NULL, '2024-03-13', NULL, NULL, 1),
(4, 2, 500.00, '2024-04-13', NULL, NULL, NULL, NULL, '2024-03-13', NULL, NULL, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `departamentos`
--

DROP TABLE IF EXISTS `departamentos`;
CREATE TABLE IF NOT EXISTS `departamentos` (
  `iddepartamento` int(11) NOT NULL AUTO_INCREMENT,
  `departamento` varchar(45) NOT NULL,
  PRIMARY KEY (`iddepartamento`),
  UNIQUE KEY `uk_departamento_deps` (`departamento`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Volcado de datos para la tabla `departamentos`
--

INSERT INTO `departamentos` (`iddepartamento`, `departamento`) VALUES
(1, 'Amazonas'),
(2, 'Áncash'),
(3, 'Apurímac'),
(4, 'Arequipa'),
(5, 'Ayacucho'),
(6, 'Cajamarca'),
(7, 'Callao'),
(8, 'Cusco'),
(9, 'Huancavelica'),
(10, 'Huánuco'),
(11, 'Ica'),
(12, 'Junín'),
(13, 'La Libertad'),
(14, 'Lambayeque'),
(15, 'Lima'),
(16, 'Loreto'),
(17, 'Madre de Dios'),
(18, 'Moquegua'),
(19, 'Pasco'),
(20, 'Piura'),
(21, 'Puno'),
(22, 'San Martín'),
(23, 'Tacna'),
(24, 'Tumbes'),
(25, 'Ucayali');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `desembolsos`
--

DROP TABLE IF EXISTS `desembolsos`;
CREATE TABLE IF NOT EXISTS `desembolsos` (
  `iddesembolso` int(11) NOT NULL AUTO_INCREMENT,
  `idfinanciera` int(11) NOT NULL,
  `idlote` int(11) NOT NULL,
  `monto_desemb` decimal(8,2) NOT NULL,
  `porcentaje` tinyint(4) NOT NULL,
  `fecha_desembolso` datetime NOT NULL,
  `create_at` date NOT NULL DEFAULT curdate(),
  `update_at` date DEFAULT NULL,
  `inactive_at` date DEFAULT NULL,
  `idusuario` int(11) NOT NULL,
  PRIMARY KEY (`iddesembolso`),
  KEY `fk_idfinanciera_desemb` (`idfinanciera`),
  KEY `fk_idlote_desemb` (`idlote`),
  KEY `fk_idusuario_desemb` (`idusuario`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Volcado de datos para la tabla `desembolsos`
--

INSERT INTO `desembolsos` (`iddesembolso`, `idfinanciera`, `idlote`, `monto_desemb`, `porcentaje`, `fecha_desembolso`, `create_at`, `update_at`, `inactive_at`, `idusuario`) VALUES
(1, 1, 2, 5000.00, 10, '2024-03-13 21:31:02', '2024-03-13', NULL, NULL, 1),
(2, 2, 5, 7000.00, 15, '2024-03-13 21:31:02', '2024-03-13', NULL, NULL, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_gastos`
--

DROP TABLE IF EXISTS `detalle_gastos`;
CREATE TABLE IF NOT EXISTS `detalle_gastos` (
  `iddetalle_gasto` int(11) NOT NULL AUTO_INCREMENT,
  `idpresupuesto` int(11) NOT NULL,
  `tipo_gasto` varchar(20) NOT NULL,
  `nombre_gasto` varchar(40) NOT NULL,
  `descripcion` varchar(100) NOT NULL,
  `cantidad` tinyint(4) NOT NULL,
  `precio_unitario` decimal(8,2) NOT NULL,
  `create_at` date NOT NULL DEFAULT curdate(),
  `update_at` date DEFAULT NULL,
  `inactive_at` date DEFAULT NULL,
  `idusuario` int(11) NOT NULL,
  PRIMARY KEY (`iddetalle_gasto`),
  KEY `fk_idpresupuesto_dtgastos` (`idpresupuesto`),
  KEY `fk_idusuario_dtgastos` (`idusuario`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Volcado de datos para la tabla `detalle_gastos`
--

INSERT INTO `detalle_gastos` (`iddetalle_gasto`, `idpresupuesto`, `tipo_gasto`, `nombre_gasto`, `descripcion`, `cantidad`, `precio_unitario`, `create_at`, `update_at`, `inactive_at`, `idusuario`) VALUES
(1, 1, 'COSTO DIRECTO', 'Materiales de construcción', 'Compra de ladrillos', 100, 0.50, '2024-03-13', NULL, NULL, 1),
(2, 1, 'COSTO INDIRECTO', 'Gastos administrativos', 'Alquiler de oficina', 1, 300.00, '2024-03-13', NULL, NULL, 1),
(3, 1, 'COSTO DIRECTO', 'Materiales de construcción', 'Compra de cemento', 50, 8.00, '2024-03-13', NULL, NULL, 1),
(4, 1, 'COSTO INDIRECTO', 'Gastos administrativos', 'Pago de servicios', 1, 150.00, '2024-03-13', NULL, NULL, 1),
(5, 2, 'COSTO DIRECTO', 'Pago de mano de obra', 'Jornal de albañiles', 5, 50.00, '2024-03-13', NULL, NULL, 1),
(6, 2, 'COSTO INDIRECTO', 'Accesorios de baño', 'Compra de grifería', 3, 120.00, '2024-03-13', NULL, NULL, 1),
(7, 2, 'COSTO DIRECTO', 'Pago de mano de obra', 'Jornal de carpinteros', 3, 60.00, '2024-03-13', NULL, NULL, 1),
(8, 2, 'COSTO INDIRECTO', 'Gastos de supervisión', 'Honorarios de arquitecto', 1, 500.00, '2024-03-13', NULL, NULL, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `direcciones`
--

DROP TABLE IF EXISTS `direcciones`;
CREATE TABLE IF NOT EXISTS `direcciones` (
  `iddireccion` int(11) NOT NULL AUTO_INCREMENT,
  `idempresa` int(11) NOT NULL,
  `iddistrito` int(11) NOT NULL,
  `direccion` varchar(70) NOT NULL,
  `referencia` varchar(45) DEFAULT NULL,
  `create_at` date NOT NULL DEFAULT curdate(),
  `update_at` date DEFAULT NULL,
  `inactive_at` date DEFAULT NULL,
  PRIMARY KEY (`iddireccion`),
  KEY `fk_idempresa_direccs` (`idempresa`),
  KEY `fk_iddistrito_direccs` (`iddistrito`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Volcado de datos para la tabla `direcciones`
--

INSERT INTO `direcciones` (`iddireccion`, `idempresa`, `iddistrito`, `direccion`, `referencia`, `create_at`, `update_at`, `inactive_at`) VALUES
(1, 1, 1007, 'MZA. A LOTE. 06 URB. JULIO ARBOLEDA', 'A 1/2 CUADRA DE MAESTRO', '2024-03-13', NULL, NULL),
(2, 1, 1009, 'AV. LOS ALAMOS MZA. C LOTE. 25 URB. EL ROSAL', 'FRENTE AL PARQUE', '2024-03-13', NULL, NULL),
(3, 1, 1010, 'CALLE LOS GIRASOLES MZA. E LOTE. 10 URB. LAS MARGARITAS', 'A 200 METROS DE LA AVENIDA PRINCIPAL', '2024-03-13', NULL, NULL),
(4, 2, 1008, 'MZA. A LOTE. 06 URB. JULIO ARBOLEDA', 'A 1/2 CUADRA DE MAESTRO', '2024-03-13', NULL, NULL),
(5, 2, 1010, 'AV. LOS ALAMOS MZA. C LOTE. 25 URB. EL ROSAL', 'FRENTE AL PARQUE', '2024-03-13', NULL, NULL),
(6, 2, 1011, 'CALLE LOS GIRASOLES MZA. E LOTE. 10 URB. LAS MARGARITAS', 'A 200 METROS DE LA AVENIDA PRINCIPAL', '2024-03-13', NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `distritos`
--

DROP TABLE IF EXISTS `distritos`;
CREATE TABLE IF NOT EXISTS `distritos` (
  `iddistrito` int(11) NOT NULL AUTO_INCREMENT,
  `idprovincia` int(11) NOT NULL,
  `distrito` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`iddistrito`),
  KEY `fk_idprovincia_distr` (`idprovincia`)
) ENGINE=InnoDB AUTO_INCREMENT=1875 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Volcado de datos para la tabla `distritos`
--

INSERT INTO `distritos` (`iddistrito`, `idprovincia`, `distrito`) VALUES
(1, 1, 'Chachapoyas'),
(2, 1, 'Asunción'),
(3, 1, 'Balsas'),
(4, 1, 'Cheto'),
(5, 1, 'Chiliquin'),
(6, 1, 'Chuquibamba'),
(7, 1, 'Granada'),
(8, 1, 'Huancas'),
(9, 1, 'La Jalca'),
(10, 1, 'Leimebamba'),
(11, 1, 'Levanto'),
(12, 1, 'Magdalena'),
(13, 1, 'Mariscal Castilla'),
(14, 1, 'Molinopampa'),
(15, 1, 'Montevideo'),
(16, 1, 'Olleros'),
(17, 1, 'Quinjalca'),
(18, 1, 'San Francisco de Daguas'),
(19, 1, 'San Isidro de Maino'),
(20, 1, 'Soloco'),
(21, 1, 'Sonche'),
(22, 2, 'Bagua'),
(23, 2, 'Aramango'),
(24, 2, 'Copallin'),
(25, 2, 'El Parco'),
(26, 2, 'Imaza'),
(27, 2, 'La Peca'),
(28, 3, 'Jumbilla'),
(29, 3, 'Chisquilla'),
(30, 3, 'Churuja'),
(31, 3, 'Corosha'),
(32, 3, 'Cuispes'),
(33, 3, 'Florida'),
(34, 3, 'Jazan'),
(35, 3, 'Recta'),
(36, 3, 'San Carlos'),
(37, 3, 'Shipasbamba'),
(38, 3, 'Valera'),
(39, 3, 'Yambrasbamba'),
(40, 4, 'Nieva'),
(41, 4, 'El Cenepa'),
(42, 4, 'Río Santiago'),
(43, 5, 'Lamud'),
(44, 5, 'Camporredondo'),
(45, 5, 'Cocabamba'),
(46, 5, 'Colcamar'),
(47, 5, 'Conila'),
(48, 5, 'Inguilpata'),
(49, 5, 'Longuita'),
(50, 5, 'Lonya Chico'),
(51, 5, 'Luya'),
(52, 5, 'Luya Viejo'),
(53, 5, 'María'),
(54, 5, 'Ocalli'),
(55, 5, 'Ocumal'),
(56, 5, 'Pisuquia'),
(57, 5, 'Providencia'),
(58, 5, 'San Cristóbal'),
(59, 5, 'San Francisco de Yeso'),
(60, 5, 'San Jerónimo'),
(61, 5, 'San Juan de Lopecancha'),
(62, 5, 'Santa Catalina'),
(63, 5, 'Santo Tomas'),
(64, 5, 'Tingo'),
(65, 5, 'Trita'),
(66, 6, 'San Nicolás'),
(67, 6, 'Chirimoto'),
(68, 6, 'Cochamal'),
(69, 6, 'Huambo'),
(70, 6, 'Limabamba'),
(71, 6, 'Longar'),
(72, 6, 'Mariscal Benavides'),
(73, 6, 'Milpuc'),
(74, 6, 'Omia'),
(75, 6, 'Santa Rosa'),
(76, 6, 'Totora'),
(77, 6, 'Vista Alegre'),
(78, 7, 'Bagua Grande'),
(79, 7, 'Cajaruro'),
(80, 7, 'Cumba'),
(81, 7, 'El Milagro'),
(82, 7, 'Jamalca'),
(83, 7, 'Lonya Grande'),
(84, 7, 'Yamon'),
(85, 8, 'Huaraz'),
(86, 8, 'Cochabamba'),
(87, 8, 'Colcabamba'),
(88, 8, 'Huanchay'),
(89, 8, 'Independencia'),
(90, 8, 'Jangas'),
(91, 8, 'La Libertad'),
(92, 8, 'Olleros'),
(93, 8, 'Pampas Grande'),
(94, 8, 'Pariacoto'),
(95, 8, 'Pira'),
(96, 8, 'Tarica'),
(97, 9, 'Aija'),
(98, 9, 'Coris'),
(99, 9, 'Huacllan'),
(100, 9, 'La Merced'),
(101, 9, 'Succha'),
(102, 10, 'Llamellin'),
(103, 10, 'Aczo'),
(104, 10, 'Chaccho'),
(105, 10, 'Chingas'),
(106, 10, 'Mirgas'),
(107, 10, 'San Juan de Rontoy'),
(108, 11, 'Chacas'),
(109, 11, 'Acochaca'),
(110, 12, 'Chiquian'),
(111, 12, 'Abelardo Pardo Lezameta'),
(112, 12, 'Antonio Raymondi'),
(113, 12, 'Aquia'),
(114, 12, 'Cajacay'),
(115, 12, 'Canis'),
(116, 12, 'Colquioc'),
(117, 12, 'Huallanca'),
(118, 12, 'Huasta'),
(119, 12, 'Huayllacayan'),
(120, 12, 'La Primavera'),
(121, 12, 'Mangas'),
(122, 12, 'Pacllon'),
(123, 12, 'San Miguel de Corpanqui'),
(124, 12, 'Ticllos'),
(125, 13, 'Carhuaz'),
(126, 13, 'Acopampa'),
(127, 13, 'Amashca'),
(128, 13, 'Anta'),
(129, 13, 'Ataquero'),
(130, 13, 'Marcara'),
(131, 13, 'Pariahuanca'),
(132, 13, 'San Miguel de Aco'),
(133, 13, 'Shilla'),
(134, 13, 'Tinco'),
(135, 13, 'Yungar'),
(136, 14, 'San Luis'),
(137, 14, 'San Nicolás'),
(138, 14, 'Yauya'),
(139, 15, 'Casma'),
(140, 15, 'Buena Vista Alta'),
(141, 15, 'Comandante Noel'),
(142, 15, 'Yautan'),
(143, 16, 'Corongo'),
(144, 16, 'Aco'),
(145, 16, 'Bambas'),
(146, 16, 'Cusca'),
(147, 16, 'La Pampa'),
(148, 16, 'Yanac'),
(149, 16, 'Yupan'),
(150, 17, 'Huari'),
(151, 17, 'Anra'),
(152, 17, 'Cajay'),
(153, 17, 'Chavin de Huantar'),
(154, 17, 'Huacachi'),
(155, 17, 'Huacchis'),
(156, 17, 'Huachis'),
(157, 17, 'Huantar'),
(158, 17, 'Masin'),
(159, 17, 'Paucas'),
(160, 17, 'Ponto'),
(161, 17, 'Rahuapampa'),
(162, 17, 'Rapayan'),
(163, 17, 'San Marcos'),
(164, 17, 'San Pedro de Chana'),
(165, 17, 'Uco'),
(166, 18, 'Huarmey'),
(167, 18, 'Cochapeti'),
(168, 18, 'Culebras'),
(169, 18, 'Huayan'),
(170, 18, 'Malvas'),
(171, 19, 'Caraz'),
(172, 19, 'Huallanca'),
(173, 19, 'Huata'),
(174, 19, 'Huaylas'),
(175, 19, 'Mato'),
(176, 19, 'Pamparomas'),
(177, 19, 'Pueblo Libre'),
(178, 19, 'Santa Cruz'),
(179, 19, 'Santo Toribio'),
(180, 19, 'Yuracmarca'),
(181, 20, 'Piscobamba'),
(182, 20, 'Casca'),
(183, 20, 'Eleazar Guzmán Barron'),
(184, 20, 'Fidel Olivas Escudero'),
(185, 20, 'Llama'),
(186, 20, 'Llumpa'),
(187, 20, 'Lucma'),
(188, 20, 'Musga'),
(189, 21, 'Ocros'),
(190, 21, 'Acas'),
(191, 21, 'Cajamarquilla'),
(192, 21, 'Carhuapampa'),
(193, 21, 'Cochas'),
(194, 21, 'Congas'),
(195, 21, 'Llipa'),
(196, 21, 'San Cristóbal de Rajan'),
(197, 21, 'San Pedro'),
(198, 21, 'Santiago de Chilcas'),
(199, 22, 'Cabana'),
(200, 22, 'Bolognesi'),
(201, 22, 'Conchucos'),
(202, 22, 'Huacaschuque'),
(203, 22, 'Huandoval'),
(204, 22, 'Lacabamba'),
(205, 22, 'Llapo'),
(206, 22, 'Pallasca'),
(207, 22, 'Pampas'),
(208, 22, 'Santa Rosa'),
(209, 22, 'Tauca'),
(210, 23, 'Pomabamba'),
(211, 23, 'Huayllan'),
(212, 23, 'Parobamba'),
(213, 23, 'Quinuabamba'),
(214, 24, 'Recuay'),
(215, 24, 'Catac'),
(216, 24, 'Cotaparaco'),
(217, 24, 'Huayllapampa'),
(218, 24, 'Llacllin'),
(219, 24, 'Marca'),
(220, 24, 'Pampas Chico'),
(221, 24, 'Pararin'),
(222, 24, 'Tapacocha'),
(223, 24, 'Ticapampa'),
(224, 25, 'Chimbote'),
(225, 25, 'Cáceres del Perú'),
(226, 25, 'Coishco'),
(227, 25, 'Macate'),
(228, 25, 'Moro'),
(229, 25, 'Nepeña'),
(230, 25, 'Samanco'),
(231, 25, 'Santa'),
(232, 25, 'Nuevo Chimbote'),
(233, 26, 'Sihuas'),
(234, 26, 'Acobamba'),
(235, 26, 'Alfonso Ugarte'),
(236, 26, 'Cashapampa'),
(237, 26, 'Chingalpo'),
(238, 26, 'Huayllabamba'),
(239, 26, 'Quiches'),
(240, 26, 'Ragash'),
(241, 26, 'San Juan'),
(242, 26, 'Sicsibamba'),
(243, 27, 'Yungay'),
(244, 27, 'Cascapara'),
(245, 27, 'Mancos'),
(246, 27, 'Matacoto'),
(247, 27, 'Quillo'),
(248, 27, 'Ranrahirca'),
(249, 27, 'Shupluy'),
(250, 27, 'Yanama'),
(251, 28, 'Abancay'),
(252, 28, 'Chacoche'),
(253, 28, 'Circa'),
(254, 28, 'Curahuasi'),
(255, 28, 'Huanipaca'),
(256, 28, 'Lambrama'),
(257, 28, 'Pichirhua'),
(258, 28, 'San Pedro de Cachora'),
(259, 28, 'Tamburco'),
(260, 29, 'Andahuaylas'),
(261, 29, 'Andarapa'),
(262, 29, 'Chiara'),
(263, 29, 'Huancarama'),
(264, 29, 'Huancaray'),
(265, 29, 'Huayana'),
(266, 29, 'Kishuara'),
(267, 29, 'Pacobamba'),
(268, 29, 'Pacucha'),
(269, 29, 'Pampachiri'),
(270, 29, 'Pomacocha'),
(271, 29, 'San Antonio de Cachi'),
(272, 29, 'San Jerónimo'),
(273, 29, 'San Miguel de Chaccrampa'),
(274, 29, 'Santa María de Chicmo'),
(275, 29, 'Talavera'),
(276, 29, 'Tumay Huaraca'),
(277, 29, 'Turpo'),
(278, 29, 'Kaquiabamba'),
(279, 29, 'José María Arguedas'),
(280, 30, 'Antabamba'),
(281, 30, 'El Oro'),
(282, 30, 'Huaquirca'),
(283, 30, 'Juan Espinoza Medrano'),
(284, 30, 'Oropesa'),
(285, 30, 'Pachaconas'),
(286, 30, 'Sabaino'),
(287, 31, 'Chalhuanca'),
(288, 31, 'Capaya'),
(289, 31, 'Caraybamba'),
(290, 31, 'Chapimarca'),
(291, 31, 'Colcabamba'),
(292, 31, 'Cotaruse'),
(293, 31, 'Ihuayllo'),
(294, 31, 'Justo Apu Sahuaraura'),
(295, 31, 'Lucre'),
(296, 31, 'Pocohuanca'),
(297, 31, 'San Juan de Chacña'),
(298, 31, 'Sañayca'),
(299, 31, 'Soraya'),
(300, 31, 'Tapairihua'),
(301, 31, 'Tintay'),
(302, 31, 'Toraya'),
(303, 31, 'Yanaca'),
(304, 32, 'Tambobamba'),
(305, 32, 'Cotabambas'),
(306, 32, 'Coyllurqui'),
(307, 32, 'Haquira'),
(308, 32, 'Mara'),
(309, 32, 'Challhuahuacho'),
(310, 33, 'Chincheros'),
(311, 33, 'Anco_Huallo'),
(312, 33, 'Cocharcas'),
(313, 33, 'Huaccana'),
(314, 33, 'Ocobamba'),
(315, 33, 'Ongoy'),
(316, 33, 'Uranmarca'),
(317, 33, 'Ranracancha'),
(318, 33, 'Rocchacc'),
(319, 33, 'El Porvenir'),
(320, 33, 'Los Chankas'),
(321, 34, 'Chuquibambilla'),
(322, 34, 'Curpahuasi'),
(323, 34, 'Gamarra'),
(324, 34, 'Huayllati'),
(325, 34, 'Mamara'),
(326, 34, 'Micaela Bastidas'),
(327, 34, 'Pataypampa'),
(328, 34, 'Progreso'),
(329, 34, 'San Antonio'),
(330, 34, 'Santa Rosa'),
(331, 34, 'Turpay'),
(332, 34, 'Vilcabamba'),
(333, 34, 'Virundo'),
(334, 34, 'Curasco'),
(335, 35, 'Arequipa'),
(336, 35, 'Alto Selva Alegre'),
(337, 35, 'Cayma'),
(338, 35, 'Cerro Colorado'),
(339, 35, 'Characato'),
(340, 35, 'Chiguata'),
(341, 35, 'Jacobo Hunter'),
(342, 35, 'La Joya'),
(343, 35, 'Mariano Melgar'),
(344, 35, 'Miraflores'),
(345, 35, 'Mollebaya'),
(346, 35, 'Paucarpata'),
(347, 35, 'Pocsi'),
(348, 35, 'Polobaya'),
(349, 35, 'Quequeña'),
(350, 35, 'Sabandia'),
(351, 35, 'Sachaca'),
(352, 35, 'San Juan de Siguas'),
(353, 35, 'San Juan de Tarucani'),
(354, 35, 'Santa Isabel de Siguas'),
(355, 35, 'Santa Rita de Siguas'),
(356, 35, 'Socabaya'),
(357, 35, 'Tiabaya'),
(358, 35, 'Uchumayo'),
(359, 35, 'Vitor'),
(360, 35, 'Yanahuara'),
(361, 35, 'Yarabamba'),
(362, 35, 'Yura'),
(363, 35, 'José Luis Bustamante Y Rivero'),
(364, 36, 'Camaná'),
(365, 36, 'José María Quimper'),
(366, 36, 'Mariano Nicolás Valcárcel'),
(367, 36, 'Mariscal Cáceres'),
(368, 36, 'Nicolás de Pierola'),
(369, 36, 'Ocoña'),
(370, 36, 'Quilca'),
(371, 36, 'Samuel Pastor'),
(372, 37, 'Caravelí'),
(373, 37, 'Acarí'),
(374, 37, 'Atico'),
(375, 37, 'Atiquipa'),
(376, 37, 'Bella Unión'),
(377, 37, 'Cahuacho'),
(378, 37, 'Chala'),
(379, 37, 'Chaparra'),
(380, 37, 'Huanuhuanu'),
(381, 37, 'Jaqui'),
(382, 37, 'Lomas'),
(383, 37, 'Quicacha'),
(384, 37, 'Yauca'),
(385, 38, 'Aplao'),
(386, 38, 'Andagua'),
(387, 38, 'Ayo'),
(388, 38, 'Chachas'),
(389, 38, 'Chilcaymarca'),
(390, 38, 'Choco'),
(391, 38, 'Huancarqui'),
(392, 38, 'Machaguay'),
(393, 38, 'Orcopampa'),
(394, 38, 'Pampacolca'),
(395, 38, 'Tipan'),
(396, 38, 'Uñon'),
(397, 38, 'Uraca'),
(398, 38, 'Viraco'),
(399, 39, 'Chivay'),
(400, 39, 'Achoma'),
(401, 39, 'Cabanaconde'),
(402, 39, 'Callalli'),
(403, 39, 'Caylloma'),
(404, 39, 'Coporaque'),
(405, 39, 'Huambo'),
(406, 39, 'Huanca'),
(407, 39, 'Ichupampa'),
(408, 39, 'Lari'),
(409, 39, 'Lluta'),
(410, 39, 'Maca'),
(411, 39, 'Madrigal'),
(412, 39, 'San Antonio de Chuca'),
(413, 39, 'Sibayo'),
(414, 39, 'Tapay'),
(415, 39, 'Tisco'),
(416, 39, 'Tuti'),
(417, 39, 'Yanque'),
(418, 39, 'Majes'),
(419, 40, 'Chuquibamba'),
(420, 40, 'Andaray'),
(421, 40, 'Cayarani'),
(422, 40, 'Chichas'),
(423, 40, 'Iray'),
(424, 40, 'Río Grande'),
(425, 40, 'Salamanca'),
(426, 40, 'Yanaquihua'),
(427, 41, 'Mollendo'),
(428, 41, 'Cocachacra'),
(429, 41, 'Dean Valdivia'),
(430, 41, 'Islay'),
(431, 41, 'Mejia'),
(432, 41, 'Punta de Bombón'),
(433, 42, 'Cotahuasi'),
(434, 42, 'Alca'),
(435, 42, 'Charcana'),
(436, 42, 'Huaynacotas'),
(437, 42, 'Pampamarca'),
(438, 42, 'Puyca'),
(439, 42, 'Quechualla'),
(440, 42, 'Sayla'),
(441, 42, 'Tauria'),
(442, 42, 'Tomepampa'),
(443, 42, 'Toro'),
(444, 43, 'Ayacucho'),
(445, 43, 'Acocro'),
(446, 43, 'Acos Vinchos'),
(447, 43, 'Carmen Alto'),
(448, 43, 'Chiara'),
(449, 43, 'Ocros'),
(450, 43, 'Pacaycasa'),
(451, 43, 'Quinua'),
(452, 43, 'San José de Ticllas'),
(453, 43, 'San Juan Bautista'),
(454, 43, 'Santiago de Pischa'),
(455, 43, 'Socos'),
(456, 43, 'Tambillo'),
(457, 43, 'Vinchos'),
(458, 43, 'Jesús Nazareno'),
(459, 43, 'Andrés Avelino Cáceres Dorregaray'),
(460, 44, 'Cangallo'),
(461, 44, 'Chuschi'),
(462, 44, 'Los Morochucos'),
(463, 44, 'María Parado de Bellido'),
(464, 44, 'Paras'),
(465, 44, 'Totos'),
(466, 45, 'Sancos'),
(467, 45, 'Carapo'),
(468, 45, 'Sacsamarca'),
(469, 45, 'Santiago de Lucanamarca'),
(470, 46, 'Huanta'),
(471, 46, 'Ayahuanco'),
(472, 46, 'Huamanguilla'),
(473, 46, 'Iguain'),
(474, 46, 'Luricocha'),
(475, 46, 'Santillana'),
(476, 46, 'Sivia'),
(477, 46, 'Llochegua'),
(478, 46, 'Canayre'),
(479, 46, 'Uchuraccay'),
(480, 46, 'Pucacolpa'),
(481, 46, 'Chaca'),
(482, 47, 'San Miguel'),
(483, 47, 'Anco'),
(484, 47, 'Ayna'),
(485, 47, 'Chilcas'),
(486, 47, 'Chungui'),
(487, 47, 'Luis Carranza'),
(488, 47, 'Santa Rosa'),
(489, 47, 'Tambo'),
(490, 47, 'Samugari'),
(491, 47, 'Anchihuay'),
(492, 47, 'Oronccoy'),
(493, 48, 'Puquio'),
(494, 48, 'Aucara'),
(495, 48, 'Cabana'),
(496, 48, 'Carmen Salcedo'),
(497, 48, 'Chaviña'),
(498, 48, 'Chipao'),
(499, 48, 'Huac-Huas'),
(500, 48, 'Laramate'),
(501, 48, 'Leoncio Prado'),
(502, 48, 'Llauta'),
(503, 48, 'Lucanas'),
(504, 48, 'Ocaña'),
(505, 48, 'Otoca'),
(506, 48, 'Saisa'),
(507, 48, 'San Cristóbal'),
(508, 48, 'San Juan'),
(509, 48, 'San Pedro'),
(510, 48, 'San Pedro de Palco'),
(511, 48, 'Sancos'),
(512, 48, 'Santa Ana de Huaycahuacho'),
(513, 48, 'Santa Lucia'),
(514, 49, 'Coracora'),
(515, 49, 'Chumpi'),
(516, 49, 'Coronel Castañeda'),
(517, 49, 'Pacapausa'),
(518, 49, 'Pullo'),
(519, 49, 'Puyusca'),
(520, 49, 'San Francisco de Ravacayco'),
(521, 49, 'Upahuacho'),
(522, 50, 'Pausa'),
(523, 50, 'Colta'),
(524, 50, 'Corculla'),
(525, 50, 'Lampa'),
(526, 50, 'Marcabamba'),
(527, 50, 'Oyolo'),
(528, 50, 'Pararca'),
(529, 50, 'San Javier de Alpabamba'),
(530, 50, 'San José de Ushua'),
(531, 50, 'Sara Sara'),
(532, 51, 'Querobamba'),
(533, 51, 'Belén'),
(534, 51, 'Chalcos'),
(535, 51, 'Chilcayoc'),
(536, 51, 'Huacaña'),
(537, 51, 'Morcolla'),
(538, 51, 'Paico'),
(539, 51, 'San Pedro de Larcay'),
(540, 51, 'San Salvador de Quije'),
(541, 51, 'Santiago de Paucaray'),
(542, 51, 'Soras'),
(543, 52, 'Huancapi'),
(544, 52, 'Alcamenca'),
(545, 52, 'Apongo'),
(546, 52, 'Asquipata'),
(547, 52, 'Canaria'),
(548, 52, 'Cayara'),
(549, 52, 'Colca'),
(550, 52, 'Huamanquiquia'),
(551, 52, 'Huancaraylla'),
(552, 52, 'Hualla'),
(553, 52, 'Sarhua'),
(554, 52, 'Vilcanchos'),
(555, 53, 'Vilcas Huaman'),
(556, 53, 'Accomarca'),
(557, 53, 'Carhuanca'),
(558, 53, 'Concepción'),
(559, 53, 'Huambalpa'),
(560, 53, 'Independencia'),
(561, 53, 'Saurama'),
(562, 53, 'Vischongo'),
(563, 54, 'Cajamarca'),
(564, 54, 'Asunción'),
(565, 54, 'Chetilla'),
(566, 54, 'Cospan'),
(567, 54, 'Encañada'),
(568, 54, 'Jesús'),
(569, 54, 'Llacanora'),
(570, 54, 'Los Baños del Inca'),
(571, 54, 'Magdalena'),
(572, 54, 'Matara'),
(573, 54, 'Namora'),
(574, 54, 'San Juan'),
(575, 55, 'Cajabamba'),
(576, 55, 'Cachachi'),
(577, 55, 'Condebamba'),
(578, 55, 'Sitacocha'),
(579, 56, 'Celendín'),
(580, 56, 'Chumuch'),
(581, 56, 'Cortegana'),
(582, 56, 'Huasmin'),
(583, 56, 'Jorge Chávez'),
(584, 56, 'José Gálvez'),
(585, 56, 'Miguel Iglesias'),
(586, 56, 'Oxamarca'),
(587, 56, 'Sorochuco'),
(588, 56, 'Sucre'),
(589, 56, 'Utco'),
(590, 56, 'La Libertad de Pallan'),
(591, 57, 'Chota'),
(592, 57, 'Anguia'),
(593, 57, 'Chadin'),
(594, 57, 'Chiguirip'),
(595, 57, 'Chimban'),
(596, 57, 'Choropampa'),
(597, 57, 'Cochabamba'),
(598, 57, 'Conchan'),
(599, 57, 'Huambos'),
(600, 57, 'Lajas'),
(601, 57, 'Llama'),
(602, 57, 'Miracosta'),
(603, 57, 'Paccha'),
(604, 57, 'Pion'),
(605, 57, 'Querocoto'),
(606, 57, 'San Juan de Licupis'),
(607, 57, 'Tacabamba'),
(608, 57, 'Tocmoche'),
(609, 57, 'Chalamarca'),
(610, 58, 'Contumaza'),
(611, 58, 'Chilete'),
(612, 58, 'Cupisnique'),
(613, 58, 'Guzmango'),
(614, 58, 'San Benito'),
(615, 58, 'Santa Cruz de Toledo'),
(616, 58, 'Tantarica'),
(617, 58, 'Yonan'),
(618, 59, 'Cutervo'),
(619, 59, 'Callayuc'),
(620, 59, 'Choros'),
(621, 59, 'Cujillo'),
(622, 59, 'La Ramada'),
(623, 59, 'Pimpingos'),
(624, 59, 'Querocotillo'),
(625, 59, 'San Andrés de Cutervo'),
(626, 59, 'San Juan de Cutervo'),
(627, 59, 'San Luis de Lucma'),
(628, 59, 'Santa Cruz'),
(629, 59, 'Santo Domingo de la Capilla'),
(630, 59, 'Santo Tomas'),
(631, 59, 'Socota'),
(632, 59, 'Toribio Casanova'),
(633, 60, 'Bambamarca'),
(634, 60, 'Chugur'),
(635, 60, 'Hualgayoc'),
(636, 61, 'Jaén'),
(637, 61, 'Bellavista'),
(638, 61, 'Chontali'),
(639, 61, 'Colasay'),
(640, 61, 'Huabal'),
(641, 61, 'Las Pirias'),
(642, 61, 'Pomahuaca'),
(643, 61, 'Pucara'),
(644, 61, 'Sallique'),
(645, 61, 'San Felipe'),
(646, 61, 'San José del Alto'),
(647, 61, 'Santa Rosa'),
(648, 62, 'San Ignacio'),
(649, 62, 'Chirinos'),
(650, 62, 'Huarango'),
(651, 62, 'La Coipa'),
(652, 62, 'Namballe'),
(653, 62, 'San José de Lourdes'),
(654, 62, 'Tabaconas'),
(655, 63, 'Pedro Gálvez'),
(656, 63, 'Chancay'),
(657, 63, 'Eduardo Villanueva'),
(658, 63, 'Gregorio Pita'),
(659, 63, 'Ichocan'),
(660, 63, 'José Manuel Quiroz'),
(661, 63, 'José Sabogal'),
(662, 64, 'San Miguel'),
(663, 64, 'Bolívar'),
(664, 64, 'Calquis'),
(665, 64, 'Catilluc'),
(666, 64, 'El Prado'),
(667, 64, 'La Florida'),
(668, 64, 'Llapa'),
(669, 64, 'Nanchoc'),
(670, 64, 'Niepos'),
(671, 64, 'San Gregorio'),
(672, 64, 'San Silvestre de Cochan'),
(673, 64, 'Tongod'),
(674, 64, 'Unión Agua Blanca'),
(675, 65, 'San Pablo'),
(676, 65, 'San Bernardino'),
(677, 65, 'San Luis'),
(678, 65, 'Tumbaden'),
(679, 66, 'Santa Cruz'),
(680, 66, 'Andabamba'),
(681, 66, 'Catache'),
(682, 66, 'Chancaybaños'),
(683, 66, 'La Esperanza'),
(684, 66, 'Ninabamba'),
(685, 66, 'Pulan'),
(686, 66, 'Saucepampa'),
(687, 66, 'Sexi'),
(688, 66, 'Uticyacu'),
(689, 66, 'Yauyucan'),
(690, 67, 'Callao'),
(691, 67, 'Bellavista'),
(692, 67, 'Carmen de la Legua Reynoso'),
(693, 67, 'La Perla'),
(694, 67, 'La Punta'),
(695, 67, 'Ventanilla'),
(696, 67, 'Mi Perú'),
(697, 68, 'Cusco'),
(698, 68, 'Ccorca'),
(699, 68, 'Poroy'),
(700, 68, 'San Jerónimo'),
(701, 68, 'San Sebastian'),
(702, 68, 'Santiago'),
(703, 68, 'Saylla'),
(704, 68, 'Wanchaq'),
(705, 69, 'Acomayo'),
(706, 69, 'Acopia'),
(707, 69, 'Acos'),
(708, 69, 'Mosoc Llacta'),
(709, 69, 'Pomacanchi'),
(710, 69, 'Rondocan'),
(711, 69, 'Sangarara'),
(712, 70, 'Anta'),
(713, 70, 'Ancahuasi'),
(714, 70, 'Cachimayo'),
(715, 70, 'Chinchaypujio'),
(716, 70, 'Huarocondo'),
(717, 70, 'Limatambo'),
(718, 70, 'Mollepata'),
(719, 70, 'Pucyura'),
(720, 70, 'Zurite'),
(721, 71, 'Calca'),
(722, 71, 'Coya'),
(723, 71, 'Lamay'),
(724, 71, 'Lares'),
(725, 71, 'Pisac'),
(726, 71, 'San Salvador'),
(727, 71, 'Taray'),
(728, 71, 'Yanatile'),
(729, 72, 'Yanaoca'),
(730, 72, 'Checca'),
(731, 72, 'Kunturkanki'),
(732, 72, 'Langui'),
(733, 72, 'Layo'),
(734, 72, 'Pampamarca'),
(735, 72, 'Quehue'),
(736, 72, 'Tupac Amaru'),
(737, 73, 'Sicuani'),
(738, 73, 'Checacupe'),
(739, 73, 'Combapata'),
(740, 73, 'Marangani'),
(741, 73, 'Pitumarca'),
(742, 73, 'San Pablo'),
(743, 73, 'San Pedro'),
(744, 73, 'Tinta'),
(745, 74, 'Santo Tomas'),
(746, 74, 'Capacmarca'),
(747, 74, 'Chamaca'),
(748, 74, 'Colquemarca'),
(749, 74, 'Livitaca'),
(750, 74, 'Llusco'),
(751, 74, 'Quiñota'),
(752, 74, 'Velille'),
(753, 75, 'Espinar'),
(754, 75, 'Condoroma'),
(755, 75, 'Coporaque'),
(756, 75, 'Ocoruro'),
(757, 75, 'Pallpata'),
(758, 75, 'Pichigua'),
(759, 75, 'Suyckutambo'),
(760, 75, 'Alto Pichigua'),
(761, 76, 'Santa Ana'),
(762, 76, 'Echarate'),
(763, 76, 'Huayopata'),
(764, 76, 'Maranura'),
(765, 76, 'Ocobamba'),
(766, 76, 'Quellouno'),
(767, 76, 'Kimbiri'),
(768, 76, 'Santa Teresa'),
(769, 76, 'Vilcabamba'),
(770, 76, 'Pichari'),
(771, 76, 'Inkawasi'),
(772, 76, 'Villa Virgen'),
(773, 76, 'Villa Kintiarina'),
(774, 76, 'Megantoni'),
(775, 77, 'Paruro'),
(776, 77, 'Accha'),
(777, 77, 'Ccapi'),
(778, 77, 'Colcha'),
(779, 77, 'Huanoquite'),
(780, 77, 'Omachaç'),
(781, 77, 'Paccaritambo'),
(782, 77, 'Pillpinto'),
(783, 77, 'Yaurisque'),
(784, 78, 'Paucartambo'),
(785, 78, 'Caicay'),
(786, 78, 'Challabamba'),
(787, 78, 'Colquepata'),
(788, 78, 'Huancarani'),
(789, 78, 'Kosñipata'),
(790, 79, 'Urcos'),
(791, 79, 'Andahuaylillas'),
(792, 79, 'Camanti'),
(793, 79, 'Ccarhuayo'),
(794, 79, 'Ccatca'),
(795, 79, 'Cusipata'),
(796, 79, 'Huaro'),
(797, 79, 'Lucre'),
(798, 79, 'Marcapata'),
(799, 79, 'Ocongate'),
(800, 79, 'Oropesa'),
(801, 79, 'Quiquijana'),
(802, 80, 'Urubamba'),
(803, 80, 'Chinchero'),
(804, 80, 'Huayllabamba'),
(805, 80, 'Machupicchu'),
(806, 80, 'Maras'),
(807, 80, 'Ollantaytambo'),
(808, 80, 'Yucay'),
(809, 81, 'Huancavelica'),
(810, 81, 'Acobambilla'),
(811, 81, 'Acoria'),
(812, 81, 'Conayca'),
(813, 81, 'Cuenca'),
(814, 81, 'Huachocolpa'),
(815, 81, 'Huayllahuara'),
(816, 81, 'Izcuchaca'),
(817, 81, 'Laria'),
(818, 81, 'Manta'),
(819, 81, 'Mariscal Cáceres'),
(820, 81, 'Moya'),
(821, 81, 'Nuevo Occoro'),
(822, 81, 'Palca'),
(823, 81, 'Pilchaca'),
(824, 81, 'Vilca'),
(825, 81, 'Yauli'),
(826, 81, 'Ascensión'),
(827, 81, 'Huando'),
(828, 82, 'Acobamba'),
(829, 82, 'Andabamba'),
(830, 82, 'Anta'),
(831, 82, 'Caja'),
(832, 82, 'Marcas'),
(833, 82, 'Paucara'),
(834, 82, 'Pomacocha'),
(835, 82, 'Rosario'),
(836, 83, 'Lircay'),
(837, 83, 'Anchonga'),
(838, 83, 'Callanmarca'),
(839, 83, 'Ccochaccasa'),
(840, 83, 'Chincho'),
(841, 83, 'Congalla'),
(842, 83, 'Huanca-Huanca'),
(843, 83, 'Huayllay Grande'),
(844, 83, 'Julcamarca'),
(845, 83, 'San Antonio de Antaparco'),
(846, 83, 'Santo Tomas de Pata'),
(847, 83, 'Secclla'),
(848, 84, 'Castrovirreyna'),
(849, 84, 'Arma'),
(850, 84, 'Aurahua'),
(851, 84, 'Capillas'),
(852, 84, 'Chupamarca'),
(853, 84, 'Cocas'),
(854, 84, 'Huachos'),
(855, 84, 'Huamatambo'),
(856, 84, 'Mollepampa'),
(857, 84, 'San Juan'),
(858, 84, 'Santa Ana'),
(859, 84, 'Tantara'),
(860, 84, 'Ticrapo'),
(861, 85, 'Churcampa'),
(862, 85, 'Anco'),
(863, 85, 'Chinchihuasi'),
(864, 85, 'El Carmen'),
(865, 85, 'La Merced'),
(866, 85, 'Locroja'),
(867, 85, 'Paucarbamba'),
(868, 85, 'San Miguel de Mayocc'),
(869, 85, 'San Pedro de Coris'),
(870, 85, 'Pachamarca'),
(871, 85, 'Cosme'),
(872, 86, 'Huaytara'),
(873, 86, 'Ayavi'),
(874, 86, 'Córdova'),
(875, 86, 'Huayacundo Arma'),
(876, 86, 'Laramarca'),
(877, 86, 'Ocoyo'),
(878, 86, 'Pilpichaca'),
(879, 86, 'Querco'),
(880, 86, 'Quito-Arma'),
(881, 86, 'San Antonio de Cusicancha'),
(882, 86, 'San Francisco de Sangayaico'),
(883, 86, 'San Isidro'),
(884, 86, 'Santiago de Chocorvos'),
(885, 86, 'Santiago de Quirahuara'),
(886, 86, 'Santo Domingo de Capillas'),
(887, 86, 'Tambo'),
(888, 87, 'Pampas'),
(889, 87, 'Acostambo'),
(890, 87, 'Acraquia'),
(891, 87, 'Ahuaycha'),
(892, 87, 'Colcabamba'),
(893, 87, 'Daniel Hernández'),
(894, 87, 'Huachocolpa'),
(895, 87, 'Huaribamba'),
(896, 87, 'Ñahuimpuquio'),
(897, 87, 'Pazos'),
(898, 87, 'Quishuar'),
(899, 87, 'Salcabamba'),
(900, 87, 'Salcahuasi'),
(901, 87, 'San Marcos de Rocchac'),
(902, 87, 'Surcubamba'),
(903, 87, 'Tintay Puncu'),
(904, 87, 'Quichuas'),
(905, 87, 'Andaymarca'),
(906, 87, 'Roble'),
(907, 87, 'Pichos'),
(908, 87, 'Santiago de Tucuma'),
(909, 88, 'Huanuco'),
(910, 88, 'Amarilis'),
(911, 88, 'Chinchao'),
(912, 88, 'Churubamba'),
(913, 88, 'Margos'),
(914, 88, 'Quisqui (Kichki)'),
(915, 88, 'San Francisco de Cayran'),
(916, 88, 'San Pedro de Chaulan'),
(917, 88, 'Santa María del Valle'),
(918, 88, 'Yarumayo'),
(919, 88, 'Pillco Marca'),
(920, 88, 'Yacus'),
(921, 88, 'San Pablo de Pillao'),
(922, 89, 'Ambo'),
(923, 89, 'Cayna'),
(924, 89, 'Colpas'),
(925, 89, 'Conchamarca'),
(926, 89, 'Huacar'),
(927, 89, 'San Francisco'),
(928, 89, 'San Rafael'),
(929, 89, 'Tomay Kichwa'),
(930, 90, 'La Unión'),
(931, 90, 'Chuquis'),
(932, 90, 'Marías'),
(933, 90, 'Pachas'),
(934, 90, 'Quivilla'),
(935, 90, 'Ripan'),
(936, 90, 'Shunqui'),
(937, 90, 'Sillapata'),
(938, 90, 'Yanas'),
(939, 91, 'Huacaybamba'),
(940, 91, 'Canchabamba'),
(941, 91, 'Cochabamba'),
(942, 91, 'Pinra'),
(943, 92, 'Llata'),
(944, 92, 'Arancay'),
(945, 92, 'Chavín de Pariarca'),
(946, 92, 'Jacas Grande'),
(947, 92, 'Jircan'),
(948, 92, 'Miraflores'),
(949, 92, 'Monzón'),
(950, 92, 'Punchao'),
(951, 92, 'Puños'),
(952, 92, 'Singa'),
(953, 92, 'Tantamayo'),
(954, 93, 'Rupa-Rupa'),
(955, 93, 'Daniel Alomía Robles'),
(956, 93, 'Hermílio Valdizan'),
(957, 93, 'José Crespo y Castillo'),
(958, 93, 'Luyando'),
(959, 93, 'Mariano Damaso Beraun'),
(960, 93, 'Pucayacu'),
(961, 93, 'Castillo Grande'),
(962, 93, 'Pueblo Nuevo'),
(963, 93, 'Santo Domingo de Anda'),
(964, 94, 'Huacrachuco'),
(965, 94, 'Cholon'),
(966, 94, 'San Buenaventura'),
(967, 94, 'La Morada'),
(968, 94, 'Santa Rosa de Alto Yanajanca'),
(969, 95, 'Panao'),
(970, 95, 'Chaglla'),
(971, 95, 'Molino'),
(972, 95, 'Umari'),
(973, 96, 'Puerto Inca'),
(974, 96, 'Codo del Pozuzo'),
(975, 96, 'Honoria'),
(976, 96, 'Tournavista'),
(977, 96, 'Yuyapichis'),
(978, 97, 'Jesús'),
(979, 97, 'Baños'),
(980, 97, 'Jivia'),
(981, 97, 'Queropalca'),
(982, 97, 'Rondos'),
(983, 97, 'San Francisco de Asís'),
(984, 97, 'San Miguel de Cauri'),
(985, 98, 'Chavinillo'),
(986, 98, 'Cahuac'),
(987, 98, 'Chacabamba'),
(988, 98, 'Aparicio Pomares'),
(989, 98, 'Jacas Chico'),
(990, 98, 'Obas'),
(991, 98, 'Pampamarca'),
(992, 98, 'Choras'),
(993, 99, 'Ica'),
(994, 99, 'La Tinguiña'),
(995, 99, 'Los Aquijes'),
(996, 99, 'Ocucaje'),
(997, 99, 'Pachacutec'),
(998, 99, 'Parcona'),
(999, 99, 'Pueblo Nuevo'),
(1000, 99, 'Salas'),
(1001, 99, 'San José de Los Molinos'),
(1002, 99, 'San Juan Bautista'),
(1003, 99, 'Santiago'),
(1004, 99, 'Subtanjalla'),
(1005, 99, 'Tate'),
(1006, 99, 'Yauca del Rosario'),
(1007, 100, 'Chincha Alta'),
(1008, 100, 'Alto Laran'),
(1009, 100, 'Chavin'),
(1010, 100, 'Chincha Baja'),
(1011, 100, 'El Carmen'),
(1012, 100, 'Grocio Prado'),
(1013, 100, 'Pueblo Nuevo'),
(1014, 100, 'San Juan de Yanac'),
(1015, 100, 'San Pedro de Huacarpana'),
(1016, 100, 'Sunampe'),
(1017, 100, 'Tambo de Mora'),
(1018, 101, 'Nasca'),
(1019, 101, 'Changuillo'),
(1020, 101, 'El Ingenio'),
(1021, 101, 'Marcona'),
(1022, 101, 'Vista Alegre'),
(1023, 102, 'Palpa'),
(1024, 102, 'Llipata'),
(1025, 102, 'Río Grande'),
(1026, 102, 'Santa Cruz'),
(1027, 102, 'Tibillo'),
(1028, 103, 'Pisco'),
(1029, 103, 'Huancano'),
(1030, 103, 'Humay'),
(1031, 103, 'Independencia'),
(1032, 103, 'Paracas'),
(1033, 103, 'San Andrés'),
(1034, 103, 'San Clemente'),
(1035, 103, 'Tupac Amaru Inca'),
(1036, 104, 'Huancayo'),
(1037, 104, 'Carhuacallanga'),
(1038, 104, 'Chacapampa'),
(1039, 104, 'Chicche'),
(1040, 104, 'Chilca'),
(1041, 104, 'Chongos Alto'),
(1042, 104, 'Chupuro'),
(1043, 104, 'Colca'),
(1044, 104, 'Cullhuas'),
(1045, 104, 'El Tambo'),
(1046, 104, 'Huacrapuquio'),
(1047, 104, 'Hualhuas'),
(1048, 104, 'Huancan'),
(1049, 104, 'Huasicancha'),
(1050, 104, 'Huayucachi'),
(1051, 104, 'Ingenio'),
(1052, 104, 'Pariahuanca'),
(1053, 104, 'Pilcomayo'),
(1054, 104, 'Pucara'),
(1055, 104, 'Quichuay'),
(1056, 104, 'Quilcas'),
(1057, 104, 'San Agustín'),
(1058, 104, 'San Jerónimo de Tunan'),
(1059, 104, 'Saño'),
(1060, 104, 'Sapallanga'),
(1061, 104, 'Sicaya'),
(1062, 104, 'Santo Domingo de Acobamba'),
(1063, 104, 'Viques'),
(1064, 105, 'Concepción'),
(1065, 105, 'Aco'),
(1066, 105, 'Andamarca'),
(1067, 105, 'Chambara'),
(1068, 105, 'Cochas'),
(1069, 105, 'Comas'),
(1070, 105, 'Heroínas Toledo'),
(1071, 105, 'Manzanares'),
(1072, 105, 'Mariscal Castilla'),
(1073, 105, 'Matahuasi'),
(1074, 105, 'Mito'),
(1075, 105, 'Nueve de Julio'),
(1076, 105, 'Orcotuna'),
(1077, 105, 'San José de Quero'),
(1078, 105, 'Santa Rosa de Ocopa'),
(1079, 106, 'Chanchamayo'),
(1080, 106, 'Perene'),
(1081, 106, 'Pichanaqui'),
(1082, 106, 'San Luis de Shuaro'),
(1083, 106, 'San Ramón'),
(1084, 106, 'Vitoc'),
(1085, 107, 'Jauja'),
(1086, 107, 'Acolla'),
(1087, 107, 'Apata'),
(1088, 107, 'Ataura'),
(1089, 107, 'Canchayllo'),
(1090, 107, 'Curicaca'),
(1091, 107, 'El Mantaro'),
(1092, 107, 'Huamali'),
(1093, 107, 'Huaripampa'),
(1094, 107, 'Huertas'),
(1095, 107, 'Janjaillo'),
(1096, 107, 'Julcán'),
(1097, 107, 'Leonor Ordóñez'),
(1098, 107, 'Llocllapampa'),
(1099, 107, 'Marco'),
(1100, 107, 'Masma'),
(1101, 107, 'Masma Chicche'),
(1102, 107, 'Molinos'),
(1103, 107, 'Monobamba'),
(1104, 107, 'Muqui'),
(1105, 107, 'Muquiyauyo'),
(1106, 107, 'Paca'),
(1107, 107, 'Paccha'),
(1108, 107, 'Pancan'),
(1109, 107, 'Parco'),
(1110, 107, 'Pomacancha'),
(1111, 107, 'Ricran'),
(1112, 107, 'San Lorenzo'),
(1113, 107, 'San Pedro de Chunan'),
(1114, 107, 'Sausa'),
(1115, 107, 'Sincos'),
(1116, 107, 'Tunan Marca'),
(1117, 107, 'Yauli'),
(1118, 107, 'Yauyos'),
(1119, 108, 'Junin'),
(1120, 108, 'Carhuamayo'),
(1121, 108, 'Ondores'),
(1122, 108, 'Ulcumayo'),
(1123, 109, 'Satipo'),
(1124, 109, 'Coviriali'),
(1125, 109, 'Llaylla'),
(1126, 109, 'Mazamari'),
(1127, 109, 'Pampa Hermosa'),
(1128, 109, 'Pangoa'),
(1129, 109, 'Río Negro'),
(1130, 109, 'Río Tambo'),
(1131, 109, 'Vizcatan del Ene'),
(1132, 110, 'Tarma'),
(1133, 110, 'Acobamba'),
(1134, 110, 'Huaricolca'),
(1135, 110, 'Huasahuasi'),
(1136, 110, 'La Unión'),
(1137, 110, 'Palca'),
(1138, 110, 'Palcamayo'),
(1139, 110, 'San Pedro de Cajas'),
(1140, 110, 'Tapo'),
(1141, 111, 'La Oroya'),
(1142, 111, 'Chacapalpa'),
(1143, 111, 'Huay-Huay'),
(1144, 111, 'Marcapomacocha'),
(1145, 111, 'Morococha'),
(1146, 111, 'Paccha'),
(1147, 111, 'Santa Bárbara de Carhuacayan'),
(1148, 111, 'Santa Rosa de Sacco'),
(1149, 111, 'Suitucancha'),
(1150, 111, 'Yauli'),
(1151, 112, 'Chupaca'),
(1152, 112, 'Ahuac'),
(1153, 112, 'Chongos Bajo'),
(1154, 112, 'Huachac'),
(1155, 112, 'Huamancaca Chico'),
(1156, 112, 'San Juan de Iscos'),
(1157, 112, 'San Juan de Jarpa'),
(1158, 112, 'Tres de Diciembre'),
(1159, 112, 'Yanacancha'),
(1160, 113, 'Trujillo'),
(1161, 113, 'El Porvenir'),
(1162, 113, 'Florencia de Mora'),
(1163, 113, 'Huanchaco'),
(1164, 113, 'La Esperanza'),
(1165, 113, 'Laredo'),
(1166, 113, 'Moche'),
(1167, 113, 'Poroto'),
(1168, 113, 'Salaverry'),
(1169, 113, 'Simbal'),
(1170, 113, 'Victor Larco Herrera'),
(1171, 114, 'Ascope'),
(1172, 114, 'Chicama'),
(1173, 114, 'Chocope'),
(1174, 114, 'Magdalena de Cao'),
(1175, 114, 'Paijan'),
(1176, 114, 'Rázuri'),
(1177, 114, 'Santiago de Cao'),
(1178, 114, 'Casa Grande'),
(1179, 115, 'Bolívar'),
(1180, 115, 'Bambamarca'),
(1181, 115, 'Condormarca'),
(1182, 115, 'Longotea'),
(1183, 115, 'Uchumarca'),
(1184, 115, 'Ucuncha'),
(1185, 116, 'Chepen'),
(1186, 116, 'Pacanga'),
(1187, 116, 'Pueblo Nuevo'),
(1188, 117, 'Julcan'),
(1189, 117, 'Calamarca'),
(1190, 117, 'Carabamba'),
(1191, 117, 'Huaso'),
(1192, 118, 'Otuzco'),
(1193, 118, 'Agallpampa'),
(1194, 118, 'Charat'),
(1195, 118, 'Huaranchal'),
(1196, 118, 'La Cuesta'),
(1197, 118, 'Mache'),
(1198, 118, 'Paranday'),
(1199, 118, 'Salpo'),
(1200, 118, 'Sinsicap'),
(1201, 118, 'Usquil'),
(1202, 119, 'San Pedro de Lloc'),
(1203, 119, 'Guadalupe'),
(1204, 119, 'Jequetepeque'),
(1205, 119, 'Pacasmayo'),
(1206, 119, 'San José'),
(1207, 120, 'Tayabamba'),
(1208, 120, 'Buldibuyo'),
(1209, 120, 'Chillia'),
(1210, 120, 'Huancaspata'),
(1211, 120, 'Huaylillas'),
(1212, 120, 'Huayo'),
(1213, 120, 'Ongon'),
(1214, 120, 'Parcoy'),
(1215, 120, 'Pataz'),
(1216, 120, 'Pias'),
(1217, 120, 'Santiago de Challas'),
(1218, 120, 'Taurija'),
(1219, 120, 'Urpay'),
(1220, 121, 'Huamachuco'),
(1221, 121, 'Chugay'),
(1222, 121, 'Cochorco'),
(1223, 121, 'Curgos'),
(1224, 121, 'Marcabal'),
(1225, 121, 'Sanagoran'),
(1226, 121, 'Sarin'),
(1227, 121, 'Sartimbamba'),
(1228, 122, 'Santiago de Chuco'),
(1229, 122, 'Angasmarca'),
(1230, 122, 'Cachicadan'),
(1231, 122, 'Mollebamba'),
(1232, 122, 'Mollepata'),
(1233, 122, 'Quiruvilca'),
(1234, 122, 'Santa Cruz de Chuca'),
(1235, 122, 'Sitabamba'),
(1236, 123, 'Cascas'),
(1237, 123, 'Lucma'),
(1238, 123, 'Marmot'),
(1239, 123, 'Sayapullo'),
(1240, 124, 'Viru'),
(1241, 124, 'Chao'),
(1242, 124, 'Guadalupito'),
(1243, 125, 'Chiclayo'),
(1244, 125, 'Chongoyape'),
(1245, 125, 'Eten'),
(1246, 125, 'Eten Puerto'),
(1247, 125, 'José Leonardo Ortiz'),
(1248, 125, 'La Victoria'),
(1249, 125, 'Lagunas'),
(1250, 125, 'Monsefu'),
(1251, 125, 'Nueva Arica'),
(1252, 125, 'Oyotun'),
(1253, 125, 'Picsi'),
(1254, 125, 'Pimentel'),
(1255, 125, 'Reque'),
(1256, 125, 'Santa Rosa'),
(1257, 125, 'Saña'),
(1258, 125, 'Cayalti'),
(1259, 125, 'Patapo'),
(1260, 125, 'Pomalca'),
(1261, 125, 'Pucala'),
(1262, 125, 'Tuman'),
(1263, 126, 'Ferreñafe'),
(1264, 126, 'Cañaris'),
(1265, 126, 'Incahuasi'),
(1266, 126, 'Manuel Antonio Mesones Muro'),
(1267, 126, 'Pitipo'),
(1268, 126, 'Pueblo Nuevo'),
(1269, 127, 'Lambayeque'),
(1270, 127, 'Chochope'),
(1271, 127, 'Illimo'),
(1272, 127, 'Jayanca'),
(1273, 127, 'Mochumi'),
(1274, 127, 'Morrope'),
(1275, 127, 'Motupe'),
(1276, 127, 'Olmos'),
(1277, 127, 'Pacora'),
(1278, 127, 'Salas'),
(1279, 127, 'San José'),
(1280, 127, 'Tucume'),
(1281, 128, 'Lima'),
(1282, 128, 'Ancón'),
(1283, 128, 'Ate'),
(1284, 128, 'Barranco'),
(1285, 128, 'Breña'),
(1286, 128, 'Carabayllo'),
(1287, 128, 'Chaclacayo'),
(1288, 128, 'Chorrillos'),
(1289, 128, 'Cieneguilla'),
(1290, 128, 'Comas'),
(1291, 128, 'El Agustino'),
(1292, 128, 'Independencia'),
(1293, 128, 'Jesús María'),
(1294, 128, 'La Molina'),
(1295, 128, 'La Victoria'),
(1296, 128, 'Lince'),
(1297, 128, 'Los Olivos'),
(1298, 128, 'Lurigancho'),
(1299, 128, 'Lurin'),
(1300, 128, 'Magdalena del Mar'),
(1301, 128, 'Pueblo Libre'),
(1302, 128, 'Miraflores'),
(1303, 128, 'Pachacamac'),
(1304, 128, 'Pucusana'),
(1305, 128, 'Puente Piedra'),
(1306, 128, 'Punta Hermosa'),
(1307, 128, 'Punta Negra'),
(1308, 128, 'Rímac'),
(1309, 128, 'San Bartolo'),
(1310, 128, 'San Borja'),
(1311, 128, 'San Isidro'),
(1312, 128, 'San Juan de Lurigancho'),
(1313, 128, 'San Juan de Miraflores'),
(1314, 128, 'San Luis'),
(1315, 128, 'San Martín de Porres'),
(1316, 128, 'San Miguel'),
(1317, 128, 'Santa Anita'),
(1318, 128, 'Santa María del Mar'),
(1319, 128, 'Santa Rosa'),
(1320, 128, 'Santiago de Surco'),
(1321, 128, 'Surquillo'),
(1322, 128, 'Villa El Salvador'),
(1323, 128, 'Villa María del Triunfo'),
(1324, 129, 'Barranca'),
(1325, 129, 'Paramonga'),
(1326, 129, 'Pativilca'),
(1327, 129, 'Supe'),
(1328, 129, 'Supe Puerto'),
(1329, 130, 'Cajatambo'),
(1330, 130, 'Copa'),
(1331, 130, 'Gorgor'),
(1332, 130, 'Huancapon'),
(1333, 130, 'Manas'),
(1334, 131, 'Canta'),
(1335, 131, 'Arahuay'),
(1336, 131, 'Huamantanga'),
(1337, 131, 'Huaros'),
(1338, 131, 'Lachaqui'),
(1339, 131, 'San Buenaventura'),
(1340, 131, 'Santa Rosa de Quives'),
(1341, 132, 'San Vicente de Cañete'),
(1342, 132, 'Asia'),
(1343, 132, 'Calango'),
(1344, 132, 'Cerro Azul'),
(1345, 132, 'Chilca'),
(1346, 132, 'Coayllo'),
(1347, 132, 'Imperial'),
(1348, 132, 'Lunahuana'),
(1349, 132, 'Mala'),
(1350, 132, 'Nuevo Imperial'),
(1351, 132, 'Pacaran'),
(1352, 132, 'Quilmana'),
(1353, 132, 'San Antonio'),
(1354, 132, 'San Luis'),
(1355, 132, 'Santa Cruz de Flores'),
(1356, 132, 'Zúñiga'),
(1357, 133, 'Huaral'),
(1358, 133, 'Atavillos Alto'),
(1359, 133, 'Atavillos Bajo'),
(1360, 133, 'Aucallama'),
(1361, 133, 'Chancay'),
(1362, 133, 'Ihuari'),
(1363, 133, 'Lampian'),
(1364, 133, 'Pacaraos'),
(1365, 133, 'San Miguel de Acos'),
(1366, 133, 'Santa Cruz de Andamarca'),
(1367, 133, 'Sumbilca'),
(1368, 133, 'Veintisiete de Noviembre'),
(1369, 134, 'Matucana'),
(1370, 134, 'Antioquia'),
(1371, 134, 'Callahuanca'),
(1372, 134, 'Carampoma'),
(1373, 134, 'Chicla'),
(1374, 134, 'Cuenca'),
(1375, 134, 'Huachupampa'),
(1376, 134, 'Huanza'),
(1377, 134, 'Huarochiri'),
(1378, 134, 'Lahuaytambo'),
(1379, 134, 'Langa'),
(1380, 134, 'Laraos'),
(1381, 134, 'Mariatana'),
(1382, 134, 'Ricardo Palma'),
(1383, 134, 'San Andrés de Tupicocha'),
(1384, 134, 'San Antonio'),
(1385, 134, 'San Bartolomé'),
(1386, 134, 'San Damian'),
(1387, 134, 'San Juan de Iris'),
(1388, 134, 'San Juan de Tantaranche'),
(1389, 134, 'San Lorenzo de Quinti'),
(1390, 134, 'San Mateo'),
(1391, 134, 'San Mateo de Otao'),
(1392, 134, 'San Pedro de Casta'),
(1393, 134, 'San Pedro de Huancayre'),
(1394, 134, 'Sangallaya'),
(1395, 134, 'Santa Cruz de Cocachacra'),
(1396, 134, 'Santa Eulalia'),
(1397, 134, 'Santiago de Anchucaya'),
(1398, 134, 'Santiago de Tuna'),
(1399, 134, 'Santo Domingo de Los Olleros'),
(1400, 134, 'Surco'),
(1401, 135, 'Huacho'),
(1402, 135, 'Ambar'),
(1403, 135, 'Caleta de Carquin'),
(1404, 135, 'Checras'),
(1405, 135, 'Hualmay'),
(1406, 135, 'Huaura'),
(1407, 135, 'Leoncio Prado'),
(1408, 135, 'Paccho'),
(1409, 135, 'Santa Leonor'),
(1410, 135, 'Santa María'),
(1411, 135, 'Sayan'),
(1412, 135, 'Vegueta'),
(1413, 136, 'Oyon'),
(1414, 136, 'Andajes'),
(1415, 136, 'Caujul'),
(1416, 136, 'Cochamarca'),
(1417, 136, 'Navan'),
(1418, 136, 'Pachangara'),
(1419, 137, 'Yauyos'),
(1420, 137, 'Alis'),
(1421, 137, 'Allauca'),
(1422, 137, 'Ayaviri'),
(1423, 137, 'Azángaro'),
(1424, 137, 'Cacra'),
(1425, 137, 'Carania'),
(1426, 137, 'Catahuasi'),
(1427, 137, 'Chocos'),
(1428, 137, 'Cochas'),
(1429, 137, 'Colonia'),
(1430, 137, 'Hongos'),
(1431, 137, 'Huampara'),
(1432, 137, 'Huancaya'),
(1433, 137, 'Huangascar'),
(1434, 137, 'Huantan'),
(1435, 137, 'Huañec'),
(1436, 137, 'Laraos'),
(1437, 137, 'Lincha'),
(1438, 137, 'Madean'),
(1439, 137, 'Miraflores'),
(1440, 137, 'Omas'),
(1441, 137, 'Putinza'),
(1442, 137, 'Quinches'),
(1443, 137, 'Quinocay'),
(1444, 137, 'San Joaquín'),
(1445, 137, 'San Pedro de Pilas'),
(1446, 137, 'Tanta'),
(1447, 137, 'Tauripampa'),
(1448, 137, 'Tomas'),
(1449, 137, 'Tupe'),
(1450, 137, 'Viñac'),
(1451, 137, 'Vitis'),
(1452, 138, 'Iquitos'),
(1453, 138, 'Alto Nanay'),
(1454, 138, 'Fernando Lores'),
(1455, 138, 'Indiana'),
(1456, 138, 'Las Amazonas'),
(1457, 138, 'Mazan'),
(1458, 138, 'Napo'),
(1459, 138, 'Punchana'),
(1460, 138, 'Torres Causana'),
(1461, 138, 'Belén'),
(1462, 138, 'San Juan Bautista'),
(1463, 139, 'Yurimaguas'),
(1464, 139, 'Balsapuerto'),
(1465, 139, 'Jeberos'),
(1466, 139, 'Lagunas'),
(1467, 139, 'Santa Cruz'),
(1468, 139, 'Teniente Cesar López Rojas'),
(1469, 140, 'Nauta'),
(1470, 140, 'Parinari'),
(1471, 140, 'Tigre'),
(1472, 140, 'Trompeteros'),
(1473, 140, 'Urarinas'),
(1474, 141, 'Ramón Castilla'),
(1475, 141, 'Pebas'),
(1476, 141, 'Yavari'),
(1477, 141, 'San Pablo'),
(1478, 142, 'Requena'),
(1479, 142, 'Alto Tapiche'),
(1480, 142, 'Capelo'),
(1481, 142, 'Emilio San Martín'),
(1482, 142, 'Maquia'),
(1483, 142, 'Puinahua'),
(1484, 142, 'Saquena'),
(1485, 142, 'Soplin'),
(1486, 142, 'Tapiche'),
(1487, 142, 'Jenaro Herrera'),
(1488, 142, 'Yaquerana'),
(1489, 143, 'Contamana'),
(1490, 143, 'Inahuaya'),
(1491, 143, 'Padre Márquez'),
(1492, 143, 'Pampa Hermosa'),
(1493, 143, 'Sarayacu'),
(1494, 143, 'Vargas Guerra'),
(1495, 144, 'Barranca'),
(1496, 144, 'Cahuapanas'),
(1497, 144, 'Manseriche'),
(1498, 144, 'Morona'),
(1499, 144, 'Pastaza'),
(1500, 144, 'Andoas'),
(1501, 145, 'Putumayo'),
(1502, 145, 'Rosa Panduro'),
(1503, 145, 'Teniente Manuel Clavero'),
(1504, 145, 'Yaguas'),
(1505, 146, 'Tambopata'),
(1506, 146, 'Inambari'),
(1507, 146, 'Las Piedras'),
(1508, 146, 'Laberinto'),
(1509, 147, 'Manu'),
(1510, 147, 'Fitzcarrald'),
(1511, 147, 'Madre de Dios'),
(1512, 147, 'Huepetuhe'),
(1513, 148, 'Iñapari'),
(1514, 148, 'Iberia'),
(1515, 148, 'Tahuamanu'),
(1516, 149, 'Moquegua'),
(1517, 149, 'Carumas'),
(1518, 149, 'Cuchumbaya'),
(1519, 149, 'Samegua'),
(1520, 149, 'San Cristóbal'),
(1521, 149, 'Torata'),
(1522, 150, 'Omate'),
(1523, 150, 'Chojata'),
(1524, 150, 'Coalaque'),
(1525, 150, 'Ichuña'),
(1526, 150, 'La Capilla'),
(1527, 150, 'Lloque'),
(1528, 150, 'Matalaque'),
(1529, 150, 'Puquina'),
(1530, 150, 'Quinistaquillas'),
(1531, 150, 'Ubinas'),
(1532, 150, 'Yunga'),
(1533, 151, 'Ilo'),
(1534, 151, 'El Algarrobal'),
(1535, 151, 'Pacocha'),
(1536, 152, 'Chaupimarca'),
(1537, 152, 'Huachon'),
(1538, 152, 'Huariaca'),
(1539, 152, 'Huayllay'),
(1540, 152, 'Ninacaca'),
(1541, 152, 'Pallanchacra'),
(1542, 152, 'Paucartambo'),
(1543, 152, 'San Francisco de Asís de Yarusyacan'),
(1544, 152, 'Simon Bolívar'),
(1545, 152, 'Ticlacayan'),
(1546, 152, 'Tinyahuarco'),
(1547, 152, 'Vicco'),
(1548, 152, 'Yanacancha'),
(1549, 153, 'Yanahuanca'),
(1550, 153, 'Chacayan'),
(1551, 153, 'Goyllarisquizga'),
(1552, 153, 'Paucar'),
(1553, 153, 'San Pedro de Pillao'),
(1554, 153, 'Santa Ana de Tusi'),
(1555, 153, 'Tapuc'),
(1556, 153, 'Vilcabamba'),
(1557, 154, 'Oxapampa'),
(1558, 154, 'Chontabamba'),
(1559, 154, 'Huancabamba'),
(1560, 154, 'Palcazu'),
(1561, 154, 'Pozuzo'),
(1562, 154, 'Puerto Bermúdez'),
(1563, 154, 'Villa Rica'),
(1564, 154, 'Constitución'),
(1565, 155, 'Piura'),
(1566, 155, 'Castilla'),
(1567, 155, 'Catacaos'),
(1568, 155, 'Cura Mori'),
(1569, 155, 'El Tallan'),
(1570, 155, 'La Arena'),
(1571, 155, 'La Unión'),
(1572, 155, 'Las Lomas'),
(1573, 155, 'Tambo Grande'),
(1574, 155, 'Veintiseis de Octubre'),
(1575, 156, 'Ayabaca'),
(1576, 156, 'Frias'),
(1577, 156, 'Jilili'),
(1578, 156, 'Lagunas'),
(1579, 156, 'Montero'),
(1580, 156, 'Pacaipampa'),
(1581, 156, 'Paimas'),
(1582, 156, 'Sapillica'),
(1583, 156, 'Sicchez'),
(1584, 156, 'Suyo'),
(1585, 157, 'Huancabamba'),
(1586, 157, 'Canchaque'),
(1587, 157, 'El Carmen de la Frontera'),
(1588, 157, 'Huarmaca'),
(1589, 157, 'Lalaquiz'),
(1590, 157, 'San Miguel de El Faique'),
(1591, 157, 'Sondor'),
(1592, 157, 'Sondorillo'),
(1593, 158, 'Chulucanas'),
(1594, 158, 'Buenos Aires'),
(1595, 158, 'Chalaco'),
(1596, 158, 'La Matanza'),
(1597, 158, 'Morropon'),
(1598, 158, 'Salitral'),
(1599, 158, 'San Juan de Bigote'),
(1600, 158, 'Santa Catalina de Mossa'),
(1601, 158, 'Santo Domingo'),
(1602, 158, 'Yamango'),
(1603, 159, 'Paita'),
(1604, 159, 'Amotape'),
(1605, 159, 'Arenal'),
(1606, 159, 'Colan'),
(1607, 159, 'La Huaca'),
(1608, 159, 'Tamarindo'),
(1609, 159, 'Vichayal'),
(1610, 160, 'Sullana'),
(1611, 160, 'Bellavista'),
(1612, 160, 'Ignacio Escudero'),
(1613, 160, 'Lancones'),
(1614, 160, 'Marcavelica'),
(1615, 160, 'Miguel Checa'),
(1616, 160, 'Querecotillo'),
(1617, 160, 'Salitral'),
(1618, 161, 'Pariñas'),
(1619, 161, 'El Alto'),
(1620, 161, 'La Brea'),
(1621, 161, 'Lobitos'),
(1622, 161, 'Los Organos'),
(1623, 161, 'Mancora'),
(1624, 162, 'Sechura'),
(1625, 162, 'Bellavista de la Unión'),
(1626, 162, 'Bernal'),
(1627, 162, 'Cristo Nos Valga'),
(1628, 162, 'Vice'),
(1629, 162, 'Rinconada Llicuar'),
(1630, 163, 'Puno'),
(1631, 163, 'Acora'),
(1632, 163, 'Amantani'),
(1633, 163, 'Atuncolla'),
(1634, 163, 'Capachica'),
(1635, 163, 'Chucuito'),
(1636, 163, 'Coata'),
(1637, 163, 'Huata'),
(1638, 163, 'Mañazo'),
(1639, 163, 'Paucarcolla'),
(1640, 163, 'Pichacani'),
(1641, 163, 'Plateria'),
(1642, 163, 'San Antonio'),
(1643, 163, 'Tiquillaca'),
(1644, 163, 'Vilque'),
(1645, 164, 'Azángaro'),
(1646, 164, 'Achaya'),
(1647, 164, 'Arapa'),
(1648, 164, 'Asillo'),
(1649, 164, 'Caminaca'),
(1650, 164, 'Chupa'),
(1651, 164, 'José Domingo Choquehuanca'),
(1652, 164, 'Muñani'),
(1653, 164, 'Potoni'),
(1654, 164, 'Saman'),
(1655, 164, 'San Anton'),
(1656, 164, 'San José'),
(1657, 164, 'San Juan de Salinas'),
(1658, 164, 'Santiago de Pupuja'),
(1659, 164, 'Tirapata'),
(1660, 165, 'Macusani'),
(1661, 165, 'Ajoyani'),
(1662, 165, 'Ayapata'),
(1663, 165, 'Coasa'),
(1664, 165, 'Corani'),
(1665, 165, 'Crucero'),
(1666, 165, 'Ituata'),
(1667, 165, 'Ollachea'),
(1668, 165, 'San Gaban'),
(1669, 165, 'Usicayos'),
(1670, 166, 'Juli'),
(1671, 166, 'Desaguadero'),
(1672, 166, 'Huacullani'),
(1673, 166, 'Kelluyo'),
(1674, 166, 'Pisacoma'),
(1675, 166, 'Pomata'),
(1676, 166, 'Zepita'),
(1677, 167, 'Ilave'),
(1678, 167, 'Capazo'),
(1679, 167, 'Pilcuyo'),
(1680, 167, 'Santa Rosa'),
(1681, 167, 'Conduriri'),
(1682, 168, 'Huancane'),
(1683, 168, 'Cojata'),
(1684, 168, 'Huatasani'),
(1685, 168, 'Inchupalla'),
(1686, 168, 'Pusi'),
(1687, 168, 'Rosaspata'),
(1688, 168, 'Taraco'),
(1689, 168, 'Vilque Chico'),
(1690, 169, 'Lampa'),
(1691, 169, 'Cabanilla'),
(1692, 169, 'Calapuja'),
(1693, 169, 'Nicasio'),
(1694, 169, 'Ocuviri'),
(1695, 169, 'Palca'),
(1696, 169, 'Paratia'),
(1697, 169, 'Pucara'),
(1698, 169, 'Santa Lucia'),
(1699, 169, 'Vilavila'),
(1700, 170, 'Ayaviri'),
(1701, 170, 'Antauta'),
(1702, 170, 'Cupi'),
(1703, 170, 'Llalli'),
(1704, 170, 'Macari'),
(1705, 170, 'Nuñoa'),
(1706, 170, 'Orurillo'),
(1707, 170, 'Santa Rosa'),
(1708, 170, 'Umachiri'),
(1709, 171, 'Moho'),
(1710, 171, 'Conima'),
(1711, 171, 'Huayrapata'),
(1712, 171, 'Tilali'),
(1713, 172, 'Putina'),
(1714, 172, 'Ananea'),
(1715, 172, 'Pedro Vilca Apaza'),
(1716, 172, 'Quilcapuncu'),
(1717, 172, 'Sina'),
(1718, 173, 'Juliaca'),
(1719, 173, 'Cabana'),
(1720, 173, 'Cabanillas'),
(1721, 173, 'Caracoto'),
(1722, 173, 'San Miguel'),
(1723, 174, 'Sandia'),
(1724, 174, 'Cuyocuyo'),
(1725, 174, 'Limbani'),
(1726, 174, 'Patambuco'),
(1727, 174, 'Phara'),
(1728, 174, 'Quiaca'),
(1729, 174, 'San Juan del Oro'),
(1730, 174, 'Yanahuaya'),
(1731, 174, 'Alto Inambari'),
(1732, 174, 'San Pedro de Putina Punco'),
(1733, 175, 'Yunguyo'),
(1734, 175, 'Anapia'),
(1735, 175, 'Copani'),
(1736, 175, 'Cuturapi'),
(1737, 175, 'Ollaraya'),
(1738, 175, 'Tinicachi'),
(1739, 175, 'Unicachi'),
(1740, 176, 'Moyobamba'),
(1741, 176, 'Calzada'),
(1742, 176, 'Habana'),
(1743, 176, 'Jepelacio'),
(1744, 176, 'Soritor'),
(1745, 176, 'Yantalo'),
(1746, 177, 'Bellavista'),
(1747, 177, 'Alto Biavo'),
(1748, 177, 'Bajo Biavo'),
(1749, 177, 'Huallaga'),
(1750, 177, 'San Pablo'),
(1751, 177, 'San Rafael'),
(1752, 178, 'San José de Sisa'),
(1753, 178, 'Agua Blanca'),
(1754, 178, 'San Martín'),
(1755, 178, 'Santa Rosa'),
(1756, 178, 'Shatoja'),
(1757, 179, 'Saposoa'),
(1758, 179, 'Alto Saposoa'),
(1759, 179, 'El Eslabón'),
(1760, 179, 'Piscoyacu'),
(1761, 179, 'Sacanche'),
(1762, 179, 'Tingo de Saposoa'),
(1763, 180, 'Lamas'),
(1764, 180, 'Alonso de Alvarado'),
(1765, 180, 'Barranquita'),
(1766, 180, 'Caynarachi'),
(1767, 180, 'Cuñumbuqui'),
(1768, 180, 'Pinto Recodo'),
(1769, 180, 'Rumisapa'),
(1770, 180, 'San Roque de Cumbaza'),
(1771, 180, 'Shanao'),
(1772, 180, 'Tabalosos'),
(1773, 180, 'Zapatero'),
(1774, 181, 'Juanjuí'),
(1775, 181, 'Campanilla'),
(1776, 181, 'Huicungo'),
(1777, 181, 'Pachiza'),
(1778, 181, 'Pajarillo'),
(1779, 182, 'Picota'),
(1780, 182, 'Buenos Aires'),
(1781, 182, 'Caspisapa'),
(1782, 182, 'Pilluana'),
(1783, 182, 'Pucacaca'),
(1784, 182, 'San Cristóbal'),
(1785, 182, 'San Hilarión'),
(1786, 182, 'Shamboyacu'),
(1787, 182, 'Tingo de Ponasa'),
(1788, 182, 'Tres Unidos'),
(1789, 183, 'Rioja'),
(1790, 183, 'Awajun'),
(1791, 183, 'Elías Soplin Vargas'),
(1792, 183, 'Nueva Cajamarca'),
(1793, 183, 'Pardo Miguel'),
(1794, 183, 'Posic'),
(1795, 183, 'San Fernando'),
(1796, 183, 'Yorongos'),
(1797, 183, 'Yuracyacu'),
(1798, 184, 'Tarapoto'),
(1799, 184, 'Alberto Leveau'),
(1800, 184, 'Cacatachi'),
(1801, 184, 'Chazuta'),
(1802, 184, 'Chipurana'),
(1803, 184, 'El Porvenir'),
(1804, 184, 'Huimbayoc'),
(1805, 184, 'Juan Guerra'),
(1806, 184, 'La Banda de Shilcayo'),
(1807, 184, 'Morales'),
(1808, 184, 'Papaplaya'),
(1809, 184, 'San Antonio'),
(1810, 184, 'Sauce'),
(1811, 184, 'Shapaja'),
(1812, 185, 'Tocache'),
(1813, 185, 'Nuevo Progreso'),
(1814, 185, 'Polvora'),
(1815, 185, 'Shunte'),
(1816, 185, 'Uchiza'),
(1817, 186, 'Tacna'),
(1818, 186, 'Alto de la Alianza'),
(1819, 186, 'Calana'),
(1820, 186, 'Ciudad Nueva'),
(1821, 186, 'Inclan'),
(1822, 186, 'Pachia'),
(1823, 186, 'Palca'),
(1824, 186, 'Pocollay'),
(1825, 186, 'Sama'),
(1826, 186, 'Coronel Gregorio Albarracín Lanchipa'),
(1827, 186, 'La Yarada los Palos'),
(1828, 187, 'Candarave'),
(1829, 187, 'Cairani'),
(1830, 187, 'Camilaca'),
(1831, 187, 'Curibaya'),
(1832, 187, 'Huanuara'),
(1833, 187, 'Quilahuani'),
(1834, 188, 'Locumba'),
(1835, 188, 'Ilabaya'),
(1836, 188, 'Ite'),
(1837, 189, 'Tarata'),
(1838, 189, 'Héroes Albarracín'),
(1839, 189, 'Estique'),
(1840, 189, 'Estique-Pampa'),
(1841, 189, 'Sitajara'),
(1842, 189, 'Susapaya'),
(1843, 189, 'Tarucachi'),
(1844, 189, 'Ticaco'),
(1845, 190, 'Tumbes'),
(1846, 190, 'Corrales'),
(1847, 190, 'La Cruz'),
(1848, 190, 'Pampas de Hospital'),
(1849, 190, 'San Jacinto'),
(1850, 190, 'San Juan de la Virgen'),
(1851, 191, 'Zorritos'),
(1852, 191, 'Casitas'),
(1853, 191, 'Canoas de Punta Sal'),
(1854, 192, 'Zarumilla'),
(1855, 192, 'Aguas Verdes'),
(1856, 192, 'Matapalo'),
(1857, 192, 'Papayal'),
(1858, 193, 'Calleria'),
(1859, 193, 'Campoverde'),
(1860, 193, 'Iparia'),
(1861, 193, 'Masisea'),
(1862, 193, 'Yarinacocha'),
(1863, 193, 'Nueva Requena'),
(1864, 193, 'Manantay'),
(1865, 194, 'Raymondi'),
(1866, 194, 'Sepahua'),
(1867, 194, 'Tahuania'),
(1868, 194, 'Yurua'),
(1869, 195, 'Padre Abad'),
(1870, 195, 'Irazola'),
(1871, 195, 'Curimana'),
(1872, 195, 'Neshuya'),
(1873, 195, 'Alexander Von Humboldt'),
(1874, 196, 'Purus');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `empresas`
--

DROP TABLE IF EXISTS `empresas`;
CREATE TABLE IF NOT EXISTS `empresas` (
  `idempresa` int(11) NOT NULL AUTO_INCREMENT,
  `razon_social` varchar(60) NOT NULL,
  `ruc` char(11) NOT NULL,
  `partida_elect` varchar(60) NOT NULL,
  `latitud` varchar(20) DEFAULT NULL,
  `longitud` varchar(20) DEFAULT NULL,
  `create_at` date NOT NULL DEFAULT curdate(),
  `update_at` date DEFAULT NULL,
  `inactive_at` date DEFAULT NULL,
  PRIMARY KEY (`idempresa`),
  UNIQUE KEY `uk_ruc_empresas` (`ruc`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Volcado de datos para la tabla `empresas`
--

INSERT INTO `empresas` (`idempresa`, `razon_social`, `ruc`, `partida_elect`, `latitud`, `longitud`, `create_at`, `update_at`, `inactive_at`) VALUES
(1, 'A.I. F CONTRATISTAS GENERALES S.A.C', '20494453003', '11013804 del Registro de Personas Jurídicas de CHINCHA-ICA', NULL, NULL, '2024-03-13', NULL, NULL),
(2, 'XYZ Construcciones S.A.C.', '12345678901', '78901234 del Registro de Empresas de Arequipa', NULL, NULL, '2024-03-13', NULL, NULL),
(3, 'Inversiones TechCorp S.A.', '98765432109', '56789012 del Registro de Empresas de Lima', NULL, NULL, '2024-03-13', NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `financieras`
--

DROP TABLE IF EXISTS `financieras`;
CREATE TABLE IF NOT EXISTS `financieras` (
  `idfinanciera` int(11) NOT NULL AUTO_INCREMENT,
  `ruc` char(11) NOT NULL,
  `razon_social` varchar(60) NOT NULL,
  `direccion` varchar(70) NOT NULL,
  PRIMARY KEY (`idfinanciera`),
  UNIQUE KEY `uk_ruc_finans` (`ruc`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Volcado de datos para la tabla `financieras`
--

INSERT INTO `financieras` (`idfinanciera`, `ruc`, `razon_social`, `direccion`) VALUES
(1, '12345678901', 'Financiera ABC', 'Calle Principal 123'),
(2, '98765432109', 'Financiera XYZ', 'Avenida Secundaria 456');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `lotes`
--

DROP TABLE IF EXISTS `lotes`;
CREATE TABLE IF NOT EXISTS `lotes` (
  `idlote` int(11) NOT NULL AUTO_INCREMENT,
  `idproyecto` int(11) NOT NULL,
  `estado_venta` varchar(10) NOT NULL DEFAULT 'SIN VENDER',
  `codigo` char(5) NOT NULL,
  `sublote` tinyint(4) NOT NULL,
  `urbanizacion` varchar(70) NOT NULL,
  `latitud` varchar(20) DEFAULT NULL,
  `longitud` varchar(20) DEFAULT NULL,
  `perimetro` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`perimetro`)),
  `moneda_venta` varchar(10) NOT NULL,
  `area_terreno` decimal(5,2) NOT NULL,
  `partida_elect` varchar(100) NOT NULL,
  `create_at` date NOT NULL DEFAULT curdate(),
  `update_at` date DEFAULT NULL,
  `inactive_at` date DEFAULT NULL,
  `idusuario` int(11) NOT NULL,
  PRIMARY KEY (`idlote`),
  UNIQUE KEY `uk_codigo_lotes` (`codigo`),
  UNIQUE KEY `uk_sublote_lotes` (`idproyecto`,`sublote`),
  KEY `fk_idusuario_lotes` (`idusuario`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Volcado de datos para la tabla `lotes`
--

INSERT INTO `lotes` (`idlote`, `idproyecto`, `estado_venta`, `codigo`, `sublote`, `urbanizacion`, `latitud`, `longitud`, `perimetro`, `moneda_venta`, `area_terreno`, `partida_elect`, `create_at`, `update_at`, `inactive_at`, `idusuario`) VALUES
(1, 1, 'VENDIDO', 'LT001', 17, 'SUB LOTE A-17 ZONA CALLE PROGRESO N°137', NULL, NULL, NULL, 'USD', 70.02, '11077471 del Registro de Propiedad Inmueble Zona Registral N: XI- Sede Ica', '2024-03-13', '2024-03-14', NULL, 1),
(2, 1, 'VENDIDO', 'LT002', 2, 'URBANIZACIÓN EL ROSAL', NULL, NULL, NULL, 'USD', 80.00, '11077472 del Registro de Propiedad Inmueble Zona Registral N: XI- Sede Ica', '2024-03-13', NULL, NULL, 2),
(3, 1, 'NO VENDIO', 'LT003', 3, 'LAS ACACIAS', NULL, NULL, NULL, 'USD', 65.75, '11077473 del Registro de Propiedad Inmueble Zona Registral N: XI- Sede Ica', '2024-03-13', '2024-03-14', NULL, 3),
(4, 1, 'VENDIDO', 'LT004', 4, 'VISTA HERMOSA', NULL, NULL, NULL, 'USD', 75.50, '11077474 del Registro de Propiedad Inmueble Zona Registral N: XI- Sede Ica', '2024-03-13', NULL, NULL, 4),
(5, 1, 'VENDIDO', 'LT005', 5, 'SAN MIGUEL', NULL, NULL, NULL, 'USD', 90.20, '11077475 del Registro de Propiedad Inmueble Zona Registral N: XI- Sede Ica', '2024-03-13', NULL, NULL, 5),
(6, 2, 'NO VENDIDO', 'LT006', 6, 'AVENIDA PRINCIPAL', NULL, NULL, NULL, 'USD', 100.00, '11077476 del Registro de Propiedad Inmueble Zona Registral N: XI- Sede Ica', '2024-03-13', NULL, NULL, 1),
(7, 2, 'SEPARADO', 'LT007', 7, 'CALLE ESPERANZA', NULL, NULL, NULL, 'USD', 85.50, '11077477 del Registro de Propiedad Inmueble Zona Registral N: XI- Sede Ica', '2024-03-13', NULL, NULL, 2),
(8, 2, 'VENDIDO', 'LT008', 8, 'PASEO DEL SOL', NULL, NULL, NULL, 'USD', 95.75, '11077478 del Registro de Propiedad Inmueble Zona Registral N: XI- Sede Ica', '2024-03-13', NULL, NULL, 3),
(9, 3, 'NO VENDIDO', 'LT009', 9, 'AVENIDA DEL MAR', NULL, NULL, NULL, 'USD', 110.25, '11077479 del Registro de Propiedad Inmueble Zona Registral N: XI- Sede Ica', '2024-03-13', NULL, NULL, 4),
(10, 3, 'SEPARADO', 'LT010', 10, 'CALLE SAN JUAN', NULL, NULL, NULL, 'USD', 120.00, '11077480 del Registro de Propiedad Inmueble Zona Registral N: XI- Sede Ica', '2024-03-13', NULL, NULL, 5),
(11, 3, 'VENDIDO', 'LT011', 11, 'PASEO DEL BOSQUE', NULL, NULL, NULL, 'USD', 130.50, '11077481 del Registro de Propiedad Inmueble Zona Registral N: XI- Sede Ica', '2024-03-13', NULL, NULL, 1),
(12, 3, 'NO VENDIDO', 'LT012', 12, 'CALLE NUEVA', NULL, NULL, NULL, 'USD', 145.75, '11077482 del Registro de Propiedad Inmueble Zona Registral N: XI- Sede Ica', '2024-03-13', NULL, NULL, 2),
(13, 4, 'SEPARADO', 'LT013', 13, 'AVENIDA LIBERTAD', NULL, NULL, NULL, 'USD', 155.25, '11077483 del Registro de Propiedad Inmueble Zona Registral N: XI- Sede Ica', '2024-03-13', NULL, NULL, 3),
(14, 4, 'VENDIDO', 'LT020', 14, 'PASEO DE LA LUNA', NULL, NULL, NULL, 'USD', 160.00, '11077484 del Registro de Propiedad Inmueble Zona Registral N: XI- Sede Ica', '2024-03-13', NULL, NULL, 4),
(15, 4, 'NO VENDIDO', 'LT021', 15, 'CALLE PRINCIPAL', NULL, NULL, NULL, 'USD', 170.50, '11077485 del Registro de Propiedad Inmueble Zona Registral N: XI- Sede Ica', '2024-03-13', NULL, NULL, 5),
(16, 6, 'VENDIDO', 'LT070', 1, 'Urbanización XYA', '12.3456', '-78.9101', '{\"puntos\": [{\"x\": 1, \"y\": 2}, {\"x\": 3, \"y\": 4}, {\"x\": 5, \"y\": 6}]}', 'USD', 200.00, 'Número de partida eléctronica', '2024-03-13', '2024-03-14', NULL, 12),
(17, 5, 'VENDIDO', 'LT023', 17, 'PASEO DE LAS ESTRELLAS', NULL, NULL, NULL, 'USD', 190.25, '11077487 del Registro de Propiedad Inmueble Zona Registral N: XI- Sede Ica', '2024-03-13', NULL, NULL, 2),
(18, 5, 'NO VENDIDO', 'LT024', 19, 'CALLE LA LUNA', NULL, NULL, NULL, 'USD', 200.50, '11077488 del Registro de Propiedad Inmueble Zona Registral N: XI- Sede Ica', '2024-03-13', NULL, NULL, 3),
(19, 5, 'SEPARADO', 'LT025', 20, 'AVENIDA DEL SOL', NULL, NULL, NULL, 'USD', 210.00, '11077489 del Registro de Propiedad Inmueble Zona Registral N: XI- Sede Ica', '2024-03-13', NULL, NULL, 4),
(20, 5, 'VENDIDO', 'LT026', 21, 'PASEO DE LA TIERRA', NULL, NULL, NULL, 'USD', 220.25, '11077490 del Registro de Propiedad Inmueble Zona Registral N: XI- Sede Ica', '2024-03-13', NULL, NULL, 5),
(21, 5, 'SEPARADO', 'LT027', 22, 'AVENIDA DEL CIELO', NULL, NULL, NULL, 'USD', 180.75, '11077486 del Registro de Propiedad Inmueble Zona Registral N: XI- Sede Ica', '2024-03-13', NULL, NULL, 1),
(22, 5, 'VENDIDO', 'LT028', 23, 'PASEO DE LAS ESTRELLAS', NULL, NULL, NULL, 'USD', 190.25, '11077487 del Registro de Propiedad Inmueble Zona Registral N: XI- Sede Ica', '2024-03-13', NULL, NULL, 2),
(23, 5, 'NO VENDIDO', 'LT029', 24, 'CALLE LA LUNA', NULL, NULL, NULL, 'USD', 200.50, '11077488 del Registro de Propiedad Inmueble Zona Registral N: XI- Sede Ica', '2024-03-13', NULL, NULL, 3),
(24, 5, 'SEPARADO', 'LT030', 25, 'AVENIDA DEL SOL', NULL, NULL, NULL, 'USD', 210.00, '11077489 del Registro de Propiedad Inmueble Zona Registral N: XI- Sede Ica', '2024-03-13', NULL, NULL, 4),
(25, 5, 'VENDIDO', 'LT031', 26, 'PASEO DE LA TIERRA', NULL, NULL, NULL, 'USD', 220.25, '11077490 del Registro de Propiedad Inmueble Zona Registral N: XI- Sede Ica', '2024-03-13', NULL, NULL, 5),
(26, 2, 'NO VENDIDO', 'LT032', 27, 'CALLE NUEVA ESPERANZA', NULL, NULL, NULL, 'USD', 230.50, '11077491 del Registro de Propiedad Inmueble Zona Registral N: XI- Sede Ica', '2024-03-13', NULL, NULL, 1),
(27, 3, 'SEPARADO', 'LT033', 28, 'AVENIDA PRINCIPAL', NULL, NULL, NULL, 'USD', 240.75, '11077492 del Registro de Propiedad Inmueble Zona Registral N: XI- Sede Ica', '2024-03-13', NULL, NULL, 2),
(28, 4, 'VENDIDO', 'LT034', 29, 'PASEO DEL PARQUE', NULL, NULL, NULL, 'USD', 250.00, '11077493 del Registro de Propiedad Inmueble Zona Registral N: XI- Sede Ica', '2024-03-13', NULL, NULL, 3),
(29, 2, 'NO VENDIDO', 'LT035', 30, 'CALLE DE LA ESPERANZA', NULL, NULL, NULL, 'USD', 260.25, '11077494 del Registro de Propiedad Inmueble Zona Registral N: XI- Sede Ica', '2024-03-13', NULL, NULL, 4),
(30, 3, 'SEPARADO', 'LT036', 31, 'AVENIDA DEL PROGRESO', NULL, NULL, NULL, 'USD', 270.50, '11077495 del Registro de Propiedad Inmueble Zona Registral N: XI- Sede Ica', '2024-03-13', NULL, NULL, 5),
(33, 1, 'VENDIDO', 'LT040', 1, 'Urbanización XYZ', '12.3456', '-78.9101', NULL, 'USD', 200.00, 'Número de partida eléctronica', '2024-03-14', NULL, NULL, 12);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `permisos`
--

DROP TABLE IF EXISTS `permisos`;
CREATE TABLE IF NOT EXISTS `permisos` (
  `idpermiso` int(11) NOT NULL AUTO_INCREMENT,
  `idrol` int(11) NOT NULL,
  `modulo` varchar(60) NOT NULL,
  `create_at` date NOT NULL DEFAULT curdate(),
  `update_at` date DEFAULT NULL,
  `inactive_at` date DEFAULT NULL,
  PRIMARY KEY (`idpermiso`),
  KEY `fk_idrol_permis` (`idrol`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Volcado de datos para la tabla `permisos`
--

INSERT INTO `permisos` (`idpermiso`, `idrol`, `modulo`, `create_at`, `update_at`, `inactive_at`) VALUES
(1, 1, 'LISTAR-LOTES', '2024-03-13', NULL, NULL),
(2, 1, 'EDITAR-CLIENTES', '2024-03-13', NULL, NULL),
(3, 1, 'CREAR-VENTAS', '2024-03-13', NULL, NULL),
(4, 1, 'ELIMINAR-PROYECTOS', '2024-03-13', NULL, NULL),
(5, 2, 'LISTAR-PROYECTOS', '2024-03-13', NULL, NULL),
(6, 2, 'EDITAR-LOTES', '2024-03-13', NULL, NULL),
(7, 2, 'CREAR-CLIENTES', '2024-03-13', NULL, NULL),
(8, 2, 'ELIMINAR-VENTAS', '2024-03-13', NULL, NULL),
(9, 3, 'LISTAR-CLIENTES', '2024-03-13', NULL, NULL),
(10, 3, 'EDITAR-VENTAS', '2024-03-13', NULL, NULL),
(11, 3, 'CREAR-LOTES', '2024-03-13', NULL, NULL),
(12, 3, 'ELIMINAR-PROYECTOS', '2024-03-13', NULL, NULL),
(13, 4, 'LISTAR-VENTAS', '2024-03-13', NULL, NULL),
(14, 4, 'EDITAR-PROYECTOS', '2024-03-13', NULL, NULL),
(15, 4, 'CREAR-CLIENTES', '2024-03-13', NULL, NULL),
(16, 4, 'ELIMINAR-LOTES', '2024-03-13', NULL, NULL),
(17, 5, 'LISTAR-PROYECTOS', '2024-03-13', NULL, NULL),
(18, 5, 'EDITAR-LOTES', '2024-03-13', NULL, NULL),
(19, 5, 'CREAR-VENTAS', '2024-03-13', NULL, NULL),
(20, 5, 'ELIMINAR-CLIENTES', '2024-03-13', NULL, NULL),
(21, 6, 'LISTAR-LOTES', '2024-03-13', NULL, NULL),
(22, 6, 'EDITAR-CLIENTES', '2024-03-13', NULL, NULL),
(23, 6, 'CREAR-VENTAS', '2024-03-13', NULL, NULL),
(24, 6, 'ELIMINAR-PROYECTOS', '2024-03-13', NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `presupuestos`
--

DROP TABLE IF EXISTS `presupuestos`;
CREATE TABLE IF NOT EXISTS `presupuestos` (
  `idpresupuesto` int(11) NOT NULL AUTO_INCREMENT,
  `idlote` int(11) NOT NULL,
  `descripcion` varchar(70) NOT NULL,
  `fecha_program` date NOT NULL,
  `create_at` date NOT NULL DEFAULT curdate(),
  `update_at` date DEFAULT NULL,
  `inactive_at` date DEFAULT NULL,
  `idusuario` int(11) NOT NULL,
  PRIMARY KEY (`idpresupuesto`),
  KEY `fk_idlote_presup` (`idlote`),
  KEY `fk_idusuario_presup` (`idusuario`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Volcado de datos para la tabla `presupuestos`
--

INSERT INTO `presupuestos` (`idpresupuesto`, `idlote`, `descripcion`, `fecha_program`, `create_at`, `update_at`, `inactive_at`, `idusuario`) VALUES
(1, 2, 'Materiales de construcción', '2024-03-10', '2024-03-13', NULL, NULL, 1),
(2, 5, 'Materiales de construcción', '2024-03-15', '2024-03-13', NULL, NULL, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `provincias`
--

DROP TABLE IF EXISTS `provincias`;
CREATE TABLE IF NOT EXISTS `provincias` (
  `idprovincia` int(11) NOT NULL AUTO_INCREMENT,
  `iddepartamento` int(11) NOT NULL,
  `provincia` varchar(45) NOT NULL,
  PRIMARY KEY (`idprovincia`),
  KEY `fk_iddepartamento_provin` (`iddepartamento`)
) ENGINE=InnoDB AUTO_INCREMENT=197 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Volcado de datos para la tabla `provincias`
--

INSERT INTO `provincias` (`idprovincia`, `iddepartamento`, `provincia`) VALUES
(1, 1, 'Chachapoyas'),
(2, 1, 'Bagua'),
(3, 1, 'Bongará'),
(4, 1, 'Condorcanqui'),
(5, 1, 'Luya'),
(6, 1, 'Rodríguez de Mendoza'),
(7, 1, 'Utcubamba'),
(8, 2, 'Huaraz'),
(9, 2, 'Aija'),
(10, 2, 'Antonio Raymondi'),
(11, 2, 'Asunción'),
(12, 2, 'Bolognesi'),
(13, 2, 'Carhuaz'),
(14, 2, 'Carlos Fermín Fitzcarrald'),
(15, 2, 'Casma'),
(16, 2, 'Corongo'),
(17, 2, 'Huari'),
(18, 2, 'Huarmey'),
(19, 2, 'Huaylas'),
(20, 2, 'Mariscal Luzuriaga'),
(21, 2, 'Ocros'),
(22, 2, 'Pallasca'),
(23, 2, 'Pomabamba'),
(24, 2, 'Recuay'),
(25, 2, 'Santa'),
(26, 2, 'Sihuas'),
(27, 2, 'Yungay'),
(28, 3, 'Abancay'),
(29, 3, 'Andahuaylas'),
(30, 3, 'Antabamba'),
(31, 3, 'Aymaraes'),
(32, 3, 'Cotabambas'),
(33, 3, 'Chincheros'),
(34, 3, 'Grau'),
(35, 4, 'Arequipa'),
(36, 4, 'Camaná'),
(37, 4, 'Caravelí'),
(38, 4, 'Castilla'),
(39, 4, 'Caylloma'),
(40, 4, 'Condesuyos'),
(41, 4, 'Islay'),
(42, 4, 'La Uniòn'),
(43, 5, 'Huamanga'),
(44, 5, 'Cangallo'),
(45, 5, 'Huanca Sancos'),
(46, 5, 'Huanta'),
(47, 5, 'La Mar'),
(48, 5, 'Lucanas'),
(49, 5, 'Parinacochas'),
(50, 5, 'Pàucar del Sara Sara'),
(51, 5, 'Sucre'),
(52, 5, 'Víctor Fajardo'),
(53, 5, 'Vilcas Huamán'),
(54, 6, 'Cajamarca'),
(55, 6, 'Cajabamba'),
(56, 6, 'Celendín'),
(57, 6, 'Chota'),
(58, 6, 'Contumazá'),
(59, 6, 'Cutervo'),
(60, 6, 'Hualgayoc'),
(61, 6, 'Jaén'),
(62, 6, 'San Ignacio'),
(63, 6, 'San Marcos'),
(64, 6, 'San Miguel'),
(65, 6, 'San Pablo'),
(66, 6, 'Santa Cruz'),
(67, 7, 'Prov. Const. del Callao'),
(68, 8, 'Cusco'),
(69, 8, 'Acomayo'),
(70, 8, 'Anta'),
(71, 8, 'Calca'),
(72, 8, 'Canas'),
(73, 8, 'Canchis'),
(74, 8, 'Chumbivilcas'),
(75, 8, 'Espinar'),
(76, 8, 'La Convención'),
(77, 8, 'Paruro'),
(78, 8, 'Paucartambo'),
(79, 8, 'Quispicanchi'),
(80, 8, 'Urubamba'),
(81, 9, 'Huancavelica'),
(82, 9, 'Acobamba'),
(83, 9, 'Angaraes'),
(84, 9, 'Castrovirreyna'),
(85, 9, 'Churcampa'),
(86, 9, 'Huaytará'),
(87, 9, 'Tayacaja'),
(88, 10, 'Huánuco'),
(89, 10, 'Ambo'),
(90, 10, 'Dos de Mayo'),
(91, 10, 'Huacaybamba'),
(92, 10, 'Huamalíes'),
(93, 10, 'Leoncio Prado'),
(94, 10, 'Marañón'),
(95, 10, 'Pachitea'),
(96, 10, 'Puerto Inca'),
(97, 10, 'Lauricocha '),
(98, 10, 'Yarowilca '),
(99, 11, 'Ica '),
(100, 11, 'Chincha '),
(101, 11, 'Nasca '),
(102, 11, 'Palpa '),
(103, 11, 'Pisco '),
(104, 12, 'Huancayo '),
(105, 12, 'Concepción '),
(106, 12, 'Chanchamayo '),
(107, 12, 'Jauja '),
(108, 12, 'Junín '),
(109, 12, 'Satipo '),
(110, 12, 'Tarma '),
(111, 12, 'Yauli '),
(112, 12, 'Chupaca '),
(113, 13, 'Trujillo '),
(114, 13, 'Ascope '),
(115, 13, 'Bolívar '),
(116, 13, 'Chepén '),
(117, 13, 'Julcán '),
(118, 13, 'Otuzco '),
(119, 13, 'Pacasmayo '),
(120, 13, 'Pataz '),
(121, 13, 'Sánchez Carrión '),
(122, 13, 'Santiago de Chuco '),
(123, 13, 'Gran Chimú '),
(124, 13, 'Virú '),
(125, 14, 'Chiclayo '),
(126, 14, 'Ferreñafe '),
(127, 14, 'Lambayeque '),
(128, 15, 'Lima '),
(129, 15, 'Barranca '),
(130, 15, 'Cajatambo '),
(131, 15, 'Canta '),
(132, 15, 'Cañete '),
(133, 15, 'Huaral '),
(134, 15, 'Huarochirí '),
(135, 15, 'Huaura '),
(136, 15, 'Oyón '),
(137, 15, 'Yauyos '),
(138, 16, 'Maynas '),
(139, 16, 'Alto Amazonas '),
(140, 16, 'Loreto '),
(141, 16, 'Mariscal Ramón Castilla '),
(142, 16, 'Requena '),
(143, 16, 'Ucayali '),
(144, 16, 'Datem del Marañón '),
(145, 16, 'Putumayo'),
(146, 17, 'Tambopata '),
(147, 17, 'Manu '),
(148, 17, 'Tahuamanu '),
(149, 18, 'Mariscal Nieto '),
(150, 18, 'General Sánchez Cerro '),
(151, 18, 'Ilo '),
(152, 19, 'Pasco '),
(153, 19, 'Daniel Alcides Carrión '),
(154, 19, 'Oxapampa '),
(155, 20, 'Piura '),
(156, 20, 'Ayabaca '),
(157, 20, 'Huancabamba '),
(158, 20, 'Morropón '),
(159, 20, 'Paita '),
(160, 20, 'Sullana '),
(161, 20, 'Talara '),
(162, 20, 'Sechura '),
(163, 21, 'Puno '),
(164, 21, 'Azángaro '),
(165, 21, 'Carabaya '),
(166, 21, 'Chucuito '),
(167, 21, 'El Collao '),
(168, 21, 'Huancané '),
(169, 21, 'Lampa '),
(170, 21, 'Melgar '),
(171, 21, 'Moho '),
(172, 21, 'San Antonio de Putina '),
(173, 21, 'San Román '),
(174, 21, 'Sandia '),
(175, 21, 'Yunguyo '),
(176, 22, 'Moyobamba '),
(177, 22, 'Bellavista '),
(178, 22, 'El Dorado '),
(179, 22, 'Huallaga '),
(180, 22, 'Lamas '),
(181, 22, 'Mariscal Cáceres '),
(182, 22, 'Picota '),
(183, 22, 'Rioja '),
(184, 22, 'San Martín '),
(185, 22, 'Tocache '),
(186, 23, 'Tacna '),
(187, 23, 'Candarave '),
(188, 23, 'Jorge Basadre '),
(189, 23, 'Tarata '),
(190, 24, 'Tumbes '),
(191, 24, 'Contralmirante Villar '),
(192, 24, 'Zarumilla '),
(193, 25, 'Coronel Portillo '),
(194, 25, 'Atalaya '),
(195, 25, 'Padre Abad '),
(196, 25, 'Purús');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `proyectos`
--

DROP TABLE IF EXISTS `proyectos`;
CREATE TABLE IF NOT EXISTS `proyectos` (
  `idproyecto` int(11) NOT NULL AUTO_INCREMENT,
  `imagen` varchar(100) DEFAULT NULL,
  `iddireccion` int(11) NOT NULL,
  `codigo` varchar(20) NOT NULL,
  `denominacion` varchar(30) NOT NULL,
  `latitud` varchar(20) DEFAULT NULL,
  `longitud` varchar(20) DEFAULT NULL,
  `perimetro` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`perimetro`)),
  `iddistrito` int(11) NOT NULL,
  `direccion` varchar(70) NOT NULL,
  `create_at` date NOT NULL DEFAULT curdate(),
  `update_at` date DEFAULT NULL,
  `inactive_at` date DEFAULT NULL,
  `idusuario` int(11) NOT NULL,
  PRIMARY KEY (`idproyecto`),
  UNIQUE KEY `uk_codigo_proyects` (`codigo`),
  UNIQUE KEY `uk_denominacion_proyects` (`denominacion`),
  KEY `fk_iddireccion_proyects` (`iddireccion`),
  KEY `fk_iddistrito_proyects` (`iddistrito`),
  KEY `fk_idusuario_proyects` (`idusuario`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Volcado de datos para la tabla `proyectos`
--

INSERT INTO `proyectos` (`idproyecto`, `imagen`, `iddireccion`, `codigo`, `denominacion`, `latitud`, `longitud`, `perimetro`, `iddistrito`, `direccion`, `create_at`, `update_at`, `inactive_at`, `idusuario`) VALUES
(1, NULL, 1, 'A-12 SAN BLAS', 'RESIDENCIAL SAN BLAS', NULL, NULL, NULL, 1007, 'Dirección A-12 SAN BLAS', '2024-03-13', NULL, NULL, 1),
(2, NULL, 1, 'A-17 SAN PEDRO', 'RESIDENCIAL SAN PABLO', NULL, NULL, NULL, 1007, 'Dirección A-17 SAN PEDRO', '2024-03-13', NULL, NULL, 2),
(3, NULL, 1, 'A-13 Santo Domingo', 'RESIDENCIAL Santo Domingo', NULL, NULL, NULL, 1007, 'Dirección Santo Domingo', '2024-03-13', NULL, NULL, 3),
(4, NULL, 1, 'A-14 Centenario II', 'RESIDENCIAL Centenario II', NULL, NULL, NULL, 1007, 'Dirección Centenario II', '2024-03-13', NULL, NULL, 4),
(5, NULL, 1, 'A-15 Kalea Playa', 'Kalea Playa', NULL, NULL, NULL, 1007, 'Dirección Kalea Playa', '2024-03-13', NULL, NULL, 5),
(6, NULL, 3, 'B-20 PUERTO RICO', 'GRAN RESIDENCIAL PUERTO RICO', NULL, NULL, NULL, 15, 'CALLE LOS ROSALES 123', '2024-03-14', '2024-03-14', NULL, 3);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `roles`
--

DROP TABLE IF EXISTS `roles`;
CREATE TABLE IF NOT EXISTS `roles` (
  `idrol` int(11) NOT NULL AUTO_INCREMENT,
  `rol` varchar(30) NOT NULL,
  `estado` char(1) NOT NULL DEFAULT '1',
  `create_at` date NOT NULL DEFAULT curdate(),
  `update_at` date DEFAULT NULL,
  `inactive_at` date DEFAULT NULL,
  PRIMARY KEY (`idrol`),
  UNIQUE KEY `uk_rol_roles` (`rol`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Volcado de datos para la tabla `roles`
--

INSERT INTO `roles` (`idrol`, `rol`, `estado`, `create_at`, `update_at`, `inactive_at`) VALUES
(1, 'REPRESENTANTE DE VENTAS 1', '1', '2024-03-13', NULL, NULL),
(2, 'REPRESENTANTE DE VENTAS 2', '1', '2024-03-13', NULL, NULL),
(3, 'ADMINISTRADOR PRINCIPAL', '1', '2024-03-13', NULL, NULL),
(4, 'ADMINISTRADOR AASISTENTE', '1', '2024-03-13', NULL, NULL),
(5, 'ADMINISTRADOR SECUNDARIO', '1', '2024-03-13', NULL, NULL),
(6, 'VENDEDOR', '1', '2024-03-13', NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `separaciones`
--

DROP TABLE IF EXISTS `separaciones`;
CREATE TABLE IF NOT EXISTS `separaciones` (
  `idseparacion` int(11) NOT NULL AUTO_INCREMENT,
  `idlote` int(11) NOT NULL,
  `idvend_representante` int(11) NOT NULL,
  `idcliente` int(11) NOT NULL,
  `separacion` decimal(5,2) NOT NULL,
  `fecha_pago` date NOT NULL,
  `penalidad_porcent` tinyint(4) NOT NULL,
  `fecha_devolucion` date DEFAULT NULL,
  `estado` varchar(10) NOT NULL,
  `create_at` date NOT NULL DEFAULT curdate(),
  `update_at` date DEFAULT NULL,
  `inactive_at` date DEFAULT NULL,
  `idusuario` int(11) NOT NULL,
  PRIMARY KEY (`idseparacion`),
  KEY `fk_idlote_sep` (`idlote`),
  KEY `fk_idvend_representante_sep` (`idvend_representante`),
  KEY `fk_idcliente_sep` (`idcliente`),
  KEY `fk_idusuario_sep` (`idusuario`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Volcado de datos para la tabla `separaciones`
--

INSERT INTO `separaciones` (`idseparacion`, `idlote`, `idvend_representante`, `idcliente`, `separacion`, `fecha_pago`, `penalidad_porcent`, `fecha_devolucion`, `estado`, `create_at`, `update_at`, `inactive_at`, `idusuario`) VALUES
(1, 1, 1, 1, 150.50, '2024-03-08', 5, NULL, 'Activo', '2024-03-08', NULL, NULL, 1),
(2, 5, 1, 1, 150.50, '2024-03-08', 5, NULL, 'Activo', '2024-03-08', NULL, NULL, 1),
(3, 6, 1, 1, 150.50, '2024-03-08', 5, NULL, 'Activo', '2024-03-08', NULL, NULL, 1),
(4, 3, 1, 1, 150.50, '2024-03-08', 5, NULL, 'Activo', '2024-03-08', NULL, NULL, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sustentos_cuotas`
--

DROP TABLE IF EXISTS `sustentos_cuotas`;
CREATE TABLE IF NOT EXISTS `sustentos_cuotas` (
  `idsustento_cuota` int(11) NOT NULL AUTO_INCREMENT,
  `idcuota` int(11) NOT NULL,
  `ruta` varchar(100) NOT NULL,
  `create_at` date NOT NULL DEFAULT curdate(),
  `update_at` date DEFAULT NULL,
  `inactive_at` date DEFAULT NULL,
  `idusuario` int(11) NOT NULL,
  PRIMARY KEY (`idsustento_cuota`),
  KEY `fk_idcuota_sust_cuo` (`idcuota`),
  KEY `fk_idusuario_sust_cuo` (`idusuario`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Volcado de datos para la tabla `sustentos_cuotas`
--

INSERT INTO `sustentos_cuotas` (`idsustento_cuota`, `idcuota`, `ruta`, `create_at`, `update_at`, `inactive_at`, `idusuario`) VALUES
(1, 1, '/ruta/imagen1.jpg', '2024-03-13', NULL, NULL, 1),
(2, 1, '/ruta/imagen2.jpg', '2024-03-13', NULL, NULL, 1),
(3, 2, '/ruta/imagen1.jpg', '2024-03-13', NULL, NULL, 1),
(4, 2, '/ruta/imagen2.jpg', '2024-03-13', NULL, NULL, 1),
(5, 3, '/ruta/imagen1.jpg', '2024-03-13', NULL, NULL, 2),
(6, 3, '/ruta/imagen2.jpg', '2024-03-13', NULL, NULL, 2),
(7, 4, '/ruta/imagen1.jpg', '2024-03-13', NULL, NULL, 2),
(8, 4, '/ruta/imagen2.jpg', '2024-03-13', NULL, NULL, 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sustentos_sep`
--

DROP TABLE IF EXISTS `sustentos_sep`;
CREATE TABLE IF NOT EXISTS `sustentos_sep` (
  `idsustento_sep` int(11) NOT NULL AUTO_INCREMENT,
  `idseparacion` int(11) NOT NULL,
  `ruta` varchar(100) NOT NULL,
  `create_at` date NOT NULL DEFAULT curdate(),
  `update_at` date DEFAULT NULL,
  `inactive_at` date DEFAULT NULL,
  `idusuario` int(11) NOT NULL,
  PRIMARY KEY (`idsustento_sep`),
  KEY `fk_idseparacion_sust_sep` (`idseparacion`),
  KEY `fk_idusuario_sust_sep` (`idusuario`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Volcado de datos para la tabla `sustentos_sep`
--

INSERT INTO `sustentos_sep` (`idsustento_sep`, `idseparacion`, `ruta`, `create_at`, `update_at`, `inactive_at`, `idusuario`) VALUES
(1, 1, '/ruta/del/sustento1.pdf', '2024-03-13', NULL, NULL, 1),
(2, 1, '/ruta/del/sustento2.pdf', '2024-03-13', NULL, NULL, 2),
(3, 1, '/ruta/del/sustento3.pdf', '2024-03-13', NULL, NULL, 1),
(4, 1, '/ruta/del/sustento4.pdf', '2024-03-13', NULL, NULL, 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
CREATE TABLE IF NOT EXISTS `usuarios` (
  `idusuario` int(11) NOT NULL AUTO_INCREMENT,
  `imagen` varchar(100) DEFAULT NULL,
  `nombres` varchar(40) NOT NULL,
  `apellidos` varchar(20) NOT NULL,
  `documento_tipo` varchar(20) NOT NULL,
  `documento_nro` varchar(12) NOT NULL,
  `estado_civil` varchar(20) NOT NULL,
  `iddistrito` int(11) NOT NULL,
  `direccion` varchar(60) NOT NULL,
  `correo` varchar(60) NOT NULL,
  `contraseña` varchar(60) NOT NULL,
  `codigo` char(9) DEFAULT NULL,
  `idrol` int(11) NOT NULL,
  `iddireccion` int(11) NOT NULL,
  `partida_elect` varchar(60) DEFAULT NULL,
  `create_at` date NOT NULL DEFAULT curdate(),
  `update_at` date DEFAULT NULL,
  `inactive_at` date DEFAULT NULL,
  PRIMARY KEY (`idusuario`),
  UNIQUE KEY `uk_documento_nro_usu` (`documento_nro`),
  UNIQUE KEY `uk_correo_us` (`correo`),
  KEY `fk_iddistrito_usu` (`iddistrito`),
  KEY `fk_idrol_usu` (`idrol`),
  KEY `fk_iddireccion_usu` (`iddireccion`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`idusuario`, `imagen`, `nombres`, `apellidos`, `documento_tipo`, `documento_nro`, `estado_civil`, `iddistrito`, `direccion`, `correo`, `contraseña`, `codigo`, `idrol`, `iddireccion`, `partida_elect`, `create_at`, `update_at`, `inactive_at`) VALUES
(1, NULL, 'Juan Carlos', 'González Pérez', 'DNI', '11111111', 'Soltero', 1, 'Calle A 123', 'juancarlos@gmail.com', 'contraseña1', NULL, 1, 1, NULL, '2024-03-13', NULL, NULL),
(2, NULL, 'María José', 'Hernández López', 'DNI', '22222222', 'Casada', 2, 'Calle B 456', 'mariajose@gmail.com', 'contraseña2', NULL, 2, 1, NULL, '2024-03-13', NULL, NULL),
(3, NULL, 'Pedro Luis', 'Díaz Martínez', 'DNI', '33333333', 'Divorciado', 3, 'Calle C 789', 'pedroluis@gmail.com', 'contraseña3', NULL, 3, 1, NULL, '2024-03-13', NULL, NULL),
(4, NULL, 'Ana Sofía', 'López Sánchez', 'DNI', '44444444', 'Soltera', 4, 'Calle D 012', 'anasofia@gmail.com', 'contraseña4', NULL, 4, 1, NULL, '2024-03-13', NULL, NULL),
(5, NULL, 'José María', 'Martínez Gómez', 'DNI', '55555555', 'Viuda', 5, 'Calle E 345', 'josemaria@gmail.com', 'contraseña5', NULL, 5, 1, NULL, '2024-03-13', NULL, NULL),
(6, NULL, 'Luisa Elena', 'Gómez Rodríguez', 'DNI', '66666666', 'Casado', 6, 'Calle F 678', 'luisaelena@gmail.com', 'contraseña6', NULL, 6, 1, NULL, '2024-03-13', NULL, NULL),
(7, NULL, 'Jorge Pablo', 'Rodríguez García', 'DNI', '77777777', 'Soltera', 7, 'Calle G 901', 'jorgepablo@gmail.com', 'contraseña7', NULL, 6, 1, NULL, '2024-03-13', NULL, NULL),
(8, NULL, 'Carlos Antonio', 'Fernández Martín', 'DNI', '88888888', 'Casado', 8, 'Calle H 234', 'carlosantonio@gmail.com', 'contraseña8', NULL, 1, 2, NULL, '2024-03-13', NULL, NULL),
(9, NULL, 'María Carmen', 'Sánchez López', 'DNI', '99999999', 'Soltera', 9, 'Calle I 567', 'mariacarmen@gmail.com', 'contraseña9', NULL, 2, 2, NULL, '2024-03-13', NULL, NULL),
(10, NULL, 'Francisco Javier', 'Gómez Rodríguez', 'DNI', '10101010', 'Divorciado', 10, 'Calle J 890', 'franciscojavier@gmail.com', 'contraseña10', NULL, 3, 2, NULL, '2024-03-13', NULL, NULL),
(11, NULL, 'Elena Isabel', 'Díaz García', 'DNI', '11111112', 'Casado', 11, 'Calle K 111', 'elenaisabel@gmail.com', 'contraseña11', NULL, 4, 2, NULL, '2024-03-13', NULL, NULL),
(12, NULL, 'Pedro Luis', 'Martínez López', 'DNI', '12121212', 'Soltera', 12, 'Calle L 222', 'pedroluis2@gmail.com', 'contraseña12', NULL, 5, 2, NULL, '2024-03-13', NULL, NULL),
(13, NULL, 'María Isabel', 'García Pérez', 'DNI', '13131313', 'Casado', 13, 'Calle M 333', 'mariaisabel@gmail.com', 'contraseña13', NULL, 6, 2, NULL, '2024-03-13', NULL, NULL),
(14, NULL, 'Antonio José', 'Hernández Martín', 'DNI', '14141414', 'Soltera', 14, 'Calle N 444', 'antoniojose@gmail.com', 'contraseña14', NULL, 6, 2, NULL, '2024-03-13', NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `vend_representantes`
--

DROP TABLE IF EXISTS `vend_representantes`;
CREATE TABLE IF NOT EXISTS `vend_representantes` (
  `idvend_representante` int(11) NOT NULL AUTO_INCREMENT,
  `idvendedor` int(11) NOT NULL,
  `idrepresentante` int(11) NOT NULL,
  `create_at` date NOT NULL DEFAULT curdate(),
  `update_at` date DEFAULT NULL,
  `inactive_at` date DEFAULT NULL,
  `idusuario` int(11) NOT NULL,
  PRIMARY KEY (`idvend_representante`),
  UNIQUE KEY `uk_vendRepresent_vend_representss` (`idvendedor`,`idrepresentante`),
  KEY `fk_idrepresent_vend_represents` (`idrepresentante`),
  KEY `fk_idusuario_vend_represents` (`idusuario`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Volcado de datos para la tabla `vend_representantes`
--

INSERT INTO `vend_representantes` (`idvend_representante`, `idvendedor`, `idrepresentante`, `create_at`, `update_at`, `inactive_at`, `idusuario`) VALUES
(1, 6, 1, '2024-03-13', NULL, NULL, 1),
(2, 7, 2, '2024-03-13', NULL, NULL, 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `viviendas`
--

DROP TABLE IF EXISTS `viviendas`;
CREATE TABLE IF NOT EXISTS `viviendas` (
  `idvivienda` int(11) NOT NULL AUTO_INCREMENT,
  `idlote` int(11) NOT NULL,
  `imagen` varchar(100) DEFAULT NULL,
  `tipo_casa` char(8) NOT NULL,
  `area_construccion` decimal(5,2) NOT NULL,
  `area_techada` decimal(5,2) NOT NULL,
  `airesm2` decimal(5,2) DEFAULT NULL,
  `zcomunes_porcent` tinyint(4) DEFAULT NULL,
  `estacionamiento_nro` tinyint(4) DEFAULT NULL,
  `detalles` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`detalles`)),
  `create_at` date NOT NULL DEFAULT curdate(),
  `update_at` date DEFAULT NULL,
  `inactive_at` date DEFAULT NULL,
  `idusuario` int(11) NOT NULL,
  PRIMARY KEY (`idvivienda`),
  KEY `fk_idlote_vivien` (`idlote`),
  KEY `fk_idusuario_vinve` (`idusuario`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Volcado de datos para la tabla `viviendas`
--

INSERT INTO `viviendas` (`idvivienda`, `idlote`, `imagen`, `tipo_casa`, `area_construccion`, `area_techada`, `airesm2`, `zcomunes_porcent`, `estacionamiento_nro`, `detalles`, `create_at`, `update_at`, `inactive_at`, `idusuario`) VALUES
(1, 1, NULL, 'CUH C001', 70.00, 70.00, NULL, NULL, 5, '{\"otros_detalles\": \"Información adicional para la vivienda 1\"}', '2024-03-13', NULL, NULL, 1),
(2, 2, NULL, 'CUH C001', 55.25, 55.25, NULL, NULL, 6, '{\"otros_detalles\": \"Información adicional para la vivienda 2\"}', '2024-03-13', NULL, NULL, 2),
(3, 3, NULL, 'CUH C001', 65.75, 65.75, NULL, 8, NULL, '{\"otros_detalles\": \"Información adicional para la vivienda 3\"}', '2024-03-13', NULL, NULL, 3),
(4, 4, NULL, 'CUH C001', 80.25, 80.25, NULL, NULL, 8, '{\"otros_detalles\": \"Información adicional para la vivienda 4\"}', '2024-03-13', NULL, NULL, 4),
(5, 5, NULL, 'CUH C001', 90.00, 90.00, NULL, NULL, 10, '{\"otros_detalles\": \"Información adicional para la vivienda 5\"}', '2024-03-13', NULL, NULL, 5),
(6, 1, NULL, 'CUH C002', 100.00, 100.00, NULL, 12, NULL, '{\"otros_detalles\": \"Información adicional para la vivienda 6\"}', '2024-03-13', NULL, NULL, 1),
(7, 2, NULL, 'CUH C002', 110.00, 110.00, NULL, 15, NULL, '{\"otros_detalles\": \"Información adicional para la vivienda 7\"}', '2024-03-13', NULL, NULL, 2),
(8, 3, NULL, 'CUH C002', 120.00, 120.00, NULL, 18, NULL, '{\"otros_detalles\": \"Información adicional para la vivienda 8\"}', '2024-03-13', NULL, NULL, 3),
(9, 4, NULL, 'CUH C002', 125.00, 125.00, NULL, 20, NULL, '{\"otros_detalles\": \"Información adicional para la vivienda 9\"}', '2024-03-13', NULL, '2024-03-14', 4),
(10, 5, NULL, 'CUH C002', 135.00, 135.00, NULL, 22, NULL, '{\"otros_detalles\": \"Información adicional para la vivienda 10\"}', '2024-03-13', NULL, NULL, 5),
(11, 7, NULL, 'CHU 001', 200.00, 250.00, NULL, 5, 2, '{\"detalle\": \"Información adicional\"}', '2024-03-14', '2024-03-14', NULL, 1);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vws_list_clients`
-- (Véase abajo para la vista actual)
--
DROP VIEW IF EXISTS `vws_list_clients`;
CREATE TABLE IF NOT EXISTS `vws_list_clients` (
`idcliente` int(11)
,`documento_tipo` varchar(20)
,`documento_nro` varchar(12)
,`apellidos` varchar(40)
,`nombres` varchar(40)
,`estado_civil` varchar(20)
,`distrito` varchar(45)
,`provincia` varchar(45)
,`departamento` varchar(45)
,`direccion` varchar(70)
,`usuario` varchar(40)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vws_list_companies`
-- (Véase abajo para la vista actual)
--
DROP VIEW IF EXISTS `vws_list_companies`;
CREATE TABLE IF NOT EXISTS `vws_list_companies` (
`idempresa` int(11)
,`ruc` char(11)
,`razon_social` varchar(60)
,`partida_elect` varchar(60)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vws_list_contracts_full`
-- (Véase abajo para la vista actual)
--
DROP VIEW IF EXISTS `vws_list_contracts_full`;
CREATE TABLE IF NOT EXISTS `vws_list_contracts_full` (
`idcontrato` int(11)
,`denominacion` varchar(30)
,`codigo` char(5)
,`sublote` tinyint(4)
,`idcliente` int(11)
,`nombres` varchar(40)
,`apellidos` varchar(40)
,`documento_tipo` varchar(20)
,`documento_nro` varchar(12)
,`estado_civil` varchar(20)
,`iddistrito` int(11)
,`distrito` varchar(45)
,`provincia` varchar(45)
,`departamento` varchar(45)
,`direccion` varchar(70)
,`idcliente2` int(11)
,`nombre2` varchar(40)
,`apellido2` varchar(40)
,`documento_tipo2` varchar(20)
,`documento_nro2` varchar(12)
,`estado_civil2` varchar(20)
,`iddistritoCL2` int(11)
,`distrito2` varchar(45)
,`provincia2` varchar(45)
,`departamento2` varchar(45)
,`direccion2` varchar(70)
,`idrepresentante1` int(11)
,`nom_represent1` varchar(40)
,`ap_represent1` varchar(20)
,`dt_represent1` varchar(20)
,`dn_represent1` varchar(12)
,`iddistritoUB` int(11)
,`distritor1` varchar(45)
,`provinciar1` varchar(45)
,`departamentor1` varchar(45)
,`dir_represent1` varchar(60)
,`part_represent1` varchar(60)
,`idrepresentante2` int(11)
,`nom_represent2` varchar(40)
,`ap_represent2` varchar(20)
,`dt_represent2` varchar(20)
,`dn_represent2` varchar(12)
,`iddistritoUB2` int(11)
,`distritor2` varchar(45)
,`provinciar2` varchar(45)
,`departamentor2` varchar(45)
,`dir_represent2` varchar(60)
,`part_represent2` varchar(60)
,`precio_total` decimal(8,2)
,`tipo_cambio` decimal(4,3)
,`idvivienda` int(11)
,`loteid` int(11)
,`imagen` varchar(100)
,`tipo_casa` char(8)
,`area_construccion` decimal(5,2)
,`area_techada` decimal(5,2)
,`airesm2` decimal(5,2)
,`zcomunes_porcent` tinyint(4)
,`estacionamiento_nro` tinyint(4)
,`detalles` longtext
,`estado` varchar(10)
,`fecha_contrato` date
,`usuario` varchar(40)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vws_list_contracts_short`
-- (Véase abajo para la vista actual)
--
DROP VIEW IF EXISTS `vws_list_contracts_short`;
CREATE TABLE IF NOT EXISTS `vws_list_contracts_short` (
`idcontrato` int(11)
,`tipo_contrato` varchar(45)
,`denominacion` varchar(30)
,`codigo` char(5)
,`sublote` tinyint(4)
,`clien_nombres` varchar(40)
,`clien_apellidos` varchar(40)
,`cony_apellidos` varchar(40)
,`cony_nombres` varchar(40)
,`estado` varchar(10)
,`usuario` varchar(40)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vws_list_drop_projects`
-- (Véase abajo para la vista actual)
--
DROP VIEW IF EXISTS `vws_list_drop_projects`;
CREATE TABLE IF NOT EXISTS `vws_list_drop_projects` (
`idproyecto` int(11)
,`imagen` varchar(100)
,`codigo` varchar(20)
,`denominacion` varchar(30)
,`distrito` varchar(45)
,`provincia` varchar(45)
,`departamento` varchar(45)
,`direccion` varchar(70)
,`usuario` varchar(40)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vws_list_inactive_clients`
-- (Véase abajo para la vista actual)
--
DROP VIEW IF EXISTS `vws_list_inactive_clients`;
CREATE TABLE IF NOT EXISTS `vws_list_inactive_clients` (
`idcliente` int(11)
,`documento_tipo` varchar(20)
,`documento_nro` varchar(12)
,`apellidos` varchar(40)
,`nombres` varchar(40)
,`estado_civil` varchar(20)
,`distrito` varchar(45)
,`provincia` varchar(45)
,`departamento` varchar(45)
,`direccion` varchar(70)
,`usuario` varchar(40)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vws_list_inactive_contracts_short`
-- (Véase abajo para la vista actual)
--
DROP VIEW IF EXISTS `vws_list_inactive_contracts_short`;
CREATE TABLE IF NOT EXISTS `vws_list_inactive_contracts_short` (
`idcontrato` int(11)
,`tipo_contrato` varchar(45)
,`denominacion` varchar(30)
,`codigo` char(5)
,`sublote` tinyint(4)
,`clien_nombres` varchar(40)
,`clien_apellidos` varchar(40)
,`cony_apellidos` varchar(40)
,`cony_nombres` varchar(40)
,`estado` varchar(10)
,`usuario` varchar(40)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vws_list_inactive_lots_short`
-- (Véase abajo para la vista actual)
--
DROP VIEW IF EXISTS `vws_list_inactive_lots_short`;
CREATE TABLE IF NOT EXISTS `vws_list_inactive_lots_short` (
`idlote` int(11)
,`denominacion` varchar(30)
,`estado_venta` varchar(10)
,`sublote` tinyint(4)
,`urbanizacion` varchar(70)
,`distrito` varchar(45)
,`provincia` varchar(45)
,`departamento` varchar(45)
,`usuario` varchar(40)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vws_list_lots`
-- (Véase abajo para la vista actual)
--
DROP VIEW IF EXISTS `vws_list_lots`;
CREATE TABLE IF NOT EXISTS `vws_list_lots` (
`idlote` int(11)
,`denominacion` varchar(30)
,`codigo` char(5)
,`estado_venta` varchar(10)
,`distrito` varchar(45)
,`provincia` varchar(45)
,`departamento` varchar(45)
,`moneda_venta` varchar(10)
,`area_terreno` decimal(5,2)
,`partida_elect` varchar(100)
,`idvivienda` int(11)
,`loteid` int(11)
,`imagen` varchar(100)
,`tipo_casa` char(8)
,`area_construccion` decimal(5,2)
,`area_techada` decimal(5,2)
,`airesm2` decimal(5,2)
,`zcomunes_porcent` tinyint(4)
,`estacionamiento_nro` tinyint(4)
,`detalles` longtext
,`usuarioH` varchar(40)
,`usuario` varchar(40)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vws_list_lots_short`
-- (Véase abajo para la vista actual)
--
DROP VIEW IF EXISTS `vws_list_lots_short`;
CREATE TABLE IF NOT EXISTS `vws_list_lots_short` (
`idlote` int(11)
,`denominacion` varchar(30)
,`codigo` char(5)
,`estado_venta` varchar(10)
,`sublote` tinyint(4)
,`urbanizacion` varchar(70)
,`distrito` varchar(45)
,`provincia` varchar(45)
,`departamento` varchar(45)
,`clien_nombres` varchar(40)
,`clien_apellidos` varchar(40)
,`usuario` varchar(40)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vws_list_projects`
-- (Véase abajo para la vista actual)
--
DROP VIEW IF EXISTS `vws_list_projects`;
CREATE TABLE IF NOT EXISTS `vws_list_projects` (
`idproyecto` int(11)
,`imagen` varchar(100)
,`codigo` varchar(20)
,`denominacion` varchar(30)
,`distrito` varchar(45)
,`provincia` varchar(45)
,`departamento` varchar(45)
,`direccion` varchar(70)
,`total_lotes` bigint(21)
,`lotes_vendidos` bigint(21)
,`lotes_NoVendidos` bigint(21)
,`lotes_separados` bigint(21)
,`usuario` varchar(40)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vws_ubigeo`
-- (Véase abajo para la vista actual)
--
DROP VIEW IF EXISTS `vws_ubigeo`;
CREATE TABLE IF NOT EXISTS `vws_ubigeo` (
`iddistrito` int(11)
,`distrito` varchar(45)
,`provincia` varchar(45)
,`departamento` varchar(45)
);

-- --------------------------------------------------------

--
-- Estructura para la vista `vws_list_clients`
--
DROP TABLE IF EXISTS `vws_list_clients`;

DROP VIEW IF EXISTS `vws_list_clients`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vws_list_clients`  AS SELECT `clien`.`idcliente` AS `idcliente`, `clien`.`documento_tipo` AS `documento_tipo`, `clien`.`documento_nro` AS `documento_nro`, `clien`.`apellidos` AS `apellidos`, `clien`.`nombres` AS `nombres`, `clien`.`estado_civil` AS `estado_civil`, `dist`.`distrito` AS `distrito`, `prov`.`provincia` AS `provincia`, `dept`.`departamento` AS `departamento`, `clien`.`direccion` AS `direccion`, `usu`.`nombres` AS `usuario` FROM ((((`clientes` `clien` join `distritos` `dist` on(`dist`.`iddistrito` = `clien`.`iddistrito`)) join `provincias` `prov` on(`prov`.`idprovincia` = `dist`.`idprovincia`)) join `departamentos` `dept` on(`dept`.`iddepartamento` = `prov`.`iddepartamento`)) join `usuarios` `usu` on(`usu`.`idusuario` = `clien`.`idusuario`)) WHERE `clien`.`inactive_at` is null ORDER BY `clien`.`apellidos` ASC ;

-- --------------------------------------------------------

--
-- Estructura para la vista `vws_list_companies`
--
DROP TABLE IF EXISTS `vws_list_companies`;

DROP VIEW IF EXISTS `vws_list_companies`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vws_list_companies`  AS SELECT `empresas`.`idempresa` AS `idempresa`, `empresas`.`ruc` AS `ruc`, `empresas`.`razon_social` AS `razon_social`, `empresas`.`partida_elect` AS `partida_elect` FROM `empresas` ;

-- --------------------------------------------------------

--
-- Estructura para la vista `vws_list_contracts_full`
--
DROP TABLE IF EXISTS `vws_list_contracts_full`;

DROP VIEW IF EXISTS `vws_list_contracts_full`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vws_list_contracts_full`  AS WITH ubigeo1 AS (SELECT `dist`.`iddistrito` AS `iddistrito`, `dist`.`distrito` AS `distrito`, `prov`.`provincia` AS `provincia`, `dept`.`departamento` AS `departamento` FROM ((`distritos` `dist` join `provincias` `prov` on(`prov`.`idprovincia` = `dist`.`idprovincia`)) join `departamentos` `dept` on(`dept`.`iddepartamento` = `prov`.`iddepartamento`))), Client1 AS (SELECT `clien`.`idcliente` AS `idcliente`, `clien`.`nombres` AS `nombres`, `clien`.`apellidos` AS `apellidos`, `clien`.`documento_tipo` AS `documento_tipo`, `clien`.`documento_nro` AS `documento_nro`, `clien`.`estado_civil` AS `estado_civil`, `ubdata`.`iddistrito` AS `iddistrito`, `ubdata`.`distrito` AS `distrito`, `ubdata`.`provincia` AS `provincia`, `ubdata`.`departamento` AS `departamento`, `clien`.`direccion` AS `direccion` FROM (`clientes` `clien` join `ubigeo1` `ubdata` on(`ubdata`.`iddistrito` = `clien`.`iddistrito`))), ubigeo2 AS (SELECT `dist`.`iddistrito` AS `iddistritoCL2`, `dist`.`distrito` AS `distrito2`, `prov`.`provincia` AS `provincia2`, `dept`.`departamento` AS `departamento2` FROM ((`distritos` `dist` join `provincias` `prov` on(`prov`.`idprovincia` = `dist`.`idprovincia`)) join `departamentos` `dept` on(`dept`.`iddepartamento` = `prov`.`iddepartamento`))), Client2 AS (SELECT `clien`.`idcliente` AS `idcliente2`, `clien`.`nombres` AS `nombre2`, `clien`.`apellidos` AS `apellido2`, `clien`.`documento_tipo` AS `documento_tipo2`, `clien`.`documento_nro` AS `documento_nro2`, `clien`.`estado_civil` AS `estado_civil2`, `ubdata2`.`iddistritoCL2` AS `iddistritoCL2`, `ubdata2`.`distrito2` AS `distrito2`, `ubdata2`.`provincia2` AS `provincia2`, `ubdata2`.`departamento2` AS `departamento2`, `clien`.`direccion` AS `direccion2` FROM (`clientes` `clien` join `ubigeo2` `ubdata2` on(`ubdata2`.`iddistritoCL2` = `clien`.`iddistrito`))), ubigeor1 AS (SELECT `dist`.`iddistrito` AS `iddistritoUB`, `dist`.`distrito` AS `distritor1`, `prov`.`provincia` AS `provinciar1`, `dept`.`departamento` AS `departamentor1` FROM ((`distritos` `dist` join `provincias` `prov` on(`prov`.`idprovincia` = `dist`.`idprovincia`)) join `departamentos` `dept` on(`dept`.`iddepartamento` = `prov`.`iddepartamento`))), represen1 AS (SELECT `usu`.`idusuario` AS `idrepresentante1`, `usu`.`nombres` AS `nom_represent1`, `usu`.`apellidos` AS `ap_represent1`, `usu`.`documento_tipo` AS `dt_represent1`, `usu`.`documento_nro` AS `dn_represent1`, `ubr1`.`iddistritoUB` AS `iddistritoUB`, `ubr1`.`distritor1` AS `distritor1`, `ubr1`.`provinciar1` AS `provinciar1`, `ubr1`.`departamentor1` AS `departamentor1`, `usu`.`direccion` AS `dir_represent1`, `usu`.`partida_elect` AS `part_represent1` FROM (`usuarios` `usu` join `ubigeor1` `ubr1` on(`ubr1`.`iddistritoUB` = `usu`.`iddistrito`))), ubigeor2 AS (SELECT `dist`.`iddistrito` AS `iddistritoUB2`, `dist`.`distrito` AS `distritor2`, `prov`.`provincia` AS `provinciar2`, `dept`.`departamento` AS `departamentor2` FROM ((`distritos` `dist` join `provincias` `prov` on(`prov`.`idprovincia` = `dist`.`idprovincia`)) join `departamentos` `dept` on(`dept`.`iddepartamento` = `prov`.`iddepartamento`)) ORDER BY `dept`.`departamento` ASC), represen2 AS (SELECT `usu`.`idusuario` AS `idrepresentante2`, `usu`.`nombres` AS `nom_represent2`, `usu`.`apellidos` AS `ap_represent2`, `usu`.`documento_tipo` AS `dt_represent2`, `usu`.`documento_nro` AS `dn_represent2`, `ubr2`.`iddistritoUB2` AS `iddistritoUB2`, `ubr2`.`distritor2` AS `distritor2`, `ubr2`.`provinciar2` AS `provinciar2`, `ubr2`.`departamentor2` AS `departamentor2`, `usu`.`direccion` AS `dir_represent2`, `usu`.`partida_elect` AS `part_represent2` FROM (`usuarios` `usu` join `ubigeor2` `ubr2` on(`ubr2`.`iddistritoUB2` = `usu`.`iddistrito`))), dataHouse AS (SELECT `viv`.`idvivienda` AS `idvivienda`, `viv`.`idlote` AS `loteid`, `viv`.`imagen` AS `imagen`, `viv`.`tipo_casa` AS `tipo_casa`, `viv`.`area_construccion` AS `area_construccion`, `viv`.`area_techada` AS `area_techada`, `viv`.`airesm2` AS `airesm2`, `viv`.`zcomunes_porcent` AS `zcomunes_porcent`, `viv`.`estacionamiento_nro` AS `estacionamiento_nro`, `viv`.`detalles` AS `detalles` FROM `viviendas` AS `viv` WHERE `viv`.`inactive_at` is null)  SELECT `cont`.`idcontrato` AS `idcontrato`, `proy`.`denominacion` AS `denominacion`, `lt`.`codigo` AS `codigo`, `lt`.`sublote` AS `sublote`, `clien1`.`idcliente` AS `idcliente`, `clien1`.`nombres` AS `nombres`, `clien1`.`apellidos` AS `apellidos`, `clien1`.`documento_tipo` AS `documento_tipo`, `clien1`.`documento_nro` AS `documento_nro`, `clien1`.`estado_civil` AS `estado_civil`, `clien1`.`iddistrito` AS `iddistrito`, `clien1`.`distrito` AS `distrito`, `clien1`.`provincia` AS `provincia`, `clien1`.`departamento` AS `departamento`, `clien1`.`direccion` AS `direccion`, `clien2`.`idcliente2` AS `idcliente2`, `clien2`.`nombre2` AS `nombre2`, `clien2`.`apellido2` AS `apellido2`, `clien2`.`documento_tipo2` AS `documento_tipo2`, `clien2`.`documento_nro2` AS `documento_nro2`, `clien2`.`estado_civil2` AS `estado_civil2`, `clien2`.`iddistritoCL2` AS `iddistritoCL2`, `clien2`.`distrito2` AS `distrito2`, `clien2`.`provincia2` AS `provincia2`, `clien2`.`departamento2` AS `departamento2`, `clien2`.`direccion2` AS `direccion2`, `rp1`.`idrepresentante1` AS `idrepresentante1`, `rp1`.`nom_represent1` AS `nom_represent1`, `rp1`.`ap_represent1` AS `ap_represent1`, `rp1`.`dt_represent1` AS `dt_represent1`, `rp1`.`dn_represent1` AS `dn_represent1`, `rp1`.`iddistritoUB` AS `iddistritoUB`, `rp1`.`distritor1` AS `distritor1`, `rp1`.`provinciar1` AS `provinciar1`, `rp1`.`departamentor1` AS `departamentor1`, `rp1`.`dir_represent1` AS `dir_represent1`, `rp1`.`part_represent1` AS `part_represent1`, `rp2`.`idrepresentante2` AS `idrepresentante2`, `rp2`.`nom_represent2` AS `nom_represent2`, `rp2`.`ap_represent2` AS `ap_represent2`, `rp2`.`dt_represent2` AS `dt_represent2`, `rp2`.`dn_represent2` AS `dn_represent2`, `rp2`.`iddistritoUB2` AS `iddistritoUB2`, `rp2`.`distritor2` AS `distritor2`, `rp2`.`provinciar2` AS `provinciar2`, `rp2`.`departamentor2` AS `departamentor2`, `rp2`.`dir_represent2` AS `dir_represent2`, `rp2`.`part_represent2` AS `part_represent2`, `cont`.`precio_total` AS `precio_total`, `cont`.`tipo_cambio` AS `tipo_cambio`, `dth`.`idvivienda` AS `idvivienda`, `dth`.`loteid` AS `loteid`, `dth`.`imagen` AS `imagen`, `dth`.`tipo_casa` AS `tipo_casa`, `dth`.`area_construccion` AS `area_construccion`, `dth`.`area_techada` AS `area_techada`, `dth`.`airesm2` AS `airesm2`, `dth`.`zcomunes_porcent` AS `zcomunes_porcent`, `dth`.`estacionamiento_nro` AS `estacionamiento_nro`, `dth`.`detalles` AS `detalles`, `cont`.`estado` AS `estado`, `cont`.`fecha_contrato` AS `fecha_contrato`, `usu`.`nombres` AS `usuario` FROM ((((((((`contratos` `cont` join `lotes` `lt` on(`lt`.`idlote` = `cont`.`idlote`)) join `proyectos` `proy` on(`proy`.`idproyecto` = `lt`.`idproyecto`)) join `client1` `clien1` on(`clien1`.`idcliente` = `cont`.`idcliente`)) left join `client2` `clien2` on(`clien2`.`idcliente2` = `cont`.`idcliente2`)) join `represen1` `rp1` on(`rp1`.`idrepresentante1` = `cont`.`idrepresentante`)) left join `represen2` `rp2` on(`rp2`.`idrepresentante2` = `cont`.`idrepresentante2`)) left join `datahouse` `dth` on(`dth`.`loteid` = `lt`.`idlote`)) join `usuarios` `usu` on(`usu`.`idusuario` = `cont`.`idusuario`)) WHERE `cont`.`inactive_at` is null ORDER BY `proy`.`denominacion` ASC`denominacion`  ;

-- --------------------------------------------------------

--
-- Estructura para la vista `vws_list_contracts_short`
--
DROP TABLE IF EXISTS `vws_list_contracts_short`;

DROP VIEW IF EXISTS `vws_list_contracts_short`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vws_list_contracts_short`  AS SELECT `cont`.`idcontrato` AS `idcontrato`, `cont`.`tipo_contrato` AS `tipo_contrato`, `proy`.`denominacion` AS `denominacion`, `lt`.`codigo` AS `codigo`, `lt`.`sublote` AS `sublote`, `clien`.`nombres` AS `clien_nombres`, `clien`.`apellidos` AS `clien_apellidos`, `clien2`.`apellidos` AS `cony_apellidos`, `clien2`.`nombres` AS `cony_nombres`, `cont`.`estado` AS `estado`, `usurep1`.`nombres` AS `usuario` FROM (((((((`contratos` `cont` join `lotes` `lt` on(`lt`.`idlote` = `cont`.`idlote`)) join `proyectos` `proy` on(`proy`.`idproyecto` = `lt`.`idproyecto`)) join `clientes` `clien` on(`clien`.`idcliente` = `cont`.`idcliente`)) left join `clientes` `clien2` on(`clien2`.`idcliente` = `cont`.`idcliente2`)) join `usuarios` `usurep1` on(`usurep1`.`idusuario` = `cont`.`idrepresentante`)) left join `usuarios` `usurep2` on(`usurep2`.`idusuario` = `cont`.`idrepresentante2`)) join `usuarios` `usu` on(`usu`.`idusuario` = `proy`.`idusuario`)) WHERE `cont`.`inactive_at` is null ORDER BY `proy`.`denominacion` ASC ;

-- --------------------------------------------------------

--
-- Estructura para la vista `vws_list_drop_projects`
--
DROP TABLE IF EXISTS `vws_list_drop_projects`;

DROP VIEW IF EXISTS `vws_list_drop_projects`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vws_list_drop_projects`  AS SELECT `proy`.`idproyecto` AS `idproyecto`, `proy`.`imagen` AS `imagen`, `proy`.`codigo` AS `codigo`, `proy`.`denominacion` AS `denominacion`, `dist`.`distrito` AS `distrito`, `prov`.`provincia` AS `provincia`, `dept`.`departamento` AS `departamento`, `proy`.`direccion` AS `direccion`, `usu`.`nombres` AS `usuario` FROM ((((`proyectos` `proy` join `distritos` `dist` on(`dist`.`iddistrito` = `proy`.`iddistrito`)) join `provincias` `prov` on(`prov`.`idprovincia` = `dist`.`idprovincia`)) join `departamentos` `dept` on(`dept`.`iddepartamento` = `prov`.`iddepartamento`)) join `usuarios` `usu` on(`usu`.`idusuario` = `proy`.`idusuario`)) WHERE `proy`.`inactive_at` is not null ORDER BY `proy`.`codigo` ASC ;

-- --------------------------------------------------------

--
-- Estructura para la vista `vws_list_inactive_clients`
--
DROP TABLE IF EXISTS `vws_list_inactive_clients`;

DROP VIEW IF EXISTS `vws_list_inactive_clients`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vws_list_inactive_clients`  AS SELECT `clien`.`idcliente` AS `idcliente`, `clien`.`documento_tipo` AS `documento_tipo`, `clien`.`documento_nro` AS `documento_nro`, `clien`.`apellidos` AS `apellidos`, `clien`.`nombres` AS `nombres`, `clien`.`estado_civil` AS `estado_civil`, `dist`.`distrito` AS `distrito`, `prov`.`provincia` AS `provincia`, `dept`.`departamento` AS `departamento`, `clien`.`direccion` AS `direccion`, `usu`.`nombres` AS `usuario` FROM ((((`clientes` `clien` join `distritos` `dist` on(`dist`.`iddistrito` = `clien`.`iddistrito`)) join `provincias` `prov` on(`prov`.`idprovincia` = `dist`.`idprovincia`)) join `departamentos` `dept` on(`dept`.`iddepartamento` = `prov`.`iddepartamento`)) join `usuarios` `usu` on(`usu`.`idusuario` = `clien`.`idusuario`)) WHERE `clien`.`inactive_at` is not null ORDER BY `clien`.`apellidos` ASC ;

-- --------------------------------------------------------

--
-- Estructura para la vista `vws_list_inactive_contracts_short`
--
DROP TABLE IF EXISTS `vws_list_inactive_contracts_short`;

DROP VIEW IF EXISTS `vws_list_inactive_contracts_short`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vws_list_inactive_contracts_short`  AS SELECT `cont`.`idcontrato` AS `idcontrato`, `cont`.`tipo_contrato` AS `tipo_contrato`, `proy`.`denominacion` AS `denominacion`, `lt`.`codigo` AS `codigo`, `lt`.`sublote` AS `sublote`, `clien`.`nombres` AS `clien_nombres`, `clien`.`apellidos` AS `clien_apellidos`, `clien2`.`apellidos` AS `cony_apellidos`, `clien2`.`nombres` AS `cony_nombres`, `cont`.`estado` AS `estado`, `usurep1`.`nombres` AS `usuario` FROM (((((((`contratos` `cont` join `lotes` `lt` on(`lt`.`idlote` = `cont`.`idlote`)) join `proyectos` `proy` on(`proy`.`idproyecto` = `lt`.`idproyecto`)) join `clientes` `clien` on(`clien`.`idcliente` = `cont`.`idcliente`)) left join `clientes` `clien2` on(`clien2`.`idcliente` = `cont`.`idcliente2`)) join `usuarios` `usurep1` on(`usurep1`.`idusuario` = `cont`.`idrepresentante`)) left join `usuarios` `usurep2` on(`usurep2`.`idusuario` = `cont`.`idrepresentante2`)) join `usuarios` `usu` on(`usu`.`idusuario` = `proy`.`idusuario`)) WHERE `cont`.`inactive_at` is not null ORDER BY `proy`.`denominacion` ASC ;

-- --------------------------------------------------------

--
-- Estructura para la vista `vws_list_inactive_lots_short`
--
DROP TABLE IF EXISTS `vws_list_inactive_lots_short`;

DROP VIEW IF EXISTS `vws_list_inactive_lots_short`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vws_list_inactive_lots_short`  AS SELECT `lt`.`idlote` AS `idlote`, `proy`.`denominacion` AS `denominacion`, `lt`.`estado_venta` AS `estado_venta`, `lt`.`sublote` AS `sublote`, `lt`.`urbanizacion` AS `urbanizacion`, `dist`.`distrito` AS `distrito`, `prov`.`provincia` AS `provincia`, `dept`.`departamento` AS `departamento`, `usu`.`nombres` AS `usuario` FROM (((((`lotes` `lt` join `proyectos` `proy` on(`proy`.`idproyecto` = `lt`.`idproyecto`)) join `distritos` `dist` on(`dist`.`iddistrito` = `proy`.`iddistrito`)) join `provincias` `prov` on(`prov`.`idprovincia` = `dist`.`idprovincia`)) join `departamentos` `dept` on(`dept`.`iddepartamento` = `prov`.`iddepartamento`)) join `usuarios` `usu` on(`usu`.`idusuario` = `lt`.`idusuario`)) WHERE `lt`.`inactive_at` is not null ORDER BY `proy`.`denominacion` ASC ;

-- --------------------------------------------------------

--
-- Estructura para la vista `vws_list_lots`
--
DROP TABLE IF EXISTS `vws_list_lots`;

DROP VIEW IF EXISTS `vws_list_lots`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vws_list_lots`  AS WITH dataHouse AS (SELECT `viv`.`idvivienda` AS `idvivienda`, `viv`.`idlote` AS `loteid`, `viv`.`imagen` AS `imagen`, `viv`.`tipo_casa` AS `tipo_casa`, `viv`.`area_construccion` AS `area_construccion`, `viv`.`area_techada` AS `area_techada`, `viv`.`airesm2` AS `airesm2`, `viv`.`zcomunes_porcent` AS `zcomunes_porcent`, `viv`.`estacionamiento_nro` AS `estacionamiento_nro`, `viv`.`detalles` AS `detalles`, `usu`.`nombres` AS `usuarioH` FROM (`viviendas` `viv` join `usuarios` `usu` on(`usu`.`idusuario` = `viv`.`idusuario`)) WHERE `viv`.`inactive_at` is null)  SELECT `lt`.`idlote` AS `idlote`, `proy`.`denominacion` AS `denominacion`, `lt`.`codigo` AS `codigo`, `lt`.`estado_venta` AS `estado_venta`, `dist`.`distrito` AS `distrito`, `prov`.`provincia` AS `provincia`, `dept`.`departamento` AS `departamento`, `lt`.`moneda_venta` AS `moneda_venta`, `lt`.`area_terreno` AS `area_terreno`, `lt`.`partida_elect` AS `partida_elect`, `dth`.`idvivienda` AS `idvivienda`, `dth`.`loteid` AS `loteid`, `dth`.`imagen` AS `imagen`, `dth`.`tipo_casa` AS `tipo_casa`, `dth`.`area_construccion` AS `area_construccion`, `dth`.`area_techada` AS `area_techada`, `dth`.`airesm2` AS `airesm2`, `dth`.`zcomunes_porcent` AS `zcomunes_porcent`, `dth`.`estacionamiento_nro` AS `estacionamiento_nro`, `dth`.`detalles` AS `detalles`, `dth`.`usuarioH` AS `usuarioH`, `usu`.`nombres` AS `usuario` FROM ((((((`lotes` `lt` join `proyectos` `proy` on(`proy`.`idproyecto` = `lt`.`idproyecto`)) join `distritos` `dist` on(`dist`.`iddistrito` = `proy`.`iddistrito`)) join `provincias` `prov` on(`prov`.`idprovincia` = `dist`.`idprovincia`)) join `departamentos` `dept` on(`dept`.`iddepartamento` = `prov`.`iddepartamento`)) join `usuarios` `usu` on(`usu`.`idusuario` = `lt`.`idusuario`)) left join `datahouse` `dth` on(`dth`.`loteid` = `lt`.`idlote`)) WHERE `lt`.`inactive_at` is null ORDER BY `proy`.`denominacion` ASC`denominacion`  ;

-- --------------------------------------------------------

--
-- Estructura para la vista `vws_list_lots_short`
--
DROP TABLE IF EXISTS `vws_list_lots_short`;

DROP VIEW IF EXISTS `vws_list_lots_short`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vws_list_lots_short`  AS SELECT `lt`.`idlote` AS `idlote`, `proy`.`denominacion` AS `denominacion`, `lt`.`codigo` AS `codigo`, `lt`.`estado_venta` AS `estado_venta`, `lt`.`sublote` AS `sublote`, `lt`.`urbanizacion` AS `urbanizacion`, `dist`.`distrito` AS `distrito`, `prov`.`provincia` AS `provincia`, `dept`.`departamento` AS `departamento`, CASE WHEN `lt`.`estado_venta` = 'SEPARADO' THEN (select `clien`.`nombres` from (`separaciones` `sep` left join `clientes` `clien` on(`clien`.`idcliente` = `sep`.`idcliente`)) where `sep`.`idlote` = `lt`.`idlote`) WHEN `lt`.`estado_venta` = 'VENDIDO' THEN (select `clien`.`nombres` from (`contratos` `cont` left join `clientes` `clien` on(`clien`.`idcliente` = `cont`.`idcliente`)) where `cont`.`idlote` = `lt`.`idlote`) END AS `clien_nombres`, CASE WHEN `lt`.`estado_venta` = 'SEPARADO' THEN (select `clien`.`apellidos` from (`separaciones` `sep` left join `clientes` `clien` on(`clien`.`idcliente` = `sep`.`idcliente`)) where `sep`.`idlote` = `lt`.`idlote`) WHEN `lt`.`estado_venta` = 'VENDIDO' THEN (select `clien`.`apellidos` from (`contratos` `cont` left join `clientes` `clien` on(`clien`.`idcliente` = `cont`.`idcliente`)) where `cont`.`idlote` = `lt`.`idlote`) END AS `clien_apellidos`, `usu`.`nombres` AS `usuario` FROM (((((`lotes` `lt` join `proyectos` `proy` on(`proy`.`idproyecto` = `lt`.`idproyecto`)) join `distritos` `dist` on(`dist`.`iddistrito` = `proy`.`iddistrito`)) join `provincias` `prov` on(`prov`.`idprovincia` = `dist`.`idprovincia`)) join `departamentos` `dept` on(`dept`.`iddepartamento` = `prov`.`iddepartamento`)) join `usuarios` `usu` on(`usu`.`idusuario` = `lt`.`idusuario`)) ORDER BY `proy`.`denominacion` ASC ;

-- --------------------------------------------------------

--
-- Estructura para la vista `vws_list_projects`
--
DROP TABLE IF EXISTS `vws_list_projects`;

DROP VIEW IF EXISTS `vws_list_projects`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vws_list_projects`  AS SELECT `proy`.`idproyecto` AS `idproyecto`, `proy`.`imagen` AS `imagen`, `proy`.`codigo` AS `codigo`, `proy`.`denominacion` AS `denominacion`, `dist`.`distrito` AS `distrito`, `prov`.`provincia` AS `provincia`, `dept`.`departamento` AS `departamento`, `proy`.`direccion` AS `direccion`, (select count(0) from `lotes` where `lotes`.`idproyecto` = `proy`.`idproyecto` and `lotes`.`inactive_at` is null) AS `total_lotes`, (select count(0) from `lotes` where `lotes`.`idproyecto` = `proy`.`idproyecto` and `lotes`.`estado_venta` = 'VENDIDO' and `lotes`.`inactive_at` is null) AS `lotes_vendidos`, (select count(0) from `lotes` where `lotes`.`idproyecto` = `proy`.`idproyecto` and `lotes`.`estado_venta` = 'NO VENDIDO' and `lotes`.`inactive_at` is null) AS `lotes_NoVendidos`, (select count(0) from `lotes` where `lotes`.`idproyecto` = `proy`.`idproyecto` and `lotes`.`estado_venta` = 'SEPARADO' and `lotes`.`inactive_at` is null) AS `lotes_separados`, `usu`.`nombres` AS `usuario` FROM ((((`proyectos` `proy` join `distritos` `dist` on(`dist`.`iddistrito` = `proy`.`iddistrito`)) join `provincias` `prov` on(`prov`.`idprovincia` = `dist`.`idprovincia`)) join `departamentos` `dept` on(`dept`.`iddepartamento` = `prov`.`iddepartamento`)) join `usuarios` `usu` on(`usu`.`idusuario` = `proy`.`idusuario`)) WHERE `proy`.`inactive_at` is null ORDER BY `proy`.`codigo` ASC ;

-- --------------------------------------------------------

--
-- Estructura para la vista `vws_ubigeo`
--
DROP TABLE IF EXISTS `vws_ubigeo`;

DROP VIEW IF EXISTS `vws_ubigeo`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vws_ubigeo`  AS SELECT `dist`.`iddistrito` AS `iddistrito`, `dist`.`distrito` AS `distrito`, `prov`.`provincia` AS `provincia`, `dept`.`departamento` AS `departamento` FROM ((`distritos` `dist` join `provincias` `prov` on(`prov`.`idprovincia` = `dist`.`idprovincia`)) join `departamentos` `dept` on(`dept`.`iddepartamento` = `prov`.`iddepartamento`)) ORDER BY `dept`.`departamento` ASC ;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `clientes`
--
ALTER TABLE `clientes`
  ADD CONSTRAINT `fk_iddistrito_cli` FOREIGN KEY (`iddistrito`) REFERENCES `distritos` (`iddistrito`),
  ADD CONSTRAINT `fk_idusuario_cli` FOREIGN KEY (`idusuario`) REFERENCES `usuarios` (`idusuario`);

--
-- Filtros para la tabla `contratos`
--
ALTER TABLE `contratos`
  ADD CONSTRAINT `fk_idcliente2_cont` FOREIGN KEY (`idcliente2`) REFERENCES `clientes` (`idcliente`),
  ADD CONSTRAINT `fk_idcliente_cont` FOREIGN KEY (`idcliente`) REFERENCES `clientes` (`idcliente`),
  ADD CONSTRAINT `fk_idlote_cont` FOREIGN KEY (`idlote`) REFERENCES `lotes` (`idlote`),
  ADD CONSTRAINT `fk_idrepresentante2_cont` FOREIGN KEY (`idrepresentante2`) REFERENCES `usuarios` (`idusuario`),
  ADD CONSTRAINT `fk_idrepresentante_cont` FOREIGN KEY (`idrepresentante`) REFERENCES `usuarios` (`idusuario`),
  ADD CONSTRAINT `fk_idusuario_cont` FOREIGN KEY (`idusuario`) REFERENCES `usuarios` (`idusuario`);

--
-- Filtros para la tabla `cuotas`
--
ALTER TABLE `cuotas`
  ADD CONSTRAINT `fk_idcontrato_cuotas` FOREIGN KEY (`idcontrato`) REFERENCES `contratos` (`idcontrato`),
  ADD CONSTRAINT `fk_idusuario_cuotas` FOREIGN KEY (`idusuario`) REFERENCES `usuarios` (`idusuario`);

--
-- Filtros para la tabla `desembolsos`
--
ALTER TABLE `desembolsos`
  ADD CONSTRAINT `fk_idfinanciera_desemb` FOREIGN KEY (`idfinanciera`) REFERENCES `financieras` (`idfinanciera`),
  ADD CONSTRAINT `fk_idlote_desemb` FOREIGN KEY (`idlote`) REFERENCES `lotes` (`idlote`),
  ADD CONSTRAINT `fk_idusuario_desemb` FOREIGN KEY (`idusuario`) REFERENCES `usuarios` (`idusuario`);

--
-- Filtros para la tabla `detalle_gastos`
--
ALTER TABLE `detalle_gastos`
  ADD CONSTRAINT `fk_idpresupuesto_dtgastos` FOREIGN KEY (`idpresupuesto`) REFERENCES `presupuestos` (`idpresupuesto`),
  ADD CONSTRAINT `fk_idusuario_dtgastos` FOREIGN KEY (`idusuario`) REFERENCES `usuarios` (`idusuario`);

--
-- Filtros para la tabla `direcciones`
--
ALTER TABLE `direcciones`
  ADD CONSTRAINT `fk_iddistrito_direccs` FOREIGN KEY (`iddistrito`) REFERENCES `distritos` (`iddistrito`),
  ADD CONSTRAINT `fk_idempresa_direccs` FOREIGN KEY (`idempresa`) REFERENCES `empresas` (`idempresa`);

--
-- Filtros para la tabla `distritos`
--
ALTER TABLE `distritos`
  ADD CONSTRAINT `fk_idprovincia_distr` FOREIGN KEY (`idprovincia`) REFERENCES `provincias` (`idprovincia`);

--
-- Filtros para la tabla `lotes`
--
ALTER TABLE `lotes`
  ADD CONSTRAINT `fk_idproyecto_lotes` FOREIGN KEY (`idproyecto`) REFERENCES `proyectos` (`idproyecto`),
  ADD CONSTRAINT `fk_idusuario_lotes` FOREIGN KEY (`idusuario`) REFERENCES `usuarios` (`idusuario`);

--
-- Filtros para la tabla `permisos`
--
ALTER TABLE `permisos`
  ADD CONSTRAINT `fk_idrol_permis` FOREIGN KEY (`idrol`) REFERENCES `roles` (`idrol`);

--
-- Filtros para la tabla `presupuestos`
--
ALTER TABLE `presupuestos`
  ADD CONSTRAINT `fk_idlote_presup` FOREIGN KEY (`idlote`) REFERENCES `lotes` (`idlote`),
  ADD CONSTRAINT `fk_idusuario_presup` FOREIGN KEY (`idusuario`) REFERENCES `usuarios` (`idusuario`);

--
-- Filtros para la tabla `provincias`
--
ALTER TABLE `provincias`
  ADD CONSTRAINT `fk_iddepartamento_provin` FOREIGN KEY (`iddepartamento`) REFERENCES `departamentos` (`iddepartamento`);

--
-- Filtros para la tabla `proyectos`
--
ALTER TABLE `proyectos`
  ADD CONSTRAINT `fk_iddireccion_proyects` FOREIGN KEY (`iddireccion`) REFERENCES `direcciones` (`iddireccion`),
  ADD CONSTRAINT `fk_iddistrito_proyects` FOREIGN KEY (`iddistrito`) REFERENCES `distritos` (`iddistrito`),
  ADD CONSTRAINT `fk_idusuario_proyects` FOREIGN KEY (`idusuario`) REFERENCES `usuarios` (`idusuario`);

--
-- Filtros para la tabla `separaciones`
--
ALTER TABLE `separaciones`
  ADD CONSTRAINT `fk_idcliente_sep` FOREIGN KEY (`idcliente`) REFERENCES `clientes` (`idcliente`),
  ADD CONSTRAINT `fk_idlote_sep` FOREIGN KEY (`idlote`) REFERENCES `lotes` (`idlote`),
  ADD CONSTRAINT `fk_idusuario_sep` FOREIGN KEY (`idusuario`) REFERENCES `usuarios` (`idusuario`),
  ADD CONSTRAINT `fk_idvend_representante_sep` FOREIGN KEY (`idvend_representante`) REFERENCES `vend_representantes` (`idvend_representante`);

--
-- Filtros para la tabla `sustentos_cuotas`
--
ALTER TABLE `sustentos_cuotas`
  ADD CONSTRAINT `fk_idcuota_sust_cuo` FOREIGN KEY (`idcuota`) REFERENCES `cuotas` (`idcuota`),
  ADD CONSTRAINT `fk_idusuario_sust_cuo` FOREIGN KEY (`idusuario`) REFERENCES `usuarios` (`idusuario`);

--
-- Filtros para la tabla `sustentos_sep`
--
ALTER TABLE `sustentos_sep`
  ADD CONSTRAINT `fk_idseparacion_sust_sep` FOREIGN KEY (`idseparacion`) REFERENCES `separaciones` (`idseparacion`),
  ADD CONSTRAINT `fk_idusuario_sust_sep` FOREIGN KEY (`idusuario`) REFERENCES `usuarios` (`idusuario`);

--
-- Filtros para la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD CONSTRAINT `fk_iddireccion_usu` FOREIGN KEY (`iddireccion`) REFERENCES `direcciones` (`iddireccion`),
  ADD CONSTRAINT `fk_iddistrito_usu` FOREIGN KEY (`iddistrito`) REFERENCES `distritos` (`iddistrito`),
  ADD CONSTRAINT `fk_idrol_usu` FOREIGN KEY (`idrol`) REFERENCES `roles` (`idrol`);

--
-- Filtros para la tabla `vend_representantes`
--
ALTER TABLE `vend_representantes`
  ADD CONSTRAINT `fk_idrepresent_vend_represents` FOREIGN KEY (`idrepresentante`) REFERENCES `usuarios` (`idusuario`),
  ADD CONSTRAINT `fk_idusuario_vend_represents` FOREIGN KEY (`idusuario`) REFERENCES `usuarios` (`idusuario`),
  ADD CONSTRAINT `fk_idvendor_vend_represents` FOREIGN KEY (`idvendedor`) REFERENCES `usuarios` (`idusuario`);

--
-- Filtros para la tabla `viviendas`
--
ALTER TABLE `viviendas`
  ADD CONSTRAINT `fk_idlote_vivien` FOREIGN KEY (`idlote`) REFERENCES `lotes` (`idlote`),
  ADD CONSTRAINT `fk_idusuario_vinve` FOREIGN KEY (`idusuario`) REFERENCES `usuarios` (`idusuario`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
