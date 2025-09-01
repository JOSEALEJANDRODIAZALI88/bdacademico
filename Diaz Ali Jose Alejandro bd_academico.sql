-- 1) Siempre arranca en master
USE master;
GO

-- 2) Si ya existe, forzar drop limpio
IF DB_ID('bdacademico') IS NOT NULL
BEGIN
    ALTER DATABASE bdacademico SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE bdacademico;
END
GO

-- 3) Crear la BD usando las rutas locales por defecto de la instancia
CREATE DATABASE bdacademico;
GO

-- 4) Usar la BD reci�n creada
USE bdacademico;
GO

-- 5) Tablas (sin duplicar)
CREATE TABLE personas
(
    id_persona VARCHAR(10) NOT NULL PRIMARY KEY,
    nombres VARCHAR(25),
    paterno VARCHAR(20),
    materno VARCHAR(20),
    ci VARCHAR(10),
    nacionalidad VARCHAR(25),
    lug_nac VARCHAR(25),
    departamento VARCHAR(25),
    sexo VARCHAR(1),
    est_civ VARCHAR(1),
    fec_nac DATETIME
);
GO

CREATE TABLE estudiante
(
    id_est INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    id_persona VARCHAR(10) NOT NULL,
    gestion VARCHAR(4),
    periodo VARCHAR(1),
    tipo_admision VARCHAR(1),
    fecha DATETIME,
    CONSTRAINT FK_estudiante_persona
        FOREIGN KEY (id_persona) REFERENCES personas (id_persona)
);
GO

CREATE TABLE docente
(
    id_doc VARCHAR(10) NOT NULL PRIMARY KEY,
    id_persona VARCHAR(10) NOT NULL,
    gestion VARCHAR(4),
    periodo VARCHAR(1),
    tipo_admision_doc VARCHAR(1),
    grad_acad VARCHAR(4),
    fecha DATETIME,
    CONSTRAINT FK_docente_persona
        FOREIGN KEY (id_persona) REFERENCES personas (id_persona)
);
GO

-- Tabla Plan Académico (base de referencia para pensum)
CREATE TABLE plan_acad
(
    id_plan VARCHAR(2) PRIMARY KEY NOT NULL,
    descripcion VARCHAR(100)
);
GO

-- Tabla Pensum
CREATE TABLE pensum
(
    id_materia VARCHAR(5) PRIMARY KEY NOT NULL,
    id_plan VARCHAR(2) NOT NULL,
    sigla VARCHAR(7),
    descripcion VARCHAR(100),
    FOREIGN KEY (id_plan) REFERENCES plan_acad(id_plan)
);
GO

-- Tabla Paralelos (para relacionar con notas)
CREATE TABLE paralelos
(
    id_paralelo VARCHAR(1) PRIMARY KEY NOT NULL,
    descripcion VARCHAR(50)
);
GO

-- Tabla Notas
CREATE TABLE notas
(
    id_nota INT IDENTITY PRIMARY KEY NOT NULL,
    id_est INT NOT NULL,
    id_materia VARCHAR(5) NOT NULL,
    id_paralelo VARCHAR(1) NOT NULL,
    periodo VARCHAR(1),
    gestion VARCHAR(4),
    nota VARCHAR(3),
    FOREIGN KEY (id_est) REFERENCES estudiante(id_est),
    FOREIGN KEY (id_paralelo) REFERENCES paralelos(id_paralelo),
    FOREIGN KEY (id_materia) REFERENCES pensum(id_materia)
);
GO
-- 2.1 PERSONAS (50)
INSERT INTO personas VALUES
('P001','Juan','Perez','Lopez','123456','Boliviana','La Paz','La Paz','M','S','2000-01-15'),
('P002','Maria','Gomez','Fernandez','234567','Boliviana','Cochabamba','Cochabamba','F','S','1999-05-22'),
('P003','Luis','Rodriguez','Soto','345678','Boliviana','Santa Cruz','Santa Cruz','M','C','1998-03-30'),
('P004','Ana','Torrez','Rios','456789','Boliviana','Oruro','Oruro','F','S','2001-07-11'),
('P005','Carlos','Mendoza','Quiroga','567890','Boliviana','Sucre','Chuquisaca','M','C','1997-10-09'),
('P006','Lucia','Flores','Vargas','678901','Boliviana','Tarija','Tarija','F','S','2002-02-20'),
('P007','Miguel','Fernandez','Perez','789012','Boliviana','Trinidad','Beni','M','S','2000-12-25'),
('P008','Sofia','Gutierrez','Cruz','890123','Boliviana','Cobija','Pando','F','S','1999-08-17'),
('P009','Andres','Rojas','Mamani','901234','Boliviana','Potosi','Potosi','M','C','1998-09-05'),
('P010','Gabriela','Salazar','Mejia','012345','Boliviana','La Paz','La Paz','F','S','2001-11-14'),

('P011','Pedro','Camacho','Mamani','111111','Boliviana','La Paz','La Paz','M','S','2000-02-11'),
('P012','Elena','Santos','Mendoza','111112','Boliviana','Cochabamba','Cochabamba','F','S','1999-03-22'),
('P013','Jorge','Rojas','Quispe','111113','Boliviana','Santa Cruz','Santa Cruz','M','C','1998-04-05'),
('P014','Claudia','Llanos','Vega','111114','Boliviana','Oruro','Oruro','F','S','2001-01-19'),
('P015','Victor','Flores','Aguilar','111115','Boliviana','Sucre','Chuquisaca','M','C','1997-10-29'),
('P016','Paola','Gutierrez','Salinas','111116','Boliviana','Tarija','Tarija','F','S','2002-06-12'),
('P017','Rodrigo','Perez','Choque','111117','Boliviana','Trinidad','Beni','M','S','2000-08-15'),
('P018','Natalia','Vargas','Lopez','111118','Boliviana','Cobija','Pando','F','S','1999-11-30'),
('P019','Oscar','Fernandez','Flores','111119','Boliviana','Potosi','Potosi','M','C','1998-09-18'),
('P020','Carla','Mamani','Villalba','111120','Boliviana','La Paz','La Paz','F','S','2001-05-07'),

('P021','Diego','Salazar','Ramos','111121','Boliviana','La Paz','La Paz','M','S','1999-07-15'),
('P022','Adriana','Morales','Zeballos','111122','Boliviana','Cochabamba','Cochabamba','F','S','2000-04-10'),
('P023','Hugo','Cruz','Arce','111123','Boliviana','Santa Cruz','Santa Cruz','M','C','1998-02-26'),
('P024','Monica','Cardenas','Gutierrez','111124','Boliviana','Oruro','Oruro','F','S','2001-03-21'),
('P025','Pablo','Quispe','Soria','111125','Boliviana','Sucre','Chuquisaca','M','C','1997-09-14'),
('P026','Daniela','Rios','Calderon','111126','Boliviana','Tarija','Tarija','F','S','2002-10-30'),
('P027','Gustavo','Medina','Torrez','111127','Boliviana','Trinidad','Beni','M','S','2000-12-12'),
('P028','Marcela','Aliaga','Cortez','111128','Boliviana','Cobija','Pando','F','S','1999-08-01'),
('P029','Enrique','Villegas','Rojas','111129','Boliviana','Potosi','Potosi','M','C','1998-06-22'),
('P030','Patricia','Gutierrez','Lopez','111130','Boliviana','La Paz','La Paz','F','S','2001-09-09'),

('P031','Sergio','Valdez','Mamani','111131','Boliviana','La Paz','La Paz','M','S','2000-10-14'),
('P032','Laura','Campos','Peñaranda','111132','Boliviana','Cochabamba','Cochabamba','F','S','1999-01-05'),
('P033','Martin','Chavez','Mercado','111133','Boliviana','Santa Cruz','Santa Cruz','M','C','1998-05-23'),
('P034','Angela','Aguilar','Soria','111134','Boliviana','Oruro','Oruro','F','S','2001-07-02'),
('P035','Cristian','Romero','Calle','111135','Boliviana','Sucre','Chuquisaca','M','C','1997-11-11'),
('P036','Tatiana','Choque','Aramayo','111136','Boliviana','Tarija','Tarija','F','S','2002-03-27'),
('P037','Edgar','Vallejos','Salazar','111137','Boliviana','Trinidad','Beni','M','S','2000-05-16'),
('P038','Mariana','Lopez','Lima','111138','Boliviana','Cobija','Pando','F','S','1999-12-24'),
('P039','Fernando','Arce','Paredes','111139','Boliviana','Potosi','Potosi','M','C','1998-07-29'),
('P040','Liliana','Castro','Perez','111140','Boliviana','La Paz','La Paz','F','S','2001-02-18'),

('P041','Ruben','Gonzales','Quinteros','111141','Boliviana','La Paz','La Paz','M','S','1999-03-03'),
('P042','Yesica','Apaza','Mamani','111142','Boliviana','Cochabamba','Cochabamba','F','S','2000-09-25'),
('P043','Javier','Torrez','Garcia','111143','Boliviana','Santa Cruz','Santa Cruz','M','C','1998-06-06'),
('P044','Milena','Soria','Alvarez','111144','Boliviana','Oruro','Oruro','F','S','2001-08-14'),
('P045','Raul','Quiroga','Duran','111145','Boliviana','Sucre','Chuquisaca','M','C','1997-05-19'),
('P046','Alejandra','Lopez','Hinojosa','111146','Boliviana','Tarija','Tarija','F','S','2002-11-08'),
('P047','German','Villca','Mamani','111147','Boliviana','Trinidad','Beni','M','S','2000-09-12'),
('P048','Isabel','Huanca','Choque','111148','Boliviana','Cobija','Pando','F','S','1999-04-29'),
('P049','Mauricio','Mamani','Lopez','111149','Boliviana','Potosi','Potosi','M','C','1998-01-07'),
('P050','Valeria','Fernandez','Cruz','111150','Boliviana','La Paz','La Paz','F','S','2001-06-20');
GO

-- 2.2 PLAN ACADÉMICO (5)
INSERT INTO plan_acad VALUES
('01','Plan Ingeniería de Sistemas'),
('02','Plan Ingeniería Informática'),
('03','Plan Ingeniería Industrial'),
('04','Plan Ingeniería Civil'),
('05','Plan Medicina');
GO

-- 2.3 PENSUM (30) → 6 por plan (01..05), id_materia MAT01..MAT30
INSERT INTO pensum VALUES
('MAT01','01','INF101','Programación I'),
('MAT02','01','INF102','Programación II'),
('MAT03','01','INF103','Bases de Datos I'),
('MAT04','01','INF104','Bases de Datos II'),
('MAT05','01','INF105','Redes I'),
('MAT06','01','INF106','Redes II'),

('MAT07','02','INF201','Algoritmos'),
('MAT08','02','INF202','Estructuras de Datos'),
('MAT09','02','INF203','Sistemas Operativos'),
('MAT10','02','INF204','Compiladores'),
('MAT11','02','INF205','Inteligencia Artificial'),
('MAT12','02','INF206','Minería de Datos'),

('MAT13','03','IND301','Gestión Industrial'),
('MAT14','03','IND302','Logística'),
('MAT15','03','IND303','Calidad'),
('MAT16','03','IND304','Investigación de Operaciones'),
('MAT17','03','IND305','Ergonomía'),
('MAT18','03','IND306','Planeamiento de Producción'),

('MAT19','04','CIV401','Mecánica de Suelos'),
('MAT20','04','CIV402','Hormigón Armado'),
('MAT21','04','CIV403','Topografía'),
('MAT22','04','CIV404','Estructuras'),
('MAT23','04','CIV405','Hidráulica'),
('MAT24','04','CIV406','Construcción'),

('MAT25','05','MED501','Anatomía'),
('MAT26','05','MED502','Fisiología I'),
('MAT27','05','MED503','Fisiología II'),
('MAT28','05','MED504','Bioquímica'),
('MAT29','05','MED505','Farmacología'),
('MAT30','05','MED506','Microbiología');
GO

-- 2.4 PARALELOS (10: A..J)
INSERT INTO paralelos VALUES
('A','Paralelo A'),('B','Paralelo B'),('C','Paralelo C'),('D','Paralelo D'),('E','Paralelo E'),
('F','Paralelo F'),('G','Paralelo G'),('H','Paralelo H'),('I','Paralelo I'),('J','Paralelo J');
GO

-- 2.5 ESTUDIANTES (35) → P001..P035
INSERT INTO estudiante (id_persona, gestion, periodo, tipo_admision, fecha) VALUES
('P001','2025','1','R','2025-02-01'),
('P002','2025','1','R','2025-02-01'),
('P003','2025','1','E','2025-02-01'),
('P004','2025','1','R','2025-02-01'),
('P005','2025','1','R','2025-02-01'),
('P006','2025','1','E','2025-02-01'),
('P007','2025','1','R','2025-02-01'),
('P008','2025','1','R','2025-02-01'),
('P009','2025','1','E','2025-02-01'),
('P010','2025','1','R','2025-02-01'),

('P011','2025','1','R','2025-02-01'),
('P012','2025','1','E','2025-02-01'),
('P013','2025','1','R','2025-02-01'),
('P014','2025','1','R','2025-02-01'),
('P015','2025','1','E','2025-02-01'),
('P016','2025','1','R','2025-02-01'),
('P017','2025','1','R','2025-02-01'),
('P018','2025','1','E','2025-02-01'),
('P019','2025','1','R','2025-02-01'),
('P020','2025','1','R','2025-02-01'),

('P021','2025','1','E','2025-02-01'),
('P022','2025','1','R','2025-02-01'),
('P023','2025','1','R','2025-02-01'),
('P024','2025','1','E','2025-02-01'),
('P025','2025','1','R','2025-02-01'),
('P026','2025','1','R','2025-02-01'),
('P027','2025','1','E','2025-02-01'),
('P028','2025','1','R','2025-02-01'),
('P029','2025','1','R','2025-02-01'),
('P030','2025','1','E','2025-02-01'),

('P031','2025','1','R','2025-02-01'),
('P032','2025','1','R','2025-02-01'),
('P033','2025','1','E','2025-02-01'),
('P034','2025','1','R','2025-02-01'),
('P035','2025','1','R','2025-02-01');
GO

-- 2.6 DOCENTES (10) → D001..D010 con P036..P045
INSERT INTO docente (id_doc, id_persona, gestion, periodo, tipo_admision_doc, grad_acad, fecha) VALUES
('D001','P036','2025','1','C','LIC','2025-02-01'),
('D002','P037','2025','1','C','ING','2025-02-01'),
('D003','P038','2025','1','N','MSC','2025-02-01'),
('D004','P039','2025','1','C','LIC','2025-02-01'),
('D005','P040','2025','1','N','PHD','2025-02-01'),
('D006','P041','2025','1','C','ING','2025-02-01'),
('D007','P042','2025','1','N','LIC','2025-02-01'),
('D008','P043','2025','1','C','MSC','2025-02-01'),
('D009','P044','2025','1','C','ING','2025-02-01'),
('D010','P045','2025','1','N','PHD','2025-02-01');
GO

-- 2.7 NOTAS (30) → id_est 1..30 / materias MAT01..MAT30 / paralelos variados
INSERT INTO notas (id_est, id_materia, id_paralelo, periodo, gestion, nota) VALUES
(1,'MAT01','A','1','2025','75'),
(2,'MAT02','B','1','2025','85'),
(3,'MAT03','C','1','2025','60'),
(4,'MAT04','D','1','2025','70'),
(5,'MAT05','E','1','2025','90'),
(6,'MAT06','F','1','2025','65'),
(7,'MAT07','G','1','2025','80'),
(8,'MAT08','H','1','2025','55'),
(9,'MAT09','I','1','2025','95'),
(10,'MAT10','J','1','2025','88'),

(11,'MAT11','A','1','2025','70'),
(12,'MAT12','B','1','2025','82'),
(13,'MAT13','C','1','2025','90'),
(14,'MAT14','D','1','2025','68'),
(15,'MAT15','E','1','2025','75'),
(16,'MAT16','F','1','2025','80'),
(17,'MAT17','G','1','2025','95'),
(18,'MAT18','H','1','2025','60'),
(19,'MAT19','I','1','2025','72'),
(20,'MAT20','J','1','2025','85'),

(21,'MAT21','A','1','2025','65'),
(22,'MAT22','B','1','2025','78'),
(23,'MAT23','C','1','2025','88'),
(24,'MAT24','D','1','2025','91'),
(25,'MAT25','E','1','2025','70'),
(26,'MAT26','F','1','2025','76'),
(27,'MAT27','G','1','2025','84'),
(28,'MAT28','H','1','2025','60'),
(29,'MAT29','I','1','2025','92'),
(30,'MAT30','J','1','2025','89');
GO

/* =========================================================
   3) Verificación final (opc.)
   ========================================================= */
SELECT 'personas' AS tabla, COUNT(*) AS total FROM personas
UNION ALL SELECT 'estudiante', COUNT(*) FROM estudiante
UNION ALL SELECT 'docente',   COUNT(*) FROM docente
UNION ALL SELECT 'plan_acad', COUNT(*) FROM plan_acad
UNION ALL SELECT 'pensum',    COUNT(*) FROM pensum
UNION ALL SELECT 'paralelos', COUNT(*) FROM paralelos
UNION ALL SELECT 'notas',     COUNT(*) FROM notas;