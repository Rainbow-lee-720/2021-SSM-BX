/*
Navicat MySQL Data Transfer

Source Server         : ssm
Source Server Version : 50527
Source Host           : localhost:3306
Source Database       : ssm_

Target Server Type    : MYSQL
Target Server Version : 50527
File Encoding         : 65001

Date: 2020-12-07 21:43:07
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `t_advertise`
-- ----------------------------
DROP TABLE IF EXISTS `t_advertise`;
CREATE TABLE `t_advertise` (
  `adverNo` int(20) NOT NULL AUTO_INCREMENT,
  `adverComNo` int(20) NOT NULL,
  `adverPosition` varchar(20) NOT NULL,
  `adverComName` varchar(50) NOT NULL,
  `adverComPhone` varchar(50) NOT NULL,
  `adverComAddress` varchar(50) NOT NULL,
  `adverCount` int(5) NOT NULL,
  `adverSalary` int(10) NOT NULL,
  `adverLocation` varchar(20) NOT NULL,
  `adverRequire` varchar(50) NOT NULL,
  `adverDate` datetime NOT NULL,
  PRIMARY KEY (`adverNo`),
  UNIQUE KEY `adverComPhone` (`adverComPhone`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_advertise
-- ----------------------------

-- ----------------------------
-- Table structure for `t_company`
-- ----------------------------
DROP TABLE IF EXISTS `t_company`;
CREATE TABLE `t_company` (
  `comNo` int(20) NOT NULL,
  `comId` varchar(20) NOT NULL,
  `comPwd` varchar(20) NOT NULL,
  `comName` varchar(50) NOT NULL,
  `comPhone` varchar(50) NOT NULL,
  `comAddress` varchar(50) NOT NULL,
  `comKind` varchar(20) NOT NULL,
  `comNum` int(10) NOT NULL,
  `comType` varchar(20) NOT NULL,
  `comBack` varchar(200) NOT NULL,
  `comPower` varchar(5) NOT NULL,
  PRIMARY KEY (`comNo`),
  UNIQUE KEY `comPhone` (`comPhone`),
  UNIQUE KEY `comId` (`comId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_company
-- ----------------------------

-- ----------------------------
-- Table structure for `t_employ`
-- ----------------------------
DROP TABLE IF EXISTS `t_employ`;
CREATE TABLE `t_employ` (
  `empNo` int(20) NOT NULL AUTO_INCREMENT,
  `empAdverNo` int(20) NOT NULL,
  `empInterNo` int(20) NOT NULL,
  `empName` varchar(20) NOT NULL,
  `empSex` varchar(5) NOT NULL,
  `empStuPhone` varchar(50) NOT NULL,
  `empDegree` varchar(20) NOT NULL,
  `empSchool` varchar(50) NOT NULL,
  `empSpecialty` varchar(20) NOT NULL,
  `empComName` varchar(50) NOT NULL,
  `empPosition` varchar(20) NOT NULL,
  `empSalary` int(10) NOT NULL,
  `empLocation` varchar(20) NOT NULL,
  `empDate` datetime NOT NULL,
  PRIMARY KEY (`empNo`),
  UNIQUE KEY `empStuPhone` (`empStuPhone`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_employ
-- ----------------------------

-- ----------------------------
-- Table structure for `t_interview`
-- ----------------------------
DROP TABLE IF EXISTS `t_interview`;
CREATE TABLE `t_interview` (
  `interNo` int(20) NOT NULL AUTO_INCREMENT,
  `interStuNo` int(20) NOT NULL,
  `interName` varchar(20) NOT NULL,
  `interSex` varchar(5) NOT NULL,
  `interAge` int(5) NOT NULL,
  `interSpecialty` varchar(20) NOT NULL,
  `interSchool` varchar(50) NOT NULL,
  `interDegree` varchar(20) NOT NULL,
  `interPhone` varchar(50) NOT NULL,
  `interPosition` varchar(20) NOT NULL,
  `interSalary` int(10) NOT NULL,
  `interLocation` varchar(20) NOT NULL,
  `interDate` datetime NOT NULL,
  PRIMARY KEY (`interNo`),
  UNIQUE KEY `interPhone` (`interPhone`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_interview
-- ----------------------------

-- ----------------------------
-- Table structure for `t_student`
-- ----------------------------
DROP TABLE IF EXISTS `t_student`;
CREATE TABLE `t_student` (
  `stuNo` int(20) NOT NULL,
  `stuId` varchar(20) NOT NULL,
  `stuPwd` varchar(20) NOT NULL,
  `stuName` varchar(20) NOT NULL,
  `stuAge` int(5) NOT NULL,
  `stuSex` varchar(5) NOT NULL,
  `stuSchool` varchar(50) NOT NULL,
  `stuSpecialty` varchar(20) NOT NULL,
  `stuPhone` varchar(50) NOT NULL,
  `stuAddress` varchar(50) NOT NULL,
  `stuDegree` varchar(20) NOT NULL,
  `stuPower` varchar(5) NOT NULL,
  PRIMARY KEY (`stuNo`),
  UNIQUE KEY `stuPhone` (`stuPhone`),
  UNIQUE KEY `stuId` (`stuId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_student
-- ----------------------------



-- auto-generated definition
create table t_advertise
(
    adverNo         int(20) auto_increment
        primary key,
    adverComNo      int(20)     not null,
    adverPosition   varchar(20) not null,
    adverComName    varchar(50) not null,
    adverComPhone   varchar(50) not null,
    adverComAddress varchar(50) not null,
    adverCount      int(5)      not null,
    adverSalary     int(10)     not null,
    adverLocation   varchar(20) not null,
    adverRequire    varchar(50) not null,
    adverDate       datetime    not null
);