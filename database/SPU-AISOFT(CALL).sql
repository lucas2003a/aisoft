USE AISOFT;

-- DEPARTAMENTOS
CALL spu_list_departaments;  -- SON 25 DEPARTAMENTOS 11=> ICA

-- PROVINCIAS
CALL spu_list_provinces(11); -- 11 => ICA

-- DISTRITOS
CALL spu_list_districts(100); -- 100 => PROVINCIA DE CHINCHA

-- EMPRESAS
CALL spu_list_companies();
CALL spu_list_companies_ruc("12"); -- POR RUC

-- DIRECCIONES
CALL spu_list_adresses("12");

-- PROYECTOS
CALL spu_list_projects();
CALL spu_list_projects_by_code("san blas");
CALL spu_add_projects("", 3, "B-20 PUERTO RICO", "RESIDENCIAL PUERTO RICO", "", "", "", 15, "CALLE LOS ROSALES 123", 3);
CALL spu_set_projects(6, "", 3, "B-20 PUERTO RICO", "GRAN RESIDENCIAL PUERTO RICO", "", "", "", 15, "CALLE LOS ROSALES 123", 3);
CALL spu_inactive_projects(6);
CALL spu_list_drop_projects();
CALL spu_list_drop_projects_by_code("12");
CALL spu_restore_projects(6);

-- lotes
SELECT * FROM separaciones;
CALL spu_list_lots_by_id(10); -- OBTENGO LOS LOTES POR ID
CALL spu_list_lots_short();
CALL spu_list_lots_short_by_code("LT0");
CALL spu_inactive_list_short();
CALL spu_inactive_list_short_by_code("LT");
CALL spu_add_lots("",6,'NO VENDIDO', 'LT043', 'CUH C002', 38, 'AVENIDA PRINCIPAL', NULL, NULL, NULL, 'USD', 90.00, 60.0, 60.0, NULL, NULL, 6, '11077477 del Registro de Propiedad Inmueble Zona Registral N: XI- Sede Ica', '{"otros_detalles": "Información adicional 22"}', 1);
CALL spu_set_lots(32, "",6,'NO VENDIDO', 'LT043', 'CUH C002', 38, 'AVENIDA PRINCIPAL', NULL, NULL, NULL, 'USD', 90.00, 60.0, 60.0, NULL, NULL, 6, '11077477 del Registro de Propiedad Inmueble Zona Registral N: XI- Sede Ica', '{"otros_detalles": "Información adicional 22"}', 1);
CALL spu_inactive_lots(2); -- DESACTIVA POR ID SI EL LOTE ESTA "NO VENDIDO"
CALL spu_restore_lotes(2); -- RECUPERA LOS LOTES DESACTIVADOS POR IDLOTE
SELECT *FROM lotes;

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
CALL spu_lits_contracts_short_by_code("LT"); -- > OBTENGO EL CONTRATO POR EL CÓDIGO DEL LOTE (LISTA COMPLETA)
CALL spu_lits_contracts_full_by_id(4); -- > OBTENGO EL CONTRATO COMPLETO POR EL IDCONTRATO
CALL spu_add_contracts(6, 3, NULL, 5, NULL, 15000.00, 500.00, 1000.00, 1200.00, '2024-03-10', 'USD', 'mensual', 0.05, 3.50, 'Activo', '2024-03-10', 3);
CALL set_inactive_contracts(6);
CALL spu_list_inactive_contracts_short();
CALL spu_list_inactive_contracts_short_by_code("LT");

-- CUANDO RESTAURES UN CONTRATO ELIMINADO, PRIMERO VERIFFICA QUE NO EXISTA OTRO CONTRATO ACTIVO CON ESE LOTE
CALL spu_resotres_contracts(5);
SELECT * FROM contratos;

    
