-- Funcion que devuelve el nombre de la marca a partir de su ID:
CREATE OR REPLACE FUNCTION obtener_nombre_marca(mid INT)
RETURNS VARCHAR AS $$
DECLARE
    resultado VARCHAR;
BEGIN
    SELECT nombre INTO resultado FROM marcas WHERE marca_id = mid;
    RETURN resultado;
END;
$$ LANGUAGE plpgsql;

-- Funcion que devuelve el número total de alquileres de un usuario:
CREATE OR REPLACE FUNCTION total_alquileres_usuario(uid INT)
RETURNS INT AS $$
DECLARE
    total INT;
BEGIN
    SELECT COUNT(*) INTO total FROM alquileres WHERE usuario_id = uid;
    RETURN total;
END;
$$ LANGUAGE plpgsql;

-- Función para calcular el costo de un alquiler en tiempo real
CREATE OR REPLACE FUNCTION calcular_costo_actual(id_alqui INT)
RETURNS DECIMAL(10,2) AS $$
DECLARE
    tarifa_por_minuto DECIMAL(10,2);
    minutos_transcurridos INT;
    costo DECIMAL(10,2);
BEGIN
    SELECT t.costo_por_minuto INTO tarifa_por_minuto
    FROM alquileres a
    JOIN tarifas t ON a.tarifa_id = t.tarifa_id
    WHERE a.alquiler_id = id_alqui;

	    SELECT EXTRACT(EPOCH FROM (NOW() - a.fecha_hora_inicio)) / 60 INTO minutos_transcurridos
    FROM alquileres a
    WHERE a.alquiler_id = id_alqui;

    costo := tarifa_por_minuto * minutos_transcurridos;
    RETURN ROUND(costo, 2);
END;
$$ LANGUAGE plpgsql;
	
-- Función para verificar disponibilidad de una patineta
CREATE OR REPLACE FUNCTION esta_disponible(patin_id INT)
RETURNS BOOLEAN AS $$
DECLARE
    estado INT;
BEGIN
    SELECT estado_id INTO estado FROM patinetas WHERE patineta_id = patin_id;
    RETURN estado = 1;
END;
$$ LANGUAGE plpgsql;