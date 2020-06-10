/*
 Navicat Premium Data Transfer

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 50528
 Source Host           : localhost:3306
 Source Schema         : jbdb

 Target Server Type    : MySQL
 Target Server Version : 50528
 File Encoding         : 65001

 Date: 10/06/2020 16:06:20
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for archives
-- ----------------------------
DROP TABLE IF EXISTS `archives`;
CREATE TABLE `archives`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `archivestype` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `author` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `date` date NOT NULL,
  `save` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `fileName` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `all`(`title`) USING BTREE,
  INDEX `archives_FK_1`(`archivestype`) USING BTREE,
  INDEX `author`(`author`) USING BTREE,
  CONSTRAINT `archives_FK_1` FOREIGN KEY (`archivestype`) REFERENCES `archivestype` (`archivestype`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 34 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of archives
-- ----------------------------
INSERT INTO `archives` VALUES (30, '档案（一）', '科学技术档案', '作者（一）', '2020-06-04', 'C:/Tomcat 7.0/webapps/laojunsen/pdf/外文翻译.pdf', '外文翻译.pdf');
INSERT INTO `archives` VALUES (31, '档案（二）', '科学技术档案', '作者（二）', '2020-06-04', 'C:/Tomcat 7.0/webapps/laojunsen/pdf/aff7c93b-efff-4571-9279-f09371261e44.pdf', 'aff7c93b-efff-4571-9279-f09371261e44.pdf');
INSERT INTO `archives` VALUES (33, '测试', '人员档案', '测试', '2020-06-09', 'C:/Tomcat 7.0/webapps/laojunsen/pdf/安装路径不能包含中文或空格.txt', '安装路径不能包含中文或空格.txt');

-- ----------------------------
-- Table structure for archivestype
-- ----------------------------
DROP TABLE IF EXISTS `archivestype`;
CREATE TABLE `archivestype`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `archivestype` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `archivestype`(`archivestype`) USING BTREE,
  UNIQUE INDEX `id`(`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of archivestype
-- ----------------------------
INSERT INTO `archivestype` VALUES (4, '人员档案');
INSERT INTO `archivestype` VALUES (8, '添加测试');
INSERT INTO `archivestype` VALUES (2, '科学技术档案');
INSERT INTO `archivestype` VALUES (7, '编辑测试');
INSERT INTO `archivestype` VALUES (3, '艺术档案');
INSERT INTO `archivestype` VALUES (1, '行政档案');

-- ----------------------------
-- Table structure for borrowing
-- ----------------------------
DROP TABLE IF EXISTS `borrowing`;
CREATE TABLE `borrowing`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userName` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `author` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `archivestype` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `progress` int(2) NOT NULL,
  `date` date NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `borrowing_FK_1`(`userName`) USING BTREE,
  INDEX `borrowing_FK_2`(`title`) USING BTREE,
  INDEX `borrowing_FK_4`(`author`) USING BTREE,
  INDEX `borrowing_FK_5`(`archivestype`) USING BTREE,
  INDEX `borrowing_KF_3`(`progress`) USING BTREE,
  CONSTRAINT `borrowing_FK_1` FOREIGN KEY (`userName`) REFERENCES `user` (`userName`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `borrowing_FK_2` FOREIGN KEY (`title`) REFERENCES `archives` (`title`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `borrowing_FK_4` FOREIGN KEY (`author`) REFERENCES `archives` (`author`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `borrowing_FK_5` FOREIGN KEY (`archivestype`) REFERENCES `archivestype` (`archivestype`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `borrowing_KF_3` FOREIGN KEY (`progress`) REFERENCES `borrowingprogress` (`progress`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of borrowing
-- ----------------------------
INSERT INTO `borrowing` VALUES (11, 'student', '档案（一）', '作者（一）', '科学技术档案', 3, '2020-06-04');
INSERT INTO `borrowing` VALUES (12, 'student', '档案（二）', '作者（二）', '科学技术档案', 2, '2020-06-04');

-- ----------------------------
-- Table structure for borrowingprogress
-- ----------------------------
DROP TABLE IF EXISTS `borrowingprogress`;
CREATE TABLE `borrowingprogress`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `progress` int(2) NOT NULL,
  `cnprogress` varchar(6) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `progress`(`progress`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of borrowingprogress
-- ----------------------------
INSERT INTO `borrowingprogress` VALUES (1, 1, '申请中');
INSERT INTO `borrowingprogress` VALUES (2, 2, '已同意');
INSERT INTO `borrowingprogress` VALUES (3, 3, '已拒绝');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userName` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `passWord` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `nickName` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `userType` int(2) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `userName`(`userName`) USING BTREE,
  UNIQUE INDEX `nickName`(`nickName`) USING BTREE,
  INDEX `user_FK_1`(`userType`) USING BTREE,
  CONSTRAINT `user_FK_1` FOREIGN KEY (`userType`) REFERENCES `usertype` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, 'student', 'root', '普通', 2);
INSERT INTO `user` VALUES (2, 'daroot', 'root', '档案管理', 1);
INSERT INTO `user` VALUES (3, 'sroot', 'root1234', '超管', 0);
INSERT INTO `user` VALUES (4, 'qwe', 'qwe', 'qwe', 2);
INSERT INTO `user` VALUES (5, 'qwew', 'qwww', 'ss', 1);
INSERT INTO `user` VALUES (7, 'a', 'e', 's', 2);
INSERT INTO `user` VALUES (8, '测试', 'aadd1111', 'sdasdsa', 1);

-- ----------------------------
-- Table structure for usertype
-- ----------------------------
DROP TABLE IF EXISTS `usertype`;
CREATE TABLE `usertype`  (
  `id` int(2) NOT NULL AUTO_INCREMENT,
  `userType` varchar(12) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `userType`(`userType`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of usertype
-- ----------------------------
INSERT INTO `usertype` VALUES (2, '普通用户');
INSERT INTO `usertype` VALUES (1, '档案管理员');
INSERT INTO `usertype` VALUES (3, '超级用户');

SET FOREIGN_KEY_CHECKS = 1;
