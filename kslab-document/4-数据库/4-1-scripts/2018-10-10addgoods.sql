/*
 Navicat MySQL Data Transfer

 Source Server         : ks
 Source Server Type    : MySQL
 Source Server Version : 50723
 Source Host           : 172.16.0.129:3306
 Source Schema         : kslab-test

 Target Server Type    : MySQL
 Target Server Version : 50723
 File Encoding         : 65001

 Date: 10/10/2018 15:46:19
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for goods
-- ----------------------------
DROP TABLE IF EXISTS `goods`;
CREATE TABLE `goods`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `uid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '产品所属用户全局唯一id',
  `category_id` int(11) NULL DEFAULT NULL COMMENT '产品分类id',
  `brand_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '品牌全局唯一id',
  `asin` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '产品编号',
  `stock` int(11) NULL DEFAULT NULL COMMENT '产品库存',
  `sell_num` int(11) NULL DEFAULT NULL COMMENT '卖出数量',
  `price` decimal(10, 2) NULL DEFAULT NULL COMMENT '单价',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商品名称',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商品描述',
  `show_picture` json NULL COMMENT '商品展示图片',
  `province` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '省份',
  `score` decimal(2, 1) NULL DEFAULT NULL COMMENT '评分',
  `creatd_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `updated_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  `status` tinyint(1) NULL DEFAULT NULL COMMENT '状态：1上架 2下架 0删除',
  `goods_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '商品全局唯一id',
  `video` json NULL COMMENT '视频',
  `attachment` json NULL COMMENT '附件',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '淘货' ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;
