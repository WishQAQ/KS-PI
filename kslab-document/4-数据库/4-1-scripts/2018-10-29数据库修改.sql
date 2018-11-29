ALTER TABLE `kslab-test`.`actives` 
ADD COLUMN `refuse` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '������Ϣ' AFTER `city`,
ADD COLUMN `first_pass` timestamp(0) NULL DEFAULT NULL COMMENT '��һ���ύ���ʱ��' AFTER `refuse`;

ALTER TABLE `kslab-test`.`business_cooperation` 
ADD COLUMN `company_name` varchar(255) NULL COMMENT '��ҵ����' AFTER `status`;

ALTER TABLE `kslab-test`.`business_cooperation` 
MODIFY COLUMN `status` tinyint(1) NULL DEFAULT NULL COMMENT '״̬��0=��������Ȥ 1=������ϵ 2=���������� 4=������' AFTER `updated_at`;

ALTER TABLE `kslab-test`.`services` 
ADD COLUMN `refuse` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '������Ϣ' AFTER `district`;

ALTER TABLE `kslab-test`.`complains` 
ADD COLUMN `review` varchar(255) NULL COMMENT '��˽���' AFTER `url`;

ALTER TABLE `kslab-test`.`admin_users` 
ADD COLUMN `disable_id` varchar(255) NULL COMMENT '��������ȫ��ID-�������' AFTER `balance`;

ALTER TABLE `kslab-test`.`company_profile` 
MODIFY COLUMN `created_id` varchar(255) NULL DEFAULT NULL AFTER `updated_at`;

ALTER TABLE `kslab-test`.`admin_users` 
MODIFY COLUMN `status` tinyint(1) NULL DEFAULT NULL COMMENT '�û�״̬ 0ɾ�� 1���� 2ע�� 3���� 4����� 5 ����' AFTER `type`;

ALTER TABLE `kslab-test`.`answers` 
MODIFY COLUMN `type` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '���ͣ�1���� 2��Ƶ 3���� 4� 5��Ʒ 6���� 7�Ի� 8 �̼Ҷ���...' AFTER `status`;


ALTER TABLE `kslab-test`.`menu_major` 
MODIFY COLUMN `type` int(11) NULL DEFAULT 0 COMMENT '���ͣ�0=> Ĭ�ϰ�� ;1=>�ٿ�;2=>���� ;3=>���� 4=>� 5=>�Ի�; 6=>��Ʒ' AFTER `description`;

ALTER TABLE `kslab-test`.`admin_users` 
ADD COLUMN `weChat` varchar(255) NULL COMMENT '΢��unionid' AFTER `disable_id`;

ALTER TABLE `kslab-test`.`admin_users` 
ADD COLUMN `qq` varchar(255) NULL AFTER `aes_pwd`,
ADD COLUMN `alipay` varchar(255) NULL AFTER `qq`;

ALTER TABLE `kslab-test`.`templates` 
MODIFY COLUMN `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT 'ģ������' AFTER `type`;



INSERT INTO header (`name`,`type`) VALUES ('��ҳ',1);
INSERT INTO header (`name`,`type`) VALUES ('�̳�',1);
INSERT INTO header (`name`,`type`) VALUES ('�Ի�',1);
INSERT INTO header (`name`,`type`) VALUES ('����',1);
INSERT INTO header (`name`,`type`) VALUES ('�',1);
INSERT INTO header (`name`,`type`) VALUES ('������ҳ',2);
INSERT INTO header (`name`,`type`) VALUES ('���ﳵ',2);
INSERT INTO header (`name`,`type`) VALUES ('�',2);
INSERT INTO header (`name`,`type`) VALUES ('�Ի�',2);
INSERT INTO header (`name`,`type`) VALUES ('��ע',2);
INSERT INTO header (`name`,`type`) VALUES ('����',2);
INSERT INTO header (`name`,`type`) VALUES ('��ʷ��¼',2);
INSERT INTO header (`name`,`type`) VALUES ('�ϴ�����',2);
INSERT INTO header (`name`,`type`) VALUES ('�Ի�����',2);
INSERT INTO header (`name`,`type`) VALUES ('HOME',3);
INSERT INTO header (`name`,`type`) VALUES ('�ֿ�',3);
INSERT INTO header (`name`,`type`) VALUES ('�',3);
INSERT INTO header (`name`,`type`) VALUES ('����',3);
INSERT INTO header (`name`,`type`) VALUES ('����',3);
INSERT INTO header (`name`,`type`) VALUES ('�Ի�',3);
INSERT INTO header (`name`,`type`) VALUES ('�ϴ�����',3);




