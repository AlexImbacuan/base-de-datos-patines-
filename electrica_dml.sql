INSERT INTO estados_patineta (nombre, descripcion) VALUES
('En carga', 'Patineta conectada a estación de carga'),
('Reservada', 'Patineta reservada por un usuario'),
('Revisando GPS', 'Patineta siendo diagnosticada por problemas de GPS'),
('Bloqueada', 'Patineta bloqueada por el sistema'),
('Extraviada', 'Patineta reportada como desaparecida'),
('Fuera de servicio', 'Patineta desactivada por razones técnicas'),
('Disponible', 'Patineta en buen estado y disponible para alquiler'),
('En uso', 'Patineta actualmente alquilada'),
('Mantenimiento', 'Patineta en reparación o mantenimiento'),
('Inactiva', 'Patineta no disponible por algún motivo');

INSERT INTO tipos_usuario (nombre, descripcion) VALUES
('Supervisor', 'Usuario que supervisa el estado general del sistema'),
('Auditor', 'Persona encargada de revisar logs y registros'),
('Soporte', 'Usuario que atiende solicitudes y problemas de clientes'),
('Visitante', 'Usuario que navega el sistema sin permisos'),
('Encargado zona norte', 'Responsable de la operación en la zona norte'),
('Encargado zona sur', 'Responsable de la operación en la zona sur'),
('Tester', 'Usuario de pruebas para validación de sistema'),
('Cliente', 'Usuario regular que alquila patinetas'),
('Técnico', 'Personal encargado de mantenimiento'),
('Administrador', 'Personal con acceso completo al sistema');

INSERT INTO metodos_pago (nombre, descripcion) VALUES
('Efectivo', 'Pago realizado en efectivo'),
('Google Pay', 'Pago a través de Google Pay'),
('Apple Pay', 'Pago a través de Apple Pay'),
('Crédito empresa', 'Crédito asignado por la empresa al usuario'),
('Saldo interno', 'Uso de saldo precargado en la cuenta'),
('Cheque', 'Pago con cheque autorizado'),
('Tarjeta Crédito', 'Pago con tarjeta de crédito'),
('Tarjeta Débito', 'Pago con tarjeta de débito'),
('PayPal', 'Pago a través de PayPal'),
('Transferencia', 'Transferencia bancaria');


INSERT INTO estados_alquiler (nombre, descripcion) VALUES
('Pendiente pago', 'Alquiler finalizado pero sin pago confirmado'),
('Reembolsado', 'Monto del alquiler devuelto al usuario'),
('Disputa', 'Alquiler en disputa por parte del cliente'),
('Incidente', 'Alquiler marcado por un incidente reportado'),
('Fraude detectado', 'Alquiler marcado por comportamiento sospechoso'),
('Prueba gratuita', 'Alquiler gratuito como parte de una promoción'),
('Activo', 'Alquiler en curso'),
('Completado', 'Alquiler finalizado correctamente'),
('Cancelado', 'Alquiler cancelado por el usuario'),
('Problema', 'Alquiler con algún problema reportado');

INSERT INTO marcas (nombre, pais_origen, fecha_fundacion, descripcion) VALUES
('Xiaomi', 'China', '2010-04-06', 'Líder en tecnología asequible'),
('Segway', 'USA', '1999-07-01', 'Pioneros en transporte personal'),
('Razor', 'USA', '2000-01-15', 'Especialistas en patinetas urbanas'),
('Ninebot', 'China', '2012-03-12', 'Subsidiaria de Segway'),
('Dualtron', 'Corea del Sur', '2015-08-20', 'Alta gama y potencia'),
('Kaabo', 'China', '2016-05-10', 'Enfoque en patinetas todo terreno'),
('Inokim', 'Israel', '2014-02-28', 'Diseño premium y minimalista'),
('Unagi', 'USA', '2018-07-04', 'Modelos elegantes para ciudad'),
('Apollo', 'Canadá', '2017-09-15', 'Innovación en movilidad urbana'),
('Vsett', 'Vietnam', '2019-01-30', 'Rendimiento y durabilidad');

INSERT INTO modelos (marca_id, nombre, año_lanzamiento, peso_kg, velocidad_max_kmh, autonomia_km, potencia_w) VALUES
(1, 'Mi Electric Scooter Pro 2', 2020, 14.2, 25.0, 45.0, 300),
(2, 'Ninebot MAX G30LP', 2021, 16.5, 30.0, 40.0, 350),
(3, 'E300', 2019, 13.8, 24.0, 35.0, 250),
(4, 'ES4', 2020, 12.5, 25.0, 28.0, 300),
(5, 'Thunder 2', 2022, 45.0, 80.0, 120.0, 5400),
(6, 'Mantis Pro SE', 2021, 36.0, 65.0, 70.0, 2000),
(7, 'Quick 4', 2022, 16.0, 30.0, 50.0, 500),
(8, 'Model One', 2021, 12.5, 32.0, 25.0, 500),
(9, 'Ghost', 2022, 27.0, 60.0, 50.0, 1000),
(10, '10+R', 2023, 35.0, 70.0, 90.0, 3000);

INSERT INTO patinetas (modelo_id, estado_id, codigo_serie, fecha_compra, precio_compra, bateria_actual, fecha_ultimo_mantenimiento, notas) VALUES
(1, 1, 'XM001-2022-001', '2022-03-15', 499.99, 85.5, '2023-01-10', 'Llantas nuevas instaladas'),
(2, 2, 'SEG002-2021-045', '2021-07-20', 699.99, 42.3, '2023-02-15', 'Frenos revisados'),
(3, 1, 'RAZ003-2020-112', '2020-11-05', 399.99, 100.0, '2023-03-01', 'Perfecto estado'),
(4, 3, 'NIN004-2022-078', '2022-05-10', 599.99, 0.0, '2023-01-25', 'Batería en reparación'),
(5, 1, 'DUA005-2023-001', '2023-01-15', 2999.99, 92.7, NULL, 'Nueva en stock'),
(6, 2, 'KAA006-2021-033', '2021-09-12', 1899.99, 37.8, '2023-02-20', 'Luz delantera cambiada'),
(7, 1, 'INO007-2022-056', '2022-08-03', 1299.99, 78.2, '2023-03-05', NULL),
(8, 4, 'UNA008-2021-004', '2021-04-22', 999.99, 0.0, '2023-01-30', 'Retirada por obsolescencia'),
(9, 1, 'APO009-2023-002', '2023-02-01', 1499.99, 95.0, NULL, 'Poco uso'),
(10, 5, 'VSE010-2023-010', '2023-03-10', 2599.99, 65.5, NULL, 'En carga');

INSERT INTO ubicaciones (patineta_id, latitud, longitud, fecha_hora_registro, velocidad_actual, bateria_en_ubicacion) VALUES
(1, 40.416775, -3.703790, '2023-03-15 08:30:45', 12.5, 82.3),
(2, 40.417500, -3.704200, '2023-03-15 09:15:22', 18.7, 40.1),
(3, 40.418300, -3.705100, '2023-03-15 10:05:33', 0.0, 98.5),
(4, 40.419000, -3.706000, '2023-03-15 11:20:10', 0.0, 0.0),
(5, 40.420000, -3.707000, '2023-03-15 12:45:15', 25.3, 90.2),
(6, 40.421000, -3.708000, '2023-03-15 13:30:40', 15.8, 35.0),
(7, 40.422000, -3.709000, '2023-03-15 14:15:05', 0.0, 76.8),
(8, 40.423000, -3.710000, '2023-03-15 15:00:30', 0.0, 0.0),
(9, 40.424000, -3.711000, '2023-03-15 16:20:55', 0.0, 94.1),
(10, 40.425000, -3.712000, '2023-03-15 17:10:20', 0.0, 63.2);

INSERT INTO usuarios (usuario_id, tipo_usuario_id, nombre, apellido, email, telefono, fecha_nacimiento, direccion, documento_identidad, saldo, activo) VALUES
(1001, 1, 'Juan', 'Pérez', 'juan.perez@email.com', '600111222', '1990-05-15', 'Calle Mayor 1, Madrid', '12345678A', 25.50, TRUE),
(1002, 1, 'María', 'Gómez', 'maria.gomez@email.com', '600222333', '1985-08-22', 'Gran Vía 45, Madrid', '87654321B', 10.00, TRUE),
(1003, 2, 'Carlos', 'Ruiz', 'carlos.ruiz@empresa.com', '610333444', '1988-03-10', 'Paseo del Prado 8, Madrid', '11223344C', 0.00, TRUE),
(1004, 1, 'Ana', 'López', 'ana.lopez@email.com', '611444555', '1995-11-30', 'Calle Alcalá 20, Madrid', '55667788D', 5.75, TRUE),
(1005, 3, 'David', 'Sánchez', 'david.sanchez@empresa.com', '620555666', '1982-07-18', 'Calle Serrano 75, Madrid', '99887766E', 0.00, TRUE),
(1006, 1, 'Laura', 'Martínez', 'laura.martinez@email.com', '630666777', '1993-02-25', 'Calle Princesa 33, Madrid', '44332211F', 15.25, TRUE),
(1007, 4, 'Pedro', 'Jiménez', 'pedro.jimenez@empresa.com', '640777888', '1991-09-12', 'Paseo de la Castellana 100, Madrid', '77889900G', 0.00, TRUE),
(1008, 1, 'Sofía', 'Hernández', 'sofia.hernandez@email.com', '650888999', '1998-04-05', 'Calle Atocha 50, Madrid', '00112233H', 0.00, FALSE),
(1009, 5, 'Javier', 'Díaz', 'javier.diaz@empresa.com', '660999000', '1987-12-20', 'Calle Orense 12, Madrid', '44556677I', 0.00, TRUE),
(1010, 1, 'Elena', 'Moreno', 'elena.moreno@email.com', '670000111', '1994-06-08', 'Calle Velázquez 30, Madrid', '88990011J', 30.00, TRUE);

INSERT INTO tarifas (nombre, costo_por_minuto, costo_desbloqueo, descripcion, fecha_inicio_vigencia, fecha_fin_vigencia) VALUES
('Básica', 0.25, 1.00, 'Tarifa estándar para todos los usuarios', '2023-01-01', NULL),
('Premium', 0.20, 0.50, 'Descuento para usuarios frecuentes', '2023-01-01', '2023-12-31'),
('Nocturna', 0.15, 1.50, 'Tarifa reducida de 00:00 a 06:00', '2023-01-01', NULL),
('Fin de semana', 0.30, 0.00, 'Sin coste de desbloqueo sábados y domingos', '2023-01-01', NULL),
('Estudiante', 0.18, 0.75, 'Descuento para estudiantes verificados', '2023-01-01', NULL),
('Empresa', 0.22, 0.00, 'Tarifa corporativa con facturación mensual', '2023-01-01', NULL),
('Turista', 0.35, 2.00, 'Tarifa para usuarios ocasionales', '2023-01-01', NULL),
('Larga distancia', 0.15, 2.50, 'Para trayectos mayores a 5km', '2023-01-01', NULL),
('Promo verano', 0.20, 0.00, 'Promoción especial de verano', '2023-06-01', '2023-09-30'),
('Económica', 0.10, 1.00, 'Velocidad limitada a 15km/h', '2023-01-01', NULL);

INSERT INTO alquileres (usuario_id, patineta_id, tarifa_id, metodo_pago_id, estado_alquiler_id, fecha_hora_inicio, fecha_hora_fin, ubicacion_inicio_lat, ubicacion_inicio_lon, ubicacion_fin_lat, ubicacion_fin_lon, costo_total, distancia_recorrida_km, duracion_minutos, calificacion_usuario, comentarios_usuario) VALUES
(1001, 1, 1, 1, 2, '2023-03-01 08:30:00', '2023-03-01 08:45:00', 40.416775, -3.703790, 40.417000, -3.704000, 4.75, 1.2, 15, 5, 'Muy buena experiencia'),
(1002, 2, 2, 2, 1, '2023-03-01 09:00:00', NULL, 40.417500, -3.704200, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1004, 3, 3, 3, 2, '2023-03-01 18:15:00', '2023-03-01 18:45:00', 40.418300, -3.705100, 40.419000, -3.706000, 6.75, 3.5, 30, 4, 'Funcionaba bien pero un poco pesada'),
(1006, 5, 1, 1, 2, '2023-03-02 10:20:00', '2023-03-02 10:50:00', 40.420000, -3.707000, 40.421000, -3.708000, 8.50, 2.8, 30, 5, 'Perfecta para moverse por la ciudad'),
(1001, 7, 4, 4, 2, '2023-03-02 14:00:00', '2023-03-02 14:30:00', 40.422000, -3.709000, 40.423000, -3.710000, 9.00, 3.0, 30, 3, 'Se quedó sin batería antes de tiempo'),
(1010, 6, 5, 5, 5, '2023-03-03 11:10:00', '2023-03-03 11:25:00', 40.421000, -3.708000, 40.420500, -3.707500, 4.05, 1.5, 15, 1, 'Frenos defectuosos, casi tengo un accidente'),
(1004, 9, 6, 6, 2, '2023-03-03 16:45:00', '2023-03-03 17:30:00', 40.424000, -3.711000, 40.425000, -3.712000, 10.90, 5.2, 45, 5, 'Muy cómoda y potente'),
(1002, 1, 7, 7, 2, '2023-03-04 09:30:00', '2023-03-04 10:00:00', 40.416775, -3.703790, 40.418000, -3.705000, 12.50, 4.0, 30, 4, NULL),
(1006, 3, 8, 8, 2, '2023-03-04 13:15:00', '2023-03-04 14:00:00', 40.418300, -3.705100, 40.420000, -3.707000, 11.25, 6.3, 45, 5, 'Genial para distancias largas'),
(1010, 5, 9, 9, 3, '2023-03-05 10:00:00', NULL, 40.420000, -3.707000, NULL, NULL, NULL, NULL, NULL, NULL, 'Cancelado por lluvia');

INSERT INTO pagos (alquiler_id, metodo_pago_id, monto, fecha_hora_pago, estado_pago, transaccion_id) VALUES
(1, 1, 4.75, '2023-03-01 08:46:12', 'Completado', 'TXN123456789'),
(3, 3, 6.75, '2023-03-01 18:46:30', 'Completado', 'TXN987654321'),
(4, 1, 8.50, '2023-03-02 10:51:45', 'Completado', 'TXN456789123'),
(5, 4, 9.00, '2023-03-02 14:31:20', 'Completado', 'TXN321654987'),
(6, 5, 4.05, '2023-03-03 11:26:18', 'Completado', 'TXN789123456'),
(7, 6, 10.90, '2023-03-03 17:31:05', 'Completado', 'TXN654987321'),
(8, 7, 12.50, '2023-03-04 10:01:33', 'Completado', 'TXN147258369'),
(9, 8, 11.25, '2023-03-04 14:01:47', 'Completado', 'TXN369258147'),
(6, 1, 4.05, '2023-03-03 12:00:00', 'Reembolsado', 'RFND789123456'),
(10, 9, 1.00, '2023-03-05 10:05:00', 'Cancelado', 'CNCL963852741');

INSERT INTO mantenimientos (patineta_id, usuario_tecnico_id, tipo_mantenimiento, fecha_hora_inicio, fecha_hora_fin, descripcion, costo, repuestos_cambiados) VALUES
(4, 1003, 'Cambio de batería', '2023-01-25 09:00:00', '2023-01-25 11:30:00', 'Batería agotada irreparable', 120.50, 'Batería 36V 10Ah'),
(1, 1003, 'Cambio de neumáticos', '2023-01-10 10:00:00', '2023-01-10 11:00:00', 'Neumáticos desgastados', 45.00, 'Neumáticos delantero y trasero'),
(6, 1003, 'Reparación de luces', '2023-02-20 14:00:00', '2023-02-20 15:30:00', 'Luz delantera no funcionaba', 22.75, 'Foco LED delantero'),
(2, 1003, 'Ajuste de frenos', '2023-02-15 16:00:00', '2023-02-15 17:00:00', 'Frenos chirriaban', 15.00, 'Pastillas de freno traseras'),
(3, 1003, 'Revisión general', '2023-03-01 09:00:00', '2023-03-01 10:00:00', 'Mantenimiento preventivo', 30.00, NULL),
(5, 1003, 'Actualización de firmware', '2023-02-10 11:00:00', '2023-02-10 11:30:00', 'Actualización a versión 2.5.3', 0.00, NULL),
(7, 1003, 'Limpieza y lubricación', '2023-03-05 10:00:00', '2023-03-05 10:45:00', 'Limpieza completa y lubricación de partes móviles', 18.50, NULL),
(8, 1003, 'Retirada de servicio', '2023-01-30 13:00:00', '2023-01-30 14:00:00', 'Modelo obsoleto para desguace', 0.00, NULL),
(9, 1003, 'Calibración de sensores', '2023-02-28 15:00:00', '2023-02-28 16:00:00', 'Ajuste de sensores de velocidad', 25.00, NULL),
(10, 1003, 'Reparación de manillar', '2023-03-10 09:30:00', '2023-03-10 11:00:00', 'Manillar flojo, requería ajuste', 35.25, 'Tornillería de fijación');

INSERT INTO incidentes (patineta_id, usuario_id, alquiler_id, tipo_incidente, descripcion, fecha_hora_incidente, ubicacion_lat, ubicacion_lon, gravedad, estado, acciones_tomadas) VALUES
(6, 1010, 6, 'Fallo de frenos', 'Los frenos no respondían correctamente en bajada', '2023-03-03 11:20:00', 40.420500, -3.707500, 'Alta', 'Resuelto', 'Patineta retirada para revisión, reembolso al usuario'),
(1, 1001, 5, 'Agotamiento de batería', 'Batería se agotó antes de lo esperado', '2023-03-02 14:25:00', 40.422500, -3.709500, 'Media', 'Resuelto', 'Usuario asistido, patineta recogida para carga'),
(3, 1004, 3, 'Pinchazo', 'Neumático trasero pinchado durante el trayecto', '2023-03-01 18:30:00', 40.418500, -3.705500, 'Media', 'Resuelto', 'Patineta reparada, descuento aplicado al usuario'),
(5, 1006, 4, 'Fallo de display', 'Pantalla no mostraba información correcta', '2023-03-02 10:40:00', 40.420500, -3.707500, 'Baja', 'Resuelto', 'Display reemplazado'),
(2, 1002, 2, 'Abandono incorrecto', 'Usuario dejó la patineta en zona no permitida', '2023-03-01 09:45:00', 40.418000, -3.704500, 'Media', 'En proceso', 'Multa aplicada al usuario, patineta recuperada'),
(7, 1001, 5, 'Sobrecalentamiento', 'Motor sobrecalentado tras uso prolongado', '2023-03-02 14:28:00', 40.422800, -3.709800, 'Alta', 'Resuelto', 'Motor revisado y enfriado'),
(9, 1004, 7, 'Pérdida de potencia', 'Reducción repentina de velocidad máxima', '2023-03-03 17:15:00', 40.424500, -3.711500, 'Media', 'Investigación', 'Diagnóstico en curso'),
(1, 1002, 8, 'Aviso de seguridad', 'Ruido anómalo en la rueda delantera', '2023-03-04 09:45:00', 40.417000, -3.704500, 'Baja', 'Resuelto', 'Ajuste realizado, sin problemas encontrados'),
(3, 1006, 9, 'Fallo de bloqueo', 'No se podía bloquear al finalizar el viaje', '2023-03-04 13:50:00', 40.419500, -3.706500, 'Media', 'Resuelto', 'Reset del sistema, funcionamiento normalizado'),
(5, 1010, 10, 'Cancelación por clima', 'Usuario canceló por condiciones meteorológicas', '2023-03-05 10:02:00', 40.420000, -3.707000, 'Baja', 'Resuelto', 'Tarifa de desbloqueo reembolsada');