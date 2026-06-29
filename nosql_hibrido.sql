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
