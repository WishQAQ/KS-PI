/*
 Navicat MySQL Data Transfer

 Source Server         : kslab-write
 Source Server Type    : MySQL
 Source Server Version : 80013
 Source Host           : 172.16.0.129:3307
 Source Schema         : kslab-test

 Target Server Type    : MySQL
 Target Server Version : 80013
 File Encoding         : 65001

 Date: 06/11/2018 11:33:37
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for goods
-- ----------------------------
DROP TABLE IF EXISTS `goods`;
CREATE TABLE `goods`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `uid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '产品所属用户全局唯一id',
  `category_id` int(11) NULL DEFAULT NULL COMMENT '产品分类id',
  `brand_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '品牌全局唯一id',
  `asin` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '产品编号',
  `stock` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '产品库存',
  `sell_num` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '卖出数量',
  `price` decimal(10, 2) NULL DEFAULT NULL COMMENT '单价',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '商品名称',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '商品描述',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `show_picture` json NULL COMMENT '商品展示图片',
  `province` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '省份',
  `view_num` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '浏览人数',
  `city` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '市',
  `district` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '区',
  `score` decimal(2, 1) UNSIGNED NOT NULL DEFAULT 0.0 COMMENT '评分',
  `created_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `updated_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `created_at` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  `status` tinyint(1) UNSIGNED NOT NULL DEFAULT 3 COMMENT '状态：1上架 2下架 0删除 3待审核 4未通过',
  `video` json NULL COMMENT '视频',
  `attachment` json NULL COMMENT '附件',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 39 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '淘货' ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;
