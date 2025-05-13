-- Procedimiento para agrega un usuario nuevo con lo básico:
CREATE OR REPLACE PROCEDURE registrar_usuario_simple(
    IN p_nombre VARCHAR,
    IN p_apellido VARCHAR,
    IN p_email VARCHAR
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO usuarios(nombre, apellido, email)
    VALUES (p_nombre, p_apellido, p_email);
END;
$$;

-- Procedimiento para crea un incidente
CREATE OR REPLACE PROCEDURE registrar_incidente_basico(
    IN p_patineta_id INT,
    IN p_tipo_incidente VARCHAR,
    IN p_descripcion TEXT
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO incidentes(patineta_id, tipo_incidente, descripcion)
    VALUES (p_patineta_id, p_tipo_incidente, p_descripcion);
END;
$$;

-- Procedimiento para iniciar un nuevo alquiler
CREATE OR REPLACE PROCEDURE iniciar_alquiler(
    p_usuario_id INT,
    p_patineta_id INT,
    p_tarifa_id INT,
    p_metodo_pago_id INT,
    p_latitud DECIMAL(10,8),
    p_longitud DECIMAL(11,8)
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_alquiler_id INT;
BEGIN
    -- Verificar que el usuario existe y está activo
    IF NOT EXISTS (SELECT 1 FROM usuarios WHERE usuario_id = p_usuario_id AND activo = TRUE) THEN
        RAISE EXCEPTION 'Usuario ID % no existe o no está activo', p_usuario_id;
    END IF;
    
    -- Verificar que la patineta existe y está disponible
    IF NOT EXISTS (SELECT 1 FROM patinetas WHERE patineta_id = p_patineta_id AND estado_id = 1) THEN
        RAISE EXCEPTION 'Patineta ID % no disponible (no existe o estado no es "Disponible")', p_patineta_id;
    END IF;
    
    -- Verificar que la tarifa existe
    IF NOT EXISTS (SELECT 1 FROM tarifas WHERE tarifa_id = p_tarifa_id) THEN
        RAISE EXCEPTION 'Tarifa ID % no existe', p_tarifa_id;
    END IF;
    
    -- Verificar que el método de pago existe
    IF NOT EXISTS (SELECT 1 FROM metodos_pago WHERE metodo_pago_id = p_metodo_pago_id) THEN
        RAISE EXCEPTION 'Método de pago ID % no existe', p_metodo_pago_id;
    END IF;
    
    -- Obtener el próximo ID de alquiler
    SELECT COALESCE(MAX(alquiler_id), 0) + 1 INTO v_alquiler_id FROM alquileres;
    
    -- Insertar el alquiler
    INSERT INTO alquileres(
        alquiler_id,
        usuario_id, 
        patineta_id, 
        tarifa_id, 
        metodo_pago_id, 
        estado_alquiler_id, 
        ubicacion_inicio_lat, 
        ubicacion_inicio_lon,
        fecha_hora_inicio
    )
    VALUES (
        v_alquiler_id,
        p_usuario_id,
        p_patineta_id,
        p_tarifa_id,
        p_metodo_pago_id,
        1, -- Estado "Iniciado"
        p_latitud,
        p_longitud,
        CURRENT_TIMESTAMP
    );
    
    -- Actualizar estado de la patineta a "Alquilada"
    UPDATE patinetas SET estado_id = 2 WHERE patineta_id = p_patineta_id;
    
    -- Registrar la ubicación actual
    INSERT INTO ubicaciones(patineta_id, latitud, longitud, fecha_hora_registro)
    VALUES (p_patineta_id, p_latitud, p_longitud, CURRENT_TIMESTAMP);
    
    RAISE NOTICE 'Alquiler iniciado correctamente con ID: %', v_alquiler_id;
END;
$$;


-- Procedimiento para finalizar un alquiler
CREATE OR REPLACE PROCEDURE finalizar_alquiler(
    p_alquiler_id INT,
    p_distancia DECIMAL(8,2),
    p_bateria_final DECIMAL(5,2)
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_duracion INT;
    v_costo_total DECIMAL(10,2);
    v_patineta_id INT;
    v_tarifa_id INT;
BEGIN
    -- Calcular duración en minutos
    SELECT 
        EXTRACT(EPOCH FROM (CURRENT_TIMESTAMP - fecha_hora_inicio))/60,
        patineta_id,
        tarifa_id
    INTO 
        v_duracion,
        v_patineta_id,
        v_tarifa_id
    FROM alquileres 
    WHERE alquiler_id = p_alquiler_id;
    
    -- Calcular costo total
    SELECT (v_duracion * costo_por_minuto) + costo_desbloqueo
    INTO v_costo_total
    FROM tarifas
    WHERE tarifa_id = v_tarifa_id;
    
    -- Actualizar alquiler
    UPDATE alquileres
    SET 
        fecha_hora_fin = CURRENT_TIMESTAMP,
        estado_alquiler_id = 2, -- Finalizado
        costo_total = v_costo_total,
        distancia_recorrida_km = p_distancia,
        duracion_minutos = v_duracion
    WHERE alquiler_id = p_alquiler_id;
    
    -- Actualizar patineta
    UPDATE patinetas
    SET 
        estado_id = 1, -- Disponible
        bateria_actual = p_bateria_final
    WHERE patineta_id = v_patineta_id;
    
    -- Registrar pago
    INSERT INTO pagos(
        alquiler_id,
        metodo_pago_id,
        monto,
        fecha_hora_pago,
        estado_pago
    )
    SELECT 
        p_alquiler_id,
        metodo_pago_id,
        v_costo_total,
        CURRENT_TIMESTAMP,
        'Completado'
    FROM alquileres
    WHERE alquiler_id = p_alquiler_id;
END;
$$;

-- Procedimiento para registrar mantenimiento preventivo
CREATE OR REPLACE PROCEDURE registrar_mantenimiento_preventivo(
    p_patineta_id INT,
    p_usuario_tecnico_id INT,
    p_tipo_mantenimiento VARCHAR(50),
    p_duracion_minutos INT,
    p_descripcion TEXT DEFAULT NULL,
    p_repuestos TEXT DEFAULT NULL
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_estado_actual INT;
    v_mantenimiento_id INT;
    v_es_tecnico BOOLEAN;
BEGIN
    -- 1. Validar que el usuario técnico existe y tiene rol de técnico
    SELECT EXISTS (
        SELECT 1 FROM usuarios 
        WHERE usuario_id = p_usuario_tecnico_id 
        AND tipo_usuario_id = 2  -- Asumiendo que 2 es el ID para técnicos
    ) INTO v_es_tecnico;
    
    IF NOT v_es_tecnico THEN
        RAISE EXCEPTION 'El usuario ID % no es un técnico válido', p_usuario_tecnico_id;
    END IF;
    
    -- 2. Validar que la patineta existe
    IF NOT EXISTS (SELECT 1 FROM patinetas WHERE patineta_id = p_patineta_id) THEN
        RAISE EXCEPTION 'Patineta ID % no encontrada', p_patineta_id;
    END IF;
    
    -- 3. Obtener estado actual de la patineta
    SELECT estado_id INTO v_estado_actual 
    FROM patinetas 
    WHERE patineta_id = p_patineta_id;
    
    -- 4. Validar que la patineta no esté alquilada
    IF v_estado_actual = 2 THEN  -- Asumiendo que 2 es "Alquilada"
        RAISE EXCEPTION 'La patineta ID % está actualmente alquilada', p_patineta_id;
    END IF;
    
    -- 5. Generar ID para el mantenimiento
    SELECT COALESCE(MAX(mantenimiento_id), 0) + 1 INTO v_mantenimiento_id 
    FROM mantenimientos;
    
    -- 6. Registrar el mantenimiento
    INSERT INTO mantenimientos(
        mantenimiento_id,
        patineta_id,
        usuario_tecnico_id,
        tipo_mantenimiento,
        fecha_hora_inicio,
        fecha_hora_fin,
        descripcion,
        repuestos_cambiados
    )
    VALUES (
        v_mantenimiento_id,
        p_patineta_id,
        p_usuario_tecnico_id,
        p_tipo_mantenimiento,
        CURRENT_TIMESTAMP,
        CURRENT_TIMESTAMP + (p_duracion_minutos * INTERVAL '1 minute'),
        p_descripcion,
        p_repuestos
    );
    
    -- 7. Actualizar estado de la patineta a "En mantenimiento"
    UPDATE patinetas 
    SET 
        estado_id = 3,  -- Asumiendo que 3 es "En mantenimiento"
        fecha_ultimo_mantenimiento = CURRENT_DATE
    WHERE patineta_id = p_patineta_id;
    
    -- 8. Notificar éxito
    RAISE NOTICE 'Mantenimiento preventivo registrado con ID: %', v_mantenimiento_id;
EXCEPTION
    WHEN OTHERS THEN
        RAISE EXCEPTION 'Error al registrar mantenimiento: %', SQLERRM;
END;
$$;

