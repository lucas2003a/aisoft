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
CALL spu_inactive_projects(1);
