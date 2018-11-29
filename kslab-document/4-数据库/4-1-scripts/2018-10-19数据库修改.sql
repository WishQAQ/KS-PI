ALTER TABLE `kslab-test`.`sensitive_word` 
ADD COLUMN `status` tinyint(1) NULL COMMENT '״ֵ̬: 0=>���� 1 ����' AFTER `key_words`;

ALTER TABLE `kslab-test`.`web_icon` 
CHANGE COLUMN `url` `image_path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'ICONͼƬ��ַ' AFTER `name`;

ALTER TABLE `kslab-test`.`admin_menu_folder` 
ADD COLUMN `menu_type` tinyint(3) NULL DEFAULT 0 COMMENT '�˵����ͣ�0=>admin_menu,1=>menu_shop,2=>menu_ui,\r\n3=>menu_major' AFTER `menu_id`;

ALTER TABLE `kslab-test`.`web_background` 
CHANGE COLUMN `url` `image_path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'ͼƬ·�ɵ�ַ' AFTER `name`;

ALTER TABLE `kslab-test`.`menu_ui` 
MODIFY COLUMN `type` int(11) NULL DEFAULT NULL COMMENT '�ϴ����ͣ�0 Ĭ�� 1���ٿ� 2������ 3������ 4���' AFTER `description`;

ALTER TABLE `kslab-test`.`web_review` 
ADD COLUMN `limit_day` int(11) NULL COMMENT '��������' AFTER `description`;

ALTER TABLE `kslab-test`.`articles` 
ADD COLUMN `word_num` int(11) NULL COMMENT '��������' AFTER `view_num`,
MODIFY COLUMN `status` tinyint(1) NULL DEFAULT NULL COMMENT '״̬��0 ɾ��  1���� 2 ����� 3 δͨ��' AFTER `updated_at`;

ALTER TABLE `kslab-test`.`articles` 
CHANGE COLUMN `catagory_id` `category_id` int(11) NULL DEFAULT NULL COMMENT '���id�����˻��������ȣ�' AFTER `image_path`;

ALTER TABLE `kslab-test`.`articles` 
ADD COLUMN `refuse` varchar(255) NULL COMMENT '������Ϣ' AFTER `status`;

ALTER TABLE `kslab-test`.`videos` 
ADD COLUMN `video_length` int(0) NULL COMMENT '��Ƶ����' AFTER `status`;

ALTER TABLE `kslab-test`.`questions` 
ADD COLUMN `word_num` int(0) NULL COMMENT '����' AFTER `attachment`;

ALTER TABLE `kslab-test`.`encyclopedias` 
ADD COLUMN `word_num` int(0) NULL COMMENT '����' AFTER `status`;

ALTER TABLE `kslab-test`.`questions` 
MODIFY COLUMN `status` tinyint(1) NULL DEFAULT 1 COMMENT '״̬��0 ɾ��  1���� 2 ����� 3 δͨ��' AFTER `updated_at`,
ADD COLUMN `refuse` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '������Ϣ' AFTER `word_num`;

ALTER TABLE `kslab-test`.`encyclopedias` 
ADD COLUMN `refuse` varchar(255) NULL COMMENT '������Ϣ' AFTER `word_num`;

ALTER TABLE `kslab-test`.`videos` 
ADD COLUMN `refuse` varchar(255) NULL COMMENT '������Ϣ' AFTER `video_length`;

ALTER TABLE `kslab-test`.`answers` 
MODIFY COLUMN `status` tinyint(1) NULL DEFAULT NULL COMMENT '״̬��1���� 0ɾ�� 2����� 3���δͨ�� 4�¼�' AFTER `updated_at`,
ADD COLUMN `review` varchar(255) NULL COMMENT '�����Ϣ' AFTER `score`;

ALTER TABLE `kslab-test`.`comments` 
MODIFY COLUMN `status` tinyint(1) NULL DEFAULT NULL COMMENT '״̬��1���� 0ɾ�� 2����� 3���δͨ�� 4�¼�' AFTER `created_at`,
ADD COLUMN `review` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '�����Ϣ' AFTER `status`;