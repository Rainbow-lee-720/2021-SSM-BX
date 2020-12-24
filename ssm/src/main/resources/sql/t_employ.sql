/*
Navicat MySQL Data Transfer

Source Server         : ssm
Source Server Version : 50527
Source Host           : localhost:3306
Source Database       : ssm_

Target Server Type    : MYSQL
Target Server Version : 50527
File Encoding         : 65001

Date: 2020-12-07 21:43:23
*/

SET FOREIGN_KEY_CHECKS=0;

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



-- auto-generated definition
create table t_employ
(
    empNo        int(20) auto_increment
        primary key,
    empStuNo     int(20)     not null,
    empComNo     int(20)     null,
    empName      varchar(20) not null,
    empSex       varchar(5)  not null,
    empAge       int         not null,
    empStuPhone  varchar(50) not null,
    empDegree    varchar(20) not null,
    empSchool    varchar(50) not null,
    empSpecialty varchar(20) not null,
    empComName   varchar(50) not null,
    empPosition  varchar(20) not null,
    empSalary    int(10)     not null,
    empLocation  varchar(20) not null,
    empDate      datetime    not null,
    empState     int(20)     not null
);