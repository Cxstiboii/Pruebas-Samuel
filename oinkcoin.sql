CREATE DATABASE  IF NOT EXISTS `oinkcoin` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;
USE `oinkcoin`;
-- MySQL dump 10.13  Distrib 8.0.44, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: oinkcoin
-- ------------------------------------------------------
-- Server version	5.5.5-10.4.32-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `bolsillo_virtual`
--

DROP TABLE IF EXISTS `bolsillo_virtual`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bolsillo_virtual` (
  `id_bolsillo_virtual` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_bolsillo_virtual` varchar(100) NOT NULL,
  `proposito_bolsillo_virtual` text DEFAULT NULL,
  `saldo_bolsillo_virtual` decimal(15,2) DEFAULT 0.00 CHECK (`saldo_bolsillo_virtual` >= 0),
  `id_usuario` int(11) NOT NULL,
  PRIMARY KEY (`id_bolsillo_virtual`),
  KEY `idx_usuario_bolsillo` (`id_usuario`),
  CONSTRAINT `bolsillo_virtual_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bolsillo_virtual`
--

LOCK TABLES `bolsillo_virtual` WRITE;
/*!40000 ALTER TABLE `bolsillo_virtual` DISABLE KEYS */;
/*!40000 ALTER TABLE `bolsillo_virtual` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categoria`
--

DROP TABLE IF EXISTS `categoria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categoria` (
  `id_categoria` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_categoria` varchar(50) NOT NULL,
  `color_categoria` varchar(7) DEFAULT '#000000',
  `icono_categoria` varchar(50) DEFAULT NULL,
  `es_predefinida` tinyint(1) DEFAULT 0,
  `es_personalizada` tinyint(1) DEFAULT 1,
  `id_usuario` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_categoria`),
  KEY `idx_usuario_categoria` (`id_usuario`),
  KEY `idx_nombre_categoria` (`nombre_categoria`),
  CONSTRAINT `categoria_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categoria`
--

LOCK TABLES `categoria` WRITE;
/*!40000 ALTER TABLE `categoria` DISABLE KEYS */;
INSERT INTO `categoria` VALUES (1,'Alimentación','#FF6B6B','restaurant',1,0,NULL),(2,'Transporte','#4ECDC4','directions_car',1,0,NULL),(3,'Vivienda','#45B7D1','home',1,0,NULL),(4,'Entretenimiento','#FFA07A','movie',1,0,NULL),(5,'Salud','#98D8C8','local_hospital',1,0,NULL),(6,'Educación','#6C5CE7','school',1,0,NULL),(7,'Servicios','#FDCB6E','build',1,0,NULL),(8,'Ropa y Accesorios','#A29BFE','shopping_bag',1,0,NULL),(9,'Tecnología','#00B894','computer',1,0,NULL),(10,'Otros','#95A5A6','more_horiz',1,0,NULL);
/*!40000 ALTER TABLE `categoria` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comparativa`
--

DROP TABLE IF EXISTS `comparativa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comparativa` (
  `id_comparativa` int(11) NOT NULL AUTO_INCREMENT,
  `meses_comparados` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`meses_comparados`)),
  `fecha_generacion` timestamp NOT NULL DEFAULT current_timestamp(),
  `id_usuario` int(11) NOT NULL,
  PRIMARY KEY (`id_comparativa`),
  KEY `idx_usuario_comparativa` (`id_usuario`),
  CONSTRAINT `comparativa_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comparativa`
--

LOCK TABLES `comparativa` WRITE;
/*!40000 ALTER TABLE `comparativa` DISABLE KEYS */;
/*!40000 ALTER TABLE `comparativa` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dashboard`
--

DROP TABLE IF EXISTS `dashboard`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dashboard` (
  `id_dashboard` int(11) NOT NULL AUTO_INCREMENT,
  `id_usuario` int(11) NOT NULL,
  `total_ingresos_mes` decimal(15,2) DEFAULT 0.00,
  `total_gastos_mes` decimal(15,2) DEFAULT 0.00,
  `balance_actual` decimal(15,2) DEFAULT 0.00,
  `ultima_actualizacion` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id_dashboard`),
  UNIQUE KEY `id_usuario` (`id_usuario`),
  CONSTRAINT `dashboard_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dashboard`
--

LOCK TABLES `dashboard` WRITE;
/*!40000 ALTER TABLE `dashboard` DISABLE KEYS */;
/*!40000 ALTER TABLE `dashboard` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `grafico`
--

DROP TABLE IF EXISTS `grafico`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `grafico` (
  `id_grafico` int(11) NOT NULL AUTO_INCREMENT,
  `tipo_grafico` enum('BARRAS','LINEAS','PIE','DONA','AREA') NOT NULL,
  `titulo` varchar(150) NOT NULL,
  `fecha_generacion` timestamp NOT NULL DEFAULT current_timestamp(),
  `id_usuario` int(11) NOT NULL,
  PRIMARY KEY (`id_grafico`),
  KEY `idx_usuario_grafico` (`id_usuario`),
  KEY `idx_fecha_grafico` (`fecha_generacion`),
  CONSTRAINT `grafico_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `grafico`
--

LOCK TABLES `grafico` WRITE;
/*!40000 ALTER TABLE `grafico` DISABLE KEYS */;
/*!40000 ALTER TABLE `grafico` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `meta_ahorro`
--

DROP TABLE IF EXISTS `meta_ahorro`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `meta_ahorro` (
  `id_meta_ahorro` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_meta_ahorro` varchar(100) NOT NULL,
  `monto_objetivo` decimal(15,2) NOT NULL CHECK (`monto_objetivo` > 0),
  `monto_actual` decimal(15,2) DEFAULT 0.00 CHECK (`monto_actual` >= 0),
  `fecha_limite` date DEFAULT NULL,
  `completada` tinyint(1) DEFAULT 0,
  `id_usuario` int(11) NOT NULL,
  PRIMARY KEY (`id_meta_ahorro`),
  KEY `idx_usuario_meta` (`id_usuario`),
  KEY `idx_completada` (`completada`),
  KEY `idx_fecha_limite` (`fecha_limite`),
  CONSTRAINT `meta_ahorro_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `meta_ahorro`
--

LOCK TABLES `meta_ahorro` WRITE;
/*!40000 ALTER TABLE `meta_ahorro` DISABLE KEYS */;
/*!40000 ALTER TABLE `meta_ahorro` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER trg_completar_meta_ahorro
BEFORE UPDATE ON meta_ahorro
FOR EACH ROW
BEGIN
    IF NEW.monto_actual >= NEW.monto_objetivo THEN
        SET NEW.completada = TRUE;
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `password_reset_token`
--

DROP TABLE IF EXISTS `password_reset_token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `password_reset_token` (
  `id_token` int(11) NOT NULL AUTO_INCREMENT,
  `token` varchar(255) NOT NULL,
  `fecha_expiracion` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `usado` tinyint(1) DEFAULT 0,
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp(),
  `id_usuario` int(11) NOT NULL,
  PRIMARY KEY (`id_token`),
  UNIQUE KEY `token_unique` (`token`),
  KEY `idx_token` (`token`),
  KEY `idx_usuario_token` (`id_usuario`),
  CONSTRAINT `password_reset_token_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `password_reset_token`
--

LOCK TABLES `password_reset_token` WRITE;
/*!40000 ALTER TABLE `password_reset_token` DISABLE KEYS */;
/*!40000 ALTER TABLE `password_reset_token` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `presupuesto`
--

DROP TABLE IF EXISTS `presupuesto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `presupuesto` (
  `id_presupuesto` int(11) NOT NULL AUTO_INCREMENT,
  `monto_limite` decimal(15,2) NOT NULL CHECK (`monto_limite` >= 0),
  `monto_gastado` decimal(15,2) DEFAULT 0.00 CHECK (`monto_gastado` >= 0),
  `fecha_presupuesto` date NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `id_categoria` int(11) NOT NULL,
  PRIMARY KEY (`id_presupuesto`),
  KEY `idx_usuario_presupuesto` (`id_usuario`),
  KEY `idx_categoria_presupuesto` (`id_categoria`),
  KEY `idx_fecha_presupuesto` (`fecha_presupuesto`),
  KEY `idx_usuario_fecha` (`id_usuario`,`fecha_presupuesto`),
  CONSTRAINT `presupuesto_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`) ON DELETE CASCADE,
  CONSTRAINT `presupuesto_ibfk_2` FOREIGN KEY (`id_categoria`) REFERENCES `categoria` (`id_categoria`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `presupuesto`
--

LOCK TABLES `presupuesto` WRITE;
/*!40000 ALTER TABLE `presupuesto` DISABLE KEYS */;
/*!40000 ALTER TABLE `presupuesto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `proyecto`
--

DROP TABLE IF EXISTS `proyecto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `proyecto` (
  `id_proyecto` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_proyecto` varchar(100) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `fecha_inicio` date NOT NULL,
  `fecha_fin` date DEFAULT NULL,
  `id_usuario` int(11) NOT NULL,
  PRIMARY KEY (`id_proyecto`),
  KEY `idx_usuario_proyecto` (`id_usuario`),
  KEY `idx_fechas_proyecto` (`fecha_inicio`,`fecha_fin`),
  CONSTRAINT `proyecto_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `proyecto`
--

LOCK TABLES `proyecto` WRITE;
/*!40000 ALTER TABLE `proyecto` DISABLE KEYS */;
/*!40000 ALTER TABLE `proyecto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reporte`
--

DROP TABLE IF EXISTS `reporte`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reporte` (
  `id_reporte` int(11) NOT NULL AUTO_INCREMENT,
  `tipo_reporte` enum('MENSUAL','TRIMESTRAL','SEMESTRAL','ANUAL','PERSONALIZADO','CATEGORIA') NOT NULL,
  `fecha_inicio` date NOT NULL,
  `fecha_fin` date NOT NULL,
  `fecha_generacion` timestamp NOT NULL DEFAULT current_timestamp(),
  `id_usuario` int(11) NOT NULL,
  PRIMARY KEY (`id_reporte`),
  KEY `idx_usuario_reporte` (`id_usuario`),
  KEY `idx_fechas_reporte` (`fecha_inicio`,`fecha_fin`),
  KEY `idx_tipo_reporte` (`tipo_reporte`),
  CONSTRAINT `reporte_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reporte`
--

LOCK TABLES `reporte` WRITE;
/*!40000 ALTER TABLE `reporte` DISABLE KEYS */;
/*!40000 ALTER TABLE `reporte` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `resumen_mensual`
--

DROP TABLE IF EXISTS `resumen_mensual`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `resumen_mensual` (
  `id_resumen_mensual` int(11) NOT NULL AUTO_INCREMENT,
  `mes` int(11) NOT NULL CHECK (`mes` between 1 and 12),
  `ano` int(11) NOT NULL CHECK (`ano` >= 2020),
  `total_ingresos` decimal(15,2) DEFAULT 0.00,
  `total_gastos` decimal(15,2) DEFAULT 0.00,
  `balance` decimal(15,2) DEFAULT 0.00,
  `id_usuario` int(11) NOT NULL,
  PRIMARY KEY (`id_resumen_mensual`),
  UNIQUE KEY `unique_mes_ano_usuario` (`mes`,`ano`,`id_usuario`),
  KEY `idx_usuario_resumen` (`id_usuario`),
  KEY `idx_mes_ano` (`mes`,`ano`),
  CONSTRAINT `resumen_mensual_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `resumen_mensual`
--

LOCK TABLES `resumen_mensual` WRITE;
/*!40000 ALTER TABLE `resumen_mensual` DISABLE KEYS */;
/*!40000 ALTER TABLE `resumen_mensual` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transaccion`
--

DROP TABLE IF EXISTS `transaccion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transaccion` (
  `id_transaccion` int(11) NOT NULL AUTO_INCREMENT,
  `monto_transaccion` decimal(15,2) NOT NULL CHECK (`monto_transaccion` <> 0),
  `tipo_transaccion` enum('INGRESO','GASTO') NOT NULL,
  `descripcion` varchar(255) DEFAULT NULL,
  `fecha` timestamp NOT NULL DEFAULT current_timestamp(),
  `es_recurrente` tinyint(1) DEFAULT 0,
  `id_usuario` int(11) NOT NULL,
  `id_categoria` int(11) NOT NULL,
  `id_proyecto` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_transaccion`),
  KEY `idx_usuario_transaccion` (`id_usuario`),
  KEY `idx_categoria_transaccion` (`id_categoria`),
  KEY `idx_proyecto_transaccion` (`id_proyecto`),
  KEY `idx_fecha_transaccion` (`fecha`),
  KEY `idx_tipo_transaccion` (`tipo_transaccion`),
  KEY `idx_usuario_fecha` (`id_usuario`,`fecha`),
  KEY `idx_usuario_tipo` (`id_usuario`,`tipo_transaccion`),
  CONSTRAINT `transaccion_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`) ON DELETE CASCADE,
  CONSTRAINT `transaccion_ibfk_2` FOREIGN KEY (`id_categoria`) REFERENCES `categoria` (`id_categoria`),
  CONSTRAINT `transaccion_ibfk_3` FOREIGN KEY (`id_proyecto`) REFERENCES `proyecto` (`id_proyecto`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transaccion`
--

LOCK TABLES `transaccion` WRITE;
/*!40000 ALTER TABLE `transaccion` DISABLE KEYS */;
/*!40000 ALTER TABLE `transaccion` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER trg_actualizar_presupuesto_insert
AFTER INSERT ON transaccion
FOR EACH ROW
BEGIN
    IF NEW.tipo_transaccion = 'GASTO' THEN
        UPDATE presupuesto 
        SET monto_gastado = monto_gastado + NEW.monto_transaccion
        WHERE id_usuario = NEW.id_usuario 
        AND id_categoria = NEW.id_categoria
        AND DATE_FORMAT(fecha_presupuesto, '%Y-%m') = DATE_FORMAT(NEW.fecha, '%Y-%m');
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER trg_actualizar_dashboard_insert
AFTER INSERT ON transaccion
FOR EACH ROW
BEGIN
    INSERT INTO dashboard (id_usuario, total_ingresos_mes, total_gastos_mes, balance_actual)
    VALUES (
        NEW.id_usuario, 
        CASE WHEN NEW.tipo_transaccion = 'INGRESO' THEN NEW.monto_transaccion ELSE 0 END,
        CASE WHEN NEW.tipo_transaccion = 'GASTO' THEN NEW.monto_transaccion ELSE 0 END,
        CASE WHEN NEW.tipo_transaccion = 'INGRESO' THEN NEW.monto_transaccion ELSE -NEW.monto_transaccion END
    )
    ON DUPLICATE KEY UPDATE
        total_ingresos_mes = total_ingresos_mes + CASE WHEN NEW.tipo_transaccion = 'INGRESO' THEN NEW.monto_transaccion ELSE 0 END,
        total_gastos_mes = total_gastos_mes + CASE WHEN NEW.tipo_transaccion = 'GASTO' THEN NEW.monto_transaccion ELSE 0 END,
        balance_actual = balance_actual + CASE WHEN NEW.tipo_transaccion = 'INGRESO' THEN NEW.monto_transaccion ELSE -NEW.monto_transaccion END;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER trg_actualizar_presupuesto_delete
AFTER DELETE ON transaccion
FOR EACH ROW
BEGIN
    IF OLD.tipo_transaccion = 'GASTO' THEN
        UPDATE presupuesto 
        SET monto_gastado = GREATEST(monto_gastado - OLD.monto_transaccion, 0)
        WHERE id_usuario = OLD.id_usuario 
        AND id_categoria = OLD.id_categoria
        AND DATE_FORMAT(fecha_presupuesto, '%Y-%m') = DATE_FORMAT(OLD.fecha, '%Y-%m');
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `transaccion_recurrente`
--

DROP TABLE IF EXISTS `transaccion_recurrente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transaccion_recurrente` (
  `id_transaccion_recurrente` int(11) NOT NULL AUTO_INCREMENT,
  `fecha_inicio` date NOT NULL,
  `fecha_fin` date DEFAULT NULL,
  `activa` tinyint(1) DEFAULT 1,
  `recurrencia` enum('DIARIA','SEMANAL','QUINCENAL','MENSUAL','TRIMESTRAL','SEMESTRAL','ANUAL') NOT NULL,
  `id_transaccion` int(11) NOT NULL,
  PRIMARY KEY (`id_transaccion_recurrente`),
  KEY `idx_transaccion_recurrente` (`id_transaccion`),
  KEY `idx_activa` (`activa`),
  KEY `idx_fecha_inicio` (`fecha_inicio`),
  CONSTRAINT `transaccion_recurrente_ibfk_1` FOREIGN KEY (`id_transaccion`) REFERENCES `transaccion` (`id_transaccion`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transaccion_recurrente`
--

LOCK TABLES `transaccion_recurrente` WRITE;
/*!40000 ALTER TABLE `transaccion_recurrente` DISABLE KEYS */;
/*!40000 ALTER TABLE `transaccion_recurrente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuario`
--

DROP TABLE IF EXISTS `usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuario` (
  `id_usuario` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_usuario` varchar(100) NOT NULL,
  `email_usuario` varchar(100) NOT NULL,
  `password_usuario` varchar(255) NOT NULL,
  `fecha_registro` timestamp NOT NULL DEFAULT current_timestamp(),
  `foto_perfil` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`id_usuario`),
  UNIQUE KEY `email_usuario` (`email_usuario`),
  KEY `idx_email` (`email_usuario`),
  KEY `idx_nombre` (`nombre_usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuario`
--

LOCK TABLES `usuario` WRITE;
/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;
INSERT INTO `usuario` VALUES (1,'Juan Pérez','juan@email.com','password123','2025-11-28 00:48:22',NULL);
/*!40000 ALTER TABLE `usuario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `vista_balance_usuario`
--

DROP TABLE IF EXISTS `vista_balance_usuario`;
/*!50001 DROP VIEW IF EXISTS `vista_balance_usuario`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vista_balance_usuario` AS SELECT 
 1 AS `id_usuario`,
 1 AS `nombre_usuario`,
 1 AS `email_usuario`,
 1 AS `total_ingresos`,
 1 AS `total_gastos`,
 1 AS `balance_total`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vista_metas_ahorro`
--

DROP TABLE IF EXISTS `vista_metas_ahorro`;
/*!50001 DROP VIEW IF EXISTS `vista_metas_ahorro`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vista_metas_ahorro` AS SELECT 
 1 AS `id_meta_ahorro`,
 1 AS `nombre_meta_ahorro`,
 1 AS `monto_objetivo`,
 1 AS `monto_actual`,
 1 AS `fecha_limite`,
 1 AS `completada`,
 1 AS `porcentaje_completado`,
 1 AS `dias_restantes`,
 1 AS `usuario`,
 1 AS `id_usuario`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vista_presupuestos_activos`
--

DROP TABLE IF EXISTS `vista_presupuestos_activos`;
/*!50001 DROP VIEW IF EXISTS `vista_presupuestos_activos`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vista_presupuestos_activos` AS SELECT 
 1 AS `id_presupuesto`,
 1 AS `monto_limite`,
 1 AS `monto_gastado`,
 1 AS `porcentaje_usado`,
 1 AS `categoria`,
 1 AS `color_categoria`,
 1 AS `usuario`,
 1 AS `id_usuario`,
 1 AS `fecha_presupuesto`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vista_transacciones_mes_actual`
--

DROP TABLE IF EXISTS `vista_transacciones_mes_actual`;
/*!50001 DROP VIEW IF EXISTS `vista_transacciones_mes_actual`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vista_transacciones_mes_actual` AS SELECT 
 1 AS `id_transaccion`,
 1 AS `monto_transaccion`,
 1 AS `tipo_transaccion`,
 1 AS `descripcion`,
 1 AS `fecha`,
 1 AS `categoria`,
 1 AS `color_categoria`,
 1 AS `icono_categoria`,
 1 AS `usuario`,
 1 AS `proyecto`*/;
SET character_set_client = @saved_cs_client;

--
-- Dumping events for database 'oinkcoin'
--

--
-- Dumping routines for database 'oinkcoin'
--
/*!50003 DROP PROCEDURE IF EXISTS `sp_obtener_balance_usuario` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_obtener_balance_usuario`(IN p_id_usuario INT)
BEGIN
    SELECT * FROM vista_balance_usuario WHERE id_usuario = p_id_usuario;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_resumen_mes_actual` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_resumen_mes_actual`(IN p_id_usuario INT)
BEGIN
    SELECT 
        COUNT(*) AS total_transacciones,
        SUM(CASE WHEN tipo_transaccion = 'INGRESO' THEN monto_transaccion ELSE 0 END) AS total_ingresos,
        SUM(CASE WHEN tipo_transaccion = 'GASTO' THEN monto_transaccion ELSE 0 END) AS total_gastos,
        SUM(CASE WHEN tipo_transaccion = 'INGRESO' THEN monto_transaccion ELSE -monto_transaccion END) AS balance
    FROM transaccion
    WHERE id_usuario = p_id_usuario
    AND DATE_FORMAT(fecha, '%Y-%m') = DATE_FORMAT(NOW(), '%Y-%m');
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_top_categorias_gasto` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_top_categorias_gasto`(IN p_id_usuario INT, IN p_limite INT)
BEGIN
    SELECT 
        c.nombre_categoria,
        c.color_categoria,
        c.icono_categoria,
        SUM(t.monto_transaccion) AS total_gastado,
        COUNT(t.id_transaccion) AS cantidad_transacciones
    FROM transaccion t
    JOIN categoria c ON t.id_categoria = c.id_categoria
    WHERE t.id_usuario = p_id_usuario
    AND t.tipo_transaccion = 'GASTO'
    AND DATE_FORMAT(t.fecha, '%Y-%m') = DATE_FORMAT(NOW(), '%Y-%m')
    GROUP BY c.id_categoria, c.nombre_categoria, c.color_categoria, c.icono_categoria
    ORDER BY total_gastado DESC
    LIMIT p_limite;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `vista_balance_usuario`
--

/*!50001 DROP VIEW IF EXISTS `vista_balance_usuario`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vista_balance_usuario` AS select `u`.`id_usuario` AS `id_usuario`,`u`.`nombre_usuario` AS `nombre_usuario`,`u`.`email_usuario` AS `email_usuario`,coalesce(sum(case when `t`.`tipo_transaccion` = 'INGRESO' then `t`.`monto_transaccion` else 0 end),0) AS `total_ingresos`,coalesce(sum(case when `t`.`tipo_transaccion` = 'GASTO' then `t`.`monto_transaccion` else 0 end),0) AS `total_gastos`,coalesce(sum(case when `t`.`tipo_transaccion` = 'INGRESO' then `t`.`monto_transaccion` else -`t`.`monto_transaccion` end),0) AS `balance_total` from (`usuario` `u` left join `transaccion` `t` on(`u`.`id_usuario` = `t`.`id_usuario`)) group by `u`.`id_usuario`,`u`.`nombre_usuario`,`u`.`email_usuario` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vista_metas_ahorro`
--

/*!50001 DROP VIEW IF EXISTS `vista_metas_ahorro`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vista_metas_ahorro` AS select `m`.`id_meta_ahorro` AS `id_meta_ahorro`,`m`.`nombre_meta_ahorro` AS `nombre_meta_ahorro`,`m`.`monto_objetivo` AS `monto_objetivo`,`m`.`monto_actual` AS `monto_actual`,`m`.`fecha_limite` AS `fecha_limite`,`m`.`completada` AS `completada`,round(`m`.`monto_actual` / nullif(`m`.`monto_objetivo`,0) * 100,2) AS `porcentaje_completado`,to_days(`m`.`fecha_limite`) - to_days(current_timestamp()) AS `dias_restantes`,`u`.`nombre_usuario` AS `usuario`,`u`.`id_usuario` AS `id_usuario` from (`meta_ahorro` `m` join `usuario` `u` on(`m`.`id_usuario` = `u`.`id_usuario`)) where `m`.`completada` = 0 order by `m`.`fecha_limite` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vista_presupuestos_activos`
--

/*!50001 DROP VIEW IF EXISTS `vista_presupuestos_activos`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vista_presupuestos_activos` AS select `p`.`id_presupuesto` AS `id_presupuesto`,`p`.`monto_limite` AS `monto_limite`,`p`.`monto_gastado` AS `monto_gastado`,round(`p`.`monto_gastado` / nullif(`p`.`monto_limite`,0) * 100,2) AS `porcentaje_usado`,`c`.`nombre_categoria` AS `categoria`,`c`.`color_categoria` AS `color_categoria`,`u`.`nombre_usuario` AS `usuario`,`u`.`id_usuario` AS `id_usuario`,`p`.`fecha_presupuesto` AS `fecha_presupuesto` from ((`presupuesto` `p` join `categoria` `c` on(`p`.`id_categoria` = `c`.`id_categoria`)) join `usuario` `u` on(`p`.`id_usuario` = `u`.`id_usuario`)) where `p`.`fecha_presupuesto` >= date_format(current_timestamp(),'%Y-%m-01') */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vista_transacciones_mes_actual`
--

/*!50001 DROP VIEW IF EXISTS `vista_transacciones_mes_actual`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vista_transacciones_mes_actual` AS select `t`.`id_transaccion` AS `id_transaccion`,`t`.`monto_transaccion` AS `monto_transaccion`,`t`.`tipo_transaccion` AS `tipo_transaccion`,`t`.`descripcion` AS `descripcion`,`t`.`fecha` AS `fecha`,`c`.`nombre_categoria` AS `categoria`,`c`.`color_categoria` AS `color_categoria`,`c`.`icono_categoria` AS `icono_categoria`,`u`.`nombre_usuario` AS `usuario`,`p`.`nombre_proyecto` AS `proyecto` from (((`transaccion` `t` join `categoria` `c` on(`t`.`id_categoria` = `c`.`id_categoria`)) join `usuario` `u` on(`t`.`id_usuario` = `u`.`id_usuario`)) left join `proyecto` `p` on(`t`.`id_proyecto` = `p`.`id_proyecto`)) where date_format(`t`.`fecha`,'%Y-%m') = date_format(current_timestamp(),'%Y-%m') order by `t`.`fecha` desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-11-28 13:39:02
