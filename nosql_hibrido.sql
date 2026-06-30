USE establo;



ALTER TABLE EVENTO_SANITARIO
    ADD COLUMN metadatos JSON NULL 
    COMMENT 'Datos variables según tipo_evento';


CREATE TABLE IF NOT EXISTS HISTORIAL_CLINICO (
    id_historial   INT PRIMARY KEY AUTO_INCREMENT,
    id_vaca        INT NOT NULL,
    fecha_registro DATETIME DEFAULT CURRENT_TIMESTAMP,
    tipo           VARCHAR(50) NOT NULL,
    datos_clinicos JSON NOT NULL,
    CONSTRAINT fk_historial_clinico_vaca
        FOREIGN KEY (id_vaca) REFERENCES VACA(id_vaca)
        ON DELETE CASCADE ON UPDATE CASCADE
);


INSERT INTO HISTORIAL_CLINICO (id_vaca, tipo, datos_clinicos) VALUES
(1, 'vacunacion',
 '{"vacuna":"Fiebre Aftosa","dosis_ml":2.5,"via":"subcutanea","lote_vacuna":"FMD-2026-01","proxima_dosis":"2026-12-01","aplicado_por":"Dr. Morales"}'),
(2, 'revision',
 '{"peso_kg":520.5,"temperatura_c":38.6,"condicion_corporal":3.5,"observaciones":"Vaca en buen estado","presion_arterial":"normal"}'),
(3, 'tratamiento',
 '{"medicamento":"Oxitetraciclina","dosis_mg":500,"duracion_dias":5,"diagnostico":"Mastitis subclínica","costo_tratamiento":85.00,"resultado":"recuperacion_completa"}'),
(1, 'parto',
 '{"tipo_parto":"normal","duracion_minutos":45,"cria_viva":true,"peso_cria_kg":38.2,"sexo_cria":"hembra","complicaciones":null}');



SELECT
    hc.id_vaca,
    v.arete,
    hc.fecha_registro,
    JSON_UNQUOTE(JSON_EXTRACT(datos_clinicos, '$.vacuna'))         AS vacuna,
    JSON_UNQUOTE(JSON_EXTRACT(datos_clinicos, '$.dosis_ml'))       AS dosis_ml,
    JSON_UNQUOTE(JSON_EXTRACT(datos_clinicos, '$.proxima_dosis'))  AS proxima_dosis,
    JSON_UNQUOTE(JSON_EXTRACT(datos_clinicos, '$.aplicado_por'))   AS aplicado_por
FROM HISTORIAL_CLINICO hc
JOIN VACA v ON hc.id_vaca = v.id_vaca
WHERE hc.tipo = 'vacunacion';


SELECT
    hc.id_vaca,
    v.arete,
    hc.fecha_registro,
    JSON_UNQUOTE(JSON_EXTRACT(datos_clinicos, '$.peso_kg'))            AS peso_kg,
    JSON_UNQUOTE(JSON_EXTRACT(datos_clinicos, '$.temperatura_c'))      AS temperatura_c,
    JSON_UNQUOTE(JSON_EXTRACT(datos_clinicos, '$.condicion_corporal')) AS condicion,
    JSON_UNQUOTE(JSON_EXTRACT(datos_clinicos, '$.observaciones'))      AS observaciones
FROM HISTORIAL_CLINICO hc
JOIN VACA v ON hc.id_vaca = v.id_vaca
WHERE hc.tipo = 'revision';


SELECT
    hc.id_vaca,
    v.arete,
    hc.fecha_registro,
    CAST(JSON_UNQUOTE(JSON_EXTRACT(datos_clinicos, '$.temperatura_c')) AS DECIMAL(4,1)) AS temperatura
FROM HISTORIAL_CLINICO hc
JOIN VACA v ON hc.id_vaca = v.id_vaca
WHERE hc.tipo = 'revision'
  AND CAST(JSON_UNQUOTE(JSON_EXTRACT(datos_clinicos, '$.temperatura_c')) AS DECIMAL(4,1)) > 39;


SELECT
    hc.id_vaca,
    v.arete,
    JSON_UNQUOTE(JSON_EXTRACT(datos_clinicos, '$.medicamento'))   AS medicamento,
    JSON_UNQUOTE(JSON_EXTRACT(datos_clinicos, '$.diagnostico'))   AS diagnostico,
    JSON_UNQUOTE(JSON_EXTRACT(datos_clinicos, '$.duracion_dias')) AS duracion_dias,
    JSON_UNQUOTE(JSON_EXTRACT(datos_clinicos, '$.resultado'))     AS resultado
FROM HISTORIAL_CLINICO hc
JOIN VACA v ON hc.id_vaca = v.id_vaca
WHERE hc.tipo = 'tratamiento';


SELECT
    v.arete,
    hc.tipo,
    hc.fecha_registro,
    hc.datos_clinicos
FROM HISTORIAL_CLINICO hc
JOIN VACA v ON hc.id_vaca = v.id_vaca
ORDER BY hc.fecha_registro DESC;


ALTER TABLE HISTORIAL_CLINICO
    ADD INDEX idx_tipo_evento (tipo);

ALTER TABLE HISTORIAL_CLINICO
    ADD INDEX idx_vaca_tipo (id_vaca, tipo);
