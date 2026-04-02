-- MariaDB dump 10.19  Distrib 10.4.32-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: uni_dms
-- ------------------------------------------------------
-- Server version	10.4.32-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `admin_users`
--

DROP TABLE IF EXISTS `admin_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `admin_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(100) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `fullname` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin_users`
--

LOCK TABLES `admin_users` WRITE;
/*!40000 ALTER TABLE `admin_users` DISABLE KEYS */;
INSERT INTO `admin_users` VALUES (1,'admin','$2y$12$LTLX0c6VE/8.s2HveoT5POZvBuUXWQWTk39UqXd0YTL6bIbwCcP9y%','System Administrator','2026-04-02 18:47:26');
/*!40000 ALTER TABLE `admin_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `degrees`
--

DROP TABLE IF EXISTS `degrees`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `degrees` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `department_id` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `duration` varchar(50) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `medium` varchar(50) DEFAULT NULL,
  `type` enum('Undergraduate','Postgraduate','Diploma') DEFAULT 'Undergraduate',
  `faculty` varchar(255) DEFAULT NULL,
  `degree_type` varchar(50) DEFAULT NULL,
  `stream_requirement` varchar(100) DEFAULT NULL,
  `min_zscore` decimal(4,2) DEFAULT NULL,
  `career_paths` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `department_id` (`department_id`),
  CONSTRAINT `degrees_ibfk_1` FOREIGN KEY (`department_id`) REFERENCES `departments` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `degrees`
--

LOCK TABLES `degrees` WRITE;
/*!40000 ALTER TABLE `degrees` DISABLE KEYS */;
INSERT INTO `degrees` VALUES (1,1,'Bachelor of Science in Mathematics','4 years','Theory-driven mathematics degree with research opportunities.','English','Undergraduate','Faculty of Science','BSc','Maths',1.95,'Academia, Finance, Data Science'),(2,3,'Bachelor of Science in Civil Engineering','4 years','Civil engineering degree preparing students for infrastructure design.','English','Undergraduate','Faculty of Engineering','BScEng','Physical Science',1.85,'Construction, Project Management, Consulting'),(3,4,'Bachelor of Science in Information Technology','4 years','Practical IT degree with industry-grade labs.','English','Undergraduate','Faculty of Information Technology','BSc','Physical Science',2.05,'Software Development, Cybersecurity, Product Management'),(4,5,'Bachelor of Science in Data Science','4 years','Data science program blending statistics and engineering.','English','Undergraduate','Faculty of Information Technology','BSc','Maths',2.20,'Data Analytics, AI, Research'),(5,2,'Bachelor of Science in Applied Statistics','4 years','Statistics degree for research and analytics careers.','English','Undergraduate','Faculty of Science','BSc','Maths',1.90,'Research, Finance, Public Sector');
/*!40000 ALTER TABLE `degrees` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `departments`
--

DROP TABLE IF EXISTS `departments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `departments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `faculty_id` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `faculty_id` (`faculty_id`),
  CONSTRAINT `departments_ibfk_1` FOREIGN KEY (`faculty_id`) REFERENCES `faculties` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `departments`
--

LOCK TABLES `departments` WRITE;
/*!40000 ALTER TABLE `departments` DISABLE KEYS */;
INSERT INTO `departments` VALUES (1,1,'Department of Mathematics'),(2,1,'Department of Statistics'),(3,2,'Department of Civil Engineering'),(4,3,'Department of Computer Science'),(5,3,'Department of Information Systems');
/*!40000 ALTER TABLE `departments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `extracurricular_activities`
--

DROP TABLE IF EXISTS `extracurricular_activities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `extracurricular_activities` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `university_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `category` varchar(100) DEFAULT 'General',
  `description` text DEFAULT NULL,
  `is_available` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `university_id` (`university_id`),
  CONSTRAINT `extracurricular_activities_ibfk_1` FOREIGN KEY (`university_id`) REFERENCES `universities` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `extracurricular_activities`
--

LOCK TABLES `extracurricular_activities` WRITE;
/*!40000 ALTER TABLE `extracurricular_activities` DISABLE KEYS */;
INSERT INTO `extracurricular_activities` VALUES (1,1,'Colombo Debate Union','Clubs','Competitive debating and public speaking academy.',1,'2026-04-02 18:47:26'),(2,2,'Peradeniya Adventure Squad','Sports','Outdoor adventure club organizing hiking and camping.',1,'2026-04-02 18:47:26');
/*!40000 ALTER TABLE `extracurricular_activities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `faculties`
--

DROP TABLE IF EXISTS `faculties`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `faculties` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `university_id` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `university_id` (`university_id`),
  CONSTRAINT `faculties_ibfk_1` FOREIGN KEY (`university_id`) REFERENCES `universities` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `faculties`
--

LOCK TABLES `faculties` WRITE;
/*!40000 ALTER TABLE `faculties` DISABLE KEYS */;
INSERT INTO `faculties` VALUES (1,1,'Faculty of Science'),(2,2,'Faculty of Engineering'),(3,1,'Faculty of Information Technology');
/*!40000 ALTER TABLE `faculties` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subjects`
--

DROP TABLE IF EXISTS `subjects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `subjects` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `degree_id` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `degree_id` (`degree_id`),
  CONSTRAINT `subjects_ibfk_1` FOREIGN KEY (`degree_id`) REFERENCES `degrees` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subjects`
--

LOCK TABLES `subjects` WRITE;
/*!40000 ALTER TABLE `subjects` DISABLE KEYS */;
/*!40000 ALTER TABLE `subjects` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `universities`
--

DROP TABLE IF EXISTS `universities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `universities` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `location` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `universities`
--

LOCK TABLES `universities` WRITE;
/*!40000 ALTER TABLE `universities` DISABLE KEYS */;
INSERT INTO `universities` VALUES (1,'University of Colombo','Colombo','Leading university in Sri Lanka','https://upload.wikimedia.org/wikipedia/commons/e/ee/College-house-of-colombo-university.jpg'),(2,'University of Peradeniya','Peradeniya','Beautiful campus with diverse faculties','images/peradeniya.jfif'),(5,'University of Sri Jayewardenepura','Sri Lanka','A premier Sri Lankan university.','https://upload.wikimedia.org/wikipedia/en/9/91/Usjp_logo.png'),(6,'University of Kelaniya','Sri Lanka','A premier Sri Lankan university.','https://upload.wikimedia.org/wikipedia/commons/thumb/1/1a/University_of_Kelaniya.jpg/800px-University_of_Kelaniya.jpg'),(7,'University of Moratuwa','Sri Lanka','A premier Sri Lankan university.','https://upload.wikimedia.org/wikipedia/commons/thumb/3/36/University_of_Moratuwa_entrance.jpg/800px-University_of_Moratuwa_entrance.jpg'),(8,'University of Jaffna','Sri Lanka','A premier Sri Lankan university.','https://upload.wikimedia.org/wikipedia/commons/thumb/0/05/Jaffna_university_entrance.jpg/800px-Jaffna_university_entrance.jpg'),(9,'Eastern University','Sri Lanka','A premier Sri Lankan university.','https://upload.wikimedia.org/wikipedia/en/4/42/Eusl_logo.png'),(10,'South Eastern University of Sri Lanka','Sri Lanka','A premier Sri Lankan university.','https://upload.wikimedia.org/wikipedia/commons/thumb/0/08/South_Eastern_University_of_Sri_Lanka.jpg/800px-South_Eastern_University_of_Sri_Lanka.jpg'),(11,'Rajarata University of Sri Lanka','Sri Lanka','A premier Sri Lankan university.','https://upload.wikimedia.org/wikipedia/en/3/3d/Rajarata_University_of_Sri_Lanka_logo.png'),(12,'Wayamba University of Sri Lanka','Sri Lanka','A premier Sri Lankan university.','https://upload.wikimedia.org/wikipedia/en/6/65/Wusl_logo.png'),(13,'Sabaragamuwa University of Sri Lanka','Sri Lanka','A premier Sri Lankan university.','https://upload.wikimedia.org/wikipedia/commons/thumb/9/96/Sabaragamuwa_University_of_Sri_Lanka.jpg/800px-Sabaragamuwa_University_of_Sri_Lanka.jpg'),(14,'Uva Wellassa University','Sri Lanka','A premier Sri Lankan university.','https://upload.wikimedia.org/wikipedia/commons/thumb/c/cf/Uva_Wellassa_University.jpg/800px-Uva_Wellassa_University.jpg'),(15,'University of Ruhuna','Sri Lanka','A premier Sri Lankan university.','https://upload.wikimedia.org/wikipedia/commons/thumb/e/e6/Ruhuna_main.jpg/800px-Ruhuna_main.jpg'),(16,'University of the Visual and Performing Arts','Sri Lanka','A premier Sri Lankan university.','https://upload.wikimedia.org/wikipedia/en/a/a8/University_of_the_Visual_and_Performing_Arts.png');
/*!40000 ALTER TABLE `universities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(100) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `fullname` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'student','$2y$10$Vfvn5My7za1jGVGxa1Vje.3Xks77FNyNGWaSjERHWDQ6A9Rwwss/e%','Sample Student','student@example.com','2026-04-02 18:47:26');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zscore_cutoffs`
--

DROP TABLE IF EXISTS `zscore_cutoffs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `zscore_cutoffs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `degree_id` int(11) DEFAULT NULL,
  `stream` enum('Maths','Bio','Commerce','Arts') DEFAULT NULL,
  `cutoff` decimal(4,3) DEFAULT NULL,
  `year` year(4) DEFAULT NULL,
  `subject1` varchar(50) DEFAULT NULL,
  `subject2` varchar(50) DEFAULT NULL,
  `subject3` varchar(50) DEFAULT NULL,
  `district` varchar(50) DEFAULT 'All',
  PRIMARY KEY (`id`),
  KEY `degree_id` (`degree_id`),
  CONSTRAINT `zscore_cutoffs_ibfk_1` FOREIGN KEY (`degree_id`) REFERENCES `degrees` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zscore_cutoffs`
--

LOCK TABLES `zscore_cutoffs` WRITE;
/*!40000 ALTER TABLE `zscore_cutoffs` DISABLE KEYS */;
INSERT INTO `zscore_cutoffs` VALUES (6,1,'Maths',1.980,2025,'Combined Mathematics','Physics','Chemistry','All'),(7,2,'Maths',1.900,2025,'Combined Mathematics','Physics','Chemistry','All'),(8,3,'Maths',2.100,2025,'Combined Mathematics','Physics','ICT','All'),(9,4,'Maths',2.250,2025,'Combined Mathematics','Physics','ICT','All'),(10,5,'Maths',1.920,2025,'Combined Mathematics','Physics','Chemistry','All');
/*!40000 ALTER TABLE `zscore_cutoffs` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-04-03  3:04:30
