USE AISOFT;

-- EMPRESAS
INSERT INTO empresas(razon_social, ruc, partida_elect)
	VALUES
    ("A.I. F CONTRATISTAS GENERALES S.A.C","20494453003","11013804 del Registro de Personas Jurídicas de CHINCHA-ICA"),
    ("XYZ Construcciones S.A.C.", "12345678901", "78901234 del Registro de Empresas de Arequipa"),
	("Inversiones TechCorp S.A.", "98765432109", "56789012 del Registro de Empresas de Lima");
    
SELECT * FROM empresas;

-- DIRECCIONES
INSERT INTO direcciones(idempresa, iddistrito, direccion, referencia)
			VALUES
				(1, 1007, "MZA. A LOTE. 06 URB. JULIO ARBOLEDA","A 1/2 CUADRA DE MAESTRO"),
                (1, 1009, "AV. LOS ALAMOS MZA. C LOTE. 25 URB. EL ROSAL","FRENTE AL PARQUE"),
				(1, 1010, "CALLE LOS GIRASOLES MZA. E LOTE. 10 URB. LAS MARGARITAS","A 200 METROS DE LA AVENIDA PRINCIPAL");
                
INSERT INTO direcciones(idempresa, iddistrito, direccion, referencia)
			VALUES
				(2, 1008, "MZA. A LOTE. 06 URB. JULIO ARBOLEDA","A 1/2 CUADRA DE MAESTRO"),
                (2, 1010, "AV. LOS ALAMOS MZA. C LOTE. 25 URB. EL ROSAL","FRENTE AL PARQUE"),
				(2, 1011, "CALLE LOS GIRASOLES MZA. E LOTE. 10 URB. LAS MARGARITAS","A 200 METROS DE LA AVENIDA PRINCIPAL");                
                                
                
SELECT * FROM direcciones;

-- ROLES
INSERT INTO roles(rol)
			VALUES
				("REPRESENTANTE DE VENTAS 1"),
                ("REPRESENTANTE DE VENTAS 2"),
                ("ADMINISTRADOR PRINCIPAL"),
                ("ADMINISTRADOR AASISTENTE"),
                ("ADMINISTRADOR SECUNDARIO"),
                ("VENDEDOR");

SELECT * FROM roles;

-- PERMISOS
INSERT INTO permisos(idrol, modulo)
			VALUES (1, 'LISTAR-LOTES'),
					(1, 'EDITAR-CLIENTES'),
					(1, 'CREAR-VENTAS'),
					(1, 'ELIMINAR-PROYECTOS'),

			-- Representante de ventas 2
				(2, 'LISTAR-PROYECTOS'),
				(2, 'EDITAR-LOTES'),
				(2, 'CREAR-CLIENTES'),
				(2, 'ELIMINAR-VENTAS'),

			-- Administrador principal
				(3, 'LISTAR-CLIENTES'),
				(3, 'EDITAR-VENTAS'),
				(3, 'CREAR-LOTES'),
				(3, 'ELIMINAR-PROYECTOS'),

			-- Administrador asistente
				(4, 'LISTAR-VENTAS'),
				(4, 'EDITAR-PROYECTOS'),
				(4, 'CREAR-CLIENTES'),
				(4, 'ELIMINAR-LOTES'),

			-- Administrador secundario
				(5, 'LISTAR-PROYECTOS'),
				(5, 'EDITAR-LOTES'),
				(5, 'CREAR-VENTAS'),
				(5, 'ELIMINAR-CLIENTES'),

			-- Vendedor
				(6, 'LISTAR-LOTES'),
				(6, 'EDITAR-CLIENTES'),
				(6, 'CREAR-VENTAS'),
				(6, 'ELIMINAR-PROYECTOS');

SELECT * FROM permisos;

-- USUARIOS
INSERT INTO usuarios (nombres, apellidos, documento_tipo, documento_nro, estado_civil, iddistrito, direccion, correo, contraseña, idrol, iddireccion)
VALUES
-- IDDIRECCION 1 => (1, 1007, "MZA. A LOTE. 06 URB. JULIO ARBOLEDA","A 1/2 CUADRA DE MAESTRO")
('Juan Carlos', 'González Pérez', 'DNI', '11111111', 'Soltero', 1, 'Calle A 123', 'juancarlos@gmail.com', 'contraseña1', 1, 1),
('María José', 'Hernández López', 'DNI', '22222222', 'Casada', 2, 'Calle B 456', 'mariajose@gmail.com', 'contraseña2', 2, 1),
('Pedro Luis', 'Díaz Martínez', 'DNI', '33333333', 'Divorciado', 3, 'Calle C 789', 'pedroluis@gmail.com', 'contraseña3', 3, 1),
('Ana Sofía', 'López Sánchez', 'DNI', '44444444', 'Soltera', 4, 'Calle D 012', 'anasofia@gmail.com', 'contraseña4', 4, 1),
('José María', 'Martínez Gómez', 'DNI', '55555555', 'Viuda', 5, 'Calle E 345', 'josemaria@gmail.com', 'contraseña5', 5, 1),
('Luisa Elena', 'Gómez Rodríguez', 'DNI', '66666666', 'Casado', 6, 'Calle F 678', 'luisaelena@gmail.com', 'contraseña6', 6, 1),
('Jorge Pablo', 'Rodríguez García', 'DNI', '77777777', 'Soltera', 7, 'Calle G 901', 'jorgepablo@gmail.com', 'contraseña7', 6, 1);

-- IDDIRECCION 2 => (1, 1009, "AV. LOS ALAMOS MZA. C LOTE. 25 URB. EL ROSAL","FRENTE AL PARQUE"),
INSERT INTO usuarios (nombres, apellidos, documento_tipo, documento_nro, estado_civil, iddistrito, direccion, correo, contraseña, idrol, iddireccion)
VALUES
('Carlos Antonio', 'Fernández Martín', 'DNI', '88888888', 'Casado', 8, 'Calle H 234', 'carlosantonio@gmail.com', 'contraseña8', 1, 2),
('María Carmen', 'Sánchez López', 'DNI', '99999999', 'Soltera', 9, 'Calle I 567', 'mariacarmen@gmail.com', 'contraseña9', 2, 2),
('Francisco Javier', 'Gómez Rodríguez', 'DNI', '10101010', 'Divorciado', 10, 'Calle J 890', 'franciscojavier@gmail.com', 'contraseña10', 3, 2),
('Elena Isabel', 'Díaz García', 'DNI', '11111112', 'Casado', 11, 'Calle K 111', 'elenaisabel@gmail.com', 'contraseña11', 4, 2),
('Pedro Luis', 'Martínez López', 'DNI', '12121212', 'Soltera', 12, 'Calle L 222', 'pedroluis2@gmail.com', 'contraseña12', 5, 2),
('María Isabel', 'García Pérez', 'DNI', '13131313', 'Casado', 13, 'Calle M 333', 'mariaisabel@gmail.com', 'contraseña13', 6, 2),
('Antonio José', 'Hernández Martín', 'DNI', '14141414', 'Soltera', 14, 'Calle N 444', 'antoniojose@gmail.com', 'contraseña14', 6, 2);

SELECT * FROM usuarios;

-- PROYECTOS
INSERT INTO proyectos(iddireccion, codigo, denominacion, iddistrito,direccion, idusuario)
			VALUES
				(1, 'A-12 SAN BLAS', 'RESIDENCIAL SAN BLAS', 1007, 'Dirección A-12 SAN BLAS', 1),
				(1, 'A-17 SAN PEDRO', 'RESIDENCIAL SAN PABLO', 1007, 'Dirección A-17 SAN PEDRO', 2),
				(1, 'A-13 Santo Domingo', 'RESIDENCIAL Santo Domingo', 1007, 'Dirección Santo Domingo', 3),
				(1, 'A-14 Centenario II', 'RESIDENCIAL Centenario II', 1007, 'Dirección Centenario II', 4),
				(1, 'A-15 Kalea Playa', 'Kalea Playa', 1007, 'Dirección Kalea Playa', 5);
                
SELECT * FROM PROYECTOS;

-- LOTES
ALTER TABLE lotes AUTO_INCREMENT = 0; SELECT *  FROM lotes;
INSERT INTO lotes (idproyecto, estado_venta, codigo, sublote, urbanizacion, moneda_venta, area_terreno, partida_elect, idusuario)
			VALUES
				(1, 'NO VENDIDO', 'LT001', 17, 'SUB LOTE A-17 ZONA CALLE PROGRESO N°137', 'USD', 70.02, '11077471 del Registro de Propiedad Inmueble Zona Registral N: XI- Sede Ica', 1),
				(1, 'VENDIDO', 'LT002', 2, 'URBANIZACIÓN EL ROSAL', 'USD', 80.00, '11077472 del Registro de Propiedad Inmueble Zona Registral N: XI- Sede Ica', 2),
				(1, 'SEPARADO', 'LT003', 3, 'LAS ACACIAS', 'USD', 65.75, '11077473 del Registro de Propiedad Inmueble Zona Registral N: XI- Sede Ica', 3),
				(1, 'NO VENDIDO', 'LT004', 4, 'VISTA HERMOSA', 'USD', 75.50, '11077474 del Registro de Propiedad Inmueble Zona Registral N: XI- Sede Ica', 4),
				(1, 'VENDIDO', 'LT005', 5, 'SAN MIGUEL', 'USD', 90.20, '11077475 del Registro de Propiedad Inmueble Zona Registral N: XI- Sede Ica', 5),
				(2, 'NO VENDIDO', 'LT006', 6, 'AVENIDA PRINCIPAL', 'USD', 100.00, '11077476 del Registro de Propiedad Inmueble Zona Registral N: XI- Sede Ica', 1),
				(2, 'SEPARADO', 'LT007', 7, 'CALLE ESPERANZA', 'USD', 85.50, '11077477 del Registro de Propiedad Inmueble Zona Registral N: XI- Sede Ica', 2),
				(2, 'VENDIDO', 'LT008', 8, 'PASEO DEL SOL', 'USD', 95.75, '11077478 del Registro de Propiedad Inmueble Zona Registral N: XI- Sede Ica', 3),
				(3, 'NO VENDIDO', 'LT009', 9, 'AVENIDA DEL MAR', 'USD', 110.25, '11077479 del Registro de Propiedad Inmueble Zona Registral N: XI- Sede Ica', 4),
				(3, 'SEPARADO', 'LT010', 10, 'CALLE SAN JUAN', 'USD', 120.00, '11077480 del Registro de Propiedad Inmueble Zona Registral N: XI- Sede Ica', 5),
				(3, 'VENDIDO', 'LT011', 11, 'PASEO DEL BOSQUE', 'USD', 130.50, '11077481 del Registro de Propiedad Inmueble Zona Registral N: XI- Sede Ica', 1),
				(3, 'NO VENDIDO', 'LT012', 12, 'CALLE NUEVA', 'USD', 145.75, '11077482 del Registro de Propiedad Inmueble Zona Registral N: XI- Sede Ica', 2),
				(4, 'SEPARADO', 'LT013', 13, 'AVENIDA LIBERTAD', 'USD', 155.25, '11077483 del Registro de Propiedad Inmueble Zona Registral N: XI- Sede Ica', 3),
				(4, 'VENDIDO', 'LT020', 14, 'PASEO DE LA LUNA', 'USD', 160.00, '11077484 del Registro de Propiedad Inmueble Zona Registral N: XI- Sede Ica', 4),
				(4, 'NO VENDIDO', 'LT021', 15, 'CALLE PRINCIPAL', 'USD', 170.50, '11077485 del Registro de Propiedad Inmueble Zona Registral N: XI- Sede Ica', 5),
				(5, 'SEPARADO', 'LT022', 16, 'AVENIDA DEL CIELO', 'USD', 180.75, '11077486 del Registro de Propiedad Inmueble Zona Registral N: XI- Sede Ica', 1),
				(5, 'VENDIDO', 'LT023', 17, 'PASEO DE LAS ESTRELLAS', 'USD', 190.25, '11077487 del Registro de Propiedad Inmueble Zona Registral N: XI- Sede Ica', 2),
				(5, 'NO VENDIDO', 'LT024', 19, 'CALLE LA LUNA', 'USD', 200.50, '11077488 del Registro de Propiedad Inmueble Zona Registral N: XI- Sede Ica', 3),
				(5, 'SEPARADO', 'LT025', 20, 'AVENIDA DEL SOL', 'USD', 210.00, '11077489 del Registro de Propiedad Inmueble Zona Registral N: XI- Sede Ica', 4),
				(5, 'VENDIDO', 'LT026', 21, 'PASEO DE LA TIERRA', 'USD', 220.25, '11077490 del Registro de Propiedad Inmueble Zona Registral N: XI- Sede Ica', 5),
				(5, 'SEPARADO', 'LT027', 22, 'AVENIDA DEL CIELO', 'USD', 180.75, '11077486 del Registro de Propiedad Inmueble Zona Registral N: XI- Sede Ica', 1),
				(5, 'VENDIDO', 'LT028', 23, 'PASEO DE LAS ESTRELLAS', 'USD', 190.25, '11077487 del Registro de Propiedad Inmueble Zona Registral N: XI- Sede Ica', 2),
				(5, 'NO VENDIDO', 'LT029', 24, 'CALLE LA LUNA', 'USD', 200.50, '11077488 del Registro de Propiedad Inmueble Zona Registral N: XI- Sede Ica', 3),
				(5, 'SEPARADO', 'LT030', 25, 'AVENIDA DEL SOL', 'USD', 210.00, '11077489 del Registro de Propiedad Inmueble Zona Registral N: XI- Sede Ica', 4),
				(5, 'VENDIDO', 'LT031', 26, 'PASEO DE LA TIERRA', 'USD', 220.25, '11077490 del Registro de Propiedad Inmueble Zona Registral N: XI- Sede Ica', 5),
				(2, 'NO VENDIDO', 'LT032', 27, 'CALLE NUEVA ESPERANZA', 'USD', 230.50, '11077491 del Registro de Propiedad Inmueble Zona Registral N: XI- Sede Ica', 1),
				(3, 'SEPARADO', 'LT033', 28, 'AVENIDA PRINCIPAL', 'USD', 240.75, '11077492 del Registro de Propiedad Inmueble Zona Registral N: XI- Sede Ica', 2),
				(4, 'VENDIDO', 'LT034', 29, 'PASEO DEL PARQUE', 'USD', 250.00, '11077493 del Registro de Propiedad Inmueble Zona Registral N: XI- Sede Ica', 3),
				(2, 'NO VENDIDO', 'LT035', 30, 'CALLE DE LA ESPERANZA', 'USD', 260.25, '11077494 del Registro de Propiedad Inmueble Zona Registral N: XI- Sede Ica', 4),	
				(3, 'SEPARADO', 'LT036', 31, 'AVENIDA DEL PROGRESO', 'USD', 270.50, '11077495 del Registro de Propiedad Inmueble Zona Registral N: XI- Sede Ica', 5);


SELECT * FROM lotes;

-- VIVIENDAS
INSERT INTO viviendas (idlote, tipo_casa, area_construccion, area_techada, airesm2, zcomunes_porcent, estacionamiento_nro, detalles, idusuario)
			VALUES
				(1, 'CUH C001', 70.0, 70.0, NULL, NULL, 5, '{"otros_detalles": "Información adicional para la vivienda 1"}', 1),
				(2, 'CUH C001', 55.25, 55.25, NULL, NULL, 6, '{"otros_detalles": "Información adicional para la vivienda 2"}', 2),
				(3, 'CUH C001', 65.75, 65.75, NULL, 8, NULL, '{"otros_detalles": "Información adicional para la vivienda 3"}', 3),
				(4, 'CUH C001', 80.25, 80.25, NULL, NULL, 8, '{"otros_detalles": "Información adicional para la vivienda 4"}', 4),
				(5, 'CUH C001', 90.0, 90.0, NULL, NULL, 10, '{"otros_detalles": "Información adicional para la vivienda 5"}', 5),
				(1, 'CUH C002', 100.0, 100.0, NULL, 12, NULL, '{"otros_detalles": "Información adicional para la vivienda 6"}', 1),
				(2, 'CUH C002', 110.0, 110.0, NULL, 15, NULL, '{"otros_detalles": "Información adicional para la vivienda 7"}', 2),
				(3, 'CUH C002', 120.0, 120.0, NULL, 18, NULL, '{"otros_detalles": "Información adicional para la vivienda 8"}', 3),
				(4, 'CUH C002', 125.0, 125.0, NULL, 20, NULL, '{"otros_detalles": "Información adicional para la vivienda 9"}', 4),
				(5, 'CUH C002', 135.0, 135.0, NULL, 22, NULL, '{"otros_detalles": "Información adicional para la vivienda 10"}', 5);


-- CLIENTES
INSERT INTO clientes (nombres, apellidos, documento_tipo, documento_nro, estado_civil, iddistrito, direccion, idusuario)
			VALUES
				('Juan Carlos', 'Pérez García', 'DNI', '12345678', 'Soltero', 1007, 'Av. Primavera 123', 1),
				('María Luisa', 'Gómez Fernández', 'DNI', '23456789', 'Casada', 1007, 'Calle Flores 456', 2),
				('Pedro José', 'Ramírez Sánchez', 'DNI', '34567890', 'Soltero', 1007, 'Jr. Libertad 789', 3);

SELECT * FROM clientes;

-- CONTRATOS
INSERT INTO contratos (idlote, idcliente, idcliente2, idrepresentante, idrepresentante2, precio_total, tipo_cambio, estado, tipo_contrato, detalles, fecha_contrato, idusuario)
			VALUES
				(1, 1, NULL, 1, NULL, 150000.00, 3.500, 'VIGENTE', 'VENTA', '{"cuota_inicial":5000.00,"bono":1500.00,"financiamiento":8000.00,"plazo_entrega":"2024-12-31","penalidad_moneda":"USD","penalidad_periodo":"mensual","penalidad":100.00}
', '2024-03-10', 1),
				(2, 2, NULL, 2, NULL, 120000.00, 3.500, 'VIGENTE', 'VENTA', '{"cuota_inicial":5000.00,"bono":1500.00,"financiamiento":8000.00,"plazo_entrega":"2024-12-31","penalidad_moneda":"USD","penalidad_periodo":"mensual","penalidad":100.00}
', '2024-03-11', 2),
				(3, 3, NULL, 3, NULL, 135000.00, 3.500, 'VIGENTE', 'VENTA', '{"cuota_inicial":5000.00,"bono":1500.00,"financiamiento":8000.00,"plazo_entrega":"2024-12-31","penalidad_moneda":"USD","penalidad_periodo":"mensual","penalidad":100.00}
', '2024-03-12', 3),
				(4, 1, NULL, 4, NULL, 145000.00, 3.500, 'VIGENTE', 'VENTA', '{"cuota_inicial":5000.00,"bono":1500.00,"financiamiento":8000.00,"plazo_entrega":"2024-12-31","penalidad_moneda":"USD","penalidad_periodo":"mensual","penalidad":100.00}
', '2024-03-13', 4),
				(5, 2, NULL, 5, NULL, 160000.00, 3.500, 'VIGENTE', 'VENTA', '{"cuota_inicial":5000.00,"bono":1500.00,"financiamiento":8000.00,"plazo_entrega":"2024-12-31","penalidad_moneda":"USD","penalidad_periodo":"mensual","penalidad":100.00}
', '2024-03-14', 5);

SELECT * FROM contratos;

-- VENDEDORES REPRESENTANTE
INSERT INTO vend_representantes (idvendedor, idrepresentante, idusuario)
			VALUES
				(6, 1, 1),
				(7, 2, 2);
SELECT * FROM vend_representantes;

-- SEPARACIONES
INSERT INTO separaciones (
    idlote, idvend_representante, idcliente, separacion, fecha_pago,
    penalidad_porcent, estado, create_at, idusuario
	) 
		VALUES (
		1, 1, 1, 150.5, '2024-03-08',
		5, 'Activo', '2024-03-08', 1
		);
        
INSERT INTO separaciones (
    idlote, idvend_representante, idcliente, separacion, fecha_pago,
    penalidad_porcent, estado, create_at, idusuario
	) 
		VALUES (
		5, 1, 1, 150.5, '2024-03-08',
		5, 'Activo', '2024-03-08', 1
		);
INSERT INTO separaciones (
    idlote, idvend_representante, idcliente, separacion, fecha_pago,
    penalidad_porcent, estado, create_at, idusuario
	) 
		VALUES (
		6, 1, 1, 150.5, '2024-03-08',
		5, 'Activo', '2024-03-08', 1
		);
SELECT * FROM separaciones;

-- SUSTENTO SEPARACIONES
INSERT INTO sustentos_sep (idseparacion, ruta, idusuario)
			VALUES 
				(1, '/ruta/del/sustento1.pdf', 1);
                
INSERT INTO sustentos_sep (idseparacion, ruta, idusuario)
			VALUES                 
                (1, '/ruta/del/sustento2.pdf', 2),
                (1, '/ruta/del/sustento3.pdf', 1),
                (1, '/ruta/del/sustento4.pdf', 2);
SELECT * FROM sustentos_sep;

-- FINANCIERAS
INSERT INTO financieras (ruc, razon_social, direccion)
			VALUES ('12345678901', 'Financiera ABC', 'Calle Principal 123'),
			('98765432109', 'Financiera XYZ', 'Avenida Secundaria 456');
SELECT * FROM financieras;

-- DESEMBOLSOS
INSERT INTO desembolsos (idfinanciera, idlote, monto_desemb, porcentaje, fecha_desembolso, idusuario)
			VALUES 
				(1, 2, 5000.00, 10, NOW(), 1),
				(2, 5, 7000.00, 15, NOW(), 1);
SELECT * FROM desembolsos;

-- PRESUPUESTOS
INSERT INTO presupuestos (idlote, descripcion, fecha_program, idusuario)
			VALUES 
				(2, 'Materiales de construcción', '2024-03-10', 1),
				(5, 'Materiales de construcción', '2024-03-15', 1);
SELECT * FROM presupuestos;

-- DETALLE GASTOS
INSERT INTO detalle_gastos (idpresupuesto, tipo_gasto, nombre_gasto, descripcion, cantidad, precio_unitario, idusuario)
			VALUES 
				(1, 'COSTO DIRECTO', 'Materiales de construcción', 'Compra de ladrillos', 100, 0.50, 1),
				(1, 'COSTO INDIRECTO', 'Gastos administrativos', 'Alquiler de oficina', 1, 300.00, 1),
				(1, 'COSTO DIRECTO', 'Materiales de construcción', 'Compra de cemento', 50, 8.00, 1),
				(1, 'COSTO INDIRECTO', 'Gastos administrativos', 'Pago de servicios', 1, 150.00, 1);
                
INSERT INTO detalle_gastos (idpresupuesto, tipo_gasto, nombre_gasto, descripcion, cantidad, precio_unitario, idusuario)
			VALUES
				(2, 'COSTO DIRECTO', 'Pago de mano de obra', 'Jornal de albañiles', 5, 50.00, 1),
				(2, 'COSTO INDIRECTO', 'Accesorios de baño', 'Compra de grifería', 3, 120.00, 1),
				(2, 'COSTO DIRECTO', 'Pago de mano de obra', 'Jornal de carpinteros', 3, 60.00, 1),
				(2, 'COSTO INDIRECTO', 'Gastos de supervisión', 'Honorarios de arquitecto', 1, 500.00, 1);
SELECT * FROM detalle_gastos;

-- CUOTAS
INSERT INTO cuotas (idcontrato, monto_cuota, fecha_vencimiento, idusuario)
			VALUES 
				(1, 500.00, '2024-03-10', 1),
				(1, 500.00, '2024-04-10', 1);
                
INSERT INTO cuotas (idcontrato, monto_cuota, fecha_vencimiento, idusuario)
			VALUES 
				(2, 500.00, '2024-03-18', 1),
				(2, 500.00, '2024-04-13', 1);          
SELECT * FROM cuotas;

-- SUTENTOS CUOTAS
INSERT INTO sustentos_cuotas (idcuota, ruta, idusuario)
			VALUES 
				(1, '/ruta/imagen1.jpg', 1),
				(1, '/ruta/imagen2.jpg', 1),
                (2, '/ruta/imagen1.jpg', 1),
				(2, '/ruta/imagen2.jpg', 1),
                (3, '/ruta/imagen1.jpg', 2),
				(3, '/ruta/imagen2.jpg', 2),
                (4, '/ruta/imagen1.jpg', 2),
				(4, '/ruta/imagen2.jpg', 2);
SELECT * FROM sustentos_cuotas;                
