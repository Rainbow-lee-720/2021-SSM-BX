/*
Navicat MySQL Data Transfer

Source Server         : ssm
Source Server Version : 50527
Source Host           : localhost:3306
Source Database       : ssm_

Target Server Type    : MYSQL
Target Server Version : 50527
File Encoding         : 65001

Date: 2020-12-07 21:43:17
*/

SET FOREIGN_KEY_CHECKS=0;

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



-- auto-generated definition
create table t_company
(
    comNo      int(20)      not null
        primary key,
    comId      varchar(20)  not null,
    comPwd     varchar(20)  not null,
    comName    varchar(50)  not null,
    comPhone   varchar(50)  not null,
    comAddress varchar(50)  not null,
    comKind    varchar(20)  not null,
    comNum     int(10)      not null,
    comType    varchar(20)  not null,
    comBack    varchar(200) not null,
    comPower   varchar(5)   not null,
    constraint comId
        unique (comId),
    constraint comPhone
        unique (comPhone)
);