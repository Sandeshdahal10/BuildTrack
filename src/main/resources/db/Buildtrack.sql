CREATE DATABASE  IF NOT EXISTS `buildtrack` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `buildtrack`;
-- MySQL dump 10.13  Distrib 8.0.45, for Win64 (x86_64)
--
-- Host: localhost    Database: buildtrack
-- ------------------------------------------------------
-- Server version	8.0.45

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
-- Dumping data for table `attendance`
--

LOCK TABLES `attendance` WRITE;
/*!40000 ALTER TABLE `attendance` DISABLE KEYS */;
/*!40000 ALTER TABLE `attendance` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `documents`
--

LOCK TABLES `documents` WRITE;
/*!40000 ALTER TABLE `documents` DISABLE KEYS */;
/*!40000 ALTER TABLE `documents` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `expenses`
--

LOCK TABLES `expenses` WRITE;
/*!40000 ALTER TABLE `expenses` DISABLE KEYS */;
/*!40000 ALTER TABLE `expenses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `inquiries`
--

LOCK TABLES `inquiries` WRITE;
/*!40000 ALTER TABLE `inquiries` DISABLE KEYS */;
/*!40000 ALTER TABLE `inquiries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `material_usage`
--

LOCK TABLES `material_usage` WRITE;
/*!40000 ALTER TABLE `material_usage` DISABLE KEYS */;
/*!40000 ALTER TABLE `material_usage` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `materials`
--

LOCK TABLES `materials` WRITE;
/*!40000 ALTER TABLE `materials` DISABLE KEYS */;
INSERT INTO `materials` VALUES (1,'UltraTech Cement','Bags',450.00,1850.00,100.00,'Grade 53 Portland Cement','2026-05-02 02:38:09','2026-05-02 02:46:15',NULL),(5,'Jagadamba Cement','ton',1000.00,50.00,20.00,'','2026-05-03 02:57:56','2026-05-03 02:57:56',NULL);
/*!40000 ALTER TABLE `materials` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `payroll`
--

LOCK TABLES `payroll` WRITE;
/*!40000 ALTER TABLE `payroll` DISABLE KEYS */;
/*!40000 ALTER TABLE `payroll` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `project_workers`
--

LOCK TABLES `project_workers` WRITE;
/*!40000 ALTER TABLE `project_workers` DISABLE KEYS */;
INSERT INTO `project_workers` VALUES (1,2,1,'Supervisor','2026-01-10',NULL,1),(2,2,2,'Labourer','2026-01-12',NULL,1);
/*!40000 ALTER TABLE `project_workers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `projects`
--

LOCK TABLES `projects` WRITE;
/*!40000 ALTER TABLE `projects` DISABLE KEYS */;
INSERT INTO `projects` VALUES (1,'Construction of Apartment','lorem',NULL,'2026-04-26','2029-06-12',5000000000.00,'PLANNED','2026-04-28 00:35:18','2026-04-28 00:35:18'),(2,'Skyline Commercial Tower','A 10-story commercial complex in downtown.',5,'2026-01-01','2027-06-30',5000000.00,'IN_PROGRESS','2026-05-02 02:38:09','2026-05-02 02:38:09'),(3,'Birdge Construction','lkjhg',5,'2026-05-03','2026-05-04',1000002.00,'PLANNED','2026-05-03 02:55:43','2026-05-03 02:56:23');
/*!40000 ALTER TABLE `projects` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Sandesh Dahal','sandeshdahal3547@gmail.com','9842566671','$2a$10$xxbx5MXh/JQa6C6cp30JUesfHlRgbJFb4V1dP0U8BYwkCr5a6hpy6','WORKER','APPROVED',850.00,'a37b9cda-f62d-42c2-a6f0-cdfa84f8b1cb','2026-04-16 08:08:55','2026-04-16 13:23:27','2026-05-02 02:38:09'),(2,'Samana Upreti','samana@gmail.com','9875468546','$2a$10$ERrh5/Sg3L.VCiNVs0KQTOjEUIkfzQxMkESYN1TVWnIDbntDymD3q','WORKER','APPROVED',700.00,NULL,NULL,'2026-04-28 00:57:17','2026-05-02 02:38:09'),(5,'Acme Corp','client@acme.com','9876543210','$2a$10$EqKcp1WFKyMnIBJCBqFzLOUbpUKmBcWY6SfR6zBqFgYqF0wSmJH2aemail','CLIENT','APPROVED',0.00,NULL,NULL,'2026-05-02 02:38:09','2026-05-02 02:38:09'),(8,'System Administrator','doejohn087643@gmail.com','0000000000','$2a$10$9SYQJ3jseR9oXI5mfH7lheW.A.JYjwfllzEyHQ16B3/ELRmAeC6O.','ADMIN','APPROVED',0.00,NULL,NULL,'2026-05-11 08:29:08','2026-05-11 08:29:08'),(9,'Rojash Admin','rojashadmin@gmail.com','9812345678','$2a$12$vokM31qqg4KKb4Er46OZiecN9zBe7Az66YsyOdxHPE1LerLjwbS9O','ADMIN','APPROVED',0.00,NULL,NULL,'2026-05-19 03:48:25','2026-05-19 03:48:25'),(10,'Sandesh Admin','sandeshadmin@gmail.com','9812345678','$2a$10$T4aP7cNSB8eDzBLjH8bCWOywLO2d5SlYCIRpOW.52J9nH/cLivTAK','ADMIN','APPROVED',0.00,NULL,NULL,'2026-05-19 03:54:19','2026-05-19 03:54:19');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `work_logs`
--

LOCK TABLES `work_logs` WRITE;
/*!40000 ALTER TABLE `work_logs` DISABLE KEYS */;
/*!40000 ALTER TABLE `work_logs` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-05-21  9:26:25
