ALTER  TABLE  `companies` add avatar varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci comment '公司头像',
add signature varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci comment '公司签名',
add `company_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '商户唯一id';
