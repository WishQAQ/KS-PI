ALTER TABLE `kslab-test`.`sensitive_word` 
ADD COLUMN `status` tinyint(1) NULL COMMENT '状态值: 0=>禁用 1 启用' AFTER `key_words`;

ALTER TABLE `kslab-test`.`web_icon` 
CHANGE COLUMN `url` `image_path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'ICON图片地址' AFTER `name`;

ALTER TABLE `kslab-test`.`admin_menu_folder` 
ADD COLUMN `menu_type` tinyint(3) NULL DEFAULT 0 COMMENT '菜单类型：0=>admin_menu,1=>menu_shop,2=>menu_ui,\r\n3=>menu_major' AFTER `menu_id`;

ALTER TABLE `kslab-test`.`web_background` 
CHANGE COLUMN `url` `image_path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '图片路由地址' AFTER `name`;

ALTER TABLE `kslab-test`.`menu_ui` 
MODIFY COLUMN `type` int(11) NULL DEFAULT NULL COMMENT '上传类型：0 默认 1、百科 2、问题 3、服务 4、活动' AFTER `description`;

ALTER TABLE `kslab-test`.`web_review` 
ADD COLUMN `limit_day` int(11) NULL COMMENT '禁用天数' AFTER `description`;

ALTER TABLE `kslab-test`.`articles` 
ADD COLUMN `word_num` int(11) NULL COMMENT '文章字数' AFTER `view_num`,
MODIFY COLUMN `status` tinyint(1) NULL DEFAULT NULL COMMENT '状态：0 删除  1正常 2 待审核 3 未通过' AFTER `updated_at`;

ALTER TABLE `kslab-test`.`articles` 
CHANGE COLUMN `catagory_id` `category_id` int(11) NULL DEFAULT NULL COMMENT '类别id（无人机，汽车等）' AFTER `image_path`;

ALTER TABLE `kslab-test`.`articles` 
ADD COLUMN `refuse` varchar(255) NULL COMMENT '驳回信息' AFTER `status`;

ALTER TABLE `kslab-test`.`videos` 
ADD COLUMN `video_length` int(0) NULL COMMENT '视频长度' AFTER `status`;

ALTER TABLE `kslab-test`.`questions` 
ADD COLUMN `word_num` int(0) NULL COMMENT '字数' AFTER `attachment`;

ALTER TABLE `kslab-test`.`encyclopedias` 
ADD COLUMN `word_num` int(0) NULL COMMENT '字数' AFTER `status`;

ALTER TABLE `kslab-test`.`questions` 
MODIFY COLUMN `status` tinyint(1) NULL DEFAULT 1 COMMENT '状态：0 删除  1正常 2 待审核 3 未通过' AFTER `updated_at`,
ADD COLUMN `refuse` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '驳回信息' AFTER `word_num`;

ALTER TABLE `kslab-test`.`encyclopedias` 
ADD COLUMN `refuse` varchar(255) NULL COMMENT '驳回信息' AFTER `word_num`;

ALTER TABLE `kslab-test`.`videos` 
ADD COLUMN `refuse` varchar(255) NULL COMMENT '驳回信息' AFTER `video_length`;

ALTER TABLE `kslab-test`.`answers` 
MODIFY COLUMN `status` tinyint(1) NULL DEFAULT NULL COMMENT '状态：1正常 0删除 2待审核 3审核未通过 4下架' AFTER `updated_at`,
ADD COLUMN `review` varchar(255) NULL COMMENT '审核信息' AFTER `score`;

ALTER TABLE `kslab-test`.`comments` 
MODIFY COLUMN `status` tinyint(1) NULL DEFAULT NULL COMMENT '状态：1正常 0删除 2待审核 3审核未通过 4下架' AFTER `created_at`,
ADD COLUMN `review` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '审核信息' AFTER `status`;