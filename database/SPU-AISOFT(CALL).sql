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
CALL spu_list_lots();
CALL spu_list_lots_short();
CALL spu_list_lots_short_by_code("LT0");
CALL spu_inactive_list_short();
CALL spu_inactive_list_short_by_code("LT");
CALL spu_add_lots("",6,'NO VENDIDO', 'LT043', 'CUH C002', 38, 1, 'AVENIDA PRINCIPAL', NULL, NULL, NULL, 'USD', 90.00, 60.0, 60.0, NULL, NULL, 6, '11077477 del Registro de Propiedad Inmueble Zona Registral N: XI- Sede Ica', '{"otros_detalles": "Información adicional 22"}', 1);
CALL spu_set_lots(32, "",6,'NO VENDIDO', 'LT043', 'CUH C002', 38, 1, 'AVENIDA PRINCIPAL', NULL, NULL, NULL, 'USD', 90.00, 60.0, 60.0, NULL, NULL, 6, '11077477 del Registro de Propiedad Inmueble Zona Registral N: XI- Sede Ica', '{"otros_detalles": "Información adicional 22"}', 1);

    
