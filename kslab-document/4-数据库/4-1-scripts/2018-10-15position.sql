ALTER TABLE `kslab-test`.`positions` 
ADD COLUMN `department_id` int(11) NULL COMMENT '����id' AFTER `status`,
ADD COLUMN `price` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT 'н�ʴ���' AFTER `department_id`,
ADD COLUMN `limit` int(11) NULL COMMENT '��ȱ����' AFTER `price`;
ADD COLUMN `end_time` timestamp(0) NULL COMMENT '������ֹʱ��' AFTER `limit`;

ALTER TABLE `kslab-test`.`position_applied` 
MODIFY COLUMN `status` tinyint(1) NULL DEFAULT 1 COMMENT '״̬�� 0ɾ�� 1����� 2 ���������� 3 �ܾ� 4 ͨ��' AFTER `updated_at`;
ADD COLUMN `education_type` tinyint(1) NULL COMMENT '�����̶� : 1 Сѧ 2 ����  3 ���� 4 ��ѧר�� 5 ��ѧ���� 6 �о��� 7 ��ʿ��' AFTER `status`;