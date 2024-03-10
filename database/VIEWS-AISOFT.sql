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
        ) AS lotes_separados
        FROM proyectos AS proy
        INNER JOIN distritos AS dist ON dist.iddistrito = proy.iddistrito
        INNER JOIN provincias AS prov ON prov.idprovincia = dist.idprovincia
        INNER JOIN departamentos AS dept ON dept.iddepartamento = prov.iddepartamento
        WHERE proy.inactive_at IS NULL
        ORDER BY codigo ASC;
$$
DELIMITER ;

SELECT * FROM vws_list_projects;