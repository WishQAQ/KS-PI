ALTER  TABLE  `addresses` modify column uid VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci comment '关联用户全局唯一id',
add default tinyint(1) UNSIGNED NULL DEFAULT 0 COMMENT '是否默认地址（1是 0否）';