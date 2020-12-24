/*
Navicat MySQL Data Transfer

Source Server         : ssm
Source Server Version : 50527
Source Host           : localhost:3306
Source Database       : ssm_

Target Server Type    : MYSQL
Target Server Version : 50527
File Encoding         : 65001

Date: 2020-12-07 21:42:14
set global time_zone='+8:00';
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `t_admin`
-- ----------------------------
DROP TABLE IF EXISTS `t_admin`;
CREATE TABLE `t_admin` (
  `adminNo` int(20) NOT NULL,
  `adminId` varchar(20) NOT NULL,
  `adminPwd` varchar(20) NOT NULL,
  `adminName` varchar(20) NOT NULL,
  `adminPhone` varchar(50) NOT NULL,
  `adminSex` varchar(5) NOT NULL,
  `adminPower` varchar(5) NOT NULL,
  PRIMARY KEY (`adminNo`),
  UNIQUE KEY `adminPhone` (`adminPhone`),
  UNIQUE KEY `adminId` (`adminId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_admin
-- ----------------------------



-- auto-generated definition
create table t_admin
(
    adminNo    int(20)     not null
        primary key,
    adminId    varchar(20) not null,
    adminPwd   varchar(20) not null,
    adminName  varchar(20) not null,
    adminPhone varchar(50) not null,
    adminSex   varchar(5)  not null,
    adminPower varchar(5)  not null,
    constraint adminId
        unique (adminId),
    constraint adminPhone
        unique (adminPhone)
);