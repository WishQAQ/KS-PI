/*
 Navicat Premium Data Transfer

 Source Server         : 酷耍
 Source Server Type    : MySQL
 Source Server Version : 50723
 Source Host           : 172.16.0.129:3306
 Source Schema         : kslab-test

 Target Server Type    : MySQL
 Target Server Version : 50723
 File Encoding         : 65001

 Date: 12/10/2018 15:03:33
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for admin_menu_folder
-- ----------------------------
DROP TABLE IF EXISTS `admin_menu_folder`;
CREATE TABLE `admin_menu_folder`  (
  `folder_id` int(11) NOT NULL COMMENT '文件夹id',
  `menu_id` int(11) NOT NULL COMMENT '菜单id'
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '菜单文件夹关联' ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;
