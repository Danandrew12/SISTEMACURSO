/*
 Navicat Premium Data Transfer

 Source Server         : base de datos
 Source Server Type    : MySQL
 Source Server Version : 100424
 Source Host           : localhost:3306
 Source Schema         : bd_curso

 Target Server Type    : MySQL
 Target Server Version : 100424
 File Encoding         : 65001

 Date: 16/05/2022 15:57:04
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for auditoria
-- ----------------------------
DROP TABLE IF EXISTS `auditoria`;
CREATE TABLE `auditoria`  (
  `audi_id` int NOT NULL AUTO_INCREMENT,
  `rol_id` int NULL DEFAULT NULL,
  `usu_id` int NULL DEFAULT NULL,
  PRIMARY KEY (`audi_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_spanish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of auditoria
-- ----------------------------

-- ----------------------------
-- Table structure for cita
-- ----------------------------
DROP TABLE IF EXISTS `cita`;
CREATE TABLE `cita`  (
  `cita_id` int NOT NULL AUTO_INCREMENT,
  `cita_nroatencion` int NULL DEFAULT NULL,
  `cita_feregistro` date NULL DEFAULT NULL,
  `medico_id` int NULL DEFAULT NULL,
  `especialidad_id` int NULL DEFAULT NULL,
  `paciente_id` int NULL DEFAULT NULL,
  `cita_estatus` enum('PENDIENTE','CANCELADA','ATENDIDA') CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL,
  `cita_descripcion` text CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL,
  `usu_id` int NOT NULL,
  PRIMARY KEY (`cita_id`) USING BTREE,
  INDEX `paciente_id`(`paciente_id`) USING BTREE,
  INDEX `medico_id`(`medico_id`) USING BTREE,
  INDEX `especialidad_id`(`especialidad_id`) USING BTREE,
  INDEX `usu_id`(`usu_id`) USING BTREE,
  CONSTRAINT `cita_ibfk_1` FOREIGN KEY (`paciente_id`) REFERENCES `paciente` (`paciente_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `cita_ibfk_2` FOREIGN KEY (`medico_id`) REFERENCES `medico` (`medico_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `cita_ibfk_3` FOREIGN KEY (`especialidad_id`) REFERENCES `especialidad` (`especialidad_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `cita_ibfk_4` FOREIGN KEY (`usu_id`) REFERENCES `usuario` (`usu_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_spanish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of cita
-- ----------------------------
INSERT INTO `cita` VALUES (1, 1, '2022-05-16', 2, 2, 3, 'PENDIENTE', 'vino por malestar', 5);
INSERT INTO `cita` VALUES (2, 2, '2022-05-16', 2, NULL, 3, 'PENDIENTE', 'cxcxcvxc', 5);
INSERT INTO `cita` VALUES (3, 3, '2022-05-16', 2, NULL, 3, 'PENDIENTE', 'wewerwe', 5);

-- ----------------------------
-- Table structure for consulta
-- ----------------------------
DROP TABLE IF EXISTS `consulta`;
CREATE TABLE `consulta`  (
  `consulta_id` int NOT NULL AUTO_INCREMENT,
  `consulta_descripcion` text CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL,
  `consulta_diagnostico` text CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL,
  `consulta_feregistro` date NULL DEFAULT NULL,
  `consulta_estatus` enum('ATENDIDA','PENDIENTE') CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  `cita_id` int NOT NULL,
  PRIMARY KEY (`consulta_id`) USING BTREE,
  INDEX `cita_id`(`cita_id`) USING BTREE,
  CONSTRAINT `consulta_ibfk_1` FOREIGN KEY (`cita_id`) REFERENCES `cita` (`cita_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_spanish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of consulta
-- ----------------------------

-- ----------------------------
-- Table structure for detalle_insumo
-- ----------------------------
DROP TABLE IF EXISTS `detalle_insumo`;
CREATE TABLE `detalle_insumo`  (
  `detain_id` int NOT NULL AUTO_INCREMENT,
  `detain_cantidad` int NULL DEFAULT NULL,
  `insumo_id` int NULL DEFAULT NULL,
  `fua_id` int NULL DEFAULT NULL,
  PRIMARY KEY (`detain_id`) USING BTREE,
  INDEX `fua_id`(`fua_id`) USING BTREE,
  INDEX `insumo_id`(`insumo_id`) USING BTREE,
  CONSTRAINT `detalle_insumo_ibfk_1` FOREIGN KEY (`fua_id`) REFERENCES `fua` (`fua_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `detalle_insumo_ibfk_2` FOREIGN KEY (`insumo_id`) REFERENCES `insumo` (`insumo_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_spanish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of detalle_insumo
-- ----------------------------

-- ----------------------------
-- Table structure for detalle_medicamento
-- ----------------------------
DROP TABLE IF EXISTS `detalle_medicamento`;
CREATE TABLE `detalle_medicamento`  (
  `detame_id` int NOT NULL AUTO_INCREMENT,
  `detame_cantidad` int NULL DEFAULT NULL,
  `medicamento_id` int NULL DEFAULT NULL,
  `fua_id` int NULL DEFAULT NULL,
  PRIMARY KEY (`detame_id`) USING BTREE,
  INDEX `medicamento_id`(`medicamento_id`) USING BTREE,
  INDEX `fua_id`(`fua_id`) USING BTREE,
  CONSTRAINT `detalle_medicamento_ibfk_1` FOREIGN KEY (`fua_id`) REFERENCES `fua` (`fua_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `detalle_medicamento_ibfk_2` FOREIGN KEY (`medicamento_id`) REFERENCES `medicamento` (`medicamento_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_spanish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of detalle_medicamento
-- ----------------------------

-- ----------------------------
-- Table structure for detalle_procedimiento
-- ----------------------------
DROP TABLE IF EXISTS `detalle_procedimiento`;
CREATE TABLE `detalle_procedimiento`  (
  `detaproce_id` int NOT NULL AUTO_INCREMENT,
  `procedimiento_id` int NULL DEFAULT NULL,
  `fua_id` int NULL DEFAULT NULL,
  PRIMARY KEY (`detaproce_id`) USING BTREE,
  INDEX `fua_id`(`fua_id`) USING BTREE,
  INDEX `procedimiento_id`(`procedimiento_id`) USING BTREE,
  CONSTRAINT `detalle_procedimiento_ibfk_1` FOREIGN KEY (`procedimiento_id`) REFERENCES `procedimiento` (`procedimiento_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `detalle_procedimiento_ibfk_2` FOREIGN KEY (`fua_id`) REFERENCES `fua` (`fua_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_spanish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of detalle_procedimiento
-- ----------------------------

-- ----------------------------
-- Table structure for donaciones
-- ----------------------------
DROP TABLE IF EXISTS `donaciones`;
CREATE TABLE `donaciones`  (
  `dona_id` int NOT NULL AUTO_INCREMENT,
  `paciente_id` int NULL DEFAULT NULL,
  PRIMARY KEY (`dona_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_spanish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of donaciones
-- ----------------------------

-- ----------------------------
-- Table structure for especialidad
-- ----------------------------
DROP TABLE IF EXISTS `especialidad`;
CREATE TABLE `especialidad`  (
  `especialidad_id` int NOT NULL AUTO_INCREMENT,
  `especialidad_nombre` varchar(50) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  `especialidad_fregistro` date NULL DEFAULT NULL,
  `especialidad_estatus` enum('ACTIVO','INACTIVO') CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`especialidad_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8 COLLATE = utf8_spanish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of especialidad
-- ----------------------------
INSERT INTO `especialidad` VALUES (2, 'ginecologia', '2021-11-03', 'ACTIVO');
INSERT INTO `especialidad` VALUES (3, 'pediactria', '2021-11-03', 'ACTIVO');
INSERT INTO `especialidad` VALUES (4, 'sexologia', '2021-11-05', 'ACTIVO');
INSERT INTO `especialidad` VALUES (5, 'fisioterapia', '2021-11-05', 'ACTIVO');
INSERT INTO `especialidad` VALUES (6, 'terapia', '2021-11-05', 'ACTIVO');

-- ----------------------------
-- Table structure for fua
-- ----------------------------
DROP TABLE IF EXISTS `fua`;
CREATE TABLE `fua`  (
  `fua_id` int NOT NULL AUTO_INCREMENT,
  `fua_fegistro` date NULL DEFAULT NULL,
  `historia_id` int NULL DEFAULT NULL,
  `consulta_id` int NULL DEFAULT NULL,
  PRIMARY KEY (`fua_id`) USING BTREE,
  INDEX `historia_id`(`historia_id`) USING BTREE,
  INDEX `consulta_id`(`consulta_id`) USING BTREE,
  CONSTRAINT `fua_ibfk_1` FOREIGN KEY (`historia_id`) REFERENCES `historia` (`historia_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fua_ibfk_2` FOREIGN KEY (`consulta_id`) REFERENCES `consulta` (`consulta_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_spanish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of fua
-- ----------------------------

-- ----------------------------
-- Table structure for historia
-- ----------------------------
DROP TABLE IF EXISTS `historia`;
CREATE TABLE `historia`  (
  `historia_id` int NOT NULL AUTO_INCREMENT,
  `paciente_id` int NULL DEFAULT NULL,
  `historia_feregistro` datetime(6) NULL DEFAULT NULL,
  PRIMARY KEY (`historia_id`) USING BTREE,
  INDEX `paciente_id`(`paciente_id`) USING BTREE,
  CONSTRAINT `historia_ibfk_1` FOREIGN KEY (`paciente_id`) REFERENCES `paciente` (`paciente_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_spanish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of historia
-- ----------------------------
INSERT INTO `historia` VALUES (1, 3, '2022-05-16 00:00:00.000000');
INSERT INTO `historia` VALUES (2, 1, '2022-05-16 00:00:00.000000');
INSERT INTO `historia` VALUES (3, 2, '2022-05-16 00:00:00.000000');

-- ----------------------------
-- Table structure for insumo
-- ----------------------------
DROP TABLE IF EXISTS `insumo`;
CREATE TABLE `insumo`  (
  `insumo_id` int NOT NULL AUTO_INCREMENT,
  `insumo_nombre` varchar(50) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  `insumo_stock` int NULL DEFAULT NULL,
  `insumo_fregistro` date NULL DEFAULT NULL,
  `insumo_estatus` enum('ACTIVO','INACTIVO','AGOTADO') CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`insumo_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8 COLLATE = utf8_spanish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of insumo
-- ----------------------------
INSERT INTO `insumo` VALUES (1, 'GUANTES', 0, '2021-10-24', 'INACTIVO');
INSERT INTO `insumo` VALUES (2, 'JRINGAS', 0, '2021-10-24', 'AGOTADO');
INSERT INTO `insumo` VALUES (3, 'AGUJAS', 1, '2021-10-24', 'INACTIVO');
INSERT INTO `insumo` VALUES (4, 'MASCARILLAS', 25, '2021-10-24', 'ACTIVO');
INSERT INTO `insumo` VALUES (5, 'PINZAS', 12, '2021-10-24', 'ACTIVO');
INSERT INTO `insumo` VALUES (6, 'ADHESIVOS', 10, '2021-10-24', 'INACTIVO');
INSERT INTO `insumo` VALUES (11, 'VENDA', 15, '2021-10-25', 'ACTIVO');
INSERT INTO `insumo` VALUES (12, 'Tapa Bocas', 2, '2022-03-27', 'ACTIVO');
INSERT INTO `insumo` VALUES (13, 'GASAS', 10, '2022-03-27', 'ACTIVO');

-- ----------------------------
-- Table structure for medicamento
-- ----------------------------
DROP TABLE IF EXISTS `medicamento`;
CREATE TABLE `medicamento`  (
  `medicamento_id` int NOT NULL AUTO_INCREMENT,
  `medicamento_nombre` varchar(50) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  `medicamento_alias` varchar(50) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  `medicamento_stock` int NULL DEFAULT NULL,
  `medicamento_fregistro` date NULL DEFAULT NULL,
  `medicamento_estatus` enum('ACTIVO','INACTIVO','AGOTADO') CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`medicamento_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8 COLLATE = utf8_spanish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of medicamento
-- ----------------------------
INSERT INTO `medicamento` VALUES (1, 'Loratadina', 'vera', 4, '2022-03-30', 'ACTIVO');
INSERT INTO `medicamento` VALUES (2, 'somatostatina', 'soma', 2, '2022-03-30', 'INACTIVO');
INSERT INTO `medicamento` VALUES (3, 'paracetamol', 'para', 0, '2022-03-30', 'AGOTADO');
INSERT INTO `medicamento` VALUES (4, 'verapamilloo', 've', 12, '2022-04-01', 'ACTIVO');
INSERT INTO `medicamento` VALUES (5, 'ibuprofeno', 'ibu', 10, '2022-04-01', 'ACTIVO');
INSERT INTO `medicamento` VALUES (6, 'acetaminofen', 'ace', 1, '2022-04-01', 'ACTIVO');

-- ----------------------------
-- Table structure for medico
-- ----------------------------
DROP TABLE IF EXISTS `medico`;
CREATE TABLE `medico`  (
  `medico_id` int NOT NULL AUTO_INCREMENT,
  `medico_nombre` varchar(50) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  `medico_apepart` varchar(50) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  `medico_apemart` varchar(50) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  `medico_direccion` varchar(200) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  `medico_movil` char(12) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  `medico_sexo` char(1) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  `medico_fenac` date NULL DEFAULT NULL,
  `medico_nrodocumento` char(12) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  `medico_colegiatura` char(12) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  `especialidad_id` int NOT NULL,
  `usu_id` int NOT NULL,
  `sag_id` int NOT NULL,
  PRIMARY KEY (`medico_id`) USING BTREE,
  INDEX `usu_id`(`usu_id`) USING BTREE,
  INDEX `FK_especialidad`(`especialidad_id`) USING BTREE,
  INDEX `sag_id`(`sag_id`) USING BTREE,
  CONSTRAINT `medico_ibfk_1` FOREIGN KEY (`especialidad_id`) REFERENCES `especialidad` (`especialidad_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `medico_ibfk_2` FOREIGN KEY (`usu_id`) REFERENCES `usuario` (`usu_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_spanish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of medico
-- ----------------------------
INSERT INTO `medico` VALUES (1, 'Betania', 'Guerrero', 'Contreras', 'las flores', '00427703757', 'F', '2000-11-29', '27390450', '11111', 2, 43, 0);

-- ----------------------------
-- Table structure for paciente
-- ----------------------------
DROP TABLE IF EXISTS `paciente`;
CREATE TABLE `paciente`  (
  `paciente_id` int NOT NULL AUTO_INCREMENT,
  `paciente_nombre` varchar(50) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  `paciente_apepat` varchar(50) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  `paciente_apemat` varchar(50) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  `paciente_direccion` varchar(200) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  `paciente_movil` char(12) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  `paciente_sexo` char(1) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  `paciente_fenac` datetime(6) NULL DEFAULT NULL,
  `paciente_nrodocumento` char(12) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  `paciente_estatus` enum('ACTIVO','INACTIVO') CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  `sag_id` int NOT NULL,
  PRIMARY KEY (`paciente_id`) USING BTREE,
  INDEX `sag_id`(`sag_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_spanish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of paciente
-- ----------------------------
INSERT INTO `paciente` VALUES (1, 'Andrew', 'Contreras', 'Valero', 'las flores', '04162204090', 'M', NULL, '26309450', 'ACTIVO', 0);
INSERT INTO `paciente` VALUES (2, 'Nestor', 'Guerrero', 'Contreras', 'las flores', '04246338650', 'M', NULL, '10749525', 'ACTIVO', 0);

-- ----------------------------
-- Table structure for procedimiento
-- ----------------------------
DROP TABLE IF EXISTS `procedimiento`;
CREATE TABLE `procedimiento`  (
  `procedimiento_id` int NOT NULL AUTO_INCREMENT,
  `procedimiento_nombre` varchar(50) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  `procedimiento_fecregistro` date NULL DEFAULT NULL,
  `procedimiento_estatus` enum('ACTIVO','INACTIVO') CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`procedimiento_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8 COLLATE = utf8_spanish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of procedimiento
-- ----------------------------
INSERT INTO `procedimiento` VALUES (1, 'Auscultacion', '2021-10-24', 'ACTIVO');
INSERT INTO `procedimiento` VALUES (2, 'Inspección médica', '2021-10-24', 'ACTIVO');
INSERT INTO `procedimiento` VALUES (3, 'Palpación', '2021-10-24', 'ACTIVO');
INSERT INTO `procedimiento` VALUES (4, 'Percusión(médica)', '2021-10-24', 'ACTIVO');
INSERT INTO `procedimiento` VALUES (5, 'Medición de signos vitales', '2021-10-24', 'ACTIVO');
INSERT INTO `procedimiento` VALUES (6, 'Electromiografia', '2021-10-24', 'ACTIVO');
INSERT INTO `procedimiento` VALUES (7, 'Electrocardiografia', '2021-10-24', 'ACTIVO');
INSERT INTO `procedimiento` VALUES (8, 'Masaje', '2021-10-24', 'ACTIVO');
INSERT INTO `procedimiento` VALUES (9, 'sexologia', '2022-03-26', 'ACTIVO');
INSERT INTO `procedimiento` VALUES (10, 'palpasión', '2022-03-26', 'ACTIVO');
INSERT INTO `procedimiento` VALUES (11, 'loca', '2022-03-26', 'ACTIVO');

-- ----------------------------
-- Table structure for restaurar
-- ----------------------------
DROP TABLE IF EXISTS `restaurar`;
CREATE TABLE `restaurar`  (
  `rest_id` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`rest_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_spanish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of restaurar
-- ----------------------------

-- ----------------------------
-- Table structure for rol
-- ----------------------------
DROP TABLE IF EXISTS `rol`;
CREATE TABLE `rol`  (
  `rol_id` int NOT NULL,
  `rol_nombre` varchar(30) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`rol_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_spanish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of rol
-- ----------------------------
INSERT INTO `rol` VALUES (1, 'ADMINISTRADOR');
INSERT INTO `rol` VALUES (2, 'RECEPCIONISTA');
INSERT INTO `rol` VALUES (3, 'MEDICO');

-- ----------------------------
-- Table structure for sangre
-- ----------------------------
DROP TABLE IF EXISTS `sangre`;
CREATE TABLE `sangre`  (
  `sag_id` int NOT NULL AUTO_INCREMENT,
  `tp_sangre` varchar(255) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`sag_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_spanish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sangre
-- ----------------------------

-- ----------------------------
-- Table structure for usuario
-- ----------------------------
DROP TABLE IF EXISTS `usuario`;
CREATE TABLE `usuario`  (
  `usu_id` int NOT NULL AUTO_INCREMENT,
  `usu_nombre` varchar(20) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  `usu_contrasena` varchar(255) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  `usu_sexo` char(1) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  `rol_id` int NULL DEFAULT NULL,
  `usu_estatus` enum('ACTIVO','INATIVO') CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  `usu_email` varchar(255) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  `usu_intento` int NULL DEFAULT NULL,
  PRIMARY KEY (`usu_id`) USING BTREE,
  INDEX `rol_id`(`rol_id`) USING BTREE,
  CONSTRAINT `usuario_ibfk_1` FOREIGN KEY (`rol_id`) REFERENCES `rol` (`rol_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 44 CHARACTER SET = utf8 COLLATE = utf8_spanish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of usuario
-- ----------------------------
INSERT INTO `usuario` VALUES (1, 'curso', '$2y$10$QgchwHKteWb7Ns3cHA2FuO8mGjXnZJ4scaj5nEusyvx4NDVhowK/G', 'M', 3, 'ACTIVO', 'daniel.valeros2012@gmail.com', 0);
INSERT INTO `usuario` VALUES (3, 'prueba', '$2y$10$cEzdbqRSjLff50kaaH9hmOyfj6o5IVa4PEn.lu3kxUtVwLfWvdWOC', 'F', 3, 'ACTIVO', 'prueba@gmail.com', 0);
INSERT INTO `usuario` VALUES (4, 'Andrew', '$2y$10$E7CM87G1TxTW1/bxzVF5k.MEU.MRww7/qgjmHd4wu6/3rydqkA1TO', 'M', 3, 'ACTIVO', 'andrew.contrera2012@gmail.com', 0);
INSERT INTO `usuario` VALUES (5, 'vero', '$2y$10$GU9cYfZJT/Z9Twm8EA8VBu/eS8PFTx5Rn5g5ml9YE5cFjlCo3rfOa', 'F', 1, 'ACTIVO', '', 0);
INSERT INTO `usuario` VALUES (6, 'betania', '$2y$10$5q/gAt/6bR/.UGxLjoGpZeRr2jLGJqYkbp/u/IV0O7yYw2lkvVIBO', 'F', 3, 'ACTIVO', 'betania@guerrero2010.com', NULL);
INSERT INTO `usuario` VALUES (7, 'daniel', '$2y$10$SGFD6sS6KRFwJ5RVR0OmuuqjHtbzl1FBPAQZ.CA.iAAqbutcdRgou', 'M', 2, 'ACTIVO', 'daniel.vale@homail.com', NULL);
INSERT INTO `usuario` VALUES (8, 'mateo', '$2y$10$fXL7Oqp7GFIbvV9nwvgcweaHyURnUVLMxTkMtlve6eIsE5dWoqDQS', 'M', 2, 'ACTIVO', 'mateo.lo@2020.com', 0);
INSERT INTO `usuario` VALUES (34, 'betania12', '$2y$10$g4Y6j8/abQO7UuYXKLWY5OMr/w.IZxJqaivUZ5YvmfZuuG.toVKA6', 'M', 3, 'ACTIVO', 'betania@guerrero2010.com', 0);
INSERT INTO `usuario` VALUES (35, 'ghfghfg', '$2y$10$uhm9GaDoeISaw.rvIConhe0jqAr8UA265BDDj.JBvO.rBi4LbDA/u', 'F', 3, 'ACTIVO', 'betania@guerrero2010.com', 0);
INSERT INTO `usuario` VALUES (36, 'ddsd', '$2y$10$PmtEKdqZ4e2XgT00YdLqQebe2ydKDanAkgaMnr7QWLw/fnypnJnUu', 'M', 3, 'ACTIVO', 'daniel.vale@homail.com', 0);
INSERT INTO `usuario` VALUES (37, 'nestor', '$2y$10$cNb25Qz/yzBdy0kv9o3qJOOI/rnN1t904uXpHLPPPS8HCV1jSWiiq', 'M', 3, 'ACTIVO', 'daniel.vale@homail.com', 0);
INSERT INTO `usuario` VALUES (38, 'cris', '$2y$10$9xgvLuaCl.lYTYLIcdBQhOjfu1jTX2mTDTdJx7WJtLeqcaStePemm', 'M', 2, 'ACTIVO', 'betania@guerrero2010.com', 0);
INSERT INTO `usuario` VALUES (39, 'dan', '$2y$10$29CX3Ja6C6ckGpO4mO90OuvM9b1TsfTfsApAzAz8l8EWuhFp9jgN6', 'M', 3, 'ACTIVO', 'betania@guerrero2010.com', 0);
INSERT INTO `usuario` VALUES (40, 'betania23', '$2y$10$ZUdAoomjy5WSQHveHsHbb.kJV7/JWwlgj37bg.WkKfGL847H041Qm', 'M', 3, 'ACTIVO', 'betania@guerrero2010.com', 0);
INSERT INTO `usuario` VALUES (41, 'andrewM', '$2y$10$8s7KBKDq4/QkZpeXMa8w/ekdG65ZcoHh4wBkUB8.nu0lvjJMbmZl6', 'M', 3, 'ACTIVO', 'pruebamail034@gmail.com', 0);
INSERT INTO `usuario` VALUES (42, 'danielM', '$2y$10$N2zsVXY160F5qbY7tYzxNuw73zppWmY0t4veFz5eu1fWhhLw31ssO', 'M', 3, 'ACTIVO', 'daniel.valeros2012@gmail.com', 0);
INSERT INTO `usuario` VALUES (43, 'betaniaM', '$2y$10$WFzPmkRxhhcLaD.xZtQq6.v1Gzzn3LOu3Ikt5H2od3WCLzehG4MHC', 'F', 3, 'ACTIVO', 'betania.guerrero@2010.com', 0);

-- ----------------------------
-- Procedure structure for SP_DASHBOARD
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_DASHBOARD`;
delimiter ;;
CREATE PROCEDURE `SP_DASHBOARD`()
SELECT
	COUNT(*) as paciente,
	(SELECT COUNT(*) FROM
	medico) as medico
FROM
	paciente
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_INTENTO_USUARIO
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_INTENTO_USUARIO`;
delimiter ;;
CREATE PROCEDURE `SP_INTENTO_USUARIO`(IN `USUARIO` VARCHAR(50))
BEGIN
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
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_LISTAR_CITA
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_LISTAR_CITA`;
delimiter ;;
CREATE PROCEDURE `SP_LISTAR_CITA`()
SELECT c.cita_id,c.cita_nroatencion,c.cita_feregistro,c.cita_estatus,p.paciente_id,concat_ws(' ',p.paciente_nombre,p.paciente_apepat,p.paciente_apemat) as paciente,c.medico_id,concat_ws(' ',m.medico_nombre,m.medico_apepart,m.medico_apemart) as medico, e.especialidad_id, e.especialidad_nombre, c.cita_descripcion 
FROM cita as c 
INNER JOIN paciente as p ON c.paciente_id=p.paciente_id
INNER JOIN medico as m on c.medico_id=m.medico_id
INNER JOIN especialidad as e ON e.especialidad_id=m.especialidad_id
ORDER BY cita_id DESC
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_LISTAR_COMBO_ESPECIALIDAD
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_LISTAR_COMBO_ESPECIALIDAD`;
delimiter ;;
CREATE PROCEDURE `SP_LISTAR_COMBO_ESPECIALIDAD`()
SELECT * FROM especialidad WHERE especialidad_estatus='ACTIVO'
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_LISTAR_COMBO_ROL
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_LISTAR_COMBO_ROL`;
delimiter ;;
CREATE PROCEDURE `SP_LISTAR_COMBO_ROL`()
SELECT
	rol.rol_id, 
	rol.rol_nombre
FROM
	rol
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_LISTAR_CONSULTA
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_LISTAR_CONSULTA`;
delimiter ;;
CREATE PROCEDURE `SP_LISTAR_CONSULTA`(IN `FECHAINICIO` DATE, IN `FECHAFIN` DATE)
SELECT
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
		WHERE consulta.consulta_feregistro BETWEEN FECHAINICIO AND FECHAFIN
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_LISTAR_CONSULTA_HISTORIAL
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_LISTAR_CONSULTA_HISTORIAL`;
delimiter ;;
CREATE PROCEDURE `SP_LISTAR_CONSULTA_HISTORIAL`()
SELECT
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
		WHERE consulta.consulta_feregistro=CURDATE()
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_LISTAR_DOCTOR_COMBO
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_LISTAR_DOCTOR_COMBO`;
delimiter ;;
CREATE PROCEDURE `SP_LISTAR_DOCTOR_COMBO`(IN `ID` INT)
SELECT `medico_id`,concat_ws(' ',`medico_nombre`,`medico_apepart`,`medico_apemart`)FROM medico where `especialidad_id` = ID
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_LISTAR_ESPECIALIDAD
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_LISTAR_ESPECIALIDAD`;
delimiter ;;
CREATE PROCEDURE `SP_LISTAR_ESPECIALIDAD`()
SELECT * FROM especialidad
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_LISTAR_ESPECIALIDAD_COMBO
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_LISTAR_ESPECIALIDAD_COMBO`;
delimiter ;;
CREATE PROCEDURE `SP_LISTAR_ESPECIALIDAD_COMBO`()
SELECT especialidad_id,especialidad_nombre FROM especialidad
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_LISTAR_HISTORIAL
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_LISTAR_HISTORIAL`;
delimiter ;;
CREATE PROCEDURE `SP_LISTAR_HISTORIAL`(IN `FECHAINICIO` DATE, IN `FECHAFIN` DATE)
SELECT
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
WHERE fua.fua_fegistro BETWEEN FECHAINICIO AND FECHAFIN
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_LISTAR_INSUMO
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_LISTAR_INSUMO`;
delimiter ;;
CREATE PROCEDURE `SP_LISTAR_INSUMO`()
SELECT * FROM insumo
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_LISTAR_INSUMO_COMBO
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_LISTAR_INSUMO_COMBO`;
delimiter ;;
CREATE PROCEDURE `SP_LISTAR_INSUMO_COMBO`()
SELECT
	insumo.insumo_id, 
	insumo.insumo_nombre
FROM
	insumo
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_LISTAR_INSUMO_DETALLE
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_LISTAR_INSUMO_DETALLE`;
delimiter ;;
CREATE PROCEDURE `SP_LISTAR_INSUMO_DETALLE`(IN `IDFUA` INT)
SELECT
	insumo.insumo_nombre, 
	detalle_insumo.detain_cantidad
FROM
	detalle_insumo
	INNER JOIN
	insumo
	ON 
		detalle_insumo.insumo_id = insumo.insumo_id
		WHERE detalle_insumo.fua_id=IDFUA
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_LISTAR_MEDICAMENTO
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_LISTAR_MEDICAMENTO`;
delimiter ;;
CREATE PROCEDURE `SP_LISTAR_MEDICAMENTO`()
SELECT * FROM medicamento
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_LISTAR_MEDICAMENTO_COMBO
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_LISTAR_MEDICAMENTO_COMBO`;
delimiter ;;
CREATE PROCEDURE `SP_LISTAR_MEDICAMENTO_COMBO`()
SELECT
	medicamento.medicamento_id, 
	medicamento.medicamento_nombre
FROM
	medicamento
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_LISTAR_MEDICAMENTO_DETALLE
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_LISTAR_MEDICAMENTO_DETALLE`;
delimiter ;;
CREATE PROCEDURE `SP_LISTAR_MEDICAMENTO_DETALLE`(IN `IDFUA` INT)
SELECT
	medicamento.medicamento_nombre, 
	detalle_medicamento.detame_cantidad
FROM
	detalle_medicamento
	INNER JOIN
	medicamento
	ON 
		detalle_medicamento.medicamento_id = medicamento.medicamento_id
		WHERE detalle_medicamento.fua_id=IDFUA
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_LISTAR_MEDICO
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_LISTAR_MEDICO`;
delimiter ;;
CREATE PROCEDURE `SP_LISTAR_MEDICO`()
SELECT
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
INNER JOIN usuario ON medico.usu_id = usuario.usu_id
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_LISTAR_PACIENTE
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_LISTAR_PACIENTE`;
delimiter ;;
CREATE PROCEDURE `SP_LISTAR_PACIENTE`()
SELECT
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
paciente
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_LISTAR_PACIENTE_CITA
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_LISTAR_PACIENTE_CITA`;
delimiter ;;
CREATE PROCEDURE `SP_LISTAR_PACIENTE_CITA`()
SELECT
	cita.cita_id, 
	cita.cita_nroatencion, 
	CONCAT_WS(' ',paciente.paciente_nombre,paciente.paciente_apepat,paciente.paciente_apemat)
FROM
	cita
	INNER JOIN
	paciente
	ON 
		cita.paciente_id = paciente.paciente_id
		WHERE cita_feregistro=CURDATE() AND cita_estatus='PENDIENTE'
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_LISTAR_PACIENTE_COMBO
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_LISTAR_PACIENTE_COMBO`;
delimiter ;;
CREATE PROCEDURE `SP_LISTAR_PACIENTE_COMBO`()
SELECT paciente_id,concat_ws(' ',paciente_nombre,paciente_apepat,paciente_apemat) FROM paciente
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_LISTAR_PROCEDIMIENTO
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_LISTAR_PROCEDIMIENTO`;
delimiter ;;
CREATE PROCEDURE `SP_LISTAR_PROCEDIMIENTO`()
SELECT * FROM procedimiento
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_LISTAR_PROCEDIMIENTO_COMBO
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_LISTAR_PROCEDIMIENTO_COMBO`;
delimiter ;;
CREATE PROCEDURE `SP_LISTAR_PROCEDIMIENTO_COMBO`()
SELECT
	procedimiento.procedimiento_id, 
	procedimiento.procedimiento_nombre
FROM
	procedimiento
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_LISTAR_PROCEDIMIENTO_DETALLE
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_LISTAR_PROCEDIMIENTO_DETALLE`;
delimiter ;;
CREATE PROCEDURE `SP_LISTAR_PROCEDIMIENTO_DETALLE`(IN `IDFUA` INT)
SELECT
	procedimiento.procedimiento_nombre
FROM
	detalle_procedimiento
	INNER JOIN
	procedimiento
	ON 
		detalle_procedimiento.procedimiento_id = procedimiento.procedimiento_id
		WHERE detalle_procedimiento.fua_id=IDFUA
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_LISTAR_USUARIO
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_LISTAR_USUARIO`;
delimiter ;;
CREATE PROCEDURE `SP_LISTAR_USUARIO`()
BEGIN
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
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_MODIFICAR_CITA
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_MODIFICAR_CITA`;
delimiter ;;
CREATE PROCEDURE `SP_MODIFICAR_CITA`(IN `IDCITA` INT, IN `IDPACIENTE` INT, IN `IDDOCTOR` INT, IN `IDESPECIALIDAD` INT, IN `DESCRIPCION` TEXT, IN `ESTATUS` VARCHAR(10))
UPDATE cita SET
paciente_id=IDPACIENTE,
medico_id=IDDOCTOR,
especialidad_id=IDESPECIALIDAD,
cita_descripcion=DESCRIPCION,
cita_estatus=ESTATUS
where cita_id=IDCITA
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_MODIFICAR_CONSULTA
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_MODIFICAR_CONSULTA`;
delimiter ;;
CREATE PROCEDURE `SP_MODIFICAR_CONSULTA`(IN `IDCONSULTA` INT, IN `DESCRIPCION` VARCHAR(255), IN `DIAGNOSTICO` VARCHAR(255))
UPDATE consulta SET
consulta_descripcion=DESCRIPCION,
consulta_diagnostico=DIAGNOSTICO
WHERE consulta_id=IDCONSULTA
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_MODIFICAR_CONTRA_USUARIO
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_MODIFICAR_CONTRA_USUARIO`;
delimiter ;;
CREATE PROCEDURE `SP_MODIFICAR_CONTRA_USUARIO`(IN `IDUSUARIO` INT, IN `CONTRA` VARCHAR(250))
UPDATE usuario SET
usu_contrasena=CONTRA
WHERE usu_id=IDUSUARIO
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_MODIFICAR_DATOS_USUARIO
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_MODIFICAR_DATOS_USUARIO`;
delimiter ;;
CREATE PROCEDURE `SP_MODIFICAR_DATOS_USUARIO`(IN `IDUSUARIO` INT, IN `SEXO` CHAR(1), IN `IDROL` INT, IN `EMAIL` VARCHAR(250))
UPDATE usuario SET
usu_sexo=SEXO,
rol_id=IDROL,
usu_email=EMAIL
WHERE usu_id=IDUSUARIO
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_MODIFICAR_ESPECIALIDAD
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_MODIFICAR_ESPECIALIDAD`;
delimiter ;;
CREATE PROCEDURE `SP_MODIFICAR_ESPECIALIDAD`(IN `ID` INT, IN `ESPECIALIDADACTUAL` VARCHAR(50), IN `ESPECIALIDADNUEVA` VARCHAR(50), IN `ESTATUS` VARCHAR(10))
BEGIN
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
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_MODIFICAR_ESTATUS_USUARIO
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_MODIFICAR_ESTATUS_USUARIO`;
delimiter ;;
CREATE PROCEDURE `SP_MODIFICAR_ESTATUS_USUARIO`(IN `IDUSUARIO` INT, IN `ESTATUS` VARCHAR(20))
UPDATE usuario SET
usu_estatus=ESTATUS
WHERE usu_id=IDUSUARIO
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_MODIFICAR_INSUMO
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_MODIFICAR_INSUMO`;
delimiter ;;
CREATE PROCEDURE `SP_MODIFICAR_INSUMO`(IN `ID` INT, IN `INSUMOACTUAL` VARCHAR(50), IN `INSUMONUEVO` VARCHAR(50), IN `STOCK` INT, IN `ESTATUS` VARCHAR(10))
BEGIN
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
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_MODIFICAR_MEDICAMENTO
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_MODIFICAR_MEDICAMENTO`;
delimiter ;;
CREATE PROCEDURE `SP_MODIFICAR_MEDICAMENTO`(IN `ID` INT, IN `MEDICAMENTOACTUAL` VARCHAR(50), IN `MEDICAMENTONUEVO` VARCHAR(50), IN `ALIAS` VARCHAR(50), IN `STOCK` INT, IN `ESTATUS` VARCHAR(10))
BEGIN
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


END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_MODIFICAR_MEDICO
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_MODIFICAR_MEDICO`;
delimiter ;;
CREATE PROCEDURE `SP_MODIFICAR_MEDICO`(IN `IDMEDICO` INT, IN `NOMBRES` VARCHAR(50), IN `APEPAT` VARCHAR(50), IN `APEMAT` VARCHAR(50), IN `DIRECCION` VARCHAR(200), IN `MOVIL` CHAR(12), IN `SEXO` CHAR(2), IN `FECHANACIMIENTO` DATE, IN `NRDOCUMENTOACTUAL` CHAR(12), IN `NRDOCUMENTONUEVO` CHAR(12), IN `COLEGIATURAACTUAL` CHAR(12), IN `COLEGIATURANUEVO` CHAR(12), IN `ESPECIALIDAD` INT, IN `IDUSUARIO` INT, IN `EMAIL` VARCHAR(255))
BEGIN
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



END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_MODIFICAR_PACIENTE
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_MODIFICAR_PACIENTE`;
delimiter ;;
CREATE PROCEDURE `SP_MODIFICAR_PACIENTE`(IN `ID` INT, IN `NOMBRE` VARCHAR(50), IN `APEPAT` VARCHAR(50), IN `APEMAT` VARCHAR(50), IN `DIRECCION` VARCHAR(200), IN `MOVIL` CHAR(12), IN `SEXO` CHAR(1), IN `NRDOCUMENTOACTUAL` CHAR(12), IN `NRDOCUMENTONUEVO` CHAR(12), IN `ESTATUS` CHAR(10))
BEGIN
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
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_MODIFICAR_PROCEDIMIENTO
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_MODIFICAR_PROCEDIMIENTO`;
delimiter ;;
CREATE PROCEDURE `SP_MODIFICAR_PROCEDIMIENTO`(IN `ID` INT, IN `PROCEDIMIENTOACTUAL` VARCHAR(50), IN `PROCEDIMIENTONUEVO` VARCHAR(50), IN `ESTATUS` VARCHAR(10))
BEGIN
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


END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_REGISTRAR_CITA
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_REGISTRAR_CITA`;
delimiter ;;
CREATE PROCEDURE `SP_REGISTRAR_CITA`(IN `IDPACIENTE` INT, IN `IDDOCTOR` INT, IN `DESCRIPCION` TEXT, IN `IDUSUARIO` INT)
BEGIN
DECLARE NUMCITA INT;
SET @NUMCITA:=(SELECT COUNT(*) +1 FROM cita WHERE cita_feregistro=CURDATE());
INSERT INTO cita(cita_nroatencion,cita_feregistro,medico_id,paciente_id,cita_estatus,cita_descripcion,usu_id) VALUES(@NUMCITA,CURDATE(),IDDOCTOR,IDPACIENTE,'PENDIENTE',DESCRIPCION,IDUSUARIO);
SELECT LAST_INSERT_ID();

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_REGISTRAR_CONSULTA
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_REGISTRAR_CONSULTA`;
delimiter ;;
CREATE PROCEDURE `SP_REGISTRAR_CONSULTA`(IN `ID` INT, IN `DESCRIPCION` VARCHAR(255), IN `DIAGNOSTICO` VARCHAR(255))
BEGIN
INSERT INTO consulta(consulta_descripcion,consulta_diagnostico,consulta_feregistro,consulta_estatus,cita_id) VALUES(DESCRIPCION,DIAGNOSTICO,CURDATE(),'ATENDIDA',ID);
UPDATE cita SET
cita_estatus='ATENDIDA'
WHERE cita_id=ID;

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_REGISTRAR_ESPECIALIDAD
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_REGISTRAR_ESPECIALIDAD`;
delimiter ;;
CREATE PROCEDURE `SP_REGISTRAR_ESPECIALIDAD`(IN `ESPECIALIDAD` VARCHAR(50), IN `ESTATUS` VARCHAR(10))
BEGIN
DECLARE CANTIDAD INT;
SET @CANTIDAD:=(SELECT COUNT(*) FROM especialidad WHERE especialidad_nombre=ESPECIALIDAD);
IF @CANTIDAD= 0 THEN
INSERT INTO especialidad(especialidad_nombre,especialidad_fregistro,especialidad_estatus) VALUES(ESPECIALIDAD,CURDATE(),ESTATUS);
SELECT 1;

ELSE
SELECT 2;
END IF;

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_REGISTRAR_INSUMO
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_REGISTRAR_INSUMO`;
delimiter ;;
CREATE PROCEDURE `SP_REGISTRAR_INSUMO`(IN `INSUMO` VARCHAR(50), IN `STOCK` INT, IN `ESTATUS` VARCHAR(10))
BEGIN
DECLARE CANTIDAD INT;
SET @CANTIDAD:=(SELECT COUNT(*) FROM insumo WHERE insumo_nombre=INSUMO);

IF @CANTIDAD = 0 THEN
INSERT INTO insumo(insumo_nombre,insumo_stock,insumo_fregistro,insumo_estatus)
VALUES(INSUMO,STOCK,CURDATE(),ESTATUS);
SELECT 1;
ELSE
SELECT 2;
END IF;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_REGISTRAR_MEDICAMENTO
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_REGISTRAR_MEDICAMENTO`;
delimiter ;;
CREATE PROCEDURE `SP_REGISTRAR_MEDICAMENTO`(IN `MEDICAMENTO` VARCHAR(50), IN `ALIAS` VARCHAR(50), IN `STOCK` INT, IN `ESTATUS` VARCHAR(10))
BEGIN
DECLARE CANTIDAD INT;
SET @CANTIDAD:=(SELECT COUNT(*) FROM medicamento WHERE medicamento_nombre=MEDICAMENTO);
IF @CANTIDAD=0 THEN
	INSERT INTO medicamento(medicamento_nombre,medicamento_alias,medicamento_stock,medicamento_fregistro,medicamento_estatus)
	VALUES(MEDICAMENTO,ALIAS,STOCK,CURDATE(),ESTATUS);
	SELECT 1;
ELSE
	SELECT 2;

END IF;

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_REGISTRAR_MEDICO
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_REGISTRAR_MEDICO`;
delimiter ;;
CREATE PROCEDURE `SP_REGISTRAR_MEDICO`(IN `NOMBRES` VARCHAR(50), IN `APEPAT` VARCHAR(50), IN `APEMAT` VARCHAR(50), IN `DIRECCION` VARCHAR(200), IN `MOVIL` CHAR(12), IN `SEXO` CHAR(2), IN `FECHANACIMIENTO` DATE, IN `NRDOCUMENTO` CHAR(12), IN `COLEGIATURA` CHAR(12), IN `ESPECIALIDAD` INT, IN `USUARIO` VARCHAR(20), IN `CONTRA` VARCHAR(255), IN `ROL` INT, IN `EMAIl` VARCHAR(255))
BEGIN 
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

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_REGISTRAR_PACIENTE
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_REGISTRAR_PACIENTE`;
delimiter ;;
CREATE PROCEDURE `SP_REGISTRAR_PACIENTE`(IN `NOMBRE` VARCHAR(50), IN `APEPAT` VARCHAR(50), IN `APEMAT` VARCHAR(50), IN `DIRECCION` VARCHAR(200), IN `MOVIL` CHAR(12), IN `SEXO` CHAR(1), IN `NRDOCUMENTO` CHAR(12))
BEGIN
DECLARE CANTIDAD INT;
SET @CANTIDAD :=(SELECT COUNT(*) FROM paciente where paciente_nrodocumento=NRDOCUMENTO);
IF @CANTIDAD=0 THEN
	INSERT INTO paciente(paciente_nombre,paciente_apepat,paciente_apemat,paciente_direccion,paciente_movil,paciente_sexo,paciente_nrodocumento,paciente_estatus) VALUES(NOMBRE,APEPAT,APEMAT,DIRECCION,MOVIL,SEXO,NRDOCUMENTO,'ACTIVO');
    SELECT 1;
   ELSE
    SELECT 2;
    END IF;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_REGISTRAR_PROCEDIMIENTO
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_REGISTRAR_PROCEDIMIENTO`;
delimiter ;;
CREATE PROCEDURE `SP_REGISTRAR_PROCEDIMIENTO`(IN `PROCEDIMIENTO` VARCHAR(50), IN `ESTATUS` VARCHAR(10))
BEGIN
DECLARE CANTIDA INT;
SET @CANTIDAD:=(SELECT count(*) FROM procedimiento WHERE procedimiento_nombre=PROCEDIMIENTO);
IF @CANTIDAD = 0 THEN
 INSERT INTO procedimiento(procedimiento_nombre,procedimiento_fecregistro,procedimiento_estatus)VALUES(PROCEDIMIENTO,CURDATE(),ESTATUS);
 SELECT 1;
ELSE
 SELECT 2;
END IF;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_REGISTRAR_USUARIO
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_REGISTRAR_USUARIO`;
delimiter ;;
CREATE PROCEDURE `SP_REGISTRAR_USUARIO`(IN `USU` VARCHAR(20), IN `CONTRA` VARCHAR(250), IN `SEXO` CHAR(1), IN `ROL` INT, IN `EMAIL` VARCHAR(250))
BEGIN
DECLARE CANTIDAD INT;
SET @CANTIDAD:=(SELECT count(*) FROM usuario WHERE usu_nombre= BINARY USU);
IF @CANTIDAD=0 THEN
	INSERT INTO usuario(usu_nombre,usu_contrasena,usu_sexo,rol_id,usu_estatus,usu_email,usu_intento) VALUES (USU,CONTRA,SEXO,ROL,'ACTIVO',EMAIL,0);
	SELECT 1;
ELSE
	SELECT 2;
END IF;

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_REGRISTRAR_DETALLE_INSUMO
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_REGRISTRAR_DETALLE_INSUMO`;
delimiter ;;
CREATE PROCEDURE `SP_REGRISTRAR_DETALLE_INSUMO`(IN `IDFUA` INT, IN `IDINSUMO` INT, IN `CANTIDADINSUMO` INT)
INSERT INTO detalle_insumo(fua_id,insumo_id,detain_cantidad)values(IDFUA,IDINSUMO,CANTIDADINSUMO)
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_REGRISTRAR_DETALLE_MEDICAMENTO
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_REGRISTRAR_DETALLE_MEDICAMENTO`;
delimiter ;;
CREATE PROCEDURE `SP_REGRISTRAR_DETALLE_MEDICAMENTO`(IN `IDFUA` INT, IN `IDMEDICAMENTO` INT, IN `CANTIDAD` INT)
INSERT INTO detalle_medicamento(fua_id,medicamento_id,detame_cantidad)values(IDFUA,IDMEDICAMENTO,CANTIDAD)
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_REGRISTRAR_DETALLE_PROCEDIMIENTO
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_REGRISTRAR_DETALLE_PROCEDIMIENTO`;
delimiter ;;
CREATE PROCEDURE `SP_REGRISTRAR_DETALLE_PROCEDIMIENTO`(IN `ID` INT, IN `IDPROCEDIMIENTO` INT)
INSERT INTO detalle_procedimiento(fua_id,procedimiento_id)values(ID,IDPROCEDIMIENTO)
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_REGRISTRAR_FUA
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_REGRISTRAR_FUA`;
delimiter ;;
CREATE PROCEDURE `SP_REGRISTRAR_FUA`(IN `IDHISTORIAL` INT, IN `IDCONSULTA` INT)
BEGIN
	INSERT INTO fua(fua_fegistro,historia_id,consulta_id)VALUES(CURDATE(),IDHISTORIAL,IDCONSULTA);
	SELECT LAST_INSERT_ID();

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_RETABLECER_CONTRA
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_RETABLECER_CONTRA`;
delimiter ;;
CREATE PROCEDURE `SP_RETABLECER_CONTRA`(IN `EMAIL` VARCHAR(255), IN `CONTRA` VARCHAR(255))
BEGIN
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

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_TRAER_STOCK_INSUMO_H
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_TRAER_STOCK_INSUMO_H`;
delimiter ;;
CREATE PROCEDURE `SP_TRAER_STOCK_INSUMO_H`(IN `ID` INT)
SELECT
	insumo.insumo_id, 
	insumo.insumo_stock
FROM
	insumo
	WHERE insumo.insumo_id=ID
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_TRAER_STOCK_MEDICAMENTO_H
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_TRAER_STOCK_MEDICAMENTO_H`;
delimiter ;;
CREATE PROCEDURE `SP_TRAER_STOCK_MEDICAMENTO_H`(IN `ID` INT)
SELECT
	medicamento.medicamento_nombre, 
	medicamento.medicamento_stock
FROM
	medicamento
	WHERE medicamento.medicamento_id=ID
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_VERIFICAR_USUARIO
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_VERIFICAR_USUARIO`;
delimiter ;;
CREATE PROCEDURE `SP_VERIFICAR_USUARIO`(IN `USUARIO` VARCHAR(20))
SELECT
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
	WHERE usu_nombre = BINARY USUARIO
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table detalle_insumo
-- ----------------------------
DROP TRIGGER IF EXISTS `TR_STOCK_INSUMO`;
delimiter ;;
CREATE TRIGGER `TR_STOCK_INSUMO` BEFORE INSERT ON `detalle_insumo` FOR EACH ROW BEGIN
DECLARE STOCKACTUAL DECIMAL(10,2);
SET @STOCKACTUAL:=(SELECT insumo_stock FROM insumo WHERE insumo_id=new.insumo_id);
UPDATE insumo SET
insumo_stock=@STOCKACTUAL-new.detain_cantidad
WHERE insumo_id=new.insumo_id;

END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table detalle_medicamento
-- ----------------------------
DROP TRIGGER IF EXISTS `TR_STOCK_MEDICAMENTO`;
delimiter ;;
CREATE TRIGGER `TR_STOCK_MEDICAMENTO` BEFORE INSERT ON `detalle_medicamento` FOR EACH ROW BEGIN
DECLARE STOCKACTUAL DECIMAL(10,2);
SET @STOCKACTUAL:=(SELECT medicamento_stock FROM medicamento WHERE medicamento_id=new.medicamento_id);
UPDATE medicamento SET
medicamento_stock=@STOCKACTUAL-new.detame_cantidad
WHERE medicamento_id=new.medicamento_id;

END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table paciente
-- ----------------------------
DROP TRIGGER IF EXISTS `TR_CREAR_HISTORIA`;
delimiter ;;
CREATE TRIGGER `TR_CREAR_HISTORIA` AFTER INSERT ON `paciente` FOR EACH ROW INSERT INTO 
historia(paciente_id,historia_feregistro)
VALUES (new.paciente_id,curdate())
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
