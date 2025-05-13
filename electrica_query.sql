-- Consulta de Patinetas Disponibles con su Ubicación Actual
SELECT 
    p.patineta_id,
    m.nombre AS modelo,
    ma.nombre AS marca,
    p.codigo_serie,
    p.bateria_actual || '%' AS bateria,
    u.latitud,
    u.longitud,
    u.fecha_hora_registro AS ultima_actualizacion
FROM patinetas p
JOIN modelos m ON p.modelo_id = m.modelo_id
JOIN marcas ma ON m.marca_id = ma.marca_id
JOIN ubicaciones u ON p.patineta_id = u.patineta_id
WHERE p.estado_id = 1  -- 1 = Disponible
    AND u.fecha_hora_registro = (
        SELECT MAX(fecha_hora_registro) 
        FROM ubicaciones 
        WHERE patineta_id = p.patineta_id
    )
ORDER BY p.bateria_actual DESC;
	
-- Consulta de Alquileres Activos con Detalles de Usuario y Patineta

SELECT 
    a.alquiler_id,
    u.usuario_id,
    u.nombre || ' ' || u.apellido AS usuario,
    p.patineta_id,
    ma.nombre || ' ' || m.nombre AS patineta,
    a.fecha_hora_inicio,
    EXTRACT(EPOCH FROM (CURRENT_TIMESTAMP - a.fecha_hora_inicio))/60 AS minutos_transcurridos,
    t.nombre AS tarifa,
    t.costo_por_minuto || '/min' AS costo_minuto,
    loc.latitud,
    loc.longitud,
    loc.fecha_hora_registro AS ultima_ubicacion
FROM alquileres a
JOIN usuarios u ON a.usuario_id = u.usuario_id
JOIN patinetas p ON a.patineta_id = p.patineta_id
JOIN modelos m ON p.modelo_id = m.modelo_id
JOIN marcas ma ON m.marca_id = ma.marca_id
JOIN tarifas t ON a.tarifa_id = t.tarifa_id
JOIN ubicaciones loc ON p.patineta_id = loc.patineta_id
WHERE 
    a.estado_alquiler_id = 1  -- 1 = Iniciado (activo)
    AND loc.fecha_hora_registro = (
        SELECT MAX(fecha_hora_registro) 
        FROM ubicaciones 
        WHERE patineta_id = p.patineta_id
    )
ORDER BY 
    a.fecha_hora_inicio;

-- Consulta de Ingresos por Período (Agrupado por Mes)


SELECT 
    DATE_TRUNC('month', p.fecha_hora_pago) AS mes,
    COUNT(*) AS total_alquileres,
    SUM(a.costo_total) AS ingresos_totales,
    SUM(a.duracion_minutos) AS minutos_alquilados,
    SUM(a.distancia_recorrida_km) AS kilometros_recorridos,
    SUM(a.costo_total) / COUNT(*) AS promedio_por_alquiler
FROM 
    pagos p
JOIN 
    alquileres a ON p.alquiler_id = a.alquiler_id
WHERE p.estado_pago = 'Completado'
    AND p.fecha_hora_pago BETWEEN '2023-01-01' AND CURRENT_DATE
GROUP BY  DATE_TRUNC('month', p.fecha_hora_pago)
ORDER BY mes DESC;

-- Consulta de Mantenimientos Pendientes y Patinetas que los Necesitan
SELECT 
    p.patineta_id,
    ma.nombre || ' ' || m.nombre AS patineta,
    p.codigo_serie,
    p.fecha_ultimo_mantenimiento,
    CURRENT_DATE - p.fecha_ultimo_mantenimiento AS dias_sin_mantenimiento,
    CASE 
        WHEN i.incidente_id IS NOT NULL THEN 'Con incidente reportado'
        WHEN p.fecha_ultimo_mantenimiento IS NULL THEN 'Nunca mantenida'
        WHEN CURRENT_DATE - p.fecha_ultimo_mantenimiento > 90 THEN 'Mantenimiento urgente'
        WHEN CURRENT_DATE - p.fecha_ultimo_mantenimiento > 60 THEN 'Mantenimiento recomendado'
        ELSE 'Mantenimiento preventivo'
    END AS prioridad,
    i.tipo_incidente,
    i.descripcion AS descripcion_incidente
FROM patinetas p
JOIN modelos m ON p.modelo_id = m.modelo_id
JOIN marcas ma ON m.marca_id = ma.marca_id
LEFT JOIN incidentes i ON p.patineta_id = i.patineta_id AND i.estado = 'Reportado'
WHERE 
    p.estado_id IN (1, 3)  -- 1 = Disponible, 3 = En mantenimiento
    AND (
        p.fecha_ultimo_mantenimiento IS NULL
        OR CURRENT_DATE - p.fecha_ultimo_mantenimiento > 30
        OR i.incidente_id IS NOT NULL
    )
ORDER BY CASE 
        WHEN i.incidente_id IS NOT NULL THEN 1
        WHEN p.fecha_ultimo_mantenimiento IS NULL THEN 2
        WHEN CURRENT_DATE - p.fecha_ultimo_mantenimiento > 90 THEN 3
        WHEN CURRENT_DATE - p.fecha_ultimo_mantenimiento > 60 THEN 4
        ELSE 5
    END,
    p.fecha_ultimo_mantenimiento;

-- Consulta de Uso por Patineta (Top 10 más utilizadas)
SELECT 
    p.patineta_id,
    ma.nombre || ' ' || m.nombre AS patineta,
    COUNT(a.alquiler_id) AS total_alquileres,
    SUM(a.duracion_minutos) AS minutos_totales_alquilada,
    SUM(a.distancia_recorrida_km) AS kilometros_totales,
    SUM(a.costo_total) AS ingresos_generados,
    ROUND(SUM(a.costo_total) / NULLIF(SUM(a.duracion_minutos), 0), 2) AS ingreso_por_minuto,
    p.fecha_compra,
    p.fecha_ultimo_mantenimiento
FROM patinetas p
JOIN modelos m ON p.modelo_id = m.modelo_id
JOIN marcas ma ON m.marca_id = ma.marca_id
LEFT JOIN alquileres a ON p.patineta_id = a.patineta_id
GROUP BY p.patineta_id, m.nombre, ma.nombre, p.fecha_compra, p.fecha_ultimo_mantenimiento
ORDER BY total_alquileres DESC
LIMIT 10;