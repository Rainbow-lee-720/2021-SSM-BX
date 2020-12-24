/*
Navicat MySQL Data Transfer

Source Server         : Lee
Source Server Version : 50527
Source Host           : localhost:3306
Source Database       : ssm_lee

Target Server Type    : MYSQL
Target Server Version : 50527
File Encoding         : 65001

Date: 2020-07-25 12:07:55
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for t_admin
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
INSERT INTO `t_admin` VALUES ('2016001', 'a2016001', 'a2016001', 'a2016001', '18014845722', '女', '0');
INSERT INTO `t_admin` VALUES ('2016002', 'a2016002', 'a2016002', 'Admin_Lxl', '13665148984', '女', '0');

-- ----------------------------
-- Table structure for t_advertise
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
  PRIMARY KEY (`adverNo`)
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_advertise
-- ----------------------------
INSERT INTO `t_advertise` VALUES ('15', '2020003', 'Linux运维工程师', '美团', '13665143857', '四川成都', '13', '5500', '广州', '熟悉Linux常用命令', '2020-05-18 12:44:42');
INSERT INTO `t_advertise` VALUES ('16', '2020004', 'Web前端工程师', '搜狗', '13854102524', '四川成都', '6', '3500', '西安', 'HTML CSS JS Jquery', '2020-05-18 13:01:31');
INSERT INTO `t_advertise` VALUES ('17', '2020005', '网络安全工程师', '百度', '18014845796', '四川成都', '7', '7200', '成都', '熟悉信息安全', '2020-05-18 13:07:26');
INSERT INTO `t_advertise` VALUES ('18', '2020006', 'Java工程师', '恒大', '15026355621', '中国上海', '3', '8500', '上海', '熟悉美术相关', '2020-03-17 12:02:31');
INSERT INTO `t_advertise` VALUES ('19', '2020007', '律师', '思科', '13652254141', '湖北武汉', '7', '12000', '南昌', '法律专业优先', '2020-03-17 12:02:56');
INSERT INTO `t_advertise` VALUES ('20', '2020008', 'UI工程师', '碧桂园', '15696968585', '云南昆明', '11', '8800', '武汉', 'UI设计专业', '2020-03-17 12:03:20');
INSERT INTO `t_advertise` VALUES ('21', '2020009', '超市导购员', '万达', '15784259652', '湖南长沙', '49', '3100', '广州', '会说话交流', '2020-03-17 12:03:53');
INSERT INTO `t_advertise` VALUES ('22', '2020010', 'Java架构工程师助理', '京东', '15896965353', '江苏宿迁', '8', '8500', '上海', '会使用电脑的基本操作', '2020-03-17 12:04:17');
INSERT INTO `t_advertise` VALUES ('23', '2020011', '搬运工', '乐百氏', '15822000000', '山西大同', '24', '5800', '北京', '男性 35岁以下', '2020-03-17 12:04:37');
INSERT INTO `t_advertise` VALUES ('24', '2020012', '流水线线长', '卫龙', '15623202020', '湖北武汉', '13', '3200', '武汉', '女性 18-35岁', '2020-04-10 23:14:46');
INSERT INTO `t_advertise` VALUES ('25', '2020013', '店长', '兰州拉面', '13685205260', '江西南昌', '30', '9000', '成都', '会做拉面', '2020-03-17 11:26:23');
INSERT INTO `t_advertise` VALUES ('26', '2020014', '厂长助理', '康师傅', '18745026302', '广西南宁', '12', '5400', '南昌', '懂得电脑的基本使用', '2020-03-17 11:27:42');
INSERT INTO `t_advertise` VALUES ('27', '2020015', '产品经理', '宝洁', '15696025630', '中国重庆', '4', '7500', '武汉', '会英语等外语优先', '2020-03-17 11:28:53');
INSERT INTO `t_advertise` VALUES ('30', '2020016', 'LV中国销售经理', 'LV', '13665656565', '新疆喀什', '10', '15000', '中国上海', '懂得礼仪', '2020-03-30 19:09:56');
INSERT INTO `t_advertise` VALUES ('31', '2020017', '香奈儿大陆销售总监', '香奈儿', '15263632010', '黑龙江大庆', '20', '18200', '江西南昌', '有销售经验', '2020-03-30 19:11:02');
INSERT INTO `t_advertise` VALUES ('32', '2020018', '浪琴制作商代理', '浪琴', '13986592020', '中国北京', '35', '23000', '湖北武汉', '懂得钟表行业', '2020-03-30 19:12:27');
INSERT INTO `t_advertise` VALUES ('33', '2020019', '匹克销售代理', '匹克', '18545455656', '中国上海', '5', '5800', '广东广州', '有工作经验 广州人', '2020-03-30 19:13:37');
INSERT INTO `t_advertise` VALUES ('34', '2020020', '耐克服务商助理', '耐克', '13665255256', '江苏无锡', '8', '3600', '四川成都', '喜爱耐克产品', '2020-03-30 19:15:45');
INSERT INTO `t_advertise` VALUES ('35', '2020021', '中国区域经理', '阿迪达斯', '15852023620', '福建厦门', '3', '35000', '中国北京', '硕士学历以上', '2020-03-30 19:17:06');
INSERT INTO `t_advertise` VALUES ('36', '2020022', 'Java架构工程师实习生', '东鹏', '13652521202', '河北承德', '100', '2800', '上海', '有工作经验优先', '2020-03-30 19:18:21');
INSERT INTO `t_advertise` VALUES ('37', '2020023', '清风金融助理', '清风', '15685202452', '中国天津', '20', '6520', '中国上海', '金融行业工作经验者', '2020-03-30 19:19:39');
INSERT INTO `t_advertise` VALUES ('38', '2020024', '超市理货员', '奥利奥', '13665265202', '山西太原', '200', '2800', '湖北武汉', '肯吃苦', '2020-03-30 19:21:25');
INSERT INTO `t_advertise` VALUES ('39', '2020025', '冰淇淋兵工厂管理员', '可爱多', '18795623202', '广东广州', '50', '4400', '四川成都', '劳动力优秀者优先', '2020-03-30 19:22:26');
INSERT INTO `t_advertise` VALUES ('41', '2020034', '蒙牛代理商', '蒙牛', '15623232020', '中国北京', '9', '8500', '中国上海', '本科学历', '2020-04-03 09:45:04');
INSERT INTO `t_advertise` VALUES ('44', '2020001', 'Java架构工程师', '腾讯', '18014845658', '中国深圳', '14', '8888', '中国上海', '熟悉SSM框架 了解Spring、SpringMVC 本科学历', '2020-05-18 12:00:09');
INSERT INTO `t_advertise` VALUES ('46', '2020001', 'C#实习生', '腾讯', '18014845658', '中国深圳', '14', '6800', '陕西西安', '熟悉架构模式', '2020-05-18 12:00:09');
INSERT INTO `t_advertise` VALUES ('47', '2020001', 'Linux运维助理', '腾讯', '18014845658', '中国深圳', '14', '3600', '湖北武汉', '懂得linux常用命令', '2020-05-18 12:00:09');
INSERT INTO `t_advertise` VALUES ('48', '2020001', 'Web前端工程师', '腾讯', '18014845658', '中国深圳', '14', '12000', '江苏南京', '需要有三年工作经验', '2020-05-18 12:00:09');
INSERT INTO `t_advertise` VALUES ('56', '2020001', '电脑维修员', '腾讯', '18014845658', '中国深圳', '14', '2500', '四川成都', '会修电脑', '2020-05-18 12:00:09');
INSERT INTO `t_advertise` VALUES ('58', '2020002', '华为欧洲代理', '华为', '18014845741', '北京东城', '24', '15000', '四川成都', '国外工作经验', '2020-05-18 12:18:19');
INSERT INTO `t_advertise` VALUES ('59', '2020002', '华为区域经理', '华为', '18014845741', '北京东城', '24', '8000', '中国上海', '上海户口', '2020-05-18 12:18:19');
INSERT INTO `t_advertise` VALUES ('60', '2020001', 'Windows代理', '腾讯', '18014845658', '中国深圳', '14', '5500', '中国上海', '开发Win10系统经验', '2020-05-18 12:00:09');

-- ----------------------------
-- Table structure for t_company
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
INSERT INTO `t_company` VALUES ('2020001', 'c2020001', 'c2020001', '腾讯', '18014845658', '中国深圳', '私企', '36030', '互联网', '腾讯公司是中国的互联网龙头企业，主要以欺骗小学生来维持公司的营收，主营王者荣耀。还有cf吃鸡,刺激战场', '2');
INSERT INTO `t_company` VALUES ('2020002', 'c2020002', 'c2020002', '华为', '18014845741', '北京东城', '国企', '2000', '服务业', '中国5G产业的领头羊', '2');
INSERT INTO `t_company` VALUES ('2020003', 'c2020003', 'c2020003', '美团', '13665143857', '四川成都', '自营', '5000', '互联网', '点外卖 吃好吃的 奶茶啥的 外卖 士力架 汉堡', '2');
INSERT INTO `t_company` VALUES ('2020004', 'c2020004', 'c2020004', '搜狗', '13854102524', '四川成都', '合资', '3600', '互联网', '中国数一数二的搜索引擎', '2');
INSERT INTO `t_company` VALUES ('2020005', 'c2020005', 'c2020005', '百度', '18014845796', '四川成都', '外资', '200', '医疗', '度娘 中国最受欢迎的搜索引擎', '2');
INSERT INTO `t_company` VALUES ('2020006', 'c2020006', 'c2020006', '恒大', '15026355621', '中国上海', '事业单位', '3600', '金融', '中国房地产领军企业 No2', '2');
INSERT INTO `t_company` VALUES ('2020007', 'c2020007', 'c2020007', '思科', '13652254141', '湖北武汉', '外资', '25300', '互联网', '软件外包大公司', '2');
INSERT INTO `t_company` VALUES ('2020008', 'c2020008', 'c2020008', '碧桂园', '15696968585', '云南昆明', '自营', '3650', '服务业', '房地产的大头企业', '2');
INSERT INTO `t_company` VALUES ('2020009', 'c2020009', 'c2020009', '万达', '15784259652', '湖南长沙', '私企', '5800', '金融', '王健林的企业 实力雄厚', '2');
INSERT INTO `t_company` VALUES ('2020010', 'c2020010', 'c2020010', '京东', '15896965353', '江苏宿迁', '自营', '25200', '物流', '京东自营店线下', '2');
INSERT INTO `t_company` VALUES ('2020011', 'c2020011', 'c2020011', '乐百氏', '15822000000', '山西大同', '合资', '4000', '设计', '矿泉水的创造者', '2');
INSERT INTO `t_company` VALUES ('2020012', 'c2020012', 'c2020012', '卫龙', '15623202020', '湖北武汉', '国企', '42050', '金融', '中国最好吃的辣条在这里', '2');
INSERT INTO `t_company` VALUES ('2020013', 'c2020013', 'c2020013', '兰州拉面', '13685205260', '江西南昌', '国企', '11200', '法律', '里面都没有牛肉只有面 不怎么好吃的', '2');
INSERT INTO `t_company` VALUES ('2020014', 'c2020014', 'c2020014', '康师傅', '18745026302', '广西南宁', '事业单位', '3502', '教育', '只有康师傅的才好吃 统一的是垃圾', '2');
INSERT INTO `t_company` VALUES ('2020015', 'c2020015', 'c2020015', '宝洁', '15696025630', '中国重庆', '私企', '8700', '旅游', '做洗浴产品的', '2');
INSERT INTO `t_company` VALUES ('2020016', 'c2020016', 'c2020016', 'LV', '13665656565', '新疆喀什', '外资', '8558', '设计', '奢侈品', '2');
INSERT INTO `t_company` VALUES ('2020017', 'c2020017', 'c2020017', '香奈儿', '15263632010', '黑龙江大庆', '外资', '9600', '互联网', '香水很好 买不起', '2');
INSERT INTO `t_company` VALUES ('2020018', 'c2020018', 'c2020018', '浪琴', '13986592020', '中国北京', '合资', '5820', '服务业', '贵族手表', '2');
INSERT INTO `t_company` VALUES ('2020019', 'c2020019', 'c2020019', '匹克', '18545455656', '中国上海', '事业单位', '54825', '法律', '国产品牌 很棒', '2');
INSERT INTO `t_company` VALUES ('2020020', 'c2020020', 'c2020020', '耐克', '13665255256', '江苏无锡', '合资', '7540', '金融', '没有匹克的好', '2');
INSERT INTO `t_company` VALUES ('2020021', 'c2020021', 'c2020021', '阿迪达斯', '15852023620', '福建厦门', '自营', '5200', '服务业', '一般般的运动品牌', '2');
INSERT INTO `t_company` VALUES ('2020022', 'c2020022', 'c2020022', '东鹏', '13652521202', '河北承德', '国企', '36200', '医疗', '比红牛甜一点', '2');
INSERT INTO `t_company` VALUES ('2020023', 'c2020023', 'c2020023', '清风', '15685202452', '中国天津', '自营', '6300', '服务业', '纸巾生产厂商 市场占有率较大', '2');
INSERT INTO `t_company` VALUES ('2020024', 'c2020024', 'c2020024', '奥利奥', '13665265202', '山西太原', '外资', '45620', '服务业', '奥利奥饼干 好吃的饼干', '2');
INSERT INTO `t_company` VALUES ('2020025', 'c2020025', 'c2020025', '可爱多', '18795623202', '广东广州', '私企', '6520', '物流', '可爱多冰淇淋 味道好极了', '2');
INSERT INTO `t_company` VALUES ('2020026', 'c2020026', 'c2020026', '舒肤佳', '18956203202', '福建厦门', '合资', '14520', '物流', '舒肤佳的香皂 去除百分之99的细菌', '2');
INSERT INTO `t_company` VALUES ('2020027', 'c2020027', 'c2020027', '百事', '13545122520', '江西南昌', '自营', '456200', '服务业', '百事可乐 好喝的可乐 非常甜', '2');
INSERT INTO `t_company` VALUES ('2020028', 'c2020028', 'c2020028', '欧冠', '18988888888', '意大利罗马', '外资', '25200', '旅游', '欧冠联盟', '2');
INSERT INTO `t_company` VALUES ('2020029', 'c2020029', 'c2020029', '中超', '13665655252', '中国北京', '事业单位', '456320', '服务业', '中超联盟', '2');
INSERT INTO `t_company` VALUES ('2020030', 'c2020030', 'c2020030', '捷普', '18556525652', '四川成都', '外资', '25000', '物流', '美国企业 苹果手机服务商', '2');

-- ----------------------------
-- Table structure for t_employ
-- ----------------------------
DROP TABLE IF EXISTS `t_employ`;
CREATE TABLE `t_employ` (
  `empNo` int(20) NOT NULL AUTO_INCREMENT,
  `empStuNo` int(20) NOT NULL,
  `empComNo` int(20) DEFAULT NULL,
  `empName` varchar(20) NOT NULL,
  `empSex` varchar(5) NOT NULL,
  `empAge` int(11) NOT NULL,
  `empStuPhone` varchar(50) NOT NULL,
  `empDegree` varchar(20) NOT NULL,
  `empSchool` varchar(50) NOT NULL,
  `empSpecialty` varchar(20) NOT NULL,
  `empComName` varchar(50) NOT NULL,
  `empPosition` varchar(20) NOT NULL,
  `empSalary` int(10) NOT NULL,
  `empLocation` varchar(20) NOT NULL,
  `empDate` datetime NOT NULL,
  `empState` int(20) NOT NULL,
  PRIMARY KEY (`empNo`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_employ
-- ----------------------------
INSERT INTO `t_employ` VALUES ('2', '2016001', '2020001', '吉吉国王', '女', '22', '13652401544', '硕士研究生', '华中师范大学', '软件工程', '腾讯', 'Java架构工程师', '7000', '会英语等', '2020-05-18 12:00:09', '1');
INSERT INTO `t_employ` VALUES ('3', '2016002', '2020002', '刘健', '男', '33', '18014845700', '博士研究生', '广州大学', '软件工程', '华为', 'Java工程师', '8000', '编程', '2020-05-18 12:18:19', '1');
INSERT INTO `t_employ` VALUES ('4', '2016003', '2020003', '王思聪', '女', '23', '15636502527', '硕士研究生', '武汉华中科技大学', '制药', '美团', 'Linux运维', '5500', '懂得Linux操作系统', '2020-05-18 12:44:42', '1');
INSERT INTO `t_employ` VALUES ('5', '2016004', '2020004', '花容瘦', '男', '21', '18014845793', '本科', '华中科技大学', '物理学', '搜狗', 'Web前端工程师', '3500', 'Web前端设计 本科毕业生', '2020-05-18 13:01:31', '1');
INSERT INTO `t_employ` VALUES ('6', '2016005', '2020005', '超人', '男', '20', '18014845795', '大专', '上海大学', '环境工程', '百度', '网络安全工程师', '8500', '信息安全专业毕业', '2020-05-18 13:07:26', '1');
INSERT INTO `t_employ` VALUES ('7', '2016001', '2020009', '吉吉国王', '女', '22', '13652401544', '硕士研究生', '华中师范大学', '软件工程', '万达', 'Java架构工程师', '7000', '会英语等', '2020-05-20 13:39:20', '0');

-- ----------------------------
-- Table structure for t_interview
-- ----------------------------
DROP TABLE IF EXISTS `t_interview`;
CREATE TABLE `t_interview` (
  `interNo` int(20) NOT NULL AUTO_INCREMENT,
  `interStuNo` int(20) NOT NULL,
  `interComNo` varchar(150) DEFAULT NULL,
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
  PRIMARY KEY (`interNo`)
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_interview
-- ----------------------------
INSERT INTO `t_interview` VALUES ('36', '2016003', '2020003g', '王思聪', '女', '23', '制药', '武汉华中科技大学', '硕士研究生', '15636502527', 'Linux运维', '5500', '懂得Linux操作系统', '2020-03-17 11:39:32');
INSERT INTO `t_interview` VALUES ('37', '2016004', 'null2020004g', '花容瘦', '男', '21', '物理学', '华中科技大学', '本科', '18014845793', 'Web前端工程师', '3500', 'Web前端设计 本科毕业生', '2020-03-17 11:42:18');
INSERT INTO `t_interview` VALUES ('38', '2016005', 'null2020005g', '超人', '男', '20', '环境工程', '上海大学', '大专', '18014845795', '网络安全工程师', '8500', '信息安全专业毕业', '2020-03-17 11:43:24');
INSERT INTO `t_interview` VALUES ('39', '2016006', null, '蝙蝠侠', '女', '36', '软件化学', '清华大学', '本科', '18014845743', '前端UI美化设计', '15000', 'Ui设计', '2020-03-17 11:44:33');
INSERT INTO `t_interview` VALUES ('40', '2016007', null, '蜘蛛侠', '女', '66', '化学生物', '北京大学', '博士研究生', '17351026911', '律师', '3800', '法律专业出身', '2020-03-17 11:45:45');
INSERT INTO `t_interview` VALUES ('41', '2016008', null, '铁男', '女', '22', '制药', '湖南大学', '本科', '18014843390', '网络运维', '3600', '网络运维工作经验', '2020-03-17 11:46:36');
INSERT INTO `t_interview` VALUES ('42', '2016009', null, '蔡文姬', '女', '21', '法律专业', '哈尔滨工业大学', '硕士研究生', '13665148389', '超市导购员', '12500', '沟通能力强', '2020-03-17 11:47:39');
INSERT INTO `t_interview` VALUES ('43', '2016010', null, '庄周', '男', '25', '制药', '南京林业大学', '硕士研究生', '15201203030', '网购导购员', '6800', '有丰富的超市工作经验', '2020-03-17 11:48:49');
INSERT INTO `t_interview` VALUES ('44', '2016011', null, '李元芳', '男', '56', '软件工程', '南京大学', '硕士研究生', '13665418983', '厂家搬运工', '4800', '体力充沛', '2020-03-17 11:50:04');
INSERT INTO `t_interview` VALUES ('49', '2016002', 'null20200012020002g', '刘健', '男', '33', '软件工程', '广州大学', '博士研究生', '18014845700', 'Java工程师', '8000', '编程', '2020-04-10 22:27:28');
INSERT INTO `t_interview` VALUES ('50', '2016012', null, '李江陇', '男', '25', '物联网工程', '华中科技大学', '本科', '18014845762', '项目经理', '12000', '工作经验丰富', '2020-04-10 23:10:23');
INSERT INTO `t_interview` VALUES ('51', '2016001', 'nullg2020001g20200032020009g', '吉吉国王', '女', '22', '软件工程', '华中师范大学', '硕士研究生', '13652401544', 'Java架构工程师', '7000', '会英语等', '2020-05-18 11:43:53');

-- ----------------------------
-- Table structure for t_student
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
INSERT INTO `t_student` VALUES ('2016001', 's2016001', 's2016001', '吉吉国王', '22', '女', '华中师范大学', '软件工程', '13652401544', '上海', '硕士研究生', '1');
INSERT INTO `t_student` VALUES ('2016002', 's2016002', 's2016002', '刘健', '33', '男', '广州大学', '软件工程', '18014845700', '武汉', '博士研究生', '1');
INSERT INTO `t_student` VALUES ('2016003', 's2016003', 's2016003', '王思聪', '23', '女', '武汉华中科技大学', '制药', '15636502527', '上海', '硕士研究生', '1');
INSERT INTO `t_student` VALUES ('2016004', 's2016004', 's2016004', '花容瘦', '21', '男', '华中科技大学', '物理学', '18014845793', '深圳', '本科', '1');
INSERT INTO `t_student` VALUES ('2016005', 's2016005', 's2016005', '超人', '20', '男', '上海大学', '环境工程', '18014845795', '南京', '大专', '1');
INSERT INTO `t_student` VALUES ('2016006', 's2016006', 's2016006', '蝙蝠侠', '36', '女', '清华大学', '软件化学', '18014845743', '成都', '本科', '1');
INSERT INTO `t_student` VALUES ('2016007', 's2016007', 's2016007', '蜘蛛侠', '66', '女', '北京大学', '化学生物', '17351026911', '武汉', '博士研究生', '1');
INSERT INTO `t_student` VALUES ('2016008', 's2016008', 's2016008', '铁男', '22', '女', '湖南大学', '制药', '18014843390', '北京', '本科', '1');
INSERT INTO `t_student` VALUES ('2016009', 's2016009', 's2016009', '蔡文姬', '21', '女', '哈尔滨工业大学', '法律专业', '13665148389', '沈阳', '硕士研究生', '1');
INSERT INTO `t_student` VALUES ('2016010', 's2016010', 's2016010', '庄周', '25', '男', '南京林业大学', '制药', '15201203030', '杭州', '硕士研究生', '1');
INSERT INTO `t_student` VALUES ('2016011', 's2016011', 's2016011', '李元芳', '56', '男', '南京大学', '软件工程', '13665418983', '重庆', '硕士研究生', '1');
INSERT INTO `t_student` VALUES ('2016012', 's2016012', 's2016012', '李江陇', '25', '男', '华中科技大学', '物联网工程', '18014845762', '南昌', '本科', '1');
INSERT INTO `t_student` VALUES ('2016013', 's2016013', 's2016013', '黄忠', '26', '男', '南京信息工程大学', '网络工程', '15623235656', '江苏南京', '本科', '1');
INSERT INTO `t_student` VALUES ('2016014', 's2016014', 's2016014', 'sdsa', '25', '男', '南京信息工程大学', '网络工程', '15623235659', '南京', '硕士研究生', '1');
