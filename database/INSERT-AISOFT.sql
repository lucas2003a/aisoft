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
			VALUES (1, 'LISTAR-activos'),
					(1, 'EDITAR-CLIENTES'),
					(1, 'CREAR-VENTAS'),
					(1, 'ELIMINAR-PROYECTOS'),

			-- Representante de ventas 2
				(2, 'LISTAR-PROYECTOS'),
				(2, 'EDITAR-activos'),
				(2, 'CREAR-CLIENTES'),
				(2, 'ELIMINAR-VENTAS'),

			-- Administrador principal
				(3, 'LISTAR-CLIENTES'),
				(3, 'EDITAR-VENTAS'),
				(3, 'CREAR-activos'),
				(3, 'ELIMINAR-PROYECTOS'),

			-- Administrador asistente
				(4, 'LISTAR-VENTAS'),
				(4, 'EDITAR-PROYECTOS'),
				(4, 'CREAR-CLIENTES'),
				(4, 'ELIMINAR-activos'),

			-- Administrador secundario
				(5, 'LISTAR-PROYECTOS'),
				(5, 'EDITAR-activos'),
				(5, 'CREAR-VENTAS'),
				(5, 'ELIMINAR-CLIENTES'),

			-- Vendedor
				(6, 'LISTAR-activos'),
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
SELECT * FROM metricas;

-- ACTIVOS
ALTER TABLE activos AUTO_INCREMENT = 0; 
SELECT * FROM activos;

-- activos
INSERT INTO activos (idproyecto, tipo_activo, codigo, sublote, direccion, moneda_venta, area_terreno, partida_elect, precio_venta, create_at, idusuario)
VALUES
	(1, 'lote', 'AC00001', 1, 'Urbanización Alpha', 'USD', 300.00, 'Partida 001', 80000.00, CURDATE(), 1),
	(2, 'lote', 'AC00003', 1, 'Urbanización Gamma', 'USD', 250.00, 'Partida 003', 100000.00, CURDATE(), 1),
	(1, 'lote', 'AC00005', 3, 'Urbanización Epsilon', 'USD', 350.00, 'Partida 005', 90000.00, CURDATE(), 1),
	(3, 'lote', 'AC00007', 2, 'Urbanización Eta', 'USD', 400.00, 'Partida 007', 120000.00, CURDATE(), 3),
	(2, 'lote', 'AC00009', 3, 'Urbanización Iota', 'USD', 280.00, 'Partida 009', 110000.00, CURDATE(), 2),
	(3, 'lote', 'AC00011', 5, 'Urbanización Lambda', 'USD', 320.00, 'Partida 011', 95000.00, CURDATE(), 2),
	(4, 'lote', 'AC00013', 1, 'Urbanización Nu', 'USD', 300.00, 'Partida 013', 85000.00, CURDATE(), 2),
	(4, 'lote', 'AC00015', 3, 'Urbanización Omicron', 'USD', 380.00, 'Partida 015', 110000.00, CURDATE(), 1),
	(1, 'lote', 'AC00017', 7, 'Urbanización Rho', 'USD', 420.00, 'Partida 017', 105000.00, CURDATE(), 3),
	(2,	'lote', 'AC00019', 9, 'Urbanización Tau', 'USD', 450.00, 'Partida 019', 115000.00, CURDATE(), 3),
	(3, 'lote', 'AC00021', 11, 'Urbanización Phi', 'USD', 480.00, 'Partida 021', 100000.00, CURDATE(), 2),
	(4, 'lote', 'AC00023', 13, 'Urbanización Psi', 'USD', 500.00, 'Partida 023', 120000.00, CURDATE(), 2),
	(1, 'lote', 'AC00025', 15, 'Urbanización Beta', 'USD', 300.00, 'Partida 025', 90000.00, CURDATE(), 2);

-- CASAS
INSERT INTO activos (idproyecto, tipo_activo, codigo, sublote, direccion, moneda_venta, area_terreno, partida_elect, idactivo, precio_venta, create_at, idusuario)
VALUES
	(1, 'casa', 'AC00002', 2, 'Urbanización Beta', 'USD', 200.00, 'Partida 002', 1, 150000.00, CURDATE(), 1),
	(2, 'casa', 'AC00004', 2, 'Urbanización Delta', 'USD', 220.00, 'Partida 004', 2, 180000.00, CURDATE(), 1),
	(1, 'casa', 'AC00006', 4, 'Urbanización Zeta', 'USD', 180.00, 'Partida 006', 3, 120000.00, CURDATE(), 2),
	(3, 'casa', 'AC00008', 3, 'Urbanización Theta', 'USD', 250.00, 'Partida 008', 4, 200000.00, CURDATE(), 2),
	(2, 'casa', 'AC00010', 4, 'Urbanización Kappa', 'USD', 230.00, 'Partida 010', 5, 190000.00, CURDATE(), 2),
	(3, 'casa', 'AC00012', 6, 'Urbanización Mu', 'USD', 210.00, 'Partida 012', 6, 160000.00, CURDATE(), 2),
	(4, 'casa', 'AC00014', 2, 'Urbanización Xi', 'USD', 240.00, 'Partida 014', 7, 175000.00, CURDATE(), 2),
	(4, 'casa', 'AC00016', 4, 'Urbanización Pi', 'USD', 260.00, 'Partida 016', 8, 220000.00, CURDATE(), 3),
	(1, 'casa', 'AC00018', 8, 'Urbanización Sigma', 'USD', 280.00, 'Partida 018', 9, 200000.00, CURDATE(), 3),
	(2, 'casa', 'AC00020', 10, 'Urbanización Upsilon', 'USD', 300.00, 'Partida 020', 10, 210000.00, CURDATE(), 3),
	(3, 'casa', 'AC00022', 12, 'Urbanización Chi', 'USD', 320.00, 'Partida 022', 11, 180000.00, CURDATE(), 2),
	(4, 'casa', 'AC00024', 14, 'Urbanización Omega', 'USD', 350.00, 'Partida 024', 12, 190000.00, CURDATE(), 2);


SELECT * FROM activos;

-- CLIENTES
INSERT INTO clientes (nombres, apellidos, documento_tipo, documento_nro, estado_civil, iddistrito, direccion, idusuario)
			VALUES
				('Juan Carlos', 'Pérez García', 'DNI', '12345678', 'Soltero', 1007, 'Av. Primavera 123', 1),
				('María Luisa', 'Gómez Fernández', 'DNI', '23456789', 'Casada', 1007, 'Calle Flores 456', 2),
				('Pedro José', 'Ramírez Sánchez', 'DNI', '34567890', 'Soltero', 1007, 'Jr. Libertad 789', 3);

SELECT * FROM clientes;

-- CONTRATOS
INSERT INTO contratos (idcliente, idconyugue, idrepresentante_primario, idrepresentante_secundario, tipo_cambio, estado, fecha_contrato, idusuario)
			VALUES
				(1, NULL, 1, NULL, 3.500, 'VIGENTE', '2024-03-10', 1),
				(2, NULL, 2, NULL, 3.500, 'VIGENTE', '2024-03-11', 2),
				(3, NULL, 2, NULL, 3.500, 'VIGENTE', '2024-03-12', 3),
				(1, NULL, 1, NULL, 3.500, 'VIGENTE', '2024-03-13', 4),
				(2, NULL, 1, NULL, 3.500, 'VIGENTE', '2024-03-14', 5);

SELECT * FROM contratos;

-- VENDEDORES REPRESENTANTE
INSERT INTO vend_representantes (idvendedor, idrepresentante, idusuario)
			VALUES
				(6, 1, 1),
				(7, 2, 2);
SELECT * FROM vend_representantes;

-- SEPARACIONES
INSERT INTO separaciones (
    idactivo, idvend_representante, idcliente, separacion, fecha_pago,
    penalidad_porcent, estado, create_at, idusuario
	) 
		VALUES (
		1, 1, 1, 150.5, '2024-03-08',
		5, 'Activo', '2024-03-08', 1
		);
        
INSERT INTO separaciones (
    idactivo, idvend_representante, idcliente, separacion, fecha_pago,
    penalidad_porcent, estado, create_at, idusuario
	) 
		VALUES (
		5, 1, 1, 150.5, '2024-03-08',
		5, 'Activo', '2024-03-08', 1
		);
INSERT INTO separaciones (
    idactivo, idvend_representante, idcliente, separacion, fecha_pago,
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
INSERT INTO desembolsos (idfinanciera, idactivo, monto_desemb, porcentaje, fecha_desembolso, idusuario)
			VALUES 
				(1, 2, 5000.00, 10, NOW(), 1),
				(2, 5, 7000.00, 15, NOW(), 1);
SELECT * FROM desembolsos;

-- PRESUPUESTOS
INSERT INTO presupuestos (idactivo, descripcion, fecha_program, idusuario)
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
INSERT INTO cuotas (idcontrato, monto_cuota, fecha_vencimiento, tipo_pago, entidad_bancaria, idusuario)
			VALUES 
				(6, 500.00, '2024-03-10', 'TRANSFERENCIA', 'BCP', 7),
				(6, 500.00, '2024-04-10', 'TRANSFERENCIA', 'BCP', 7);
                
INSERT INTO cuotas (idcontrato, monto_cuota, fecha_vencimiento, tipo_pago, entidad_bancaria, idusuario)
			VALUES 
				(7, 500.00, '2024-03-18','TRANSFERENCIA', 'BCP', 6),
				(7, 500.00, '2024-04-13','TRANSFERENCIA', 'BCP',  6);          
SELECT * FROM cuotas;

-- SUTENTOS CUOTAS
INSERT INTO sustentos_cuotas (idcuota, ruta, idusuario)
			VALUES 
				(9, '/ruta/imagen1.jpg', 1),
				(9, '/ruta/imagen2.jpg', 1),
                (9, '/ruta/imagen1.jpg', 1),
				(9, '/ruta/imagen2.jpg', 1),
                (7, '/ruta/imagen1.jpg', 2),
				(7, '/ruta/imagen2.jpg', 2),
                (8, '/ruta/imagen1.jpg', 2),
				(8, '/ruta/imagen2.jpg', 2);
SELECT * FROM sustentos_cuotas;                
