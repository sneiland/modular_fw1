-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               10.1.11-MariaDB - mariadb.org binary distribution
-- Server OS:                    Win64
-- HeidiSQL Version:             9.3.0.4984
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- Dumping database structure for demo
CREATE DATABASE IF NOT EXISTS `demo` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `demo`;


-- Dumping structure for table demo.calls
CREATE TABLE IF NOT EXISTS `calls` (
  `callId` int(11) NOT NULL AUTO_INCREMENT,
  `subject` varchar(50) DEFAULT NULL,
  `datetimeStart` datetime DEFAULT NULL,
  `datetimeEnd` datetime DEFAULT NULL,
  `description` text,
  PRIMARY KEY (`callId`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- Dumping data for table demo.calls: ~0 rows (approximately)
/*!40000 ALTER TABLE `calls` DISABLE KEYS */;
REPLACE INTO `calls` (`callId`, `subject`, `datetimeStart`, `datetimeEnd`, `description`) VALUES
	(1, 'First', '2016-06-13 10:39:59', '2016-06-13 10:40:00', 'First call'),
	(2, 'Second', '2016-06-17 10:40:22', '2016-06-17 10:40:30', 'Second call');
/*!40000 ALTER TABLE `calls` ENABLE KEYS */;


-- Dumping structure for table demo.options
CREATE TABLE IF NOT EXISTS `options` (
  `optionId` int(11) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `price` float DEFAULT NULL,
  PRIMARY KEY (`optionId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table demo.options: ~32 rows (approximately)
/*!40000 ALTER TABLE `options` DISABLE KEYS */;
REPLACE INTO `options` (`optionId`, `name`, `price`) VALUES
	(1, 'Daily Tape Backup', 50),
	(2, 'Microsoft SQL Server 2000 Wkgp, per processor', 99),
	(3, 'Windows 2003 Standard Edition', 24),
	(4, '160GB Hard Drive', 18),
	(5, '80GB Hard Drive', 12),
	(6, '512MB Addnl. RAM (Value Server)', 10),
	(7, '1GB Addnl RAM', 12),
	(8, 'Windows 2003 Web Edition', 0),
	(9, 'Red Hat Enterprise Linux', 25),
	(11, 'CentOS Linux', 0),
	(12, 'Cox Cable Basic Service', 10.75),
	(13, 'Microsoft SQL Server - Shared Account - 500MB', 48),
	(14, 'Plesk 7 Control Panel - 30 domains', 20),
	(15, 'Email/IM Jabber Accounts', 3),
	(16, 'Addnl Bandwidth - 50GB', 50),
	(17, 'Microsoft SQL Server Standard Ed., per processor', 200),
	(18, 'DVD Backup - per disk', 20),
	(19, 'Long Term Emergency Power Service', 650),
	(20, 'Reseller Discount', 0),
	(21, 'Semi-Annual Billing', 0),
	(22, 'General Technical Support', 0),
	(23, '750GB Hard Drive - IDE', 38),
	(24, '2 750GB Hard Drives (RAID 1) - SATA', 75),
	(25, 'VMWare ESX Server', 0),
	(26, 'Annual Billing', 0),
	(27, 'Quarterly Billing', 0),
	(28, 'Microsoft SQL Server 2005 Wkgp, per processor', 120),
	(29, 'ColdFusion 8 Standard License', 90),
	(30, 'ColdFusion 5 Standard License', 50),
	(31, 'Additional IP Address', 1),
	(32, 'Managed Server Monthly Fee', 95),
	(33, 'ColdFusion 7 Standard License', 90);
/*!40000 ALTER TABLE `options` ENABLE KEYS */;


-- Dumping structure for table demo.servers
CREATE TABLE IF NOT EXISTS `servers` (
  `serverId` int(11) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `client` varchar(50) DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL,
  `billable` bit(1) DEFAULT NULL,
  `price` float DEFAULT NULL,
  `notes` text,
  PRIMARY KEY (`serverId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table demo.servers: ~46 rows (approximately)
/*!40000 ALTER TABLE `servers` DISABLE KEYS */;
REPLACE INTO `servers` (`serverId`, `name`, `client`, `type`, `billable`, `price`, `notes`) VALUES
	(2, 'DS230', 'ACME1', 'Standard Dedicated Server', b'1', 109, ''),
	(5, 'DS234 - Linux Dev Server', 'SVSN', 'Standard Dedicated Server', b'0', 0, ''),
	(6, 'DS235 - Linux Production Server', 'SVSN', 'Standard Dedicated Server', b'0', 0, ''),
	(7, 'DS236 (FarCry Dev Server)', 'SVSN', 'Standard Dedicated Server', b'0', 0, 'previously leased by James'),
	(8, 'DS237', 'TEST1', 'Standard Dedicated Server', b'1', 109, ''),
	(9, 'DSB200 -  Internal Server', 'SVSN', 'Standard Dedicated Server', b'0', 0, ''),
	(10, 'DSB201 - CollegeTrends', 'GDIS', 'Standard Dedicated Server', b'1', 135, 'Quarterly Billing ($915/Qtr)'),
	(12, 'DSB203 -  Plesk/FP Server', 'SVSN', 'Standard Dedicated Server', b'0', 0, ''),
	(13, 'RACK20', 'SVSN', 'Premium Dedicated Server', b'0', 189, 'Shared SQL 2005 Server'),
	(14, 'RACK21', 'MJH', 'Premium Dedicated Server', b'1', 189, 'notes go here'),
	(15, 'RACK22', 'MJH', 'Enterprise Dedicated Server', b'1', 249, 'Database Server'),
	(16, 'RACK23', 'Aventura', 'Premium Dedicated Server', b'0', 225, ''),
	(17, 'COL131', 'TEST1', 'CoLocation Single Server', b'1', 150, ''),
	(18, 'COL132', 'TEST1', 'CoLocation Single Server', b'0', 150, 'Canceled as of 5/21/07 react. 06/26/07 recanceled 09/07/07'),
	(19, 'RACK04', 'TSGVA', 'Standard Dedicated Server', b'1', 150, 'Windows 2000'),
	(22, 'COL139', 'RM23', 'CoLocation Single Server', b'1', 150, ''),
	(23, 'RACK24 - Database Server', 'SVSN', 'Enterprise Dedicated Server', b'0', 0, ''),
	(28, 'RACK26', 'VHHA', 'Enterprise Dedicated Server', b'1', 249, ''),
	(30, 'COL223', 'TEST1', 'Co-Location Single Server', b'1', 150, ''),
	(32, 'DSB207 - Media2', 'MJH', 'Standard Dedicated Server', b'0', 109, ''),
	(33, 'Rack27 - Map App. Server', 'SVSN', 'Enterprise Dedicated Server', b'0', 0, ''),
	(34, 'DSB238', 'FPL1', 'Standard Dedicated Server', b'0', 135, 'Officially terminated service 10/19/07'),
	(35, 'COL128', 'RDFG', 'Co-Location Single Server', b'1', 300, 'cable service included in cost'),
	(36, 'RACK28', 'TEST1', 'Enterprise Dedicated Server', b'0', 300, 'canceled 10/09/08'),
	(37, 'RACK29', 'TEST1', 'Premium Dedicated Server', b'0', 225, 'canceled 10/09/08'),
	(39, 'RACK30', 'TEST1', 'Enterprise Dedicated Server', b'1', 300, ''),
	(40, 'RACK31', 'SVSN', 'Premium Dedicated Server', b'0', 225, 'previously TVOF'),
	(41, 'DSB208', 'FTLE', 'Standard Dedicated Server', b'1', 135, ''),
	(42, 'Media 1', 'MJH', 'Dedicated Server - Peer 1', b'1', 489.45, ''),
	(43, 'COL220', 'FOREST', 'CoLocation Single Server', b'1', 3500, 'BILLED ANNUALLY ($1500/year)'),
	(44, 'DSB241', 'ZZZZ', 'CoLocation Single Server', b'0', 0, ''),
	(45, 'DSB210 - Dev Server', 'MJH', 'Value Server', b'1', 109, 'They purchased the RAM for the box - no monthly charge for it.'),
	(46, 'HAGG', 'GTER', 'Co-Location - Tower', b'0', 0, 'removed'),
	(47, 'vhost31', 'Hollywood', 'VPS - Gold', b'1', 225, 'Virtual Private Server (VMWare Image) - Gold Package'),
	(48, 'COL217', 'VDOC', 'CoLocation Single Server', b'1', 200, 'Dell 1650'),
	(49, 'RACK25', 'WWWW', 'Premium Dedicated Server', b'1', 225, 'Annual Billing'),
	(50, 'DSB240', 'POIZ', 'Colocated Tower Server', b'0', 0, 'Windows Standard'),
	(53, 'vmserver01', 'MJH', '1U Co-Located Server', b'1', 175, 'Dell 1950 VMWare Host Server - 1U + 1 redund.  PSU + 3 network connections'),
	(54, 'vmserver02', 'MJH', '1U Co-Located Server', b'1', 175, 'Dell 1950 VMWare Host Server - 1U + 1 redund.  PSU + 3 network connections'),
	(55, 'IMB File Storage', 'MJH', 'Dedicated File Storage - 1TB', b'1', 950, '1TB of space on File Server'),
	(56, 'vhost30', 'AXL', 'VPS - Silver', b'1', 135, ''),
	(57, 'COL034', 'SSFM', 'Co-Location Single Server', b'1', 150, 'Apple Xserv 1 U - 2 NIC connects, 2 PS connects'),
	(58, 'COL036', 'TEST6', 'Co-Location Single Server', b'1', 150, 'Dell 1950 1U Server  1 NIC 2 PSUs'),
	(59, 'COL037', 'GERT', 'Co-Location Single Server', b'1', 350, 'Dell 2950 2 U - 1 NIC connect, 2 PS connects - Web Server'),
	(60, 'col248', 'GERT', '2U Co-Located Server', b'1', 350, 'Dell 2950 2 U - 1 NIC connect, 2 PS connects - Database Server'),
	(61, 'COL035', 'GERT', 'Co-Location Single Server', b'1', 350, 'Dell 2850 2 U - 1 NIC connect, 2 PS connects - Web Server');
/*!40000 ALTER TABLE `servers` ENABLE KEYS */;


-- Dumping structure for table demo.server_options
CREATE TABLE IF NOT EXISTS `server_options` (
  `serverId` int(11) NOT NULL,
  `optionId` int(11) NOT NULL,
  `price` float DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  PRIMARY KEY (`serverId`,`optionId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table demo.server_options: ~101 rows (approximately)
/*!40000 ALTER TABLE `server_options` DISABLE KEYS */;
REPLACE INTO `server_options` (`serverId`, `optionId`, `price`, `quantity`) VALUES
	(2, 1, NULL, 1),
	(2, 6, NULL, 1),
	(2, 11, NULL, 1),
	(2, 14, NULL, 1),
	(7, 1, NULL, 1),
	(7, 5, NULL, 1),
	(7, 7, NULL, 2),
	(7, 8, NULL, 1),
	(8, 1, NULL, 1),
	(8, 3, 20, 1),
	(8, 5, NULL, 1),
	(8, 7, NULL, 2),
	(8, 17, NULL, 1),
	(9, 11, NULL, 1),
	(10, 1, NULL, 1),
	(10, 5, 12, 1),
	(10, 6, 10, 1),
	(10, 8, 0, 1),
	(10, 13, NULL, 1),
	(10, 22, NULL, 1),
	(10, 27, NULL, 1),
	(10, 30, NULL, 1),
	(13, 1, NULL, 1),
	(13, 7, NULL, 1),
	(14, 1, NULL, 1),
	(14, 7, NULL, 1),
	(15, 1, NULL, 1),
	(15, 2, NULL, 2),
	(15, 3, 20, 1),
	(15, 4, NULL, 2),
	(16, 1, 60, 1),
	(16, 7, NULL, 1),
	(16, 8, NULL, 1),
	(16, 13, 48, 1),
	(17, 1, NULL, 1),
	(18, 1, NULL, 1),
	(19, 1, 50, 1),
	(22, 12, NULL, 1),
	(28, 1, NULL, 1),
	(28, 2, NULL, 1),
	(28, 3, NULL, 1),
	(28, 4, NULL, 1),
	(28, 19, NULL, 1),
	(32, 1, 50, 1),
	(32, 6, 10, 1),
	(32, 8, NULL, 1),
	(32, 23, 38, 1),
	(33, 1, NULL, 1),
	(33, 3, NULL, 1),
	(33, 4, NULL, 1),
	(35, 12, 0, 1),
	(35, 22, 0, 1),
	(36, 1, NULL, 1),
	(36, 2, NULL, 2),
	(36, 3, 20, 1),
	(36, 20, -113.6, 1),
	(37, 1, NULL, 1),
	(37, 4, NULL, 2),
	(37, 7, NULL, 2),
	(37, 8, NULL, 1),
	(37, 20, -67, 1),
	(39, 1, NULL, 1),
	(39, 4, NULL, 1),
	(39, 7, NULL, 2),
	(39, 8, NULL, 1),
	(39, 20, -78.4, 1),
	(40, 7, NULL, 1),
	(40, 8, NULL, 1),
	(41, 5, NULL, 1),
	(41, 8, NULL, 1),
	(41, 15, NULL, 6),
	(43, 1, NULL, 1),
	(43, 22, NULL, 1),
	(43, 26, NULL, 1),
	(45, 5, 12, 1),
	(45, 7, 0, 2),
	(45, 11, 0, 1),
	(45, 25, 0, 1),
	(47, 1, 60, 1),
	(47, 3, NULL, 1),
	(47, 13, NULL, 1),
	(47, 29, NULL, 1),
	(48, 28, 120, 1),
	(49, 1, 60, 1),
	(49, 7, 12, 1),
	(49, 13, NULL, 1),
	(49, 33, NULL, 1),
	(50, 1, 0, 1),
	(53, 1, 50, 3),
	(54, 1, 50, 3),
	(56, 13, NULL, 1),
	(56, 15, 1, 75),
	(56, 30, NULL, 1),
	(57, 31, 1, 5),
	(58, 32, NULL, 1),
	(59, 27, NULL, 1),
	(59, 32, NULL, 2),
	(60, 27, NULL, 1),
	(60, 32, NULL, 2),
	(61, 27, NULL, 1),
	(62, 8, 10, 1);
/*!40000 ALTER TABLE `server_options` ENABLE KEYS */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
