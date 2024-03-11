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
			usu.nombres AS usuario
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
        usu.nombres AS usuario
		FROM lotes AS lt
        INNER JOIN proyectos AS proy ON proy.idproyecto = lt.idproyecto
        INNER JOIN distritos AS dist ON dist.iddistrito = proy.iddistrito
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
        CASE
			WHEN lt.estado_venta = "SEPARADO" 
				THEN(
					SELECT 
						clien.nombres
					FROM separaciones AS sep
					LEFT JOIN clientes AS clien ON clien.idcliente = sep.idcliente
					WHERE sep.idlote = lt.idlote
                )
			WHEN lt.estado_venta = "VENDIDO"
				THEN(
					SELECT clien.nombres
                    FROM contratos AS cont
                    LEFT JOIN clientes AS clien ON clien.idcliente = cont.idcliente
                    WHERE cont.idlote = lt.idlote
                )
		END AS clien_nombres,
		CASE
			WHEN lt.estado_venta = "SEPARADO" 
				THEN(
					SELECT 
						clien.apellidos
					FROM separaciones AS sep
					LEFT JOIN clientes AS clien ON clien.idcliente = sep.idcliente
					WHERE sep.idlote = lt.idlote
                )
			WHEN lt.estado_venta = "VENDIDO"
				THEN(
					SELECT clien.apellidos
                    FROM contratos AS cont
                    LEFT JOIN clientes AS clien ON clien.idcliente = cont.idcliente
                    WHERE cont.idlote = lt.idlote
                )
		END AS clien_apellidos,
        usu.nombres AS usuario
		FROM lotes AS lt
        INNER JOIN proyectos AS proy ON proy.idproyecto = lt.idproyecto
        INNER JOIN distritos AS dist ON dist.iddistrito = proy.iddistrito
        INNER JOIN provincias AS prov ON prov.idprovincia = dist.idprovincia
        INNER JOIN departamentos AS dept ON dept.iddepartamento = prov.iddepartamento
        INNER JOIN usuarios AS usu ON usu.idusuario = lt.idusuario
        ORDER BY proy.denominacion;
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
        usu.nombres AS usuario
		FROM lotes AS lt
        INNER JOIN proyectos AS proy ON proy.idproyecto = lt.idproyecto
        INNER JOIN distritos AS dist ON dist.iddistrito = proy.iddistrito
        INNER JOIN provincias AS prov ON prov.idprovincia = dist.idprovincia
        INNER JOIN departamentos AS dept ON dept.iddepartamento = prov.iddepartamento
        INNER JOIN usuarios AS usu ON usu.idusuario = lt.idusuario
        WHERE lt.inactive_at IS NOT NULL
        ORDER BY proy.denominacion
$$
DELIMITER ;

SELECT * FROM vws_list_inactive_lots_short;

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
CREATE VIEW vws_list_contracts_short AS
	SELECT 
		cont.idcontrato,
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

DELIMITER $$
CREATE VIEW vws_list_inactive_contracts_short AS
	SELECT 
		cont.idcontrato,
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

DELIMITER $$
CREATE VIEW vws_list_contracts_full AS

	-- CTE (EPRESION DE TABLA COMUN) ESTRUCTURA TEMPORAL QUE SE PUEDE USAR DENTRO DE UNA CONSULTA
    -- RECOLECTAMOS LA DATA
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
			clien.idcliente AS idcliente2,
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
				usu.idusuario AS idrepresentante1,
				usu.nombres AS nom_represent1,
                usu.apellidos AS ap_represent1,
                usu.documento_tipo AS dt_represent1,
                usu.documento_nro AS dn_represent1,
                ubr1.*,
                usu.direccion AS dir_represent1,
                usu.partida_elect AS part_represent1
			FROM usuarios AS usu
            INNER JOIN ubigeor1 AS ubr1 ON ubr1.iddistritoUB = usu.iddistrito
		
    ),
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
				usu.idusuario AS idrepresentante2,
				usu.nombres AS nom_represent2,
                usu.apellidos AS ap_represent2,
                usu.documento_tipo AS dt_represent2,
                usu.documento_nro AS dn_represent2,
                ubr2.*,
                usu.direccion AS dir_represent2,
                usu.partida_elect AS part_represent2
			FROM usuarios AS usu
            INNER JOIN ubigeor2 AS ubr2 ON ubr2.iddistritoUB2 = usu.iddistrito

    )
	SELECT 
		cont.idcontrato,
        proy.denominacion,
        lt.codigo,
        lt.sublote,
		clien1.*, -- * IGUAL QUE SELECT * FROM INDICA TODOS LOS REGISTROS DE LA CTA
        clien2.*,
		rp1.*,
        rp2.*,
        cont.precio_total, -- CREO QUE SE DEBERIA CALCULAR
        cont.cuota_inicial,
        cont.bono,
        cont.financiamiento,
        cont.plazo_entrega,
        cont.penalidad_moneda,
        cont.penalidad_periodo,
        cont.penalidad,
        cont.tipo_cambio,
        cont.estado,
        cont.fecha_contrato,
        usu.nombres AS usuario
		FROM contratos AS cont
        INNER JOIN lotes AS lt ON lt.idlote = cont.idlote
        INNER JOIN proyectos AS proy ON proy.idproyecto = lt.idproyecto
        
        -- OBTENGO LOS DATOS DEL CLIENTE1 Y DEL CLIENTE2 (SI EXISTE)
        INNER JOIN Client1 AS clien1 ON clien1.idcliente = cont.idcliente
        LEFT JOIN Client2 AS clien2 ON clien2.idcliente2 = cont.idcliente2
        
        -- OBTENGO LOS DATOS DEL REPRESENTANTE Y DEL REPRESENTANTE2 (SI EXISTE)
        INNER JOIN represen1 AS rp1 ON rp1.idrepresentante1 = cont.idrepresentante
        LEFT JOIN represen2 AS rp2 ON rp2.idrepresentante2 = cont.idrepresentante2
        
        -- OBTENGO LOS DATOS DEL USUARIO 
        INNER JOIN usuarios AS usu ON usu.idusuario = cont.idusuario
        WHERE cont.inactive_at IS NULL
        ORDER BY denominacion;
$$
DELIMITER ;