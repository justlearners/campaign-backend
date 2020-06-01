-- MySQL dump 10.13  Distrib 5.7.24, for Linux (x86_64)
--
-- Host: localhost    Database: campaign
-- ------------------------------------------------------
-- Server version	5.7.24-0ubuntu0.16.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `app_config`
--

DROP TABLE IF EXISTS `app_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `app_config` (
  `id` mediumint(9) NOT NULL AUTO_INCREMENT,
  `config_categ` varchar(45) NOT NULL,
  `config_key` varchar(100) NOT NULL,
  `config_value` varchar(1000) NOT NULL,
  `is_active` char(1) NOT NULL DEFAULT 'Y',
  `created_by` varchar(50) NOT NULL,
  `created_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `modified_by` varchar(50) DEFAULT NULL,
  `modified_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_config`
--

LOCK TABLES `app_config` WRITE;
/*!40000 ALTER TABLE `app_config` DISABLE KEYS */;
INSERT INTO `app_config` VALUES (1,'slot','slot1','9-10AM','y','Anuj','2020-05-22 06:05:11',NULL,'2020-05-22 06:05:11'),(2,'slot','slot2','10-11AM','y','Anuj','2020-05-22 06:05:11',NULL,'2020-05-22 06:05:11'),(3,'slot','slot3','11-12AM','y','Anuj','2020-05-22 06:05:11',NULL,'2020-05-22 06:05:11'),(4,'slot','slot4','12-1PM','y','Anuj','2020-05-22 06:05:46',NULL,'2020-05-22 06:05:46'),(5,'slot','slot4','1-2PM','y','Anuj','2020-05-30 08:03:08',NULL,'2020-05-30 08:03:08'),(6,'slot','slot4','2-3PM','y','Anuj','2020-05-30 08:03:08',NULL,'2020-05-30 08:03:08'),(7,'slot','slot4','3-4PM','y','Anuj','2020-05-30 08:03:08',NULL,'2020-05-30 08:03:08');
/*!40000 ALTER TABLE `app_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `booking`
--

DROP TABLE IF EXISTS `booking`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `booking` (
  `bid` int(11) NOT NULL AUTO_INCREMENT,
  `cid` int(11) NOT NULL,
  `uid` int(11) NOT NULL,
  `booking_date` date NOT NULL,
  `slot` varchar(45) NOT NULL,
  `created_by` varchar(45) DEFAULT NULL,
  `created_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `modified_by` varchar(45) DEFAULT NULL,
  `modified_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`bid`),
  UNIQUE KEY `uindex1` (`booking_date`,`slot`,`cid`),
  KEY `fk_booking_1_idx` (`cid`),
  KEY `fk_booking_2_idx` (`uid`),
  CONSTRAINT `fk_booking_1` FOREIGN KEY (`cid`) REFERENCES `campaign` (`cid`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_booking_2` FOREIGN KEY (`uid`) REFERENCES `user` (`uid`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `booking`
--

LOCK TABLES `booking` WRITE;
/*!40000 ALTER TABLE `booking` DISABLE KEYS */;
INSERT INTO `booking` VALUES (2,1,3126,'2020-05-25','1',NULL,'2020-06-01 09:18:41',NULL,'2020-06-01 09:18:41'),(3,1,3127,'2020-05-28','5',NULL,'2020-06-01 09:21:25',NULL,'2020-06-01 09:21:25'),(4,1,3128,'2020-05-27','5',NULL,'2020-06-01 09:21:51',NULL,'2020-06-01 09:21:51');
/*!40000 ALTER TABLE `booking` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `campaign`
--

DROP TABLE IF EXISTS `campaign`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `campaign` (
  `cid` int(11) NOT NULL AUTO_INCREMENT,
  `tid` int(11) NOT NULL,
  `name` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `shortdesc` varchar(145) COLLATE utf8_unicode_ci DEFAULT NULL,
  `longdesc` varchar(800) CHARACTER SET utf8 DEFAULT NULL,
  `startdate` timestamp NULL DEFAULT NULL,
  `enddate` timestamp NULL DEFAULT NULL,
  `is_active` varchar(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  `slogan` varchar(145) COLLATE utf8_unicode_ci DEFAULT NULL,
  `main_logo` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `footer_logo1` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '	',
  `footer_logo2` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `contact_person_id1` int(11) DEFAULT NULL,
  `contact_person_id2` int(11) DEFAULT NULL,
  `created_by` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `modified_by` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `modified_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`cid`),
  KEY `fk_campaign_1_idx` (`tid`),
  CONSTRAINT `fk_campaign_1` FOREIGN KEY (`tid`) REFERENCES `campaign_type` (`tid`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `campaign`
--

LOCK TABLES `campaign` WRITE;
/*!40000 ALTER TABLE `campaign` DISABLE KEYS */;
INSERT INTO `campaign` VALUES (1,1,'णमोकार मंत्र','Test','णमोकार मन्त्र जैन धर्म का सर्वाधिक महत्वपूर्ण मन्त्र है। इसे \'नवकार मन्त्र\', \'नमस्कार मन्त्र\' या \'पंच परमेष्ठि नमस्कार\' भी कहा जाता है। इस मन्त्र में अरिहन्तों, सिद्धों, आचार्यों, उपाध्यायों और साधुओं का नमस्कार किया गया है।\n\nणमोकार महामंत्र\' एक लोकोत्तर मंत्र है। इस मंत्र को जैन धर्म का परम पवित्र और अनादि मूल मंत्र माना जाता है। इसमें किसी व्यक्ति का नहीं, किंतु संपूर्ण रूप से विकसित और विकासमान विशुद्ध आत्मस्वरूप का ही दर्शन, स्मरण, चिंतन, ध्यान एवं अनुभव किया जाता है। इसलिए यह अनादि और अक्षयस्वरूपी मंत्र है। लौकिक मंत्र आदि सिर्फ लौकिक लाभ पहुँचाते हैं, किंतु लोकोत्तर मंत्र लौकिक और लोकोत्तर दोनों कार्य सिद्ध करते हैं। इसलिए णमोकार मंत्र सर्वकार्य सिद्धिकारक लोकोत्तर मंत्र माना जाता है।','2020-05-24 18:30:00','2020-05-30 18:30:00','y','अरिहंत, सिद्ध, आचार्य को,\n शत् शत् करूँ प्रणाम।\nउपाध्याय सर्वसाधु,\nकरते सब पर कल्याण।।','dj3.jpeg','dj_footer_1.png',NULL,NULL,NULL,NULL,'2020-05-31 08:33:52',NULL,'2020-05-31 08:33:52'),(2,1,'णमोकार मंत्र का अर्थ एवं महिमा\n','Test','प्राथना करो केवल इसलिए नहीं की,\nकुछ जरूरत है,\n\nबल्कि इसलिए की~\n\nहम शुक्रगुज़ार हैं,\nभगवान की...\nजो कुछ हमारे पास है,\n\nवो बहुत कम लोगों को,\nनसीब होता है...!!!','2020-06-05 18:30:00','2020-06-14 18:30:00','y','अपने ज्ञान, ध्यान \nऔर \nउच्च आचरण द्वारा\nजैन शासन की प्रभावना करिये...','dj2.jpeg','dj_footer_1.png',NULL,NULL,NULL,NULL,'2020-05-31 08:50:42',NULL,'2020-05-31 08:50:42'),(3,1,'णमोकार मंत्र का अर्थ','Test','प्राथना करो केवल इसलिए नहीं की,\nकुछ जरूरत है,\n\nबल्कि इसलिए की~\n\nहम शुक्रगुज़ार हैं,\nभगवान की...\nजो कुछ हमारे पास है,\n\nवो बहुत कम लोगों को,\nनसीब होता है...!!!','2020-06-05 18:30:00','2020-06-14 18:30:00','y','अपने ज्ञान, ध्यान \nऔर \nउच्च आचरण द्वारा\nजैन शासन की प्रभावना करिये...','dj.jpeg','dj_footer_1.png',NULL,NULL,NULL,NULL,'2020-05-31 08:50:42',NULL,'2020-05-31 08:50:42');
/*!40000 ALTER TABLE `campaign` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `campaign_group`
--

DROP TABLE IF EXISTS `campaign_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `campaign_group` (
  `cgid` int(11) NOT NULL AUTO_INCREMENT,
  `cid` varchar(45) NOT NULL,
  `gid` varchar(45) NOT NULL,
  PRIMARY KEY (`cgid`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `campaign_group`
--

LOCK TABLES `campaign_group` WRITE;
/*!40000 ALTER TABLE `campaign_group` DISABLE KEYS */;
INSERT INTO `campaign_group` VALUES (1,'2','2');
/*!40000 ALTER TABLE `campaign_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `campaign_type`
--

DROP TABLE IF EXISTS `campaign_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `campaign_type` (
  `tid` int(11) NOT NULL AUTO_INCREMENT,
  `tname` varchar(45) NOT NULL,
  `tdesc` varchar(145) DEFAULT NULL,
  `created_by` varchar(45) DEFAULT NULL,
  `created_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `modified_by` varchar(45) DEFAULT NULL,
  `modified_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`tid`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `campaign_type`
--

LOCK TABLES `campaign_type` WRITE;
/*!40000 ALTER TABLE `campaign_type` DISABLE KEYS */;
INSERT INTO `campaign_type` VALUES (1,'Jain Campaign ','','admin','2020-05-31 08:15:23',NULL,'2020-05-31 08:15:23'),(2,'Jain Campaign 2','','admin','2020-05-31 08:15:23',NULL,'2020-05-31 08:15:23');
/*!40000 ALTER TABLE `campaign_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cgroup`
--

DROP TABLE IF EXISTS `cgroup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cgroup` (
  `gid` int(11) NOT NULL AUTO_INCREMENT,
  `gname` varchar(45) NOT NULL,
  `gparemt` int(11) DEFAULT NULL,
  `is_active` varchar(45) DEFAULT 'Y',
  `created_by` varchar(45) DEFAULT NULL,
  `created_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `modified_by` varchar(45) DEFAULT NULL,
  `modified_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`gid`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cgroup`
--

LOCK TABLES `cgroup` WRITE;
/*!40000 ALTER TABLE `cgroup` DISABLE KEYS */;
INSERT INTO `cgroup` VALUES (1,'Digambar Jain Mahasabha',NULL,'y','admin','2020-05-31 08:17:11',NULL,'2020-05-31 08:17:11'),(2,'Digambar Jain Yuva Mahasabha',NULL,'y','admin','2020-05-31 08:17:11',NULL,'2020-05-31 08:17:11');
/*!40000 ALTER TABLE `cgroup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `state_list`
--

DROP TABLE IF EXISTS `state_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `state_list` (
  `id` int(11) NOT NULL,
  `state_name` varchar(150) DEFAULT NULL,
  `country_id` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `state_list`
--

LOCK TABLES `state_list` WRITE;
/*!40000 ALTER TABLE `state_list` DISABLE KEYS */;
INSERT INTO `state_list` VALUES (1,'ANDAMAN AND NICOBAR ISLANDS','91'),(2,'ANDHRA PRADESH','91'),(3,'ARUNACHAL PRADESH','91'),(4,'ASSAM','91'),(5,'BIHAR','91'),(6,'CHATTISGARH','91'),(7,'CHANDIGARH','91'),(8,'DAMAN AND DIU','91'),(9,'DELHI','91'),(10,'DADRA AND NAGAR HAVELI','91'),(11,'GOA','91'),(12,'GUJARAT','91'),(13,'HIMACHAL PRADESH','91'),(14,'HARYANA','91'),(15,'JAMMU AND KASHMIR','91'),(16,'JHARKHAND','91'),(17,'KERALA','91'),(18,'KARNATAKA','91'),(19,'LAKSHADWEEP','91'),(20,'MEGHALAYA','91'),(21,'MAHARASHTRA','91'),(22,'MANIPUR','91'),(23,'MADHYA PRADESH','91'),(24,'MIZORAM','91'),(25,'NAGALAND','91'),(26,'ORISSA','91'),(27,'PUNJAB','91'),(28,'PONDICHERRY','91'),(29,'RAJASTHAN','91'),(30,'SIKKIM','91'),(31,'TAMIL NADU','91'),(32,'TRIPURA','91'),(33,'UTTARAKHAND','91'),(34,'UTTAR PRADESH','91'),(35,'WEST BENGAL','91'),(36,'TELANGANA','91');
/*!40000 ALTER TABLE `state_list` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `uid` int(11) NOT NULL AUTO_INCREMENT,
  `uname` varchar(45) NOT NULL,
  `emailid` varchar(45) DEFAULT NULL,
  `contact` varchar(45) DEFAULT NULL,
  `address` varchar(45) DEFAULT NULL,
  `city` varchar(45) DEFAULT NULL,
  `state` int(11) DEFAULT NULL,
  `country` varchar(45) DEFAULT NULL,
  `created_by` varchar(45) DEFAULT NULL,
  `created_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `modified_by` varchar(45) DEFAULT NULL,
  `modified_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`uid`),
  KEY `fk_user_1_idx` (`state`),
  CONSTRAINT `fk_user_1` FOREIGN KEY (`state`) REFERENCES `state_list` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3129 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (3126,'Anuj Jain',NULL,'9810052069','T8, 802,\nPark View Residency, Sector -3','Gurugram',14,NULL,NULL,'2020-06-01 09:18:41',NULL,'2020-06-01 09:18:41'),(3127,'ffdg',NULL,'1234567890','gdsfgsd','gsdfgsd',10,NULL,NULL,'2020-06-01 09:21:24',NULL,'2020-06-01 09:21:24'),(3128,'fhfhf',NULL,'1234567890','hfghf','ghfghfdh',11,NULL,NULL,'2020-06-01 09:21:51',NULL,'2020-06-01 09:21:51');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-06-01 16:04:48
