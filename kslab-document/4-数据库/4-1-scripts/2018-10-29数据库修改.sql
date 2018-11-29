ALTER TABLE `kslab-test`.`actives` 
ADD COLUMN `refuse` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '驳回信息' AFTER `city`,
ADD COLUMN `first_pass` timestamp(0) NULL DEFAULT NULL COMMENT '第一次提交审核时间' AFTER `refuse`;

ALTER TABLE `kslab-test`.`business_cooperation` 
ADD COLUMN `company_name` varchar(255) NULL COMMENT '企业名称' AFTER `status`;

ALTER TABLE `kslab-test`.`business_cooperation` 
MODIFY COLUMN `status` tinyint(1) NULL DEFAULT NULL COMMENT '状态：0=》不感兴趣 1=》待联系 2=》继续跟进 4=》结束' AFTER `updated_at`;

ALTER TABLE `kslab-test`.`services` 
ADD COLUMN `refuse` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '驳回信息' AFTER `district`;

ALTER TABLE `kslab-test`.`complains` 
ADD COLUMN `review` varchar(255) NULL COMMENT '审核结论' AFTER `url`;

ALTER TABLE `kslab-test`.`admin_users` 
ADD COLUMN `disable_id` varchar(255) NULL COMMENT '禁用类型全局ID-禁用类别' AFTER `balance`;

ALTER TABLE `kslab-test`.`company_profile` 
MODIFY COLUMN `created_id` varchar(255) NULL DEFAULT NULL AFTER `updated_at`;

ALTER TABLE `kslab-test`.`admin_users` 
MODIFY COLUMN `status` tinyint(1) NULL DEFAULT NULL COMMENT '用户状态 0删除 1正常 2注销 3禁用 4待审核 5 驳回' AFTER `type`;

ALTER TABLE `kslab-test`.`answers` 
MODIFY COLUMN `type` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '类型：1文章 2视频 3问题 4活动 5商品 6服务 7淘货 8 商家订单...' AFTER `status`;


ALTER TABLE `kslab-test`.`menu_major` 
MODIFY COLUMN `type` int(11) NULL DEFAULT 0 COMMENT '类型：0=> 默认板块 ;1=>百科;2=>问题 ;3=>服务 4=>活动 5=>淘货; 6=>商品' AFTER `description`;

ALTER TABLE `kslab-test`.`admin_users` 
ADD COLUMN `weChat` varchar(255) NULL COMMENT '微信unionid' AFTER `disable_id`;

ALTER TABLE `kslab-test`.`admin_users` 
ADD COLUMN `qq` varchar(255) NULL AFTER `aes_pwd`,
ADD COLUMN `alipay` varchar(255) NULL AFTER `qq`;

ALTER TABLE `kslab-test`.`templates` 
MODIFY COLUMN `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '模版内容' AFTER `type`;



INSERT INTO header (`name`,`type`) VALUES ('首页',1);
INSERT INTO header (`name`,`type`) VALUES ('商城',1);
INSERT INTO header (`name`,`type`) VALUES ('淘货',1);
INSERT INTO header (`name`,`type`) VALUES ('服务',1);
INSERT INTO header (`name`,`type`) VALUES ('活动',1);
INSERT INTO header (`name`,`type`) VALUES ('个人首页',2);
INSERT INTO header (`name`,`type`) VALUES ('购物车',2);
INSERT INTO header (`name`,`type`) VALUES ('活动',2);
INSERT INTO header (`name`,`type`) VALUES ('对话',2);
INSERT INTO header (`name`,`type`) VALUES ('关注',2);
INSERT INTO header (`name`,`type`) VALUES ('收入',2);
INSERT INTO header (`name`,`type`) VALUES ('历史纪录',2);
INSERT INTO header (`name`,`type`) VALUES ('上传管理',2);
INSERT INTO header (`name`,`type`) VALUES ('淘货管理',2);
INSERT INTO header (`name`,`type`) VALUES ('HOME',3);
INSERT INTO header (`name`,`type`) VALUES ('仓库',3);
INSERT INTO header (`name`,`type`) VALUES ('活动',3);
INSERT INTO header (`name`,`type`) VALUES ('服务',3);
INSERT INTO header (`name`,`type`) VALUES ('收入',3);
INSERT INTO header (`name`,`type`) VALUES ('对话',3);
INSERT INTO header (`name`,`type`) VALUES ('上传管理',3);




