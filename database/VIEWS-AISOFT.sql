USE AISOFT;

-- VISTA LISTA UBIGEO
DELIMITER $$
CREATE VIEW vws_ubigeo AS
	SELECT 
			dist.iddistrito,
			dept.departamento,
            prov.provincia,
            dist.distrito
		FROM distritos AS dist
        INNER JOIN provincias AS prov ON prov.idprovincia = dist.idprovincia
        INNER JOIN departamentos AS dept ON dept.iddepartamento = prov.iddepartamento
        ORDER BY dept.departamento ASC;
$$
DELIMITER ;

SELECT * FROM vws_ubigeo;

-- VISTA EMPRESAS
DELIMITER $$
CREATE VIEW vws_list_companies AS
	SELECT
		idempresa,
        ruc,
        razon_social,
        partida_elect
		FROM empresas;
$$
DELIMITER ;

SELECT * FROM vws_list_companies;

-- VISTA LOTES
DELIMITER $$
CREATE VIEW vws_list_projects AS
		SELECT 
			proy.idproyecto,
            proy.imagen,
			proy.codigo,
			proy.denominacion,
			dist.distrito,
			prov.provincia,
			dept.departamento,
			proy.direccion,
		(SELECT COUNT(*) 
			FROM lotes 
			WHERE idproyecto = proy.idproyecto 
            AND inactive_at IS NULL
		) AS total_lotes,
        (SELECT COUNT(*) 
			FROM lotes 
            WHERE idproyecto = proy.idproyecto 
            AND estado_venta = "VENDIDO" AND inactive_at IS NULL
		)AS lotes_vendidos,
        (SELECT COUNT(*)
			FROM lotes
			WHERE idproyecto = proy.idproyecto
            AND estado_venta = "NO VENDIDO" AND inactive_at IS NULL
        ) AS lotes_NoVendidos,
        (SELECT COUNT(*)
			FROM lotes
            WHERE idproyecto = proy.idproyecto
            AND estado_venta = "SEPARADO" AND inactive_at IS NULL
        ) AS lotes_separados,
			usu.nombres
        FROM proyectos AS proy
        INNER JOIN distritos AS dist ON dist.iddistrito = proy.iddistrito
        INNER JOIN provincias AS prov ON prov.idprovincia = dist.idprovincia
        INNER JOIN departamentos AS dept ON dept.iddepartamento = prov.iddepartamento
        INNER JOIN usuarios AS usu ON usu.idusuario = proy.idusuario
        WHERE proy.inactive_at IS NULL
        ORDER BY codigo ASC;
$$
DELIMITER ;

DELIMITER $$
CREATE VIEW vws_list_drop_projects AS
		SELECT 
			proy.idproyecto,
            proy.imagen,
			proy.codigo,
			proy.denominacion,
			dist.distrito,
			prov.provincia,
			dept.departamento,
			proy.direccion,
            usu.nombres
        FROM proyectos AS proy
        INNER JOIN distritos AS dist ON dist.iddistrito = proy.iddistrito
        INNER JOIN provincias AS prov ON prov.idprovincia = dist.idprovincia
        INNER JOIN departamentos AS dept ON dept.iddepartamento = prov.iddepartamento
        INNER JOIN usuarios AS usu ON usu.idusuario = proy.idusuario
        WHERE proy.inactive_at IS NOT NULL
        ORDER BY codigo ASC;
$$
DELIMITER ;

SELECT * FROM vws_list_projects;

-- LOTES
DELIMITER $$
CREATE VIEW vws_list_lots AS
	SELECT 
		lt.idlote,
        proy.denominacion,
        lt.imagen,
        lt.codigo,
        lt.estado_venta,
        lt.tipo_casa,
        lt.sublote,
        lt.urbanizacion,
        dist.distrito,
        prov.provincia,
        dept.departamento,
        lt.moneda_venta,
        lt.area_terreno,
        lt.area_construccion,
        lt.area_techada,
        lt.airesm2,
        lt.zcomunes_porcent,
        lt.estacionamiento_nro,
        lt.partida_elect,
        lt.detalles,
        usu.nombres
		FROM lotes AS lt
        INNER JOIN proyectos AS proy ON proy.idproyecto = lt.idproyecto
        INNER JOIN distritos AS dist ON dist.iddistrito = lt.iddistrito
        INNER JOIN provincias AS prov ON prov.idprovincia = dist.idprovincia
        INNER JOIN departamentos AS dept ON dept.iddepartamento = prov.iddepartamento
        INNER JOIN usuarios AS usu ON usu.idusuario = lt.idusuario
        WHERE lt.inactive_at IS NULL
        ORDER BY proy.denominacion
$$
DELIMITER ;

SELECT * FROM vws_list_lots;

DELIMITER $$
CREATE VIEW vws_list_lots_short AS
	SELECT
		lt.idlote,
        proy.denominacion,
        lt.imagen,
        lt.codigo,
        lt.estado_venta,
        lt.tipo_casa,
        lt.sublote,
        lt.urbanizacion,
        dist.distrito,
        prov.provincia,
        dept.departamento,
        usu.nombres
		FROM lotes AS lt
        INNER JOIN proyectos AS proy ON proy.idproyecto = lt.idproyecto
        INNER JOIN distritos AS dist ON dist.iddistrito = lt.iddistrito
        INNER JOIN provincias AS prov ON prov.idprovincia = dist.idprovincia
        INNER JOIN departamentos AS dept ON dept.iddepartamento = prov.iddepartamento
        INNER JOIN usuarios AS usu ON usu.idusuario = lt.idusuario
        WHERE lt.inactive_at IS NULL
        ORDER BY proy.denominacion
$$
DELIMITER ;

SELECT * FROM vws_list_lots_short;

DELIMITER $$
CREATE VIEW vws_list_inactive_lots_short AS
	SELECT 
		lt.idlote,
        proy.denominacion,
        lt.imagen,
        lt.codigo,
        lt.estado_venta,
        lt.tipo_casa,
        lt.sublote,
        lt.urbanizacion,
        dist.distrito,
        prov.provincia,
        dept.departamento,
        usu.nombres
		FROM lotes AS lt
        INNER JOIN proyectos AS proy ON proy.idproyecto = lt.idproyecto
        INNER JOIN distritos AS dist ON dist.iddistrito = lt.iddistrito
        INNER JOIN provincias AS prov ON prov.idprovincia = dist.idprovincia
        INNER JOIN departamentos AS dept ON dept.iddepartamento = prov.iddepartamento
        INNER JOIN usuarios AS usu ON usu.idusuario = lt.idusuario
        WHERE lt.inactive_at IS NOT NULL
        ORDER BY proy.denominacion
$$
DELIMITER ;

SELECT * FROM vws_list_inactive_lots_short;