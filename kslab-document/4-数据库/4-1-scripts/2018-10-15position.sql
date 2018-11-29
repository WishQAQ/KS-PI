ALTER TABLE `kslab-test`.`positions` 
ADD COLUMN `department_id` int(11) NULL COMMENT '部门id' AFTER `status`,
ADD COLUMN `price` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '薪资待遇' AFTER `department_id`,
ADD COLUMN `limit` int(11) NULL COMMENT '空缺人数' AFTER `price`;
ADD COLUMN `end_time` timestamp(0) NULL COMMENT '报名截止时间' AFTER `limit`;

ALTER TABLE `kslab-test`.`position_applied` 
MODIFY COLUMN `status` tinyint(1) NULL DEFAULT 1 COMMENT '状态： 0删除 1待审核 2 已邀请面试 3 拒绝 4 通过' AFTER `updated_at`;
ADD COLUMN `education_type` tinyint(1) NULL COMMENT '教育程度 : 1 小学 2 初中  3 高中 4 大学专科 5 大学本科 6 研究生 7 博士生' AFTER `status`;