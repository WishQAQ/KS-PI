ALTER  TABLE  `company_orders` modify column product_id VARCHAR(255) comment '订单关联产品或活动唯一id';
ALTER  TABLE  `company_orders` add type smallint(1) not null default 1 comment '类型：1产品 2活动 3服务',
 add created_id varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '买家全局uid',
add refund tinyint(1) unsigned not null DEFAULT 0 comment '退货退款状态：1卖家已退款 0未退款 2买家已确认退款',
add refund_num int(10) unsigned not null DEFAULT 0 comment '退货数量',
add merchant_no varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商户单号',
add is_deleted tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '用户是否删除',
add payment smallint(2) UNSIGNED NOT NULL DEFAULT 0 COMMENT '支付方式（1微信 2支付宝 3余额支付）',
add delivery_time timestamp(0)  DEFAULT null COMMENT '发货时间',
add refund_time timestamp(0)  DEFAULT null COMMENT '最后退款时间',
add take_delivery_time timestamp(0)  DEFAULT null COMMENT '收货时间',
add confirm_refund_time timestamp(0)  DEFAULT null COMMENT '确认退款时间',
add pay_time timestamp(0)  DEFAULT null COMMENT '付款时间',
add carrier varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '承运人（快递公司）';