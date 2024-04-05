USE AISOFT;

-- VISTA LISTA UBIGEO
DELIMITER $$
CREATE VIEW vws_ubigeo AS
	SELECT 
			dist.iddistrito,
            dist.distrito,
            prov.provincia,
            dept.departamento
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

-- VISTA PORYECTOS
DELIMITER $$
CREATE VIEW vws_list_projects AS
		SELECT 
			proy.idproyecto,
            proy.imagen,
			proy.iddireccion,
            proy.codigo,            
			proy.denominacion,
            proy.latitud,
            proy.longitud,
            proy.perimetro,
			dist.iddistrito,
            dist.distrito,
			prov.idprovincia,
            prov.provincia,
			dept.iddepartamento,
            dept.departamento,
			proy.direccion,
			met.l_vendidos,
            met.l_noVendidos,
            met.l_separados,
            (met.l_vendidos + met.l_noVendidos + met.l_separados) as l_total,
			usu.nombres AS usuario
        FROM proyectos AS proy
        INNER JOIN distritos AS dist ON dist.iddistrito = proy.iddistrito
        INNER JOIN provincias AS prov ON prov.idprovincia = dist.idprovincia
        INNER JOIN departamentos AS dept ON dept.iddepartamento = prov.iddepartamento
        INNER JOIN usuarios AS usu ON usu.idusuario = proy.idusuario
        INNER JOIN metricas AS met ON met.idproyecto = proy.idproyecto
        WHERE proy.inactive_at IS NULL
        ORDER BY codigo ASC;
$$
DELIMITER ;

SELECT * FROM vws_list_projects;

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
            usu.nombres AS usuario
        FROM proyectos AS proy
        INNER JOIN distritos AS dist ON dist.iddistrito = proy.iddistrito
        INNER JOIN provincias AS prov ON prov.idprovincia = dist.idprovincia
        INNER JOIN departamentos AS dept ON dept.iddepartamento = prov.iddepartamento
        INNER JOIN usuarios AS usu ON usu.idusuario = proy.idusuario
        WHERE proy.inactive_at IS NOT NULL
        ORDER BY codigo ASC;
$$
DELIMITER ;

SELECT * FROM vws_list_drop_projects;

-- ACTIVOS

-- SOLO SE HARÀ POR ID

DELIMITER $$
CREATE VIEW vws_list_assets_short AS
	SELECT
		act.idactivo,
        proy.idproyecto,
        proy.denominacion,
        act.codigo,
        act.estado,
        act.sublote,
        act.direccion,
        dist.distrito,
        prov.provincia,
        dept.departamento,
        usu.nombres AS usuario
		FROM activos AS act
        INNER JOIN proyectos AS proy ON proy.idproyecto = act.idproyecto
        INNER JOIN distritos AS dist ON dist.iddistrito = proy.iddistrito
        INNER JOIN provincias AS prov ON prov.idprovincia = dist.idprovincia
        INNER JOIN departamentos AS dept ON dept.iddepartamento = prov.iddepartamento
        INNER JOIN usuarios AS usu ON usu.idusuario = act.idusuario
        WHERE act.tipo_activo = "LOTE"
        ORDER BY CAST(SUBSTRING(act.codigo,3) AS UNSIGNED) ASC;
$$
DELIMITER ;

SELECT * FROM vws_list_assets_short;

DELIMITER $$
CREATE VIEW vws_list_inactive_assets AS
	SELECT
		act.idactivo,
        proy.denominacion,
        act.codigo,
        act.estado,
        act.sublote,
        act.direccion,
        dist.distrito,
        prov.provincia,
        dept.departamento,
        usu.nombres AS usuario
		FROM activos AS act
        INNER JOIN proyectos AS proy ON proy.idproyecto = act.idproyecto
        INNER JOIN distritos AS dist ON dist.iddistrito = proy.iddistrito
        INNER JOIN provincias AS prov ON prov.idprovincia = dist.idprovincia
        INNER JOIN departamentos AS dept ON dept.iddepartamento = prov.iddepartamento
        INNER JOIN usuarios AS usu ON usu.idusuario = act.idusuario
        WHERE act.tipo_activo = "LOTE" 
        AND act.inactive_at IS NOT NULL
        ORDER BY proy.denominacion
$$
DELIMITER ;

SELECT * FROM vws_list_inactive_assets;

-- CLIENTES
DELIMITER $$
CREATE VIEW vws_list_clients AS
	SELECT
		clien.idcliente,
		clien.documento_tipo,
        clien.documento_nro,
        clien.apellidos,
        clien.nombres,
        clien.estado_civil,
        dist.distrito,
        prov.provincia,
        dept.departamento,
        clien.direccion,
        usu.nombres AS usuario
		FROM clientes AS clien
        INNER JOIN distritos AS dist ON dist.iddistrito = clien.iddistrito
        INNER JOIN provincias AS prov ON prov.idprovincia = dist.idprovincia
        INNER JOIN departamentos AS dept ON dept.iddepartamento = prov.iddepartamento
        INNER JOIN usuarios AS usu ON usu.idusuario = clien.idusuario
        WHERE clien.inactive_at IS NULL
        ORDER BY clien.apellidos ASC;
$$
DELIMITER ;

SELECT * FROM vws_list_clients;

DELIMITER $$
CREATE VIEW vws_list_inactive_clients AS
	SELECT
		clien.idcliente,
		clien.documento_tipo,
        clien.documento_nro,
        clien.apellidos,
        clien.nombres,
        clien.estado_civil,
        dist.distrito,
        prov.provincia,
        dept.departamento,
        clien.direccion,
        usu.nombres AS usuario
		FROM clientes AS clien
        INNER JOIN distritos AS dist ON dist.iddistrito = clien.iddistrito
        INNER JOIN provincias AS prov ON prov.idprovincia = dist.idprovincia
        INNER JOIN departamentos AS dept ON dept.iddepartamento = prov.iddepartamento
        INNER JOIN usuarios AS usu ON usu.idusuario = clien.idusuario
        WHERE clien.inactive_at IS NOT NULL
        ORDER BY clien.apellidos ASC;
$$
DELIMITER ;

SELECT * FROM vws_list_inactive_clients;

-- CONTRATOS
DELIMITER $$
DROP VIEW vws_list_contracts_short AS
	SELECT 
		cont.idcontrato,
        cont.tipo_contrato,
        proy.denominacion,
        lt.codigo,
        lt.sublote,
		clien.nombres AS clien_nombres,
		clien.apellidos AS clien_apellidos,
        clien2.apellidos AS cony_apellidos,
		clien2.nombres AS cony_nombres,
        cont.estado,
        usuRep1.nombres AS usuario
		FROM contratos AS cont
        INNER JOIN lotes AS lt ON lt.idlote = cont.idlote
        INNER JOIN proyectos AS proy ON proy.idproyecto = lt.idproyecto
        
        -- OBTENGO LOS DATOS DEL CLIENTE1 Y DEL CLIENTE2 (SI EXISTE)
        INNER JOIN clientes AS clien ON clien.idcliente = cont.idcliente
        LEFT JOIN clientes AS clien2 ON clien2.idcliente = cont.idcliente2
        
        -- OBTENGO LOS DATOS DEL REPRESENTANTE1 Y DEL REPRESENTAN 2(SI EXISTE)
        INNER JOIN usuarios AS usuRep1 ON usuRep1.idusuario = cont.idrepresentante
        LEFT JOIN usuarios AS usuRep2 ON usuRep2.idusuario = cont.idrepresentante2
        
        -- OBTENGO LOS DATOS DEL USUARIO 
        INNER JOIN usuarios AS usu ON usu.idusuario = proy.idusuario
        WHERE cont.inactive_at IS NULL
        ORDER BY denominacion;
$$
DELIMITER ;

SELECT * FROM vws_list_contracts_short;

DELIMITER $$
DROP VIEW vws_list_inactive_contracts_short AS
	SELECT 
		cont.idcontrato,
        cont.tipo_contrato,
        proy.denominacion,
        lt.codigo,
        lt.sublote,
		clien.nombres AS clien_nombres,
		clien.apellidos AS clien_apellidos,
        clien2.apellidos AS cony_apellidos,
		clien2.nombres AS cony_nombres,
        cont.estado,
        usuRep1.nombres AS usuario
		FROM contratos AS cont
        INNER JOIN lotes AS lt ON lt.idlote = cont.idlote
        INNER JOIN proyectos AS proy ON proy.idproyecto = lt.idproyecto
        
        -- OBTENGO LOS DATOS DEL CLIENTE1 Y DEL CLIENTE2 (SI EXISTE)
        INNER JOIN clientes AS clien ON clien.idcliente = cont.idcliente
        LEFT JOIN clientes AS clien2 ON clien2.idcliente = cont.idcliente2
        
        -- OBTENGO LOS DATOS DEL REPRESENTANTE1 Y DEL REPRESENTAN 2(SI EXISTE)
        INNER JOIN usuarios AS usuRep1 ON usuRep1.idusuario = cont.idrepresentante
        LEFT JOIN usuarios AS usuRep2 ON usuRep2.idusuario = cont.idrepresentante2
        
        -- OBTENGO LOS DATOS DEL USUARIO 
        INNER JOIN usuarios AS usu ON usu.idusuario = proy.idusuario
        WHERE cont.inactive_at IS NOT NULL
        ORDER BY denominacion;
$$
DELIMITER ;


-- sustentos_cuotas, cuotas, detalle_gastos, presupuestos, desembolsos, sustentos_sep, separaciones, contratos, viviendas, lotes;