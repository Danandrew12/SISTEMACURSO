-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 22-06-2022 a las 15:19:17
-- Versión del servidor: 10.4.24-MariaDB
-- Versión de PHP: 8.1.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `bd_curso`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_DASHBOARD` ()   SELECT
	COUNT(*) as paciente,
	(SELECT COUNT(*) FROM
	medico) as medico
FROM
	paciente$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_INTENTO_USUARIO` (IN `USUARIO` VARCHAR(50))   BEGIN
DECLARE INTENTO INT;
SET @INTENTO:=(SELECT usu_intento FROM usuario WHERE usu_nombre=USUARIO);
IF @INTENTO = 2 THEN
	SELECT @INTENTO;
ELSE
	UPDATE usuario set
	usu_intento=@INTENTO+1
	WHERE usu_nombre=USUARIO;
		SELECT @INTENTO;
END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_LISTAR_AUDITORIA` ()   SELECT
	auditoria.audi_id, 
	auditoria.fecha, 
	auditoria.accion, 
	auditoria.usu_id
FROM
	auditoria$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_LISTAR_CITA` ()   SELECT c.cita_id,c.cita_nroatencion,c.cita_feregistro,c.cita_estatus,p.paciente_id,concat_ws(' ',p.paciente_nombre,p.paciente_apepat,p.paciente_apemat) as paciente,c.medico_id,concat_ws(' ',m.medico_nombre,m.medico_apepart,m.medico_apemart) as medico, e.especialidad_id, e.especialidad_nombre, c.cita_descripcion 
FROM cita as c 
INNER JOIN paciente as p ON c.paciente_id=p.paciente_id
INNER JOIN medico as m on c.medico_id=m.medico_id
INNER JOIN especialidad as e ON e.especialidad_id=m.especialidad_id
ORDER BY cita_id DESC$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_LISTAR_COMBO_ESPECIALIDAD` ()   SELECT * FROM especialidad WHERE especialidad_estatus='ACTIVO'$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_LISTAR_COMBO_ROL` ()   SELECT
	rol.rol_id, 
	rol.rol_nombre
FROM
	rol$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_LISTAR_CONSULTA` (IN `FECHAINICIO` DATE, IN `FECHAFIN` DATE)   SELECT
	consulta.consulta_id, 
	consulta.consulta_descripcion, 
	consulta.consulta_diagnostico, 
	consulta.consulta_feregistro, 
	consulta.consulta_estatus, 
	cita.cita_nroatencion, 
	cita.cita_feregistro, 
	cita.medico_id, 
	cita.especialidad_id,
  cita.paciente_id,
	cita.cita_estatus, 
	cita.cita_descripcion, 
	cita.usu_id, 
	CONCAT_WS(' ',paciente.paciente_nombre,paciente.paciente_apepat,paciente.paciente_apemat) as paciente, 
paciente.paciente_nrodocumento, 
	CONCAT_WS(' ',medico.medico_nombre,medico.medico_apepart,medico.medico_apemart)as medico,
	especialidad.especialidad_nombre
FROM
	consulta
	INNER JOIN
	cita
	ON 
		consulta.cita_id = cita.cita_id
	INNER JOIN
	paciente
	ON 
		cita.paciente_id = paciente.paciente_id
	INNER JOIN
	medico
	ON 
		cita.medico_id = medico.medico_id
	INNER JOIN
	especialidad
	ON 
		cita.especialidad_id = especialidad.especialidad_id
		WHERE consulta.consulta_feregistro BETWEEN FECHAINICIO AND FECHAFIN$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_LISTAR_CONSULTA_HISTORIAL` ()   SELECT
	consulta.consulta_id, 
	consulta.consulta_descripcion, 
	consulta.consulta_diagnostico,
	paciente.paciente_nrodocumento,	
	CONCAT(' ',paciente.paciente_nombre,paciente.paciente_apepat,paciente.paciente_apemat) AS paciente, 
	historia.historia_id, 
	consulta.consulta_feregistro
FROM
	consulta
	INNER JOIN
	cita
	ON 
		consulta.cita_id = cita.cita_id
	INNER JOIN
	paciente
	ON 
		cita.paciente_id = paciente.paciente_id
	INNER JOIN
	historia
	ON 
		paciente.paciente_id = historia.paciente_id
		WHERE consulta.consulta_feregistro=CURDATE()$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_LISTAR_DOCTOR_COMBO` (IN `ID` INT)   SELECT `medico_id`,concat_ws(' ',`medico_nombre`,`medico_apepart`,`medico_apemart`)FROM medico where `especialidad_id` = ID$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_LISTAR_ESPECIALIDAD` ()   SELECT * FROM especialidad$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_LISTAR_ESPECIALIDAD_COMBO` ()   SELECT especialidad_id,especialidad_nombre FROM especialidad$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_LISTAR_HISTORIAL` (IN `FECHAINICIO` DATE, IN `FECHAFIN` DATE)   SELECT
	fua.fua_id,
    fua.fua_fegistro,
    fua.historia_id,
    fua.consulta_id,
    consulta.consulta_diagnostico,
    CONCAT_WS(' ',paciente.paciente_nombre,paciente.paciente_apepat,paciente.paciente_apemat) AS paciente,
paciente.paciente_nrodocumento,
CONCAT_WS(' ', medico.medico_nombre,medico.medico_apepart,medico.medico_apemart) AS medico
FROM
fua
INNER JOIN
consulta
ON
fua.consulta_id = consulta.consulta_id
INNER JOIN
cita
ON
consulta.cita_id = cita.cita_id
INNER JOIN
paciente
ON
cita.paciente_id = paciente.paciente_id
INNER JOIN
medico
ON
cita.medico_id= medico.medico_id
WHERE fua.fua_fegistro BETWEEN FECHAINICIO AND FECHAFIN$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_LISTAR_INSUMO` ()   SELECT * FROM insumo$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_LISTAR_INSUMO_COMBO` ()   SELECT
	insumo.insumo_id, 
	insumo.insumo_nombre
FROM
	insumo$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_LISTAR_INSUMO_DETALLE` (IN `IDFUA` INT)   SELECT
	insumo.insumo_nombre, 
	detalle_insumo.detain_cantidad
FROM
	detalle_insumo
	INNER JOIN
	insumo
	ON 
		detalle_insumo.insumo_id = insumo.insumo_id
		WHERE detalle_insumo.fua_id=IDFUA$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_LISTAR_MEDICAMENTO` ()   SELECT * FROM medicamento$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_LISTAR_MEDICAMENTO_COMBO` ()   SELECT
	medicamento.medicamento_id, 
	medicamento.medicamento_nombre
FROM
	medicamento$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_LISTAR_MEDICAMENTO_DETALLE` (IN `IDFUA` INT)   SELECT
	medicamento.medicamento_nombre, 
	detalle_medicamento.detame_cantidad
FROM
	detalle_medicamento
	INNER JOIN
	medicamento
	ON 
		detalle_medicamento.medicamento_id = medicamento.medicamento_id
		WHERE detalle_medicamento.fua_id=IDFUA$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_LISTAR_MEDICO` ()   SELECT
medico.medico_id,
medico_nombre,
medico_apepart,
medico_apemart,
CONCAT_WS(' ',medico_nombre,medico_apepart,medico_apemart) as medico,
medico.medico_direccion,
medico.medico_movil,
medico.medico_sexo,
medico.medico_fenac,
medico.medico_nrodocumento,
medico.medico_colegiatura,
medico.especialidad_id,
medico.usu_id,
especialidad.especialidad_nombre,
usuario.usu_nombre,
usuario.rol_id,
usuario.usu_email,
sangre.sag_id,
sangre.tp_sangre
FROM
medico
INNER JOIN especialidad ON medico.especialidad_id= especialidad.especialidad_id
INNER JOIN usuario ON medico.usu_id = usuario.usu_id
INNER JOIN sangre ON medico.sag_id= sangre.sag_id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_LISTAR_PACIENTE` ()   SELECT
CONCAT_WS(' ',paciente_nombre,paciente_apepat,paciente_apemat) as paciente,
paciente.paciente_id,
paciente.paciente_nombre,
paciente.paciente_apepat,
paciente.paciente_apemat,
paciente.paciente_direccion,
paciente.paciente_movil,
paciente.paciente_sexo,
paciente_fenac,
paciente.paciente_nrodocumento,
paciente.paciente_estatus,
sangre.sag_id,
sangre.tp_sangre
FROM
paciente
INNER JOIN
sangre
ON
	paciente.sag_id= sangre.sag_id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_LISTAR_PACIENTE_CITA` ()   SELECT
	cita.cita_id, 
	cita.cita_nroatencion, 
	CONCAT_WS(' ',paciente.paciente_nombre,paciente.paciente_apepat,paciente.paciente_apemat)
FROM
	cita
	INNER JOIN
	paciente
	ON 
		cita.paciente_id = paciente.paciente_id
		WHERE cita_feregistro=CURDATE() AND cita_estatus='PENDIENTE'$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_LISTAR_PACIENTE_COMBO` ()   SELECT paciente_id,concat_ws(' ',paciente_nombre,paciente_apepat,paciente_apemat) FROM paciente$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_LISTAR_PROCEDIMIENTO` ()   SELECT * FROM procedimiento$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_LISTAR_PROCEDIMIENTO_COMBO` ()   SELECT
	procedimiento.procedimiento_id, 
	procedimiento.procedimiento_nombre
FROM
	procedimiento$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_LISTAR_PROCEDIMIENTO_DETALLE` (IN `IDFUA` INT)   SELECT
	procedimiento.procedimiento_nombre
FROM
	detalle_procedimiento
	INNER JOIN
	procedimiento
	ON 
		detalle_procedimiento.procedimiento_id = procedimiento.procedimiento_id
		WHERE detalle_procedimiento.fua_id=IDFUA$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_LISTAR_SANGRE_COMBO` ()   SELECT 
	sangre.sag_id,
	sangre.tp_sangre
FROM 
	sangre$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_LISTAR_USUARIO` ()   BEGIN
DECLARE CANTIDAD INT;
SET @CANTIDAD:=0;
SELECT
@CANTIDAD:=@CANTIDAD+1 AS posicion,
	u.usu_id, 
	u.usu_nombre, 
	u.usu_sexo, 
	u.rol_id, 
	u.usu_estatus, 
	r.rol_nombre,
	u.usu_email
FROM
	usuario AS u
	INNER JOIN
	rol AS r
	ON 
		u.rol_id = r.rol_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_MODIFICAR_CITA` (IN `IDCITA` INT, IN `IDPACIENTE` INT, IN `IDDOCTOR` INT, IN `IDESPECIALIDAD` INT, IN `DESCRIPCION` TEXT, IN `ESTATUS` VARCHAR(10))   UPDATE cita SET
paciente_id=IDPACIENTE,
medico_id=IDDOCTOR,
especialidad_id=IDESPECIALIDAD,
cita_descripcion=DESCRIPCION,
cita_estatus=ESTATUS
where cita_id=IDCITA$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_MODIFICAR_CONSULTA` (IN `IDCONSULTA` INT, IN `DESCRIPCION` VARCHAR(255), IN `DIAGNOSTICO` VARCHAR(255))   UPDATE consulta SET
consulta_descripcion=DESCRIPCION,
consulta_diagnostico=DIAGNOSTICO
WHERE consulta_id=IDCONSULTA$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_MODIFICAR_CONTRA_USUARIO` (IN `IDUSUARIO` INT, IN `CONTRA` VARCHAR(250))   UPDATE usuario SET
usu_contrasena=CONTRA
WHERE usu_id=IDUSUARIO$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_MODIFICAR_DATOS_USUARIO` (IN `IDUSUARIO` INT, IN `SEXO` CHAR(1), IN `IDROL` INT, IN `EMAIL` VARCHAR(250))   UPDATE usuario SET
usu_sexo=SEXO,
rol_id=IDROL,
usu_email=EMAIL
WHERE usu_id=IDUSUARIO$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_MODIFICAR_ESPECIALIDAD` (IN `ID` INT, IN `ESPECIALIDADACTUAL` VARCHAR(50), IN `ESPECIALIDADNUEVA` VARCHAR(50), IN `ESTATUS` VARCHAR(10))   BEGIN
DECLARE CANTIDAD INT;
 IF ESPECIALIDADACTUAL=ESPECIALIDADNUEVA THEN
	UPDATE especialidad SET
    especialidad_estatus=ESTATUS
    WHERE especialidad_id=ID;
    SELECT 1;
 ELSE
	SET @CANTIDAD:=(SELECT COUNT(*) FROM especialidad WHERE especialidad_nombre=ESPECIALIDADNUEVA);
    IF @CANTIDAD=0 THEN
    	UPDATE especialidad SET
        especialidad_nombre=ESPECIALIDADNUEVA,
        especialidad_estatus=ESTATUS
        WHERE especialidad_id=ID;
        SELECT 1;
    ELSE
    	SELECT 2;
    END IF;
 END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_MODIFICAR_ESTATUS_USUARIO` (IN `IDUSUARIO` INT, IN `ESTATUS` VARCHAR(20))   UPDATE usuario SET
usu_estatus=ESTATUS
WHERE usu_id=IDUSUARIO$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_MODIFICAR_INSUMO` (IN `ID` INT, IN `INSUMOACTUAL` VARCHAR(50), IN `INSUMONUEVO` VARCHAR(50), IN `STOCK` INT, IN `FECHV` DATE, IN `ESTATUS` VARCHAR(10))   BEGIN
DECLARE CANTIDAD INT;

IF INSUMOACTUAL = INSUMONUEVO THEN
	UPDATE insumo SET
	insumo_stock= STOCK,
	insumo_fechf= FECHV,
	insumo_estatus= ESTATUS
	WHERE insumo_id= ID;
	SELECT 1;
ELSE
SET @CANTIDAD:=(SELECT COUNT(*) FROM insumo WHERE insumo_nombre=INSUMONUEVO);

IF @CANTIDAD = 0 THEN
	UPDATE insumo SET
	insumo_nombre=INSUMONUEVO,
	insumo_stock= STOCK,
	insumo_fechf= FECHV,
	insumo_estatus= ESTATUS
	WHERE insumo_id= ID;
	SELECT 1;
ELSE
	SELECT 2;
END IF;

END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_MODIFICAR_MEDICAMENTO` (IN `ID` INT, IN `MEDICAMENTOACTUAL` VARCHAR(50), IN `MEDICAMENTONUEVO` VARCHAR(50), IN `ALIAS` VARCHAR(50), IN `STOCK` INT, IN `FECHA` DATE, IN `ESTATUS` VARCHAR(10))   BEGIN
DECLARE CANTIDAD INT;
IF MEDICAMENTOACTUAL= MEDICAMENTONUEVO THEN
	UPDATE medicamento SET
	medicamento_alias=ALIAS,
	medicamento_stock=STOCK,
	medicamento_fechf=FECHA,
	medicamento_estatus=ESTATUS
	WHERE medicamento_id=ID;
	SELECT 1;
ELSE

SET @CANTIDAD:=(SELECT COUNT(*) FROM medicamento WHERE medicamento_nombre=MEDICAMENTONUEVO);
	
	IF @CANTIDAD=0 THEN
		UPDATE medicamento SET
		medicamento_nombre=MEDICAMENTONUEVO,
		medicamento_alias=ALIAS,
		medicamento_stock=STOCK,
		medicamento_fechf=FECHA,
		medicamento_estatus=ESTATUS
		WHERE medicamento_id=ID;
		SELECT 1;
	ELSE
		SELECT 2;
	END IF;
	
END IF;


END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_MODIFICAR_MEDICO` (IN `IDMEDICO` INT, IN `NOMBRES` VARCHAR(50), IN `APEPAT` VARCHAR(50), IN `APEMAT` VARCHAR(50), IN `DIRECCION` VARCHAR(200), IN `MOVIL` CHAR(12), IN `SEXO` CHAR(2), IN `FECHANACIMIENTO` DATE, IN `SANGRE` INT, IN `NRDOCUMENTOACTUAL` CHAR(12), IN `NRDOCUMENTONUEVO` CHAR(12), IN `COLEGIATURAACTUAL` CHAR(12), IN `COLEGIATURANUEVO` CHAR(12), IN `ESPECIALIDAD` INT, IN `IDUSUARIO` INT, IN `EMAIL` VARCHAR(255))   BEGIN
DECLARE CANTIDAD INT;
IF NRDOCUMENTOACTUAL=NRDOCUMENTONUEVO OR COLEGIATURAACTUAL=COLEGIATURANUEVO THEN
	UPDATE usuario SET
    usu_email=EMAIL,
    usu_sexo=SEXO
    WHERE usu_id=IDUSUARIO;
    UPDATE medico SET
    medico_nombre=NOMBRES,
    medico_apepart=APEPAT,
    medico_apemart=APEMAT,
    medico_direccion=DIRECCION,
    medico_movil=MOVIL,
    medico_sexo=SEXO,
    medico_fenac=FECHANACIMIENTO,
		sag_id=SANGRE,
    medico_nrodocumento=NRDOCUMENTONUEVO,
    medico_colegiatura=COLEGIATURANUEVO,
    especialidad_id=ESPECIALIDAD
    WHERE medico_id=IDMEDICO;
    SELECT 1;
ELSE
	SET @CANTIDAD:=(SELECT COUNT(*) FROM medico WHERE medico_nrodocumento=NRDOCUMENTONUEVO OR medico_colegiatura=COLEGIATURANUEVO);
    IF @CANTIDAD=0 THEN
    UPDATE usuario SET
    usu_email=EMAIL,
    usu_sexo=SEXO
    WHERE usu_id=IDUSUARIO;
    UPDATE medico SET
    medico_nombre=NOMBRES,
    medico_apepart=APEPAT,
    medico_apemart=APEMAT,
    medico_direccion=DIRECCION,
    medico_movil=MOVIL,
    medico_sexo=SEXO,
    medico_fenac=FECHANACIMIENTO,
		sag_id=SANGRE,
    medico_nrodocumento=NRDOCUMENTONUEVO,
    medico_colegiatura=COLEGIATURANUEVO,
    especialidad_id=ESPECIALIDAD
    WHERE medico_id=IDMEDICO;
    SELECT 1;
   ELSE 
    SELECT 2;
   END IF;
    
END IF;



END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_MODIFICAR_PACIENTE` (IN `ID` INT, IN `NOMBRE` VARCHAR(50), IN `APEPAT` VARCHAR(50), IN `APEMAT` VARCHAR(50), IN `DIRECCION` VARCHAR(200), IN `MOVIL` CHAR(12), IN `FECHA` DATE, IN `SANGRE` INT, IN `SEXO` CHAR(1), IN `NRDOCUMENTOACTUAL` CHAR(12), IN `NRDOCUMENTONUEVO` CHAR(12), IN `ESTATUS` CHAR(10))   BEGIN
DECLARE CANTIDAD INT;
IF NRDOCUMENTOACTUAL=NRDOCUMENTONUEVO THEN
	UPDATE paciente SET
    paciente_nombre=NOMBRE,
    paciente_apepat=APEPAT,
    paciente_apemat=APEMAT,
    paciente_direccion=DIRECCION,
    paciente_movil=MOVIL,
		paciente_fenac=FECHA,
		sag_id=SANGRE,
    paciente_sexo=SEXO,
    paciente_estatus=ESTATUS
    WHERE paciente_id=ID;
    SELECT 1;
ELSE
SET @CANTIDAD:=(SELECT COUNT(*) FROM paciente where paciente_nrodocumento=NRDOCUMENTONUEVO);
 IF @CANTIDAD= 0 THEN
 UPDATE paciente SET
    paciente_nombre=NOMBRE,
    paciente_apepat=APEPAT,
    paciente_apemat=APEMAT,
    paciente_direccion=DIRECCION,
    paciente_movil=MOVIL,
		paciente_fenac=FECHA,
		sag_id=SANGRE,
    paciente_sexo=SEXO,
    paciente_nrodocumento=NRDOCUMENTONUEVO,
    paciente_estatus=ESTATUS
    WHERE paciente_id=ID;
    SELECT 1;
  ELSE
    SELECT 2;
  END IF;
END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_MODIFICAR_PROCEDIMIENTO` (IN `ID` INT, IN `PROCEDIMIENTOACTUAL` VARCHAR(50), IN `PROCEDIMIENTONUEVO` VARCHAR(50), IN `ESTATUS` VARCHAR(10))   BEGIN
DECLARE CANTIDAD INT;
IF PROCEDIMIENTOACTUAL=PROCEDIMIENTONUEVO THEN
		UPDATE procedimiento SET
		procedimiento_estatus=ESTATUS
		WHERE procedimiento_id=ID;
		SELECT 1;
ELSE
		SET @CANTIDAD:=(SELECT count(*) FROM procedimiento WHERE procedimiento_nombre=PROCEDIMIENTONUEVO);
		if @CANTIDAD = 0 THEN
		UPDATE procedimiento SET
		procedimiento_estatus=ESTATUS,
		procedimiento_nombre=PROCEDIMIENTONUEVO
		WHERE procedimiento_id=ID;
		SELECT 1;
	ELSE
		SELECT 2;
		
		END IF;
END IF;


END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_REGISTRAR_CITA` (IN `IDPACIENTE` INT, IN `IDDOCTOR` INT, IN `DESCRIPCION` TEXT, IN `IDUSUARIO` INT)   BEGIN
DECLARE NUMCITA INT;
SET @NUMCITA:=(SELECT COUNT(*) +1 FROM cita WHERE cita_feregistro=CURDATE());
INSERT INTO cita(cita_nroatencion,cita_feregistro,medico_id,paciente_id,cita_estatus,cita_descripcion,usu_id) VALUES(@NUMCITA,CURDATE(),IDDOCTOR,IDPACIENTE,'PENDIENTE',DESCRIPCION,IDUSUARIO);
SELECT LAST_INSERT_ID();

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_REGISTRAR_CONSULTA` (IN `ID` INT, IN `DESCRIPCION` VARCHAR(255), IN `DIAGNOSTICO` VARCHAR(255))   BEGIN
INSERT INTO consulta(consulta_descripcion,consulta_diagnostico,consulta_feregistro,consulta_estatus,cita_id) VALUES(DESCRIPCION,DIAGNOSTICO,CURDATE(),'ATENDIDA',ID);
UPDATE cita SET
cita_estatus='ATENDIDA'
WHERE cita_id=ID;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_REGISTRAR_ESPECIALIDAD` (IN `ESPECIALIDAD` VARCHAR(50), IN `ESTATUS` VARCHAR(10))   BEGIN
DECLARE CANTIDAD INT;
SET @CANTIDAD:=(SELECT COUNT(*) FROM especialidad WHERE especialidad_nombre=ESPECIALIDAD);
IF @CANTIDAD= 0 THEN
INSERT INTO especialidad(especialidad_nombre,especialidad_fregistro,especialidad_estatus) VALUES(ESPECIALIDAD,CURDATE(),ESTATUS);
SELECT 1;

ELSE
SELECT 2;
END IF;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_REGISTRAR_INSUMO` (IN `INSUMO` VARCHAR(50), IN `STOCK` INT, IN `FECHV` DATE, IN `ESTATUS` VARCHAR(10))   BEGIN
DECLARE CANTIDAD INT;
SET @CANTIDAD:=(SELECT COUNT(*) FROM insumo WHERE insumo_nombre=INSUMO);

IF @CANTIDAD = 0 THEN
INSERT INTO insumo(insumo_nombre,insumo_stock,insumo_fechf,insumo_fregistro,insumo_estatus)
VALUES(INSUMO,STOCK,FECHV,CURDATE(),ESTATUS);
SELECT 1;
ELSE
SELECT 2;
END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_REGISTRAR_MEDICAMENTO` (IN `MEDICAMENTO` VARCHAR(50), IN `ALIAS` VARCHAR(50), IN `STOCK` INT, IN `FECHA` DATE, IN `ESTATUS` VARCHAR(10))   BEGIN
DECLARE CANTIDAD INT;
SET @CANTIDAD:=(SELECT COUNT(*) FROM medicamento WHERE medicamento_nombre=MEDICAMENTO);
IF @CANTIDAD=0 THEN
	INSERT INTO medicamento(medicamento_nombre,medicamento_alias,medicamento_stock,medicamento_fregistro,medicamento_estatus,medicamento_fechf)
	VALUES(MEDICAMENTO,ALIAS,STOCK,CURDATE(),ESTATUS,FECHA);
	SELECT 1;
ELSE
	SELECT 2;

END IF;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_REGISTRAR_MEDICO` (IN `NOMBRES` VARCHAR(50), IN `APEPAT` VARCHAR(50), IN `APEMAT` VARCHAR(50), IN `DIRECCION` VARCHAR(200), IN `MOVIL` CHAR(12), IN `SANGRE` VARCHAR(255), IN `SEXO` CHAR(2), IN `FECHANACIMIENTO` DATE, IN `NRDOCUMENTO` CHAR(12), IN `COLEGIATURA` CHAR(12), IN `ESPECIALIDAD` INT, IN `USUARIO` VARCHAR(20), IN `CONTRA` VARCHAR(255), IN `ROL` INT, IN `EMAIl` VARCHAR(255))   BEGIN 
DECLARE CANTIDADU INT; 
DECLARE CANTIDADME INT; 
 SET @CANTIDADU:=(SELECT COUNT(*) FROM usuario WHERE usu_nombre=USUARIO); 
 IF @CANTIDADU = 0 THEN
 SET @CANTIDADME:=(SELECT COUNT(*) FROM medico WHERE medico_nrodocumento=NRDOCUMENTO OR medico_colegiatura=COLEGIATURA); 
 IF @CANTIDADME= 0 THEN 
 INSERT INTO usuario(usu_nombre,usu_contrasena,usu_sexo,rol_id,usu_estatus,usu_email,usu_intento) 
 VALUES(USUARIO,CONTRA,SEXO,ROL,'ACTIVO',EMAIL,0); 
 INSERT INTo medico(medico_nombre,medico_apepart,medico_apemart,medico_direccion,medico_movil,sag_id,medico_sexo,medico_fenac,medico_nrodocumento,medico_colegiatura,especialidad_id,usu_id)
  VALUES(NOMBRES,APEPAT,APEMAT,DIRECCION,MOVIL,SANGRE,SEXO,FECHANACIMIENTO,NRDOCUMENTO,COLEGIATURA,ESPECIALIDAD,(SELECT MAX(usu_id) FROM usuario)); 
SELECT 1;
ELSE
SELECT 2;
END IF;
ELSE 
SELECT 2;
END IF;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_REGISTRAR_PACIENTE` (IN `NOMBRE` VARCHAR(50), IN `APEPAT` VARCHAR(50), IN `APEMAT` VARCHAR(50), IN `DIRECCION` VARCHAR(200), IN `MOVIL` CHAR(12), IN `SEXO` CHAR(1), IN `FCHA` DATE, IN `NRDOCUMENTO` CHAR(12), IN `SANGRE` VARCHAR(255))   BEGIN
DECLARE CANTIDAD INT;
SET @CANTIDAD :=(SELECT COUNT(*) FROM paciente where paciente_nrodocumento=NRDOCUMENTO);
IF @CANTIDAD=0 THEN
	INSERT INTO paciente(paciente_nombre,paciente_apepat,paciente_apemat,paciente_direccion,paciente_movil,paciente_sexo,paciente_fenac,paciente_nrodocumento,sag_id,paciente_estatus) VALUES(NOMBRE,APEPAT,APEMAT,DIRECCION,MOVIL,SEXO,FCHA,NRDOCUMENTO,SANGRE,'ACTIVO');
    SELECT 1;
   ELSE
    SELECT 2;
    END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_REGISTRAR_PROCEDIMIENTO` (IN `PROCEDIMIENTO` VARCHAR(50), IN `ESTATUS` VARCHAR(10))   BEGIN
DECLARE CANTIDA INT;
SET @CANTIDAD:=(SELECT count(*) FROM procedimiento WHERE procedimiento_nombre=PROCEDIMIENTO);
IF @CANTIDAD = 0 THEN
 INSERT INTO procedimiento(procedimiento_nombre,procedimiento_fecregistro,procedimiento_estatus)VALUES(PROCEDIMIENTO,CURDATE(),ESTATUS);
 SELECT 1;
ELSE
 SELECT 2;
END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_REGISTRAR_USUARIO` (IN `USU` VARCHAR(20), IN `CONTRA` VARCHAR(250), IN `SEXO` CHAR(1), IN `ROL` INT, IN `EMAIL` VARCHAR(250))   BEGIN
DECLARE CANTIDAD INT;
SET @CANTIDAD:=(SELECT count(*) FROM usuario WHERE usu_nombre= BINARY USU);
IF @CANTIDAD=0 THEN
	INSERT INTO usuario(usu_nombre,usu_contrasena,usu_sexo,rol_id,usu_estatus,usu_email,usu_intento) VALUES (USU,CONTRA,SEXO,ROL,'ACTIVO',EMAIL,0);
	SELECT 1;
ELSE
	SELECT 2;
END IF;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_REGRISTRAR_DETALLE_INSUMO` (IN `IDFUA` INT, IN `IDINSUMO` INT, IN `CANTIDADINSUMO` INT)   INSERT INTO detalle_insumo(fua_id,insumo_id,detain_cantidad)values(IDFUA,IDINSUMO,CANTIDADINSUMO)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_REGRISTRAR_DETALLE_MEDICAMENTO` (IN `IDFUA` INT, IN `IDMEDICAMENTO` INT, IN `CANTIDAD` INT)   INSERT INTO detalle_medicamento(fua_id,medicamento_id,detame_cantidad)values(IDFUA,IDMEDICAMENTO,CANTIDAD)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_REGRISTRAR_DETALLE_PROCEDIMIENTO` (IN `ID` INT, IN `IDPROCEDIMIENTO` INT)   INSERT INTO detalle_procedimiento(fua_id,procedimiento_id)values(ID,IDPROCEDIMIENTO)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_REGRISTRAR_FUA` (IN `IDHISTORIAL` INT, IN `IDCONSULTA` INT)   BEGIN
	INSERT INTO fua(fua_fegistro,historia_id,consulta_id)VALUES(CURDATE(),IDHISTORIAL,IDCONSULTA);
	SELECT LAST_INSERT_ID();

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_RETABLECER_CONTRA` (IN `EMAIL` VARCHAR(255), IN `CONTRA` VARCHAR(255))   BEGIN
DECLARE  CANTIDAD INT;
SET @CANTIDAD:=(SELECT COUNT(*) FROM usuario WHERE usu_email=EMAIL);
IF @CANTIDAD>0 THEN
	
	UPDATE usuario SET 
	usu_contrasena=CONTRA, 
	usu_intento=0
	WHERE usu_email=EMAIL;
	
	SELECT 1;
ELSE
	
	SELECT 2;
END IF;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_TRAER_STOCK_INSUMO_H` (IN `ID` INT)   SELECT
	insumo.insumo_id, 
	insumo.insumo_stock
FROM
	insumo
	WHERE insumo.insumo_id=ID$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_TRAER_STOCK_MEDICAMENTO_H` (IN `ID` INT)   SELECT
	medicamento.medicamento_nombre, 
	medicamento.medicamento_stock
FROM
	medicamento
	WHERE medicamento.medicamento_id=ID$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_VERIFICAR_USUARIO` (IN `USUARIO` VARCHAR(20))   SELECT
	usuario.usu_id, 
	usuario.usu_nombre, 
	usuario.usu_contrasena, 
	usuario.usu_sexo, 
	usuario.rol_id, 
	usuario.usu_estatus, 
	rol.rol_nombre,
	usuario.usu_intento
FROM
	usuario
	INNER JOIN rol ON usuario.rol_id = rol .rol_id
	WHERE usu_nombre = BINARY USUARIO$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `auditoria`
--

CREATE TABLE `auditoria` (
  `audi_id` int(11) NOT NULL,
  `fecha` date DEFAULT NULL,
  `accion` varchar(100) COLLATE utf8_spanish_ci DEFAULT NULL,
  `usu_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci ROW_FORMAT=DYNAMIC;

--
-- Volcado de datos para la tabla `auditoria`
--

INSERT INTO `auditoria` (`audi_id`, `fecha`, `accion`, `usu_id`) VALUES
(10, '2022-06-20', 'Se inserto un nuevo usuario', 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cita`
--

CREATE TABLE `cita` (
  `cita_id` int(11) NOT NULL,
  `cita_nroatencion` int(11) DEFAULT NULL,
  `cita_feregistro` date DEFAULT NULL,
  `medico_id` int(11) DEFAULT NULL,
  `especialidad_id` int(11) DEFAULT NULL,
  `paciente_id` int(11) DEFAULT NULL,
  `cita_estatus` enum('PENDIENTE','CANCELADA','ATENDIDA') COLLATE utf8_spanish_ci NOT NULL,
  `cita_descripcion` text COLLATE utf8_spanish_ci NOT NULL,
  `usu_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci ROW_FORMAT=DYNAMIC;

--
-- Volcado de datos para la tabla `cita`
--

INSERT INTO `cita` (`cita_id`, `cita_nroatencion`, `cita_feregistro`, `medico_id`, `especialidad_id`, `paciente_id`, `cita_estatus`, `cita_descripcion`, `usu_id`) VALUES
(1, 1, '2022-06-20', 1, 3, 1, 'ATENDIDA', 'malestar', 5);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `consulta`
--

CREATE TABLE `consulta` (
  `consulta_id` int(11) NOT NULL,
  `consulta_descripcion` text COLLATE utf8_spanish_ci DEFAULT NULL,
  `consulta_diagnostico` text COLLATE utf8_spanish_ci DEFAULT NULL,
  `consulta_feregistro` date DEFAULT NULL,
  `consulta_estatus` enum('ATENDIDA','PENDIENTE') COLLATE utf8_spanish_ci DEFAULT NULL,
  `cita_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci ROW_FORMAT=DYNAMIC;

--
-- Volcado de datos para la tabla `consulta`
--

INSERT INTO `consulta` (`consulta_id`, `consulta_descripcion`, `consulta_diagnostico`, `consulta_feregistro`, `consulta_estatus`, `cita_id`) VALUES
(1, 'vino por un malestar', 'se le dio descaso he ibuprofeno', '2022-06-19', 'ATENDIDA', 1),
(2, 'dfdf', 'dfd', '2022-06-20', 'ATENDIDA', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_insumo`
--

CREATE TABLE `detalle_insumo` (
  `detain_id` int(11) NOT NULL,
  `detain_cantidad` int(11) DEFAULT NULL,
  `insumo_id` int(11) DEFAULT NULL,
  `fua_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci ROW_FORMAT=DYNAMIC;

--
-- Disparadores `detalle_insumo`
--
DELIMITER $$
CREATE TRIGGER `TR_STOCK_INSUMO` AFTER INSERT ON `detalle_insumo` FOR EACH ROW BEGIN
DECLARE STOCKACTUAL DECIMAL(10,2);
SET @STOCKACTUAL:=(SELECT insumo_stock FROM insumo WHERE insumo_id=new.insumo_id);
UPDATE insumo SET
insumo_stock=@STOCKACTUAL-new.detain_cantidad
WHERE insumo_id=new.insumo_id;

END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_medicamento`
--

CREATE TABLE `detalle_medicamento` (
  `detame_id` int(11) NOT NULL,
  `detame_cantidad` int(11) DEFAULT NULL,
  `medicamento_id` int(11) DEFAULT NULL,
  `fua_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci ROW_FORMAT=DYNAMIC;

--
-- Volcado de datos para la tabla `detalle_medicamento`
--

INSERT INTO `detalle_medicamento` (`detame_id`, `detame_cantidad`, `medicamento_id`, `fua_id`) VALUES
(1, 1, 5, 1),
(2, 2, 3, 2),
(3, 2, 1, 3),
(4, 30, 7, 5);

--
-- Disparadores `detalle_medicamento`
--
DELIMITER $$
CREATE TRIGGER `TR_SCTOK_MEDICAMENTO` AFTER INSERT ON `detalle_medicamento` FOR EACH ROW BEGIN
DECLARE STOCKACTUAL DECIMAL(10,2);
SET @STOCKACTUAL:=(SELECT medicamento_stock FROM medicamento WHERE medicamento_id=new.medicamento_id);
UPDATE medicamento SET
medicamento_stock=@STOCKACTUAL-new.detame_cantidad
WHERE medicamento_id=new.medicamento_id;

END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `TR_STATUS_MEDICAMENTO` AFTER INSERT ON `detalle_medicamento` FOR EACH ROW BEGIN
DECLARE STOCKACTUAL INT;
SET @STOCKACTUAL:=(SELECT medicamento_stock FROM medicamento WHERE medicamento_id=new.medicamento_id);
	IF @STOCKACTUAL=0 THEN
		UPDATE medicamento SET
		medicamento_estatus='AGOTADO'
		WHERE medicamento_id=new.medicamento_id;
	END IF;
	
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_procedimiento`
--

CREATE TABLE `detalle_procedimiento` (
  `detaproce_id` int(11) NOT NULL,
  `procedimiento_id` int(11) DEFAULT NULL,
  `fua_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `donaciones`
--

CREATE TABLE `donaciones` (
  `dona_id` int(11) NOT NULL,
  `paciente_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `especialidad`
--

CREATE TABLE `especialidad` (
  `especialidad_id` int(11) NOT NULL,
  `especialidad_nombre` varchar(50) COLLATE utf8_spanish_ci DEFAULT NULL,
  `especialidad_fregistro` date DEFAULT NULL,
  `especialidad_estatus` enum('ACTIVO','INACTIVO') COLLATE utf8_spanish_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci ROW_FORMAT=DYNAMIC;

--
-- Volcado de datos para la tabla `especialidad`
--

INSERT INTO `especialidad` (`especialidad_id`, `especialidad_nombre`, `especialidad_fregistro`, `especialidad_estatus`) VALUES
(2, 'ginecologia', '2021-11-03', 'ACTIVO'),
(3, 'pediactria', '2021-11-03', 'ACTIVO'),
(4, 'sexologia', '2021-11-05', 'ACTIVO'),
(5, 'fisioterapia', '2021-11-05', 'ACTIVO'),
(6, 'terapia', '2021-11-05', 'ACTIVO');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `fua`
--

CREATE TABLE `fua` (
  `fua_id` int(11) NOT NULL,
  `fua_fegistro` date DEFAULT NULL,
  `historia_id` int(11) DEFAULT NULL,
  `consulta_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci ROW_FORMAT=DYNAMIC;

--
-- Volcado de datos para la tabla `fua`
--

INSERT INTO `fua` (`fua_id`, `fua_fegistro`, `historia_id`, `consulta_id`) VALUES
(1, '2022-06-19', 1, 1),
(2, '2022-06-19', 1, 1),
(3, '2022-06-19', 1, 1),
(4, '2022-06-20', 1, 2),
(5, '2022-06-20', 1, 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `historia`
--

CREATE TABLE `historia` (
  `historia_id` int(11) NOT NULL,
  `paciente_id` int(11) DEFAULT NULL,
  `historia_feregistro` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci ROW_FORMAT=DYNAMIC;

--
-- Volcado de datos para la tabla `historia`
--

INSERT INTO `historia` (`historia_id`, `paciente_id`, `historia_feregistro`) VALUES
(1, 1, '2022-06-19');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `insumo`
--

CREATE TABLE `insumo` (
  `insumo_id` int(11) NOT NULL,
  `insumo_nombre` varchar(50) COLLATE utf8_spanish_ci DEFAULT NULL,
  `insumo_stock` int(11) DEFAULT NULL,
  `insumo_fregistro` date DEFAULT NULL,
  `insumo_estatus` enum('ACTIVO','INACTIVO','AGOTADO') COLLATE utf8_spanish_ci DEFAULT NULL,
  `insumo_fechf` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci ROW_FORMAT=DYNAMIC;

--
-- Volcado de datos para la tabla `insumo`
--

INSERT INTO `insumo` (`insumo_id`, `insumo_nombre`, `insumo_stock`, `insumo_fregistro`, `insumo_estatus`, `insumo_fechf`) VALUES
(1, 'GUANTES', 0, '2021-10-24', 'INACTIVO', '2022-06-09'),
(2, 'JRINGAS', 0, '2021-10-24', 'INACTIVO', '2022-07-07'),
(3, 'AGUJAS', 0, '2021-10-24', 'INACTIVO', '2022-06-09'),
(4, 'MASCARILLAS', 23, '2021-10-24', 'ACTIVO', '2022-06-07'),
(5, 'PINZAS', 12, '2021-10-24', 'ACTIVO', '2022-06-16'),
(6, 'ADHESIVOS', 10, '2021-10-24', 'INACTIVO', '2022-06-09'),
(11, 'VENDA', 15, '2021-10-25', 'ACTIVO', '2022-06-22'),
(12, 'Tapa Bocas', 2, '2022-03-27', 'ACTIVO', '2022-06-08'),
(13, 'GASAS', 10, '2022-03-27', 'ACTIVO', '2022-06-08'),
(14, 'Jeringa', 12, '2022-06-09', 'ACTIVO', '2022-06-15'),
(15, 'Jeringas', 23, '2022-06-09', 'ACTIVO', '2023-06-08');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `medicamento`
--

CREATE TABLE `medicamento` (
  `medicamento_id` int(11) NOT NULL,
  `medicamento_nombre` varchar(50) COLLATE utf8_spanish_ci DEFAULT NULL,
  `medicamento_alias` varchar(50) COLLATE utf8_spanish_ci DEFAULT NULL,
  `medicamento_stock` int(11) DEFAULT NULL,
  `medicamento_fregistro` date DEFAULT NULL,
  `medicamento_estatus` enum('ACTIVO','INACTIVO','AGOTADO') COLLATE utf8_spanish_ci DEFAULT NULL,
  `medicamento_fechf` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci ROW_FORMAT=DYNAMIC;

--
-- Volcado de datos para la tabla `medicamento`
--

INSERT INTO `medicamento` (`medicamento_id`, `medicamento_nombre`, `medicamento_alias`, `medicamento_stock`, `medicamento_fregistro`, `medicamento_estatus`, `medicamento_fechf`) VALUES
(1, 'Loratadina', 'vera', 0, '2022-03-30', 'INACTIVO', '2022-06-09'),
(2, 'somatostatina', 'soma', 0, '2022-03-30', 'INACTIVO', '2022-06-29'),
(3, 'paracetamol', 'para', 0, '2022-03-30', 'ACTIVO', '2022-06-29'),
(4, 'verapamilloo', 've', 0, '2022-04-01', 'ACTIVO', '2022-06-29'),
(5, 'ibuprofeno', 'ibu', 0, '2022-04-01', 'ACTIVO', '2022-06-30'),
(6, 'acetaminofen', 'ace', 0, '2022-04-01', 'ACTIVO', '2022-06-28'),
(7, 'esomepraxol', 'eso', 0, '2022-06-10', 'ACTIVO', '2022-06-28'),
(8, 'losatan', 'lo', 0, '2022-06-10', 'ACTIVO', '2022-06-17'),
(9, 'valtasa', 'val', 0, '2022-06-10', 'ACTIVO', '2022-06-09');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `medico`
--

CREATE TABLE `medico` (
  `medico_id` int(11) NOT NULL,
  `medico_nombre` varchar(50) COLLATE utf8_spanish_ci DEFAULT NULL,
  `medico_apepart` varchar(50) COLLATE utf8_spanish_ci DEFAULT NULL,
  `medico_apemart` varchar(50) COLLATE utf8_spanish_ci DEFAULT NULL,
  `medico_direccion` varchar(200) COLLATE utf8_spanish_ci DEFAULT NULL,
  `medico_movil` char(12) COLLATE utf8_spanish_ci DEFAULT NULL,
  `medico_sexo` char(1) COLLATE utf8_spanish_ci DEFAULT NULL,
  `medico_fenac` date DEFAULT NULL,
  `medico_nrodocumento` char(12) COLLATE utf8_spanish_ci DEFAULT NULL,
  `medico_colegiatura` char(12) COLLATE utf8_spanish_ci DEFAULT NULL,
  `especialidad_id` int(11) NOT NULL,
  `usu_id` int(11) NOT NULL,
  `sag_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci ROW_FORMAT=DYNAMIC;

--
-- Volcado de datos para la tabla `medico`
--

INSERT INTO `medico` (`medico_id`, `medico_nombre`, `medico_apepart`, `medico_apemart`, `medico_direccion`, `medico_movil`, `medico_sexo`, `medico_fenac`, `medico_nrodocumento`, `medico_colegiatura`, `especialidad_id`, `usu_id`, `sag_id`) VALUES
(1, 'andrew', 'contreras', 'contreras', 'Las flores', '04162204090', 'M', '2022-05-03', '26309450', '222333', 3, 45, 4),
(2, 'nestor', 'Guerrero', 'Contrera', 'Unidad vecinal', '04246338650', 'M', '1998-04-09', '14348333', '3344433', 5, 46, 5);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `paciente`
--

CREATE TABLE `paciente` (
  `paciente_id` int(11) NOT NULL,
  `paciente_nombre` varchar(50) COLLATE utf8_spanish_ci DEFAULT NULL,
  `paciente_apepat` varchar(50) COLLATE utf8_spanish_ci DEFAULT NULL,
  `paciente_apemat` varchar(50) COLLATE utf8_spanish_ci DEFAULT NULL,
  `paciente_direccion` varchar(200) COLLATE utf8_spanish_ci DEFAULT NULL,
  `paciente_movil` char(12) COLLATE utf8_spanish_ci DEFAULT NULL,
  `paciente_sexo` char(1) COLLATE utf8_spanish_ci DEFAULT NULL,
  `paciente_fenac` date DEFAULT NULL,
  `paciente_nrodocumento` char(12) COLLATE utf8_spanish_ci DEFAULT NULL,
  `paciente_estatus` enum('ACTIVO','INACTIVO') COLLATE utf8_spanish_ci DEFAULT NULL,
  `sag_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci ROW_FORMAT=DYNAMIC;

--
-- Volcado de datos para la tabla `paciente`
--

INSERT INTO `paciente` (`paciente_id`, `paciente_nombre`, `paciente_apepat`, `paciente_apemat`, `paciente_direccion`, `paciente_movil`, `paciente_sexo`, `paciente_fenac`, `paciente_nrodocumento`, `paciente_estatus`, `sag_id`) VALUES
(1, 'Andrew', 'Contreras', 'Valero', 'Las flores', '04246338650', 'M', '1998-05-15', '26309450', 'ACTIVO', 2);

--
-- Disparadores `paciente`
--
DELIMITER $$
CREATE TRIGGER `TR_CREAR_HISTORIA` AFTER INSERT ON `paciente` FOR EACH ROW INSERT INTO 
historia(paciente_id,historia_feregistro)
VALUES (new.paciente_id,curdate())
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `procedimiento`
--

CREATE TABLE `procedimiento` (
  `procedimiento_id` int(11) NOT NULL,
  `procedimiento_nombre` varchar(50) COLLATE utf8_spanish_ci DEFAULT NULL,
  `procedimiento_fecregistro` date DEFAULT NULL,
  `procedimiento_estatus` enum('ACTIVO','INACTIVO') COLLATE utf8_spanish_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci ROW_FORMAT=DYNAMIC;

--
-- Volcado de datos para la tabla `procedimiento`
--

INSERT INTO `procedimiento` (`procedimiento_id`, `procedimiento_nombre`, `procedimiento_fecregistro`, `procedimiento_estatus`) VALUES
(1, 'Auscultacion', '2021-10-24', 'ACTIVO'),
(2, 'Inspección médica', '2021-10-24', 'ACTIVO'),
(3, 'Palpación', '2021-10-24', 'ACTIVO'),
(4, 'Percusión(médica)', '2021-10-24', 'ACTIVO'),
(5, 'Medición de signos vitales', '2021-10-24', 'ACTIVO'),
(6, 'Electromiografia', '2021-10-24', 'ACTIVO'),
(7, 'Electrocardiografia', '2021-10-24', 'ACTIVO'),
(8, 'Masaje', '2021-10-24', 'ACTIVO'),
(9, 'sexologia', '2022-03-26', 'ACTIVO'),
(10, 'palpasión', '2022-03-26', 'ACTIVO'),
(11, 'loca', '2022-03-26', 'ACTIVO');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `restaurar`
--

CREATE TABLE `restaurar` (
  `rest_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `rol`
--

CREATE TABLE `rol` (
  `rol_id` int(11) NOT NULL,
  `rol_nombre` varchar(30) COLLATE utf8_spanish_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci ROW_FORMAT=DYNAMIC;

--
-- Volcado de datos para la tabla `rol`
--

INSERT INTO `rol` (`rol_id`, `rol_nombre`) VALUES
(1, 'ADMINISTRADOR'),
(2, 'RECEPCIONISTA'),
(3, 'MEDICO');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sangre`
--

CREATE TABLE `sangre` (
  `sag_id` int(11) NOT NULL,
  `tp_sangre` varchar(255) COLLATE utf8_spanish_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci ROW_FORMAT=DYNAMIC;

--
-- Volcado de datos para la tabla `sangre`
--

INSERT INTO `sangre` (`sag_id`, `tp_sangre`) VALUES
(1, 'A+'),
(2, 'A-'),
(3, 'B+'),
(4, 'B-'),
(5, 'AB+'),
(6, 'AB-'),
(7, 'O+'),
(8, 'O-');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE `usuario` (
  `usu_id` int(11) NOT NULL,
  `usu_nombre` varchar(20) COLLATE utf8_spanish_ci DEFAULT NULL,
  `usu_contrasena` varchar(255) COLLATE utf8_spanish_ci DEFAULT NULL,
  `usu_sexo` char(1) COLLATE utf8_spanish_ci DEFAULT NULL,
  `rol_id` int(11) DEFAULT NULL,
  `usu_estatus` enum('ACTIVO','INATIVO') COLLATE utf8_spanish_ci DEFAULT NULL,
  `usu_email` varchar(255) COLLATE utf8_spanish_ci DEFAULT NULL,
  `usu_intento` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci ROW_FORMAT=DYNAMIC;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`usu_id`, `usu_nombre`, `usu_contrasena`, `usu_sexo`, `rol_id`, `usu_estatus`, `usu_email`, `usu_intento`) VALUES
(5, 'vero', '$2y$10$GU9cYfZJT/Z9Twm8EA8VBu/eS8PFTx5Rn5g5ml9YE5cFjlCo3rfOa', 'F', 1, 'ACTIVO', '', 1),
(45, 'andrew', '$2y$10$.82mx3k7avhJ32yZiMqwOeKfevfMwpy1dmj4v4aBYSRHoVNRCNbZq', 'M', 3, 'ACTIVO', 'andrew.contrera2012@gmail.com', 0),
(46, 'nestor', '$2y$10$daE2a1NjU5jgPK.QgS58g.aPZTajqVx6O/5WI9vvmr5PfMEXLrWNG', 'F', 3, 'ACTIVO', 'nestor.contrera2022@gmail.com', 0),
(47, 'betania', '123', 'M', 3, 'ACTIVO', 'betania.contrera2012@gmail.com', 0),
(48, 'betzaida', '$2y$10$9SS1Ksy.nH2VqX5jnj0xFu.DzBtL205To/VjXATCWkhVjQUcVnyRu', 'M', 2, 'ACTIVO', 'betzaida.contrera2012@gmail.com', 0);

--
-- Disparadores `usuario`
--
DELIMITER $$
CREATE TRIGGER `TRIGGER_INSERT_USUARIO` AFTER INSERT ON `usuario` FOR EACH ROW INSERT INTO auditoria(usu_id,fecha,accion)
VALUES (CURRENT_USER(),NOW(),"Se inserto un nuevo usuario")
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `TR_DELETE_USUARIO` AFTER INSERT ON `usuario` FOR EACH ROW INSERT INTO auditoria(usuario,fecha,accion)
VALUES (CURRENT_USER(),NOW(),"Se ha eliminado un nuevo usuario")
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `TR_UPDATE_USUARIO` AFTER UPDATE ON `usuario` FOR EACH ROW INSERT INTO auditoria(usu_id,fecha,accion)
VALUES (CURRENT_USER(),NOW(),"Se inserto un nuevo usuario")
$$
DELIMITER ;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `auditoria`
--
ALTER TABLE `auditoria`
  ADD PRIMARY KEY (`audi_id`) USING BTREE,
  ADD KEY `usu_id` (`usu_id`);

--
-- Indices de la tabla `cita`
--
ALTER TABLE `cita`
  ADD PRIMARY KEY (`cita_id`) USING BTREE,
  ADD KEY `paciente_id` (`paciente_id`) USING BTREE,
  ADD KEY `medico_id` (`medico_id`) USING BTREE,
  ADD KEY `especialidad_id` (`especialidad_id`) USING BTREE,
  ADD KEY `usu_id` (`usu_id`) USING BTREE;

--
-- Indices de la tabla `consulta`
--
ALTER TABLE `consulta`
  ADD PRIMARY KEY (`consulta_id`) USING BTREE,
  ADD KEY `cita_id` (`cita_id`) USING BTREE;

--
-- Indices de la tabla `detalle_insumo`
--
ALTER TABLE `detalle_insumo`
  ADD PRIMARY KEY (`detain_id`) USING BTREE,
  ADD KEY `fua_id` (`fua_id`) USING BTREE,
  ADD KEY `insumo_id` (`insumo_id`) USING BTREE;

--
-- Indices de la tabla `detalle_medicamento`
--
ALTER TABLE `detalle_medicamento`
  ADD PRIMARY KEY (`detame_id`) USING BTREE,
  ADD KEY `medicamento_id` (`medicamento_id`) USING BTREE,
  ADD KEY `fua_id` (`fua_id`) USING BTREE;

--
-- Indices de la tabla `detalle_procedimiento`
--
ALTER TABLE `detalle_procedimiento`
  ADD PRIMARY KEY (`detaproce_id`) USING BTREE,
  ADD KEY `fua_id` (`fua_id`) USING BTREE,
  ADD KEY `procedimiento_id` (`procedimiento_id`) USING BTREE;

--
-- Indices de la tabla `donaciones`
--
ALTER TABLE `donaciones`
  ADD PRIMARY KEY (`dona_id`) USING BTREE,
  ADD KEY `paciente_id` (`paciente_id`) USING BTREE;

--
-- Indices de la tabla `especialidad`
--
ALTER TABLE `especialidad`
  ADD PRIMARY KEY (`especialidad_id`) USING BTREE;

--
-- Indices de la tabla `fua`
--
ALTER TABLE `fua`
  ADD PRIMARY KEY (`fua_id`) USING BTREE,
  ADD KEY `historia_id` (`historia_id`) USING BTREE,
  ADD KEY `consulta_id` (`consulta_id`) USING BTREE;

--
-- Indices de la tabla `historia`
--
ALTER TABLE `historia`
  ADD PRIMARY KEY (`historia_id`) USING BTREE,
  ADD KEY `paciente_id` (`paciente_id`) USING BTREE;

--
-- Indices de la tabla `insumo`
--
ALTER TABLE `insumo`
  ADD PRIMARY KEY (`insumo_id`) USING BTREE;

--
-- Indices de la tabla `medicamento`
--
ALTER TABLE `medicamento`
  ADD PRIMARY KEY (`medicamento_id`) USING BTREE;

--
-- Indices de la tabla `medico`
--
ALTER TABLE `medico`
  ADD PRIMARY KEY (`medico_id`) USING BTREE,
  ADD KEY `usu_id` (`usu_id`) USING BTREE,
  ADD KEY `FK_especialidad` (`especialidad_id`) USING BTREE,
  ADD KEY `sag_id` (`sag_id`);

--
-- Indices de la tabla `paciente`
--
ALTER TABLE `paciente`
  ADD PRIMARY KEY (`paciente_id`) USING BTREE,
  ADD KEY `sag_id` (`sag_id`);

--
-- Indices de la tabla `procedimiento`
--
ALTER TABLE `procedimiento`
  ADD PRIMARY KEY (`procedimiento_id`) USING BTREE;

--
-- Indices de la tabla `restaurar`
--
ALTER TABLE `restaurar`
  ADD PRIMARY KEY (`rest_id`) USING BTREE;

--
-- Indices de la tabla `rol`
--
ALTER TABLE `rol`
  ADD PRIMARY KEY (`rol_id`) USING BTREE;

--
-- Indices de la tabla `sangre`
--
ALTER TABLE `sangre`
  ADD PRIMARY KEY (`sag_id`) USING BTREE;

--
-- Indices de la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`usu_id`) USING BTREE,
  ADD KEY `rol_id` (`rol_id`) USING BTREE;

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `auditoria`
--
ALTER TABLE `auditoria`
  MODIFY `audi_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `cita`
--
ALTER TABLE `cita`
  MODIFY `cita_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `consulta`
--
ALTER TABLE `consulta`
  MODIFY `consulta_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `detalle_insumo`
--
ALTER TABLE `detalle_insumo`
  MODIFY `detain_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `detalle_medicamento`
--
ALTER TABLE `detalle_medicamento`
  MODIFY `detame_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `detalle_procedimiento`
--
ALTER TABLE `detalle_procedimiento`
  MODIFY `detaproce_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `donaciones`
--
ALTER TABLE `donaciones`
  MODIFY `dona_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `especialidad`
--
ALTER TABLE `especialidad`
  MODIFY `especialidad_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `fua`
--
ALTER TABLE `fua`
  MODIFY `fua_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `historia`
--
ALTER TABLE `historia`
  MODIFY `historia_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `insumo`
--
ALTER TABLE `insumo`
  MODIFY `insumo_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT de la tabla `medicamento`
--
ALTER TABLE `medicamento`
  MODIFY `medicamento_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `medico`
--
ALTER TABLE `medico`
  MODIFY `medico_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `paciente`
--
ALTER TABLE `paciente`
  MODIFY `paciente_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `procedimiento`
--
ALTER TABLE `procedimiento`
  MODIFY `procedimiento_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT de la tabla `restaurar`
--
ALTER TABLE `restaurar`
  MODIFY `rest_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `sangre`
--
ALTER TABLE `sangre`
  MODIFY `sag_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `usuario`
--
ALTER TABLE `usuario`
  MODIFY `usu_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=49;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `cita`
--
ALTER TABLE `cita`
  ADD CONSTRAINT `cita_ibfk_1` FOREIGN KEY (`medico_id`) REFERENCES `medico` (`medico_id`),
  ADD CONSTRAINT `cita_ibfk_2` FOREIGN KEY (`especialidad_id`) REFERENCES `especialidad` (`especialidad_id`),
  ADD CONSTRAINT `cita_ibfk_3` FOREIGN KEY (`paciente_id`) REFERENCES `paciente` (`paciente_id`),
  ADD CONSTRAINT `cita_ibfk_4` FOREIGN KEY (`usu_id`) REFERENCES `usuario` (`usu_id`);

--
-- Filtros para la tabla `consulta`
--
ALTER TABLE `consulta`
  ADD CONSTRAINT `consulta_ibfk_1` FOREIGN KEY (`cita_id`) REFERENCES `cita` (`cita_id`);

--
-- Filtros para la tabla `detalle_insumo`
--
ALTER TABLE `detalle_insumo`
  ADD CONSTRAINT `detalle_insumo_ibfk_1` FOREIGN KEY (`insumo_id`) REFERENCES `insumo` (`insumo_id`),
  ADD CONSTRAINT `detalle_insumo_ibfk_2` FOREIGN KEY (`fua_id`) REFERENCES `fua` (`fua_id`);

--
-- Filtros para la tabla `detalle_medicamento`
--
ALTER TABLE `detalle_medicamento`
  ADD CONSTRAINT `detalle_medicamento_ibfk_1` FOREIGN KEY (`medicamento_id`) REFERENCES `medicamento` (`medicamento_id`),
  ADD CONSTRAINT `detalle_medicamento_ibfk_2` FOREIGN KEY (`fua_id`) REFERENCES `fua` (`fua_id`);

--
-- Filtros para la tabla `detalle_procedimiento`
--
ALTER TABLE `detalle_procedimiento`
  ADD CONSTRAINT `detalle_procedimiento_ibfk_1` FOREIGN KEY (`procedimiento_id`) REFERENCES `procedimiento` (`procedimiento_id`),
  ADD CONSTRAINT `detalle_procedimiento_ibfk_2` FOREIGN KEY (`fua_id`) REFERENCES `fua` (`fua_id`);

--
-- Filtros para la tabla `donaciones`
--
ALTER TABLE `donaciones`
  ADD CONSTRAINT `donaciones_ibfk_1` FOREIGN KEY (`paciente_id`) REFERENCES `paciente` (`paciente_id`);

--
-- Filtros para la tabla `fua`
--
ALTER TABLE `fua`
  ADD CONSTRAINT `fua_ibfk_1` FOREIGN KEY (`historia_id`) REFERENCES `historia` (`historia_id`),
  ADD CONSTRAINT `fua_ibfk_2` FOREIGN KEY (`consulta_id`) REFERENCES `consulta` (`consulta_id`);

--
-- Filtros para la tabla `historia`
--
ALTER TABLE `historia`
  ADD CONSTRAINT `historia_ibfk_1` FOREIGN KEY (`paciente_id`) REFERENCES `paciente` (`paciente_id`);

--
-- Filtros para la tabla `medico`
--
ALTER TABLE `medico`
  ADD CONSTRAINT `medico_ibfk_1` FOREIGN KEY (`especialidad_id`) REFERENCES `especialidad` (`especialidad_id`),
  ADD CONSTRAINT `medico_ibfk_2` FOREIGN KEY (`usu_id`) REFERENCES `usuario` (`usu_id`),
  ADD CONSTRAINT `medico_ibfk_3` FOREIGN KEY (`sag_id`) REFERENCES `sangre` (`sag_id`);

--
-- Filtros para la tabla `paciente`
--
ALTER TABLE `paciente`
  ADD CONSTRAINT `paciente_ibfk_1` FOREIGN KEY (`sag_id`) REFERENCES `sangre` (`sag_id`);

--
-- Filtros para la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD CONSTRAINT `usuario_ibfk_1` FOREIGN KEY (`rol_id`) REFERENCES `rol` (`rol_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
