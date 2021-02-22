/*
 Navicat Premium Data Transfer

 Source Server         : XiaMin
 Source Server Type    : MySQL
 Source Server Version : 50733
 Source Host           : localhost:3306
 Source Schema         : medicalresourceschedulingsystem

 Target Server Type    : MySQL
 Target Server Version : 50733
 File Encoding         : 65001

 Date: 20/02/2021 11:30:57
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for accounttb
-- ----------------------------
DROP TABLE IF EXISTS `accounttb`;
CREATE TABLE `accounttb`  (
  `accountNum` int(11) NOT NULL COMMENT '登录账号',
  `accountPwd` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '登录密码',
  `accountRole` int(255) NOT NULL COMMENT '账号角色',
  PRIMARY KEY (`accountNum`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for admintb
-- ----------------------------
DROP TABLE IF EXISTS `admintb`;
CREATE TABLE `admintb`  (
  `adminNum` int(11) NOT NULL COMMENT '管理员账号',
  `adminName` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '管理员姓名',
  `adminTel` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '管理员电话号码',
  `adminEmail` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '管理员邮箱',
  PRIMARY KEY (`adminNum`) USING BTREE,
  CONSTRAINT `mannger_acconut` FOREIGN KEY (`adminNum`) REFERENCES `accounttb` (`accountNum`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for applytb
-- ----------------------------
DROP TABLE IF EXISTS `applytb`;
CREATE TABLE `applytb`  (
  `hospitalNum` int(11) NOT NULL COMMENT '申请医院的账号',
  `applyId` int(11) NOT NULL AUTO_INCREMENT COMMENT '申请记录id',
  `suppliesId` int(11) NOT NULL COMMENT '申请物资id',
  `suppliesNum` int(11) NOT NULL COMMENT '申请物资的数量',
  `operationAccount` int(11) NULL DEFAULT NULL COMMENT '操作者账号',
  `operationRes` int(11) NULL DEFAULT NULL COMMENT '操作结果',
  PRIMARY KEY (`applyId`) USING BTREE,
  INDEX `apply_hospitalAco`(`hospitalNum`) USING BTREE,
  INDEX `apply_supId`(`suppliesId`) USING BTREE,
  CONSTRAINT `apply_hospitalAco` FOREIGN KEY (`hospitalNum`) REFERENCES `hospitalmesstb` (`hospitalNum`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `apply_supId` FOREIGN KEY (`suppliesId`) REFERENCES `suppliestb` (`suppliesId`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for hospitalmesstb
-- ----------------------------
DROP TABLE IF EXISTS `hospitalmesstb`;
CREATE TABLE `hospitalmesstb`  (
  `hospitalNum` int(11) NOT NULL COMMENT '医院账号',
  `hospitalName` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '医院名称',
  `hospitalDescribe` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '医院简述',
  `hospitalDress` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '医院地址',
  `hospitalImgUrl` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '医院账户头像地址',
  `tel` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '医院联系电话',
  `bedsSum` int(255) NULL DEFAULT NULL COMMENT '医院病床总数',
  `emptys` int(255) NULL DEFAULT NULL COMMENT '医院空病床数',
  PRIMARY KEY (`hospitalNum`) USING BTREE,
  CONSTRAINT `accountNum` FOREIGN KEY (`hospitalNum`) REFERENCES `accounttb` (`accountNum`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for hospitalsuppliestb
-- ----------------------------
DROP TABLE IF EXISTS `hospitalsuppliestb`;
CREATE TABLE `hospitalsuppliestb`  (
  `hospitalNum` int(11) NOT NULL COMMENT '医院账号',
  `suppliesId` int(11) NOT NULL COMMENT '物资编号',
  `hospitalsuppliesNum` int(11) NULL DEFAULT NULL COMMENT '医院对于该物资的库存',
  PRIMARY KEY (`hospitalNum`, `suppliesId`) USING BTREE,
  INDEX `suppliesId`(`suppliesId`) USING BTREE,
  CONSTRAINT `hospitalAccount` FOREIGN KEY (`hospitalNum`) REFERENCES `accounttb` (`accountNum`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `suppliesId` FOREIGN KEY (`suppliesId`) REFERENCES `suppliestb` (`suppliesId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for patienttb
-- ----------------------------
DROP TABLE IF EXISTS `patienttb`;
CREATE TABLE `patienttb`  (
  `patientId` int(11) NOT NULL AUTO_INCREMENT COMMENT '病人住院记录id',
  `patientName` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '病人姓名',
  `idCardNum` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '病人身份证号码',
  `startTime` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '住院开始时间',
  `endTime` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '出院时间',
  `hospitalNum` int(11) NULL DEFAULT NULL COMMENT '所在医院的账号',
  PRIMARY KEY (`patientId`) USING BTREE,
  INDEX `patien_hospitalNum`(`hospitalNum`) USING BTREE,
  CONSTRAINT `patien_hospitalNum` FOREIGN KEY (`hospitalNum`) REFERENCES `hospitalmesstb` (`hospitalNum`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for suppliestb
-- ----------------------------
DROP TABLE IF EXISTS `suppliestb`;
CREATE TABLE `suppliestb`  (
  `suppliesId` int(11) NOT NULL AUTO_INCREMENT COMMENT '物资编号',
  `suppliesName` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '物资名称',
  `suppliesSum` int(255) NULL DEFAULT NULL COMMENT '中心库存',
  PRIMARY KEY (`suppliesId`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for volunteerstb
-- ----------------------------
DROP TABLE IF EXISTS `volunteerstb`;
CREATE TABLE `volunteerstb`  (
  `volunteerNum` int(11) NOT NULL COMMENT '自愿者账号',
  `tel` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '自愿者电话',
  `email` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '自愿者邮箱地址',
  `volunteerName` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '自愿者姓名',
  `volunteerId` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '自愿者身份证号',
  `hospitalNum` int(11) NULL DEFAULT NULL COMMENT '自愿者所在医院的账号',
  PRIMARY KEY (`volunteerNum`) USING BTREE,
  UNIQUE INDEX `身份证号`(`volunteerId`) USING BTREE COMMENT '一个身份证只能注册成为一个志愿者',
  CONSTRAINT `accountNum_vol` FOREIGN KEY (`volunteerNum`) REFERENCES `accounttb` (`accountNum`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Triggers structure for table accounttb
-- ----------------------------
DROP TRIGGER IF EXISTS `autoInsertMess`;
delimiter ;;
CREATE TRIGGER `autoInsertMess` AFTER INSERT ON `accounttb` FOR EACH ROW BEGIN
if new.accountRole=0 
THEN INSERT INTO admintb(adminNum,adminName) VALUES (new.accountNum,new.accountNum);
end if;
if new.accountRole=1 
THEN INSERT INTO hospitalmesstb(hospitalNum,hospitalName) VALUES (new.accountNum,new.accountNum);
end if;
if new.accountRole=2 
THEN INSERT INTO volunteerstb(volunteerNum,volunteerName) VALUES (new.accountNum,new.accountNum);
end if;
END
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
