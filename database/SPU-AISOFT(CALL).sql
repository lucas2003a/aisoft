USE AISOFT;

-- DEPARTAMENTOS
CALL spu_list_departaments;  -- SON 25 DEPARTAMENTOS 11=> ICA

-- PROVINCIAS
CALL spu_list_provinces(11); -- 11 => ICA

-- DISTRITOS
CALL spu_list_districts(100); -- 100 => PROVINCIA DE CHINCHA

-- EMPRESAS
CALL spu_list_companies();
CALL spu_list_companies_ruc("1"); -- POR RUC

-- DIRECCIONES
CALL spu_list_addresses();
CALL spu_list_addresses_ruc("12"); -- RUC EMPRESA

-- PROYECTOS
select * from proyectos;
CALL spu_list_projects();
CALL spu_list_projects_id(1);
CALL spu_list_projects_by_code("san blas");
CALL spu_add_projects("", 3, "B-20 PUERTO RICO", "RESIDENCIAL PUERTO RICO", "", "", "", 15, "CALLE LOS ROSALES 123", 3);
CALL spu_set_projects(6, "", 3, "B-20 PUERTO RICO", "GRAN RESIDENCIAL PUERTO RICO", "", "", "", 15, "CALLE LOS ROSALES 123", 3);
CALL spu_inactive_projects(6);
CALL spu_list_drop_projects();
CALL spu_list_drop_projects_by_code("b-20");
CALL spu_restore_projects(6);

-- ACTIVOS
SELECT * FROM separaciones;
CALL spu_list_assets_by_id(10); -- OBTENGO LOS ACTIVOS POR ID
CALL spu_list_assets_short();
CALL spu_list_assets_by_code("AC");
CALL spu_list_inactive_assets();
CALL spu_list_inactive_assets_by_code("LT");
CALL spu_add_assets(1, 'lote', NULL, 'Disponible', 'AC00060', 12, 'Calle Principal 123', 'USD', 300.00, 10, 'Partida 001','-12.045678', '-77.032456', '{"perimetro": "100m"}', NULL, 80000.00, 1);
CALL spu_set_assets(28, 1, 'lote', NULL, 'SIN VENDER', 'AC00060', 12, 'Calle Principal 123', 'USD', 300.00, 10, 'Partida 001','-12.045678', '-77.032456', '{"perimetro": "100m"}', NULL, 80000.00, 1);
CALL spu_inactive_assets(2); -- DESACTIVA POR ID SI EL LOTE ESTA "NO VENDIDO"
CALL spu_restore_assets(2); -- RECUPERA LOS LOTES DESACTIVADOS POR IDLOTE

SELECT * FROM activos;
UPDATE lotes AS lt 
INNER JOIN viviendas AS viv ON viv.idlote = lt.idlote
SET estado_venta = "VENDIDO";

-- CLIENTES
CALL spu_list_clients();
CALL spu_list_inactive_clients();
CALL spu_list_clients_by_docNro("12");
CALL spu_add_clients('Juan Carlos',' Perez Gomez', 'DNI', '77345678', 'Soltero', 1, 'Calle 123', 1);
CALL spu_set_clients(5, 'Juan Emilio',' Perez Gomez', 'DNI', '77345678', 'Soltero', 1, 'Calle 123', 1);
CALL spu_inactve_clients(3);
CALL spu_restore_clientes(3);
SELECT * FROM clientes;

-- CONTRATOS
SELECT * FROM contratos;
SELECT * FROM detalles_contratos;
CALL spu_lits_contracts_full_by_id(10); -- > OBTENGO EL CONTRATO COMPLETO POR EL IDCONTRATO
CALL spu_add_contracts(1, 0, 2, 0, '3.8', 'Activo', '{"detalle": "Información adicional", "detalles construccion":"varios"}', '2024-03-17',3);
CALL spu_set_contracts(10, 1, 0, 2, 0, '3.2', 'Activo', '{"detalle": "Información confidencial", "detalles construccion":"varios"}', '2024-03-17',3);
CALL set_inactive_contracts(1);

-- DETALLE CONTRATOS
SELECT * FROM detalles_contratos;
CALL spu_list_det_contracts(28);
CALL spu_add_det_contracts(28,6,1);
CALL spu_inactive_det_contracts(15);
SELECT * FROM METRICAS;

update activos set estado = "SEPARADO" WHERE idactivo = 28;
-- CUANDO RESTAURES UN CONTRATO ELIMINADO, PRIMERO VERIFFICA QUE NO EXISTA OTRO CONTRATO ACTIVO CON ESE LOTE
CALL spu_resotres_contracts(3);
SELECT * FROM activos WHERE idactivo = 11;
UPDATE activos SET estado = "SEPARADO" WHERE idactivo <16 AND idactivo > 0 ;

select * from proyectos;

    
