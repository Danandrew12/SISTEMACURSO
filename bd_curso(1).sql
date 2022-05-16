-- phpMyAdmin SQL Dump
-- version 4.7.0
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 02-05-2022 a las 22:54:45
-- Versión del servidor: 5.7.17
-- Versión de PHP: 7.1.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
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
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_INTENTO_USUARIO` (IN `USUARIO` VARCHAR(50))  BEGIN
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_LISTAR_CITA` ()  SELECT c.cita_id,c.cita_nroatencion,c.cita_feregistro,c.cita_estatus,p.paciente_id,concat_ws(' ',p.paciente_nombre,p.paciente_apepat,p.paciente_apemat) as paciente,c.medico_id,concat_ws(' ',m.medico_nombre,m.medico_apepart,m.medico_apemart) as medico, e.especialidad_id, e.especialidad_nombre, c.cita_descripcion 
FROM cita as c 
INNER JOIN paciente as p ON c.paciente_id=p.paciente_id
INNER JOIN medico as m on c.medico_id=m.medico_id
INNER JOIN especialidad as e ON e.especialidad_id=m.especialidad_id
ORDER BY cita_id DESC$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_LISTAR_COMBO_ESPECIALIDAD` ()  SELECT * FROM especialidad WHERE especialidad_estatus='ACTIVO'$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_LISTAR_COMBO_ROL` ()  SELECT
	rol.rol_id, 
	rol.rol_nombre
FROM
	rol$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_LISTAR_CONSULTA` (IN `FECHAINICIO` DATE, IN `FECHAFIN` DATE)  SELECT
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_LISTAR_CONSULTA_HISTORIAL` ()  SELECT
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_LISTAR_DOCTOR_COMBO` (IN `ID` INT)  SELECT `medico_id`,concat_ws(' ',`medico_nombre`,`medico_apepart`,`medico_apemart`)FROM medico where `especialidad_id` = ID$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_LISTAR_ESPECIALIDAD` ()  SELECT * FROM especialidad$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_LISTAR_ESPECIALIDAD_COMBO` ()  SELECT especialidad_id,especialidad_nombre FROM especialidad$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_LISTAR_HISTORIAL` (IN `FECHAINICIO` DATE, IN `FECHAFIN` DATE)  SELECT
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_LISTAR_INSUMO` ()  SELECT * FROM insumo$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_LISTAR_INSUMO_COMBO` ()  SELECT
	insumo.insumo_id, 
	insumo.insumo_nombre
FROM
	insumo$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_LISTAR_INSUMO_DETALLE` (IN `IDFUA` INT)  SELECT
	insumo.insumo_nombre, 
	detalle_insumo.detain_cantidad
FROM
	detalle_insumo
	INNER JOIN
	insumo
	ON 
		detalle_insumo.insumo_id = insumo.insumo_id
		WHERE detalle_insumo.fua_id=IDFUA$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_LISTAR_MEDICAMENTO` ()  SELECT * FROM medicamento$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_LISTAR_MEDICAMENTO_COMBO` ()  SELECT
	medicamento.medicamento_id, 
	medicamento.medicamento_nombre
FROM
	medicamento$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_LISTAR_MEDICAMENTO_DETALLE` (IN `IDFUA` INT)  SELECT
	medicamento.medicamento_nombre, 
	detalle_medicamento.detame_cantidad
FROM
	detalle_medicamento
	INNER JOIN
	medicamento
	ON 
		detalle_medicamento.medicamento_id = medicamento.medicamento_id
		WHERE detalle_medicamento.fua_id=IDFUA$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_LISTAR_MEDICO` ()  SELECT
medico.medico_id,
medico.medico_nombre,
medico.medico_apepart,
medico.medico_apemart,
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
usuario.usu_email
FROM
medico
INNER JOIN especialidad ON medico.especialidad_id= especialidad.especialidad_id
INNER JOIN usuario ON medico.usu_id = usuario.usu_id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_LISTAR_PACIENTE` ()  SELECT
CONCAT_WS(' ',paciente_nombre,paciente_apepat,paciente_apemat) as paciente,
paciente.paciente_id,
paciente.paciente_nombre,
paciente.paciente_apepat,
paciente.paciente_apemat,
paciente.paciente_direccion,
paciente.paciente_movil,
paciente.paciente_sexo,
paciente.paciente_nrodocumento,
paciente.paciente_estatus
FROM
paciente$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_LISTAR_PACIENTE_CITA` ()  SELECT
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_LISTAR_PACIENTE_COMBO` ()  SELECT paciente_id,concat_ws(' ',paciente_nombre,paciente_apepat,paciente_apemat) FROM paciente$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_LISTAR_PROCEDIMIENTO` ()  SELECT * FROM procedimiento$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_LISTAR_PROCEDIMIENTO_COMBO` ()  SELECT
	procedimiento.procedimiento_id, 
	procedimiento.procedimiento_nombre
FROM
	procedimiento$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_LISTAR_PROCEDIMIENTO_DETALLE` (IN `IDFUA` INT)  SELECT
	procedimiento.procedimiento_nombre
FROM
	detalle_procedimiento
	INNER JOIN
	procedimiento
	ON 
		detalle_procedimiento.procedimiento_id = procedimiento.procedimiento_id
		WHERE detalle_procedimiento.fua_id=IDFUA$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_LISTAR_USUARIO` ()  BEGIN
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_MODIFICAR_CITA` (IN `IDCITA` INT, IN `IDPACIENTE` INT, IN `IDDOCTOR` INT, IN `IDESPECIALIDAD` INT, IN `DESCRIPCION` TEXT, IN `ESTATUS` VARCHAR(10))  UPDATE cita SET
paciente_id=IDPACIENTE,
medico_id=IDDOCTOR,
especialidad_id=IDESPECIALIDAD,
cita_descripcion=DESCRIPCION,
cita_estatus=ESTATUS
where cita_id=IDCITA$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_MODIFICAR_CONSULTA` (IN `IDCONSULTA` INT, IN `DESCRIPCION` VARCHAR(255), IN `DIAGNOSTICO` VARCHAR(255))  UPDATE consulta SET
consulta_descripcion=DESCRIPCION,
consulta_diagnostico=DIAGNOSTICO
WHERE consulta_id=IDCONSULTA$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_MODIFICAR_CONTRA_USUARIO` (IN `IDUSUARIO` INT, IN `CONTRA` VARCHAR(250))  UPDATE usuario SET
usu_contrasena=CONTRA
WHERE usu_id=IDUSUARIO$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_MODIFICAR_DATOS_USUARIO` (IN `IDUSUARIO` INT, IN `SEXO` CHAR(1), IN `IDROL` INT, IN `EMAIL` VARCHAR(250))  UPDATE usuario SET
usu_sexo=SEXO,
rol_id=IDROL,
usu_email=EMAIL
WHERE usu_id=IDUSUARIO$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_MODIFICAR_ESPECIALIDAD` (IN `ID` INT, IN `ESPECIALIDADACTUAL` VARCHAR(50), IN `ESPECIALIDADNUEVA` VARCHAR(50), IN `ESTATUS` VARCHAR(10))  BEGIN
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_MODIFICAR_ESTATUS_USUARIO` (IN `IDUSUARIO` INT, IN `ESTATUS` VARCHAR(20))  UPDATE usuario SET
usu_estatus=ESTATUS
WHERE usu_id=IDUSUARIO$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_MODIFICAR_INSUMO` (IN `ID` INT, IN `INSUMOACTUAL` VARCHAR(50), IN `INSUMONUEVO` VARCHAR(50), IN `STOCK` INT, IN `ESTATUS` VARCHAR(10))  BEGIN
DECLARE CANTIDAD INT;

IF INSUMOACTUAL = INSUMONUEVO THEN
	UPDATE insumo SET
	insumo_stock= STOCK,
	insumo_estatus= ESTATUS
	WHERE insumo_id= ID;
	SELECT 1;
ELSE
SET @CANTIDAD:=(SELECT COUNT(*) FROM insumo WHERE insumo_nombre=INSUMONUEVO);

IF @CANTIDAD = 0 THEN
	UPDATE insumo SET
	insumo_nombre=INSUMONUEVO,
	insumo_stock= STOCK,
	insumo_estatus= ESTATUS
	WHERE insumo_id= ID;
	SELECT 1;
ELSE
	SELECT 2;
END IF;

END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_MODIFICAR_MEDICAMENTO` (IN `ID` INT, IN `MEDICAMENTOACTUAL` VARCHAR(50), IN `MEDICAMENTONUEVO` VARCHAR(50), IN `ALIAS` VARCHAR(50), IN `STOCK` INT, IN `ESTATUS` VARCHAR(10))  BEGIN
DECLARE CANTIDAD INT;
IF MEDICAMENTOACTUAL= MEDICAMENTONUEVO THEN
	UPDATE medicamento SET
	medicamento_alias=ALIAS,
	medicamento_stock=STOCK,
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
		medicamento_estatus=ESTATUS
		WHERE medicamento_id=ID;
		SELECT 1;
	ELSE
		SELECT 2;
	END IF;
	
END IF;


END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_MODIFICAR_MEDICO` (IN `IDMEDICO` INT, IN `NOMBRES` VARCHAR(50), IN `APEPAT` VARCHAR(50), IN `APEMAT` VARCHAR(50), IN `DIRECCION` VARCHAR(200), IN `MOVIL` CHAR(12), IN `SEXO` CHAR(2), IN `FECHANACIMIENTO` DATE, IN `NRDOCUMENTOACTUAL` CHAR(12), IN `NRDOCUMENTONUEVO` CHAR(12), IN `COLEGIATURAACTUAL` CHAR(12), IN `COLEGIATURANUEVO` CHAR(12), IN `ESPECIALIDAD` INT, IN `IDUSUARIO` INT, IN `EMAIL` VARCHAR(255))  BEGIN
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_MODIFICAR_PACIENTE` (IN `ID` INT, IN `NOMBRE` VARCHAR(50), IN `APEPAT` VARCHAR(50), IN `APEMAT` VARCHAR(50), IN `DIRECCION` VARCHAR(200), IN `MOVIL` CHAR(12), IN `SEXO` CHAR(1), IN `NRDOCUMENTOACTUAL` CHAR(12), IN `NRDOCUMENTONUEVO` CHAR(12), IN `ESTATUS` CHAR(10))  BEGIN
DECLARE CANTIDAD INT;
IF NRDOCUMENTOACTUAL=NRDOCUMENTONUEVO THEN
	UPDATE paciente SET
    paciente_nombre=NOMBRE,
    paciente_apepat=APEPAT,
    paciente_apemat=APEMAT,
    paciente_direccion=DIRECCION,
    paciente_movil=MOVIL,
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_MODIFICAR_PROCEDIMIENTO` (IN `ID` INT, IN `PROCEDIMIENTOACTUAL` VARCHAR(50), IN `PROCEDIMIENTONUEVO` VARCHAR(50), IN `ESTATUS` VARCHAR(10))  BEGIN
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_REGISTRAR_CITA` (IN `IDPACIENTE` INT, IN `IDDOCTOR` INT, IN `DESCRIPCION` TEXT, IN `IDUSUARIO` INT)  BEGIN
DECLARE NUMCITA INT;
SET @NUMCITA:=(SELECT COUNT(*) +1 FROM cita WHERE cita_feregistro=CURDATE());
INSERT INTO cita(cita_nroatencion,cita_feregistro,medico_id,paciente_id,cita_estatus,cita_descripcion,usu_id) VALUES(@NUMCITA,CURDATE(),IDDOCTOR,IDPACIENTE,'PENDIENTE',DESCRIPCION,IDUSUARIO);
SELECT LAST_INSERT_ID();

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_REGISTRAR_CONSULTA` (IN `ID` INT, IN `DESCRIPCION` VARCHAR(255), IN `DIAGNOSTICO` VARCHAR(255))  BEGIN
INSERT INTO consulta(consulta_descripcion,consulta_diagnostico,consulta_feregistro,consulta_estatus,cita_id) VALUES(DESCRIPCION,DIAGNOSTICO,CURDATE(),'ATENDIDA',ID);
UPDATE cita SET
cita_estatus='ATENDIDA'
WHERE cita_id=ID;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_REGISTRAR_ESPECIALIDAD` (IN `ESPECIALIDAD` VARCHAR(50), IN `ESTATUS` VARCHAR(10))  BEGIN
DECLARE CANTIDAD INT;
SET @CANTIDAD:=(SELECT COUNT(*) FROM especialidad WHERE especialidad_nombre=ESPECIALIDAD);
IF @CANTIDAD= 0 THEN
INSERT INTO especialidad(especialidad_nombre,especialidad_fregistro,especialidad_estatus) VALUES(ESPECIALIDAD,CURDATE(),ESTATUS);
SELECT 1;

ELSE
SELECT 2;
END IF;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_REGISTRAR_INSUMO` (IN `INSUMO` VARCHAR(50), IN `STOCK` INT, IN `ESTATUS` VARCHAR(10))  BEGIN
DECLARE CANTIDAD INT;
SET @CANTIDAD:=(SELECT COUNT(*) FROM insumo WHERE insumo_nombre=INSUMO);

IF @CANTIDAD = 0 THEN
INSERT INTO insumo(insumo_nombre,insumo_stock,insumo_fregistro,insumo_estatus)
VALUES(INSUMO,STOCK,CURDATE(),ESTATUS);
SELECT 1;
ELSE
SELECT 2;
END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_REGISTRAR_MEDICAMENTO` (IN `MEDICAMENTO` VARCHAR(50), IN `ALIAS` VARCHAR(50), IN `STOCK` INT, IN `ESTATUS` VARCHAR(10))  BEGIN
DECLARE CANTIDAD INT;
SET @CANTIDAD:=(SELECT COUNT(*) FROM medicamento WHERE medicamento_nombre=MEDICAMENTO);
IF @CANTIDAD=0 THEN
	INSERT INTO medicamento(medicamento_nombre,medicamento_alias,medicamento_stock,medicamento_fregistro,medicamento_estatus)
	VALUES(MEDICAMENTO,ALIAS,STOCK,CURDATE(),ESTATUS);
	SELECT 1;
ELSE
	SELECT 2;

END IF;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_REGISTRAR_MEDICO` (IN `NOMBRES` VARCHAR(50), IN `APEPAT` VARCHAR(50), IN `APEMAT` VARCHAR(50), IN `DIRECCION` VARCHAR(200), IN `MOVIL` CHAR(12), IN `SEXO` CHAR(2), IN `FECHANACIMIENTO` DATE, IN `NRDOCUMENTO` CHAR(12), IN `COLEGIATURA` CHAR(12), IN `ESPECIALIDAD` INT, IN `USUARIO` VARCHAR(20), IN `CONTRA` VARCHAR(255), IN `ROL` INT, IN `EMAIl` VARCHAR(255))  BEGIN 
DECLARE CANTIDADU INT; 
DECLARE CANTIDADME INT; 
 SET @CANTIDADU:=(SELECT COUNT(*) FROM usuario WHERE usu_nombre=USUARIO); 
 IF @CANTIDADU = 0 THEN
 SET @CANTIDADME:=(SELECT COUNT(*) FROM medico WHERE medico_nrodocumento=NRDOCUMENTO OR medico_colegiatura=COLEGIATURA); 
 IF @CANTIDADME= 0 THEN 
 INSERT INTO usuario(usu_nombre,usu_contrasena,usu_sexo,rol_id,usu_estatus,usu_email,usu_intento) 
 VALUES(USUARIO,CONTRA,SEXO,ROL,'ACTIVO',EMAIL,0); 
 INSERT INTo medico(medico_nombre,medico_apepart,medico_apemart,medico_direccion,medico_movil,medico_sexo,medico_fenac,medico_nrodocumento,medico_colegiatura,especialidad_id,usu_id)
  VALUES(NOMBRES,APEPAT,APEMAT,DIRECCION,MOVIL,SEXO,FECHANACIMIENTO,NRDOCUMENTO,COLEGIATURA,ESPECIALIDAD,(SELECT MAX(usu_id) FROM usuario)); 
SELECT 1;
ELSE
SELECT 2;
END IF;
ELSE 
SELECT 2;
END IF;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_REGISTRAR_PACIENTE` (IN `NOMBRE` VARCHAR(50), IN `APEPAT` VARCHAR(50), IN `APEMAT` VARCHAR(50), IN `DIRECCION` VARCHAR(200), IN `MOVIL` CHAR(12), IN `SEXO` CHAR(1), IN `NRDOCUMENTO` CHAR(12))  BEGIN
DECLARE CANTIDAD INT;
SET @CANTIDAD :=(SELECT COUNT(*) FROM paciente where paciente_nrodocumento=NRDOCUMENTO);
IF @CANTIDAD=0 THEN
	INSERT INTO paciente(paciente_nombre,paciente_apepat,paciente_apemat,paciente_direccion,paciente_movil,paciente_sexo,paciente_nrodocumento,paciente_estatus) VALUES(NOMBRE,APEPAT,APEMAT,DIRECCION,MOVIL,SEXO,NRDOCUMENTO,'ACTIVO');
    SELECT 1;
   ELSE
    SELECT 2;
    END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_REGISTRAR_PROCEDIMIENTO` (IN `PROCEDIMIENTO` VARCHAR(50), IN `ESTATUS` VARCHAR(10))  BEGIN
DECLARE CANTIDA INT;
SET @CANTIDAD:=(SELECT count(*) FROM procedimiento WHERE procedimiento_nombre=PROCEDIMIENTO);
IF @CANTIDAD = 0 THEN
 INSERT INTO procedimiento(procedimiento_nombre,procedimiento_fecregistro,procedimiento_estatus)VALUES(PROCEDIMIENTO,CURDATE(),ESTATUS);
 SELECT 1;
ELSE
 SELECT 2;
END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_REGISTRAR_USUARIO` (IN `USU` VARCHAR(20), IN `CONTRA` VARCHAR(250), IN `SEXO` CHAR(1), IN `ROL` INT, IN `EMAIL` VARCHAR(250))  BEGIN
DECLARE CANTIDAD INT;
SET @CANTIDAD:=(SELECT count(*) FROM usuario WHERE usu_nombre= BINARY USU);
IF @CANTIDAD=0 THEN
	INSERT INTO usuario(usu_nombre,usu_contrasena,usu_sexo,rol_id,usu_estatus,usu_email,usu_intento) VALUES (USU,CONTRA,SEXO,ROL,'ACTIVO',EMAIL,0);
	SELECT 1;
ELSE
	SELECT 2;
END IF;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_REGRISTRAR_DETALLE_INSUMO` (IN `IDFUA` INT, IN `IDINSUMO` INT, IN `CANTIDADINSUMO` INT)  INSERT INTO detalle_insumo(fua_id,insumo_id,detain_cantidad)values(IDFUA,IDINSUMO,CANTIDADINSUMO)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_REGRISTRAR_DETALLE_MEDICAMENTO` (IN `IDFUA` INT, IN `IDMEDICAMENTO` INT, IN `CANTIDAD` INT)  INSERT INTO detalle_medicamento(fua_id,medicamento_id,detame_cantidad)values(IDFUA,IDMEDICAMENTO,CANTIDAD)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_REGRISTRAR_DETALLE_PROCEDIMIENTO` (IN `ID` INT, IN `IDPROCEDIMIENTO` INT)  INSERT INTO detalle_procedimiento(fua_id,procedimiento_id)values(ID,IDPROCEDIMIENTO)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_REGRISTRAR_FUA` (IN `IDHISTORIAL` INT, IN `IDCONSULTA` INT)  BEGIN
	INSERT INTO fua(fua_fegistro,historia_id,consulta_id)VALUES(CURDATE(),IDHISTORIAL,IDCONSULTA);
	SELECT LAST_INSERT_ID();

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_RETABLECER_CONTRA` (IN `EMAIL` VARCHAR(255), IN `CONTRA` VARCHAR(255))  BEGIN
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_TRAER_STOCK_INSUMO_H` (IN `ID` INT)  SELECT
	insumo.insumo_id, 
	insumo.insumo_stock
FROM
	insumo
	WHERE insumo.insumo_id=ID$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_TRAER_STOCK_MEDICAMENTO_H` (IN `ID` INT)  SELECT
	medicamento.medicamento_nombre, 
	medicamento.medicamento_stock
FROM
	medicamento
	WHERE medicamento.medicamento_id=ID$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_VERIFICAR_USUARIO` (IN `USUARIO` VARCHAR(20))  SELECT
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
-- Estructura de tabla para la tabla `cita`
--

CREATE TABLE `cita` (
  `cita_id` int(11) NOT NULL,
  `cita_nroatencion` int(255) DEFAULT NULL,
  `cita_feregistro` date DEFAULT NULL,
  `medico_id` int(11) DEFAULT NULL,
  `especialidad_id` int(11) DEFAULT NULL,
  `paciente_id` int(11) DEFAULT NULL,
  `cita_estatus` enum('PENDIENTE','CANCELADA','ATENDIDA') COLLATE utf8_spanish_ci NOT NULL,
  `cita_descripcion` text COLLATE utf8_spanish_ci NOT NULL,
  `usu_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `cita`
--

INSERT INTO `cita` (`cita_id`, `cita_nroatencion`, `cita_feregistro`, `medico_id`, `especialidad_id`, `paciente_id`, `cita_estatus`, `cita_descripcion`, `usu_id`) VALUES
(1, 1, '2021-11-09', 12, NULL, 9, 'PENDIENTE', 'asdasd', 1),
(2, 212, '2021-11-09', 13, NULL, 13, 'PENDIENTE', 'asdasdasd', 1),
(3, NULL, '2021-11-09', 13, NULL, 9, 'PENDIENTE', 'asdasdasa', 5),
(4, 4, '2021-11-09', 13, NULL, 9, 'PENDIENTE', 'sdasdasdas', 5),
(5, 1, '2021-11-10', 13, NULL, 9, 'PENDIENTE', 'soy burro', 5),
(6, 2, '2021-11-10', 13, NULL, 9, 'PENDIENTE', 'vino por dolor de cabeza', 5),
(7, 3, '2021-11-10', 13, NULL, 9, 'PENDIENTE', 'vino por dolor', 5),
(8, 4, '2021-11-10', 13, NULL, 9, 'PENDIENTE', 'ssa', 5),
(9, 5, '2021-11-10', 13, NULL, 9, 'PENDIENTE', 'ddff', 5),
(10, 6, '2021-11-10', 13, NULL, 14, 'PENDIENTE', 'vino por dolor', 5),
(11, 7, '2021-11-10', 13, NULL, 9, 'PENDIENTE', 'asdasd', 5),
(12, 8, '2021-11-10', 13, NULL, 9, 'PENDIENTE', 'hghg', 5),
(13, 9, '2021-11-10', 12, NULL, 15, 'PENDIENTE', 'vino por un dolor de vientre', 5),
(14, 1, '2022-04-04', 13, NULL, 10, 'PENDIENTE', 'adsdsfd', 5),
(15, 1, '2022-04-05', 13, 2, 9, 'PENDIENTE', '  c', 5),
(16, 1, '2022-04-06', 15, NULL, 9, 'PENDIENTE', 'prueba', 5);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `consulta`
--

CREATE TABLE `consulta` (
  `consulta_id` int(11) NOT NULL,
  `consulta_descripcion` text COLLATE utf8_spanish_ci,
  `consulta_diagnostico` text COLLATE utf8_spanish_ci,
  `consulta_feregistro` date DEFAULT NULL,
  `consulta_estatus` enum('ATENDIDA','PENDIENTE') COLLATE utf8_spanish_ci DEFAULT NULL,
  `cita_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `consulta`
--

INSERT INTO `consulta` (`consulta_id`, `consulta_descripcion`, `consulta_diagnostico`, `consulta_feregistro`, `consulta_estatus`, `cita_id`) VALUES
(1, 'prueba', 'sanoffff', '2022-04-05', 'PENDIENTE', 15),
(2, 'prueba2', 'enfermo', '2022-05-02', 'ATENDIDA', 15);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_insumo`
--

CREATE TABLE `detalle_insumo` (
  `detain_id` int(11) NOT NULL,
  `detain_cantidad` int(255) DEFAULT NULL,
  `insumo_id` int(11) DEFAULT NULL,
  `fua_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `detalle_insumo`
--

INSERT INTO `detalle_insumo` (`detain_id`, `detain_cantidad`, `insumo_id`, `fua_id`) VALUES
(1, 1, 3, 15),
(2, 1, 3, 16);

--
-- Disparadores `detalle_insumo`
--
DELIMITER $$
CREATE TRIGGER `TR_STOCK_INSUMO` BEFORE INSERT ON `detalle_insumo` FOR EACH ROW BEGIN
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
  `detame_cantidad` int(255) DEFAULT NULL,
  `medicamento_id` int(11) DEFAULT NULL,
  `fua_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `detalle_medicamento`
--

INSERT INTO `detalle_medicamento` (`detame_id`, `detame_cantidad`, `medicamento_id`, `fua_id`) VALUES
(1, 11, 1, 9),
(2, 1, 2, 9),
(3, 11, 1, 10),
(4, 1, 2, 10),
(5, 11, 1, 11),
(6, 1, 2, 11),
(7, 11, 1, 12),
(8, 1, 2, 12),
(9, 1, 4, 13),
(10, 1, 5, 13),
(11, 2, 1, 15),
(12, 6, 1, 16),
(13, 2, 1, 17);

--
-- Disparadores `detalle_medicamento`
--
DELIMITER $$
CREATE TRIGGER `TR_STOCK_MEDICAMENTO` BEFORE INSERT ON `detalle_medicamento` FOR EACH ROW BEGIN
DECLARE STOCKACTUAL DECIMAL(10,2);
SET @STOCKACTUAL:=(SELECT medicamento_stock FROM medicamento WHERE medicamento_id=new.medicamento_id);
UPDATE medicamento SET
medicamento_stock=@STOCKACTUAL-new.detame_cantidad
WHERE medicamento_id=new.medicamento_id;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `detalle_procedimiento`
--

INSERT INTO `detalle_procedimiento` (`detaproce_id`, `procedimiento_id`, `fua_id`) VALUES
(1, 1, 7),
(2, 2, 7),
(3, 1, 8),
(4, 2, 8),
(5, 2, 11),
(6, 3, 11),
(7, 2, 12),
(8, 3, 12),
(9, 4, 13),
(10, 5, 13),
(11, 1, 15);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `especialidad`
--

CREATE TABLE `especialidad` (
  `especialidad_id` int(11) NOT NULL,
  `especialidad_nombre` varchar(50) COLLATE utf8_spanish_ci DEFAULT NULL,
  `especialidad_fregistro` date DEFAULT NULL,
  `especialidad_estatus` enum('ACTIVO','INACTIVO') COLLATE utf8_spanish_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `fua`
--

INSERT INTO `fua` (`fua_id`, `fua_fegistro`, `historia_id`, `consulta_id`) VALUES
(3, '2022-04-25', 1, 2),
(4, '2022-04-25', 1, 2),
(5, '2022-04-25', 1, 2),
(6, '2022-04-25', 1, 2),
(7, '2022-04-25', 1, 2),
(8, '2022-04-25', 1, 2),
(9, '2022-04-25', 1, 2),
(10, '2022-04-25', 1, 2),
(11, '2022-04-25', 1, 2),
(12, '2022-04-25', 1, 2),
(13, '2022-04-25', 1, 2),
(14, '2022-04-25', 1, 2),
(15, '2022-04-25', 1, 2),
(16, '2022-04-26', 1, 2),
(17, '2022-05-02', 1, 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `historia`
--

CREATE TABLE `historia` (
  `historia_id` int(255) NOT NULL,
  `paciente_id` int(11) DEFAULT NULL,
  `historia_feregistro` datetime(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `historia`
--

INSERT INTO `historia` (`historia_id`, `paciente_id`, `historia_feregistro`) VALUES
(1, 9, '2021-11-07 00:00:00.000000'),
(2, 10, '2021-11-07 00:00:00.000000'),
(3, 11, '2021-11-09 00:00:00.000000'),
(4, 12, '2021-11-09 00:00:00.000000'),
(5, 13, '2021-11-09 00:00:00.000000'),
(6, 14, '2021-11-09 00:00:00.000000'),
(7, 15, '2021-11-10 00:00:00.000000');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `insumo`
--

CREATE TABLE `insumo` (
  `insumo_id` int(11) NOT NULL,
  `insumo_nombre` varchar(50) COLLATE utf8_spanish_ci DEFAULT NULL,
  `insumo_stock` int(255) DEFAULT NULL,
  `insumo_fregistro` date DEFAULT NULL,
  `insumo_estatus` enum('ACTIVO','INACTIVO','AGOTADO') COLLATE utf8_spanish_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `insumo`
--

INSERT INTO `insumo` (`insumo_id`, `insumo_nombre`, `insumo_stock`, `insumo_fregistro`, `insumo_estatus`) VALUES
(1, 'GUANTES', 0, '2021-10-24', 'INACTIVO'),
(2, 'JRINGAS', 0, '2021-10-24', 'AGOTADO'),
(3, 'AGUJAS', 1, '2021-10-24', 'INACTIVO'),
(4, 'MASCARILLAS', 25, '2021-10-24', 'ACTIVO'),
(5, 'PINZAS', 12, '2021-10-24', 'ACTIVO'),
(6, 'ADHESIVOS', 10, '2021-10-24', 'INACTIVO'),
(11, 'VENDA', 15, '2021-10-25', 'ACTIVO'),
(12, 'Tapa Bocas', 2, '2022-03-27', 'ACTIVO'),
(13, 'GASAS', 10, '2022-03-27', 'ACTIVO');

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
  `medicamento_estatus` enum('ACTIVO','INACTIVO','AGOTADO') COLLATE utf8_spanish_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `medicamento`
--

INSERT INTO `medicamento` (`medicamento_id`, `medicamento_nombre`, `medicamento_alias`, `medicamento_stock`, `medicamento_fregistro`, `medicamento_estatus`) VALUES
(1, 'Loratadina', 'vera', 4, '2022-03-30', 'ACTIVO'),
(2, 'somatostatina', 'soma', 2, '2022-03-30', 'INACTIVO'),
(3, 'paracetamol', 'para', 0, '2022-03-30', 'AGOTADO'),
(4, 'verapamilloo', 've', 12, '2022-04-01', 'ACTIVO'),
(5, 'ibuprofeno', 'ibu', 10, '2022-04-01', 'ACTIVO'),
(6, 'acetaminofen', 'ace', 1, '2022-04-01', 'ACTIVO');

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
  `usu_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `medico`
--

INSERT INTO `medico` (`medico_id`, `medico_nombre`, `medico_apepart`, `medico_apemart`, `medico_direccion`, `medico_movil`, `medico_sexo`, `medico_fenac`, `medico_nrodocumento`, `medico_colegiatura`, `especialidad_id`, `usu_id`) VALUES
(12, 'SDASDAD', 'ASDASDAS', 'ASDASDAS', 'ASDASDA', '1041242', 'M', '2021-11-05', '11111', '2124154', 5, 34),
(13, 'beta', 'xgxssd', 'sdfsdfsdfsdf', 'aasdasdasa', '532321221', 'F', '2021-11-05', '6623215', '521212', 2, 35),
(14, 'asdasd', 'asdas', 'asdasda', 'adsas', '2123123232', 'M', '2021-11-07', '2312312', '12312', 3, 36),
(15, 'fabiola', 'contreras', 'guerrero', 'las flores', '04162204090', 'M', '2021-11-06', '10749525', '25465621', 3, 37),
(16, 'carlos', 'lopez', 'gutierrez', 'el valle', '004246338650', 'M', '2021-11-19', '2348655', '2233442', 4, 40);

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
  `paciente_fenac` datetime(6) DEFAULT NULL,
  `paciente_nrodocumento` char(12) COLLATE utf8_spanish_ci DEFAULT NULL,
  `paciente_estatus` enum('ACTIVO','INACTIVO') COLLATE utf8_spanish_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `paciente`
--

INSERT INTO `paciente` (`paciente_id`, `paciente_nombre`, `paciente_apepat`, `paciente_apemat`, `paciente_direccion`, `paciente_movil`, `paciente_sexo`, `paciente_fenac`, `paciente_nrodocumento`, `paciente_estatus`) VALUES
(9, 'ANDREW', 'CONTRERAS', 'GUERREROa', 'LAS FLORES', '23123', 'M', NULL, '12', 'INACTIVO'),
(10, 'asdasd', 'asdas', 'asdas', 'sadasd', '123123', 'M', NULL, '121233', 'INACTIVO'),
(11, 'asdas', 'sadas', 'asdas', 'dsasd', '2312', 'M', NULL, '22', 'ACTIVO'),
(12, 'adasdasd', 'asdasd', 'asdasd', 'asdas', '123123', 'M', NULL, '12323', 'ACTIVO'),
(13, 'asdasd', 'asdas', 'asdas', 'sada', '123123', 'M', NULL, '123123', 'ACTIVO'),
(14, 'crisley', 'guerrero', 'valero', 'el valle', '04162204090', 'F', NULL, '10743565', 'ACTIVO'),
(15, 'sirey', 'contrera', 'valero', 'las flores', '04162204090', 'M', NULL, '2345566', 'ACTIVO');

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

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
-- Estructura de tabla para la tabla `rol`
--

CREATE TABLE `rol` (
  `rol_id` int(11) NOT NULL,
  `rol_nombre` varchar(30) COLLATE utf8_spanish_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `rol`
--

INSERT INTO `rol` (`rol_id`, `rol_nombre`) VALUES
(1, 'ADMINISTRADOR'),
(2, 'RECEPCIONISTA'),
(3, 'MEDICO');

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
  `usu_intento` int(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`usu_id`, `usu_nombre`, `usu_contrasena`, `usu_sexo`, `rol_id`, `usu_estatus`, `usu_email`, `usu_intento`) VALUES
(1, 'curso', '$2y$10$QgchwHKteWb7Ns3cHA2FuO8mGjXnZJ4scaj5nEusyvx4NDVhowK/G', 'M', 3, 'ACTIVO', 'daniel.valeros2012@gmail.com', 0),
(3, 'prueba', '$2y$10$cEzdbqRSjLff50kaaH9hmOyfj6o5IVa4PEn.lu3kxUtVwLfWvdWOC', 'F', 3, 'ACTIVO', 'prueba@gmail.com', 0),
(4, 'Andrew', '$2y$10$E7CM87G1TxTW1/bxzVF5k.MEU.MRww7/qgjmHd4wu6/3rydqkA1TO', 'M', 3, 'ACTIVO', 'andrew.contrera2012@gmail.com', 0),
(5, 'vero', '$2y$10$GU9cYfZJT/Z9Twm8EA8VBu/eS8PFTx5Rn5g5ml9YE5cFjlCo3rfOa', 'F', 1, 'ACTIVO', '', 0),
(6, 'betania', '$2y$10$5q/gAt/6bR/.UGxLjoGpZeRr2jLGJqYkbp/u/IV0O7yYw2lkvVIBO', 'F', 3, 'ACTIVO', 'betania@guerrero2010.com', NULL),
(7, 'daniel', '$2y$10$SGFD6sS6KRFwJ5RVR0OmuuqjHtbzl1FBPAQZ.CA.iAAqbutcdRgou', 'M', 2, 'ACTIVO', 'daniel.vale@homail.com', NULL),
(8, 'mateo', '$2y$10$fXL7Oqp7GFIbvV9nwvgcweaHyURnUVLMxTkMtlve6eIsE5dWoqDQS', 'M', 2, 'ACTIVO', 'mateo.lo@2020.com', 0),
(34, 'betania12', '$2y$10$g4Y6j8/abQO7UuYXKLWY5OMr/w.IZxJqaivUZ5YvmfZuuG.toVKA6', 'M', 3, 'ACTIVO', 'betania@guerrero2010.com', 0),
(35, 'ghfghfg', '$2y$10$uhm9GaDoeISaw.rvIConhe0jqAr8UA265BDDj.JBvO.rBi4LbDA/u', 'F', 3, 'ACTIVO', 'betania@guerrero2010.com', 0),
(36, 'ddsd', '$2y$10$PmtEKdqZ4e2XgT00YdLqQebe2ydKDanAkgaMnr7QWLw/fnypnJnUu', 'M', 3, 'ACTIVO', 'daniel.vale@homail.com', 0),
(37, 'nestor', '$2y$10$cNb25Qz/yzBdy0kv9o3qJOOI/rnN1t904uXpHLPPPS8HCV1jSWiiq', 'M', 3, 'ACTIVO', 'daniel.vale@homail.com', 0),
(38, 'cris', '$2y$10$9xgvLuaCl.lYTYLIcdBQhOjfu1jTX2mTDTdJx7WJtLeqcaStePemm', 'M', 2, 'ACTIVO', 'betania@guerrero2010.com', 0),
(39, 'dan', '$2y$10$29CX3Ja6C6ckGpO4mO90OuvM9b1TsfTfsApAzAz8l8EWuhFp9jgN6', 'M', 3, 'ACTIVO', 'betania@guerrero2010.com', 0),
(40, 'betania23', '$2y$10$ZUdAoomjy5WSQHveHsHbb.kJV7/JWwlgj37bg.WkKfGL847H041Qm', 'M', 3, 'ACTIVO', 'betania@guerrero2010.com', 0);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `cita`
--
ALTER TABLE `cita`
  ADD PRIMARY KEY (`cita_id`),
  ADD KEY `paciente_id` (`paciente_id`),
  ADD KEY `medico_id` (`medico_id`),
  ADD KEY `especialidad_id` (`especialidad_id`),
  ADD KEY `usu_id` (`usu_id`);

--
-- Indices de la tabla `consulta`
--
ALTER TABLE `consulta`
  ADD PRIMARY KEY (`consulta_id`),
  ADD KEY `cita_id` (`cita_id`);

--
-- Indices de la tabla `detalle_insumo`
--
ALTER TABLE `detalle_insumo`
  ADD PRIMARY KEY (`detain_id`),
  ADD KEY `fua_id` (`fua_id`),
  ADD KEY `insumo_id` (`insumo_id`);

--
-- Indices de la tabla `detalle_medicamento`
--
ALTER TABLE `detalle_medicamento`
  ADD PRIMARY KEY (`detame_id`),
  ADD KEY `medicamento_id` (`medicamento_id`),
  ADD KEY `fua_id` (`fua_id`);

--
-- Indices de la tabla `detalle_procedimiento`
--
ALTER TABLE `detalle_procedimiento`
  ADD PRIMARY KEY (`detaproce_id`),
  ADD KEY `fua_id` (`fua_id`),
  ADD KEY `procedimiento_id` (`procedimiento_id`);

--
-- Indices de la tabla `especialidad`
--
ALTER TABLE `especialidad`
  ADD PRIMARY KEY (`especialidad_id`);

--
-- Indices de la tabla `fua`
--
ALTER TABLE `fua`
  ADD PRIMARY KEY (`fua_id`),
  ADD KEY `historia_id` (`historia_id`),
  ADD KEY `consulta_id` (`consulta_id`);

--
-- Indices de la tabla `historia`
--
ALTER TABLE `historia`
  ADD PRIMARY KEY (`historia_id`),
  ADD KEY `paciente_id` (`paciente_id`);

--
-- Indices de la tabla `insumo`
--
ALTER TABLE `insumo`
  ADD PRIMARY KEY (`insumo_id`);

--
-- Indices de la tabla `medicamento`
--
ALTER TABLE `medicamento`
  ADD PRIMARY KEY (`medicamento_id`);

--
-- Indices de la tabla `medico`
--
ALTER TABLE `medico`
  ADD PRIMARY KEY (`medico_id`),
  ADD KEY `usu_id` (`usu_id`),
  ADD KEY `FK_especialidad` (`especialidad_id`);

--
-- Indices de la tabla `paciente`
--
ALTER TABLE `paciente`
  ADD PRIMARY KEY (`paciente_id`);

--
-- Indices de la tabla `procedimiento`
--
ALTER TABLE `procedimiento`
  ADD PRIMARY KEY (`procedimiento_id`);

--
-- Indices de la tabla `rol`
--
ALTER TABLE `rol`
  ADD PRIMARY KEY (`rol_id`);

--
-- Indices de la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`usu_id`),
  ADD KEY `rol_id` (`rol_id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `cita`
--
ALTER TABLE `cita`
  MODIFY `cita_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;
--
-- AUTO_INCREMENT de la tabla `consulta`
--
ALTER TABLE `consulta`
  MODIFY `consulta_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT de la tabla `detalle_insumo`
--
ALTER TABLE `detalle_insumo`
  MODIFY `detain_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT de la tabla `detalle_medicamento`
--
ALTER TABLE `detalle_medicamento`
  MODIFY `detame_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;
--
-- AUTO_INCREMENT de la tabla `detalle_procedimiento`
--
ALTER TABLE `detalle_procedimiento`
  MODIFY `detaproce_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;
--
-- AUTO_INCREMENT de la tabla `especialidad`
--
ALTER TABLE `especialidad`
  MODIFY `especialidad_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT de la tabla `fua`
--
ALTER TABLE `fua`
  MODIFY `fua_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;
--
-- AUTO_INCREMENT de la tabla `historia`
--
ALTER TABLE `historia`
  MODIFY `historia_id` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT de la tabla `insumo`
--
ALTER TABLE `insumo`
  MODIFY `insumo_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;
--
-- AUTO_INCREMENT de la tabla `medicamento`
--
ALTER TABLE `medicamento`
  MODIFY `medicamento_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT de la tabla `medico`
--
ALTER TABLE `medico`
  MODIFY `medico_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;
--
-- AUTO_INCREMENT de la tabla `paciente`
--
ALTER TABLE `paciente`
  MODIFY `paciente_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;
--
-- AUTO_INCREMENT de la tabla `procedimiento`
--
ALTER TABLE `procedimiento`
  MODIFY `procedimiento_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;
--
-- AUTO_INCREMENT de la tabla `usuario`
--
ALTER TABLE `usuario`
  MODIFY `usu_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;
--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `cita`
--
ALTER TABLE `cita`
  ADD CONSTRAINT `cita_ibfk_1` FOREIGN KEY (`paciente_id`) REFERENCES `paciente` (`paciente_id`),
  ADD CONSTRAINT `cita_ibfk_2` FOREIGN KEY (`medico_id`) REFERENCES `medico` (`medico_id`),
  ADD CONSTRAINT `cita_ibfk_3` FOREIGN KEY (`especialidad_id`) REFERENCES `especialidad` (`especialidad_id`),
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
  ADD CONSTRAINT `detalle_insumo_ibfk_1` FOREIGN KEY (`fua_id`) REFERENCES `fua` (`fua_id`),
  ADD CONSTRAINT `detalle_insumo_ibfk_2` FOREIGN KEY (`insumo_id`) REFERENCES `insumo` (`insumo_id`);

--
-- Filtros para la tabla `detalle_medicamento`
--
ALTER TABLE `detalle_medicamento`
  ADD CONSTRAINT `detalle_medicamento_ibfk_1` FOREIGN KEY (`fua_id`) REFERENCES `fua` (`fua_id`),
  ADD CONSTRAINT `detalle_medicamento_ibfk_2` FOREIGN KEY (`medicamento_id`) REFERENCES `medicamento` (`medicamento_id`);

--
-- Filtros para la tabla `detalle_procedimiento`
--
ALTER TABLE `detalle_procedimiento`
  ADD CONSTRAINT `detalle_procedimiento_ibfk_1` FOREIGN KEY (`procedimiento_id`) REFERENCES `procedimiento` (`procedimiento_id`),
  ADD CONSTRAINT `detalle_procedimiento_ibfk_2` FOREIGN KEY (`fua_id`) REFERENCES `fua` (`fua_id`);

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
  ADD CONSTRAINT `medico_ibfk_2` FOREIGN KEY (`usu_id`) REFERENCES `usuario` (`usu_id`);

--
-- Filtros para la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD CONSTRAINT `usuario_ibfk_1` FOREIGN KEY (`rol_id`) REFERENCES `rol` (`rol_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
