USE establo;

ALTER TABLE EVENTO_SANITARIO
    ADD COLUMN metadatos JSON NULL COMMENT 'Datos variables según tipo_evento';

CREATE TABLE IF NOT EXISTS HISTORIAL_CLINICO (
    id_historial   INT PRIMARY KEY AUTO_INCREMENT,
    id_vaca        INT NOT NULL,
    fecha_registro DATETIME DEFAULT CURRENT_TIMESTAMP,
    tipo           VARCHAR(50) NOT NULL,
    datos_clinicos JSON NOT NULL,  
    CONSTRAINT fk_historial_clinico_vaca
        FOREIGN KEY (id_vaca) REFERENCES VACA(id_vaca)
        ON DELETE CASCADE ON UPDATE CASCADE --hola
);
INSERT INTO HISTORIAL_CLINICO (id_vaca, tipo, datos_clinicos) 
VALUES 
  (1, 'vacunacion', '{ "vacuna": "Fiebre Aftosa", "dosis_ml": 2.5, "via": "subcutanea", "lote_vacuna": "FMD-2026-01", "proxima_dosis": "2026-12-01", "aplicado_por": "Dr. Morales" }'), 
  (2, 'revision',    '{ "peso_kg": 520.5, "temperatura_c": 38.6, "condicion_corporal": 3.5, "observaciones": "Vaca en buen estado, sin anomalias", "presion_arterial": "normal" }'), 
  (3, 'tratamiento', '{ "medicamento": "Oxitetraciclina", "dosis_mg": 500, "duracion_dias": 5, "diagnostico": "Mastitis subclínica", "costo_tratamiento": 85.00, "resultado": "recuperacion_completa" }'), 
  (1, 'parto',       '{ "tipo_parto": "normal", "duracion_minutos": 45, "cria_viva": true, "peso_cria_kg": 38.2, "sexo_cria": "hembra", "complicaciones": null }');

SELECT 
    id_vaca,
    fecha_registro,
    datos_clinicos->>'$.vacuna'       AS vacuna,
    datos_clinicos->>'$.dosis_ml'     AS dosis,
    datos_clinicos->>'$.proxima_dosis' AS proxima_dosis
FROM HISTORIAL_CLINICO
WHERE tipo = 'vacunacion';

SELECT 
    hc.id_vaca,
    v.arete,
    hc.fecha_registro,
    datos_clinicos->>'$.temperatura_c' AS temperatura
FROM HISTORIAL_CLINICO hc
JOIN VACA v ON hc.id_vaca = v.id_vaca
WHERE tipo = 'revision'
  AND (datos_clinicos->>'$.temperatura_c') > 39;

ALTER TABLE HISTORIAL_CLINICO
    ADD INDEX idx_tipo_evento (tipo);

CREATE INDEX idx_json_temperatura
    ON HISTORIAL_CLINICO ((CAST(datos_clinicos->>'$.temperatura_c' AS DECIMAL(4,1))));
