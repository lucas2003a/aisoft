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
CALL spu_list_projects();
CALL spu_list_projects_by_code("san blas");
CALL spu_add_projects("", 3, "B-20 PUERTO RICO", "RESIDENCIAL PUERTO RICO", "", "", "", 15, "CALLE LOS ROSALES 123", 3);
CALL spu_set_projects(6, "", 3, "B-20 PUERTO RICO", "GRAN RESIDENCIAL PUERTO RICO", "", "", "", 15, "CALLE LOS ROSALES 123", 3);
CALL spu_inactive_projects(6);
CALL spu_list_drop_projects();
CALL spu_list_drop_projects_by_code("b-20");
CALL spu_restore_projects(6);

-- lotes
SELECT * FROM separaciones;
CALL spu_list_lots_by_id(10); -- OBTENGO LOS LOTES POR ID
CALL spu_list_lots_short();
CALL spu_list_lots_short_by_code("LT0");
CALL spu_inactive_list_short();
CALL spu_inactive_list_short_by_code("LT");
CALL spu_add_lots(1, 'VENDIDO', 'LT040', 1, 'Urbanización XYZ', '12.3456', '-78.9101', '{"puntos": [{"x": 1, "y": 2}, {"x": 3, "y": 4}, {"x": 5, "y": 6}]}', 'USD', 200.00, 'Número de partida eléctronica', 12);
CALL spu_set_lots(16, 6, 'VENDIDO', 'LT070', 1, 'Urbanización XYA', '12.3456', '-78.9101', '{"puntos": [{"x": 1, "y": 2}, {"x": 3, "y": 4}, {"x": 5, "y": 6}]}', 'USD', 200.00, 'Número de partida eléctronica', 12);
CALL spu_inactive_lots(2); -- DESACTIVA POR ID SI EL LOTE ESTA "NO VENDIDO"
CALL spu_restore_lotes(2); -- RECUPERA LOS LOTES DESACTIVADOS POR IDLOTE
SELECT *FROM lotes;

SELECT * FROM viviendas;
UPDATE lotes AS lt 
INNER JOIN viviendas AS viv ON viv.idlote = lt.idlote
SET estado_venta = "VENDIDO";

-- VIVIENDAS
SELECT * FROM viviendas;
CALL spu_add_houses(6,"", 'CHU 001', 200.00, 250.00, NULL, 5, 2, '{"detalle": "Información adicional"}', 1);
CALL spu_set_houses(11, 7,"", 'CHU 001', 200.00, 250.00, NULL, 5, 2, '{"detalle": "Información adicional"}', 1);
CALL spu_inactive_houses(9);
CALL spu_restore_houses(9);
SELECT * FROM presupuestos;

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
CALL spu_list_contracts_short(); -- > LISTA CORTA
CALL spu_lits_contracts_short_by_code("LT001"); -- > OBTENGO EL CONTRATO POR EL CÓDIGO DEL LOTE (LISTA COMPLETA)
CALL spu_lits_contracts_full_by_id(4); -- > OBTENGO EL CONTRATO COMPLETO POR EL IDCONTRATO
CALL spu_add_contracts(3, 1, NULL, 2, NULL, 50000.00, 3.50, 'ACTIVO', 'VENTA', '{"detalle": "Información adicional"}', '2024-03-15', 1);
CALL spu_set_contracts(7, 3, 1, NULL, 2, NULL, 50000.00, 3.50, 'ACTIVO', 'VENTA', '{"detalle": "Información adicional", "detalles construccion":"varios"}', '2024-03-15', 1);
CALL set_inactive_contracts(3);
CALL spu_list_inactive_contracts_short();
CALL spu_list_inactive_contracts_short_by_code("LT");

-- CUANDO RESTAURES UN CONTRATO ELIMINADO, PRIMERO VERIFFICA QUE NO EXISTA OTRO CONTRATO ACTIVO CON ESE LOTE
CALL spu_resotres_contracts(3);
SELECT * FROM contratos;

    
