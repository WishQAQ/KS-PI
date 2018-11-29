ALTER TABLE `kslab-test`.`videos_title_relations` 
DROP COLUMN `id`,
DROP PRIMARY KEY;

ALTER TABLE `kslab-test`.`menu_relationship` 
DROP COLUMN `menu_shop`,
DROP COLUMN `menu_ui`,
CHANGE COLUMN `menu_major` `menu_id` varchar(255) NULL DEFAULT NULL COMMENT '全局菜单ID' FIRST,
CHANGE COLUMN `global_id` `relation_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '全局关联ID' AFTER `menu_id`,
CHANGE COLUMN `table_name` `type` int(11) NULL DEFAULT NULL COMMENT '菜单类型：0 menu_ui 上传菜单；1 menu_major 专业目录 ； 2 menu_shop 商城目录' AFTER `relation_id`;