USE establo;

ALTER TABLE EVENTO_SANITARIO
    ADD COLUMN metadatos JSON NULL COMMENT 'Datos variables según tipo_evento';

CREATE TABLE IF NOT EXISTS HISTORIAL_CLINICO (
    id_historial   INT PRIMARY KEY AUTO_INCREMENT,
    id_vaca        INT NOT NULL,
    fecha_registro DATETIME DEFAULT CURRENT_TIMESTAMP,
    tipo           VARCHAR(50) NOT NULL,
    datos_clinicos JSON NOT NULL,  -- datos semi-estructurados
    CONSTRAINT fk_historial_clinico_vaca
        FOREIGN KEY (id_vaca) REFERENCES VACA(id_vaca)
        ON DELETE CASCADE ON UPDATE CASCADE
);
INSERT INTO HISTORIAL_CLINICO (id_vaca, tipo, datos_clinicos) 
VALUES 
  (1, 'vacunacion', '{ "vacuna": "Fiebre Aftosa", "dosis_ml": 2.5, "via": "subcutanea", "lote_vacuna": "FMD-2026-01", "proxima_dosis": "2026-12-01", "aplicado_por": "Dr. Morales" }'), 
  (2, 'revision',    '{ "peso_kg": 520.5, "temperatura_c": 38.6, "condicion_corporal": 3.5, "observaciones": "Vaca en buen estado, sin anomalias", "presion_arterial": "normal" }'), 
  (3, 'tratamiento', '{ "medicamento": "Oxitetraciclina", "dosis_mg": 500, "duracion_dias": 5, "diagnostico": "Mastitis subclínica", "costo_tratamiento": 85.00, "resultado": "recuperacion_completa" }'), 
  (1, 'parto',       '{ "tipo_parto": "normal", "duracion_minutos": 45, "cria_viva": true, "peso_cria_kg": 38.2, "sexo_cria": "hembra", "complicaciones": null }');
