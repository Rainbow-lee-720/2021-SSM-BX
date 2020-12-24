/*
Navicat MySQL Data Transfer

Source Server         : ssm
Source Server Version : 50527
Source Host           : localhost:3306
Source Database       : ssm_

Target Server Type    : MYSQL
Target Server Version : 50527
File Encoding         : 65001

Date: 2020-12-07 21:43:29
*/

SET FOREIGN_KEY_CHECKS=0;

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



-- auto-generated definition
create table t_interview
(
    interNo        int(20) auto_increment
        primary key,
    interStuNo     int(20)      not null,
    interComNo     varchar(150) null,
    interName      varchar(20)  not null,
    interSex       varchar(5)   not null,
    interAge       int(5)       not null,
    interSpecialty varchar(20)  not null,
    interSchool    varchar(50)  not null,
    interDegree    varchar(20)  not null,
    interPhone     varchar(50)  not null,
    interPosition  varchar(20)  not null,
    interSalary    int(10)      not null,
    interLocation  varchar(20)  not null,
    interDate      datetime     not null
);

