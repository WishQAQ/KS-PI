/*
 Navicat MySQL Data Transfer

 Source Server         : 172.16.0.129
 Source Server Type    : MySQL
 Source Server Version : 50723
 Source Host           : 172.16.0.129
 Source Database       : kslab-test

 Target Server Type    : MySQL
 Target Server Version : 50723
 File Encoding         : utf-8

 Date: 10/08/2018 09:03:45 AM
*/

SET NAMES utf8;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
--  Table structure for `actives`
-- ----------------------------
DROP TABLE IF EXISTS `actives`;
CREATE TABLE `actives` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `active_id` varchar(255) DEFAULT NULL COMMENT '活动全局唯一id',
  `company_id` varchar(255) DEFAULT NULL COMMENT '关联公司全局唯一id',
  `category_id` int(11) DEFAULT NULL COMMENT '类别id',
  `active_date` timestamp NULL DEFAULT NULL COMMENT '活动日期，不设置为长期',
  `price` decimal(10,2) DEFAULT NULL COMMENT '价格',
  `title` varchar(255) DEFAULT NULL COMMENT '活动名称',
  `content` text COMMENT '活动内容',
  `address` varchar(255) DEFAULT NULL COMMENT '举办地址',
  `telphone` varchar(255) DEFAULT NULL COMMENT '联系电话',
  `promotee` varchar(255) DEFAULT NULL COMMENT '举办方',
  `attachment` json DEFAULT NULL COMMENT '附件（图片，文件等）',
  `created_id` varchar(255) DEFAULT NULL,
  `updated_id` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `status` tinyint(1) DEFAULT NULL COMMENT '状态：1正常 0删除 2待审核 3审核未通过 4已取消 5已停止报名 6已暂停',
  `quantity` int(10) DEFAULT NULL COMMENT '活动限制总票数',
  `description` text COMMENT '活动简介',
  `sale_num` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '售出票数',
  `registration_deadline` timestamp NULL DEFAULT NULL COMMENT '报名截止时间',
  `pics` json DEFAULT NULL COMMENT '活动图片',
  `like_num` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '点赞数',
  `score` decimal(2,1) unsigned NOT NULL DEFAULT '0.0' COMMENT '评分（平均分）',
  `video` json DEFAULT NULL COMMENT '活动视频',
  `view_num` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '浏览量',
  `area_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '活动区域Id(市级区域id)',
  `enrollment` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '报名人数',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COMMENT='服务';

-- ----------------------------
--  Table structure for `addresses`
-- ----------------------------
DROP TABLE IF EXISTS `addresses`;
CREATE TABLE `addresses` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `uid` int(11) DEFAULT NULL COMMENT '关联用户id',
  `address_id` varchar(255) DEFAULT NULL COMMENT '收货地址全局唯一id',
  `province_id` int(11) DEFAULT NULL COMMENT '关联省id',
  `city_id` int(11) DEFAULT NULL COMMENT '关联市id',
  `area_id` int(11) DEFAULT NULL COMMENT '关联区id',
  `detail` varchar(255) DEFAULT NULL COMMENT '地址详情',
  `telphone` varchar(255) DEFAULT NULL COMMENT '联系电话',
  `postcode` varchar(255) DEFAULT NULL COMMENT '邮编',
  `conducts` varchar(255) DEFAULT NULL COMMENT '联系人',
  `created_id` varchar(255) DEFAULT NULL,
  `updated_id` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `status` tinyint(1) DEFAULT NULL COMMENT '状态：1正常 0删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
--  Table structure for `admin_menu`
-- ----------------------------
DROP TABLE IF EXISTS `admin_menu`;
CREATE TABLE `admin_menu` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL COMMENT '菜单列表名称',
  `url` varchar(255) DEFAULT NULL COMMENT '跳转连接',
  `icon` varchar(100) DEFAULT NULL COMMENT '图标',
  `type` int(11) DEFAULT NULL COMMENT '菜单级别：1=》一级菜单，2=》二级菜单.....',
  `pid` int(11) DEFAULT NULL COMMENT '父id',
  `status` int(11) DEFAULT NULL COMMENT '状态：0=》正常，1=》异常',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
--  Table structure for `admin_permission_role`
-- ----------------------------
DROP TABLE IF EXISTS `admin_permission_role`;
CREATE TABLE `admin_permission_role` (
  `permission_id` int(11) NOT NULL COMMENT '权限id',
  `role_id` int(11) NOT NULL COMMENT '角色id'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='权限角色关联表';

-- ----------------------------
--  Table structure for `admin_permissions`
-- ----------------------------
DROP TABLE IF EXISTS `admin_permissions`;
CREATE TABLE `admin_permissions` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT '权限名:填写url,无url填写#',
  `label` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT '权限解释名称',
  `description` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '描述与备注',
  `type` tinyint(1) unsigned DEFAULT NULL COMMENT '权限类型：1菜单 2动作',
  `cid` tinyint(4) NOT NULL COMMENT '级别',
  `icon` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '图标',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=117 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='权限表';

-- ----------------------------
--  Table structure for `admin_role_user`
-- ----------------------------
DROP TABLE IF EXISTS `admin_role_user`;
CREATE TABLE `admin_role_user` (
  `role_id` int(11) NOT NULL COMMENT '角色id',
  `user_id` int(11) NOT NULL COMMENT '用户id'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='角色用户关联表';

-- ----------------------------
--  Table structure for `admin_roles`
-- ----------------------------
DROP TABLE IF EXISTS `admin_roles`;
CREATE TABLE `admin_roles` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 NOT NULL COMMENT '角色名称',
  `description` varchar(255) CHARACTER SET utf8mb4 NOT NULL COMMENT '备注',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='角色表';

-- ----------------------------
--  Table structure for `admin_users`
-- ----------------------------
DROP TABLE IF EXISTS `admin_users`;
CREATE TABLE `admin_users` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '管理员用户表ID',
  `uid` varchar(255) DEFAULT NULL COMMENT '全局唯一用户id',
  `username` varchar(255) NOT NULL COMMENT '用户名',
  `email` varchar(255) DEFAULT NULL COMMENT '邮箱',
  `phone` varchar(255) DEFAULT NULL COMMENT '手机号',
  `password` varchar(255) DEFAULT NULL COMMENT '密码',
  `disable_end` timestamp NULL DEFAULT NULL COMMENT '禁用结束时间',
  `disable_reason` varchar(100) DEFAULT NULL COMMENT '禁用理由',
  `remember_token` varchar(100) DEFAULT NULL COMMENT '记住我令牌',
  `type` tinyint(2) DEFAULT NULL COMMENT '用户注册类型：0系统注册(管理员，客服，运营等) 1个人注册 2公司注册 3微信注册 4QQ注册 5微博注册',
  `status` tinyint(1) DEFAULT NULL COMMENT '用户状态 0删除 1正常 2注销 3禁用 4待审核',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `admin_users_email_unique` (`email`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8mb4 COMMENT='后台用户表';

-- ----------------------------
--  Table structure for `admin_users_profile`
-- ----------------------------
DROP TABLE IF EXISTS `admin_users_profile`;
CREATE TABLE `admin_users_profile` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `uid` varchar(255) DEFAULT NULL COMMENT '用户资料关联uid',
  `nickname` varchar(255) DEFAULT NULL COMMENT '用户昵称',
  `signature` varchar(255) DEFAULT NULL COMMENT '个性签名',
  `avatar` varchar(255) DEFAULT NULL COMMENT '头像',
  `actual_name` char(20) DEFAULT NULL COMMENT '真实姓名',
  `id_card` char(18) DEFAULT NULL COMMENT '身份证',
  `gender` tinyint(1) DEFAULT NULL COMMENT '性别 1男 2女 3保密',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COMMENT='用户资料';

-- ----------------------------
--  Table structure for `admin_users_social`
-- ----------------------------
DROP TABLE IF EXISTS `admin_users_social`;
CREATE TABLE `admin_users_social` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `uid` varchar(255) DEFAULT NULL COMMENT '社交账号关联用户uid',
  `social_id` varchar(255) DEFAULT NULL COMMENT '社交账号id',
  `social_name` varchar(255) DEFAULT NULL COMMENT '社交账号昵称',
  `social_photo` varchar(255) DEFAULT NULL COMMENT '社交账号头像',
  `status` tinyint(1) DEFAULT NULL COMMENT '状态 1正常绑定 2解除绑定',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `uid` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='第三方社交账户';

-- ----------------------------
--  Table structure for `answers`
-- ----------------------------
DROP TABLE IF EXISTS `answers`;
CREATE TABLE `answers` (
  `id` int(255) unsigned NOT NULL AUTO_INCREMENT,
  `answer_id` varchar(255) DEFAULT NULL COMMENT '回答全局唯一id',
  `source_id` varchar(255) DEFAULT NULL COMMENT '来源全局唯一id（文章，视频，问题，活动，商品等）',
  `content` text COMMENT '回答内容',
  `like_num` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '点赞数',
  `comment_num` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '评论数目',
  `created_id` varchar(255) DEFAULT NULL COMMENT '发布者id',
  `updated_id` varchar(255) DEFAULT NULL COMMENT '编辑者id',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL,
  `status` tinyint(1) DEFAULT NULL COMMENT '状态：1正常 0删除',
  `type` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '类型：1文章 2视频 3问题 4活动 5商品 ...',
  `score` smallint(4) unsigned NOT NULL DEFAULT '0' COMMENT '评分',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COMMENT='回答表';

-- ----------------------------
--  Table structure for `articles`
-- ----------------------------
DROP TABLE IF EXISTS `articles`;
CREATE TABLE `articles` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `article_id` varchar(255) DEFAULT NULL COMMENT '文章全局唯一id',
  `image_path` varchar(255) DEFAULT NULL COMMENT '文章图片路径',
  `catagory_id` int(11) DEFAULT NULL COMMENT '类别id（无人机，汽车等）',
  `source` varchar(255) DEFAULT NULL COMMENT '来源（网易新闻等）',
  `title` varchar(255) DEFAULT NULL COMMENT '标题',
  `profile` varchar(255) DEFAULT NULL COMMENT '文章简介',
  `content` text COMMENT '内容',
  `attachment` json DEFAULT NULL COMMENT '附件地址',
  `like_num` int(11) DEFAULT NULL COMMENT '点赞数',
  `comment_num` int(11) DEFAULT NULL COMMENT '评论数',
  `view_num` int(11) DEFAULT NULL COMMENT '浏览数',
  `created_id` varchar(255) DEFAULT NULL COMMENT '发布者id',
  `updated_id` varchar(255) DEFAULT NULL COMMENT '修改者id',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `status` tinyint(1) DEFAULT NULL COMMENT '状态：1正常 0删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COMMENT='文章表';

-- ----------------------------
--  Table structure for `banners`
-- ----------------------------
DROP TABLE IF EXISTS `banners`;
CREATE TABLE `banners` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `banner_id` varchar(255) DEFAULT NULL COMMENT 'banner全局唯一id',
  `banner_url` varchar(255) DEFAULT NULL COMMENT 'banner图片地址',
  `section` tinyint(2) unsigned DEFAULT NULL COMMENT 'banner所对应板块：1文章 ',
  `self_define_text_1` varchar(255) DEFAULT NULL COMMENT '自定义文本1',
  `self_define_text_2` varchar(255) DEFAULT NULL COMMENT '自定义文本2',
  `self_define_text_3` varchar(255) DEFAULT NULL COMMENT '自定义文本3',
  `created_id` varchar(255) DEFAULT NULL,
  `updated_id` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `status` tinyint(1) DEFAULT NULL COMMENT '状态：1正常 0删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
--  Table structure for `brands`
-- ----------------------------
DROP TABLE IF EXISTS `brands`;
CREATE TABLE `brands` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `brand_id` varchar(255) NOT NULL COMMENT '品牌全局唯一id',
  `brand_pid` varchar(255) NOT NULL COMMENT '品牌全局唯一父id',
  `name` varchar(255) NOT NULL COMMENT '品牌名称',
  `description` varchar(255) DEFAULT NULL COMMENT '品牌描述',
  `status` tinyint(1) DEFAULT NULL COMMENT '状态：1正常 0删除',
  `created_id` varchar(255) DEFAULT NULL,
  `updated_id` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='品牌表';

-- ----------------------------
--  Table structure for `catalog`
-- ----------------------------
DROP TABLE IF EXISTS `catalog`;
CREATE TABLE `catalog` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `encyclopedia_id` varchar(255) DEFAULT NULL COMMENT '百科全局唯一id',
  `catalog_id` varchar(255) DEFAULT NULL COMMENT '目录全局唯一id',
  `name` varchar(255) DEFAULT NULL COMMENT '百科目录名字',
  `pid` varchar(255) DEFAULT NULL COMMENT '父级ID，顶级为0',
  `level` int(11) DEFAULT NULL COMMENT '目录层级',
  `content` text COMMENT '内容',
  `created_id` varchar(255) DEFAULT NULL COMMENT '发布者id',
  `updated_id` varchar(255) DEFAULT NULL COMMENT '修改者id',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `status` tinyint(1) DEFAULT NULL COMMENT '状态：1正常 0删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COMMENT='百科目录表';

-- ----------------------------
--  Table structure for `categories`
-- ----------------------------
DROP TABLE IF EXISTS `categories`;
CREATE TABLE `categories` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `pid` int(11) unsigned DEFAULT '0' COMMENT '父级类别id',
  `name` varchar(255) DEFAULT NULL COMMENT '类别名称（无人机，汽车等）',
  `description` text COMMENT '类别描述',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `status` tinyint(1) DEFAULT NULL COMMENT '状态：1正常 0删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COMMENT='类别表';

-- ----------------------------
--  Table structure for `city`
-- ----------------------------
DROP TABLE IF EXISTS `city`;
CREATE TABLE `city` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(6) NOT NULL,
  `name` varchar(20) NOT NULL,
  `provincecode` varchar(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=343 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `city_linkage`
-- ----------------------------
DROP TABLE IF EXISTS `city_linkage`;
CREATE TABLE `city_linkage` (
  `id` int(5) unsigned NOT NULL AUTO_INCREMENT,
  `pid` int(5) unsigned NOT NULL DEFAULT '0' COMMENT '父类id',
  `name` varchar(120) DEFAULT NULL COMMENT '名称',
  `type` tinyint(1) DEFAULT '2' COMMENT '1=》省，2=》市，3=》区',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3410 DEFAULT CHARSET=utf8 COMMENT='城市三级联动表';

-- ----------------------------
--  Table structure for `comments`
-- ----------------------------
DROP TABLE IF EXISTS `comments`;
CREATE TABLE `comments` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `comment_id` varchar(255) DEFAULT NULL COMMENT '评论全局唯一id',
  `content` text COMMENT '评论内容',
  `answer_id` varchar(255) DEFAULT NULL COMMENT '回答全局唯一id',
  `reply_to_id` varchar(255) DEFAULT NULL COMMENT '回复到评论者id',
  `like_num` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '点赞数',
  `created_id` varchar(255) NOT NULL COMMENT '评论者id',
  `updated_id` varchar(255) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `status` tinyint(1) DEFAULT NULL COMMENT '状态：1正常 0删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COMMENT='评论表';

-- ----------------------------
--  Table structure for `companies`
-- ----------------------------
DROP TABLE IF EXISTS `companies`;
CREATE TABLE `companies` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `uid` varchar(255) NOT NULL COMMENT '公司关联用户id',
  `company_id` varchar(255) NOT NULL COMMENT '商户唯一id',
  `contacts` varchar(255) NOT NULL COMMENT '联系人',
  `telphone` varchar(255) NOT NULL COMMENT '公司电话',
  `name` varchar(255) NOT NULL COMMENT '公司名称',
  `address` varchar(255) NOT NULL COMMENT '公司地址',
  `feature` varchar(255) NOT NULL,
  `profile` varchar(2048) NOT NULL COMMENT '公司简介',
  `cover` json DEFAULT NULL COMMENT '公司图片展示，最多8张，json格式存储图片url',
  `license` json NOT NULL COMMENT '公司执照，json格式存储执照图片url',
  `is_webchat_pay` tinyint(1) DEFAULT NULL COMMENT '是否开通微信支付：1是 2否',
  `is_alipay` tinyint(1) DEFAULT NULL COMMENT '是否支付宝支付：1是 2否',
  `is_union_pay` tinyint(1) DEFAULT NULL COMMENT '是否银联支付：1是 2否',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `avatar` varchar(255) DEFAULT NULL COMMENT '公司头像',
  `signature` varchar(255) DEFAULT NULL COMMENT '公司签名',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COMMENT='注册公司表';

-- ----------------------------
--  Table structure for `company_orders`
-- ----------------------------
DROP TABLE IF EXISTS `company_orders`;
CREATE TABLE `company_orders` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` varchar(255) DEFAULT NULL COMMENT '订单全局唯一id',
  `order_pid` varchar(255) DEFAULT NULL COMMENT '订单父id',
  `order_no` varchar(255) DEFAULT NULL COMMENT '订单编号',
  `product_id` varchar(255) DEFAULT NULL COMMENT '订单关联产品表asin',
  `company_id` varchar(255) DEFAULT NULL COMMENT '订单关联用户uid',
  `price` decimal(10,2) DEFAULT NULL COMMENT '单价',
  `total_price` decimal(10,2) DEFAULT NULL COMMENT '总价',
  `quantity` int(11) DEFAULT NULL COMMENT '数量',
  `logistics_no` varchar(255) DEFAULT NULL,
  `address_id` varchar(255) DEFAULT NULL COMMENT '关联地址id',
  `status` tinyint(1) DEFAULT NULL COMMENT '状态 1未付款 2已付款 3未发货 4已发货 5已收货 6删除',
  `is_comment` tinyint(1) DEFAULT NULL COMMENT '是否评价：1已评价 0未评价',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='商家订单';

-- ----------------------------
--  Table structure for `complains`
-- ----------------------------
DROP TABLE IF EXISTS `complains`;
CREATE TABLE `complains` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `complain_id` varchar(255) DEFAULT NULL COMMENT '举报全局唯一id',
  `category_id` int(11) DEFAULT NULL COMMENT '举报分类id',
  `source_id` varchar(255) DEFAULT NULL COMMENT '来源全局唯一id（文章，视频，问题，活动，商品等）',
  `content` text COMMENT '举报内容',
  `attachment` json DEFAULT NULL COMMENT '举报上传证据',
  `created_id` varchar(255) DEFAULT NULL COMMENT '举报人id',
  `updated_id` varchar(255) DEFAULT NULL COMMENT '编辑者id',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `status` tinyint(1) DEFAULT NULL COMMENT '状态：1已处理 2未处理 0已删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='投诉';

-- ----------------------------
--  Table structure for `encyclopedias`
-- ----------------------------
DROP TABLE IF EXISTS `encyclopedias`;
CREATE TABLE `encyclopedias` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `encyclopedia_id` varchar(255) DEFAULT NULL COMMENT '百科全局唯一id',
  `source_id` varchar(255) DEFAULT NULL COMMENT '来源id（百科目前正在被使用的那个id）',
  `title` varchar(255) DEFAULT NULL COMMENT '百科标题',
  `content` text COMMENT '百科内容',
  `description` json DEFAULT NULL COMMENT '百科详细描述',
  `like_num` int(11) DEFAULT NULL COMMENT '关注数目',
  `view_num` int(11) DEFAULT NULL COMMENT '浏览数目',
  `source` json DEFAULT NULL COMMENT '来源（网易新闻等）',
  `attachment` json DEFAULT NULL COMMENT '百科上传附件（图片，文档等）',
  `cover` varchar(255) DEFAULT NULL COMMENT '百科封面图片url',
  `category_id` int(11) DEFAULT NULL COMMENT '百科类别id',
  `created_id` varchar(255) DEFAULT NULL COMMENT '创建者id',
  `updated_id` varchar(255) DEFAULT NULL COMMENT '编辑者id',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `status` tinyint(1) DEFAULT NULL COMMENT '状态：1正常 0删除 2待审核 3未通过 4被修改',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COMMENT='百科';

-- ----------------------------
--  Table structure for `files`
-- ----------------------------
DROP TABLE IF EXISTS `files`;
CREATE TABLE `files` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `path` varchar(255) NOT NULL DEFAULT '',
  `type` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '文件类型（1图片 2附件 3视频）',
  `serial_number` varchar(255) DEFAULT NULL COMMENT '批次编号',
  `created_id` varchar(255) DEFAULT NULL COMMENT '上传者唯一uid',
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=62 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
--  Table structure for `followers`
-- ----------------------------
DROP TABLE IF EXISTS `followers`;
CREATE TABLE `followers` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `uid` varchar(255) DEFAULT NULL COMMENT '关联用户uid',
  `follower_id` varchar(255) DEFAULT NULL COMMENT '关注者id',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COMMENT='关注者表';

-- ----------------------------
--  Table structure for `history_records`
-- ----------------------------
DROP TABLE IF EXISTS `history_records`;
CREATE TABLE `history_records` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `uid` varchar(255) DEFAULT NULL COMMENT '活动记录关联用户uid',
  `record_id` varchar(255) DEFAULT NULL COMMENT '活动记录id，关联视频id和百科id',
  `type` tinyint(1) DEFAULT NULL COMMENT '类别：1视频 2百科',
  `record_time` int(11) DEFAULT NULL COMMENT '记录时间',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户历史记录';

-- ----------------------------
--  Table structure for `identity_cards`
-- ----------------------------
DROP TABLE IF EXISTS `identity_cards`;
CREATE TABLE `identity_cards` (
  `id` varchar(255) NOT NULL,
  `uid` varchar(255) NOT NULL COMMENT '用户全局id',
  `name` varchar(255) NOT NULL COMMENT '姓名',
  `identity_no` varchar(255) NOT NULL COMMENT '身份证号码',
  `birthday` datetime(6) DEFAULT NULL COMMENT '出生年月日',
  `address` varchar(255) DEFAULT NULL COMMENT '地址',
  `gender` tinyint(1) DEFAULT NULL COMMENT '性别：1男 2女',
  `facecard` varchar(255) DEFAULT NULL COMMENT '身份证正面',
  `backcard` varchar(255) DEFAULT NULL COMMENT '身份证背面',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='身份信息';

-- ----------------------------
--  Table structure for `messages`
-- ----------------------------
DROP TABLE IF EXISTS `messages`;
CREATE TABLE `messages` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `message_id` varchar(255) DEFAULT NULL COMMENT '消息全局唯一id',
  `template_id` varchar(255) DEFAULT NULL COMMENT '模版id',
  `type` tinyint(1) DEFAULT NULL COMMENT '消息类型：1短信 2邮件 3消息',
  `content` varchar(255) DEFAULT NULL COMMENT '消息内容',
  `created_id` varchar(255) DEFAULT NULL,
  `receiver_id` varchar(255) DEFAULT NULL COMMENT '接收人uid',
  `updated_id` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `status` tinyint(1) DEFAULT NULL COMMENT '状态：1正常 0删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COMMENT='消息表';

-- ----------------------------
--  Table structure for `migrations`
-- ----------------------------
DROP TABLE IF EXISTS `migrations`;
CREATE TABLE `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT '迁移表',
  `batch` int(11) NOT NULL COMMENT '批次',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='数据迁移表，系统用';

-- ----------------------------
--  Table structure for `password_resets`
-- ----------------------------
DROP TABLE IF EXISTS `password_resets`;
CREATE TABLE `password_resets` (
  `email` varchar(255) CHARACTER SET utf8mb4 NOT NULL COMMENT '邮箱',
  `token` varchar(255) CHARACTER SET utf8mb4 NOT NULL COMMENT '令牌',
  `created_at` timestamp NULL DEFAULT NULL,
  KEY `password_resets_email_index` (`email`),
  KEY `password_resets_token_index` (`token`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='重置密码';

-- ----------------------------
--  Table structure for `products`
-- ----------------------------
DROP TABLE IF EXISTS `products`;
CREATE TABLE `products` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `company_id` varchar(255) DEFAULT NULL COMMENT '产品所属公司全局唯一id',
  `category_id` int(11) DEFAULT NULL COMMENT '产品分类id',
  `brand_id` varchar(255) DEFAULT NULL COMMENT '品牌全局唯一id',
  `asin` varchar(255) DEFAULT NULL COMMENT '产品编号',
  `stock` int(11) DEFAULT NULL COMMENT '产品库存',
  `sell_num` int(11) DEFAULT NULL COMMENT '卖出数量',
  `price` decimal(10,2) DEFAULT NULL COMMENT '单价',
  `title` varchar(255) DEFAULT NULL COMMENT '商品名称',
  `description` varchar(255) DEFAULT NULL COMMENT '商品描述',
  `show_picture` json DEFAULT NULL COMMENT '商品展示图片',
  `specification` json DEFAULT NULL COMMENT '产品规格',
  `score` decimal(2,1) DEFAULT NULL COMMENT '评分',
  `creatd_id` varchar(255) DEFAULT NULL,
  `updated_id` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `status` tinyint(1) DEFAULT NULL COMMENT '状态：1上架 2下架 0删除',
  `product_id` varchar(255) NOT NULL COMMENT '商品全局唯一id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
--  Table structure for `provinces`
-- ----------------------------
DROP TABLE IF EXISTS `provinces`;
CREATE TABLE `provinces` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `province_id` varchar(255) NOT NULL COMMENT '地区全局唯一id',
  `name` varchar(255) NOT NULL COMMENT '地区名称',
  `status` tinyint(1) DEFAULT NULL COMMENT '状态：1正常 0删除',
  `created_id` varchar(255) DEFAULT NULL,
  `updated_id` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='省市地区表';

-- ----------------------------
--  Table structure for `questions`
-- ----------------------------
DROP TABLE IF EXISTS `questions`;
CREATE TABLE `questions` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `question_id` varchar(255) DEFAULT NULL COMMENT '问题全局唯一id',
  `category_id` int(11) unsigned DEFAULT NULL COMMENT '类别id',
  `like_num` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '点赞数',
  `comment_num` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '问题评论数',
  `view_num` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '问题浏览数',
  `created_id` varchar(255) DEFAULT NULL COMMENT '问题创建者id',
  `updated_id` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL,
  `status` tinyint(1) DEFAULT '1' COMMENT '状态：1正常 0删除',
  `content` varchar(2048) DEFAULT NULL COMMENT '问题内容',
  `title` varchar(100) DEFAULT NULL COMMENT '标题',
  `attachment` json DEFAULT NULL COMMENT '附件',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=84 DEFAULT CHARSET=utf8mb4 COMMENT='问题表';

-- ----------------------------
--  Table structure for `revenues`
-- ----------------------------
DROP TABLE IF EXISTS `revenues`;
CREATE TABLE `revenues` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `uid` varchar(255) DEFAULT NULL COMMENT '关联用户id',
  `order_id` varchar(255) DEFAULT NULL COMMENT '订单关联id',
  `revenue_id` varchar(255) DEFAULT NULL COMMENT '收入全局唯一id',
  `message` varchar(255) DEFAULT NULL COMMENT '收入说明信息',
  `amount` decimal(10,2) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='收入表';

-- ----------------------------
--  Table structure for `sensitive_word`
-- ----------------------------
DROP TABLE IF EXISTS `sensitive_word`;
CREATE TABLE `sensitive_word` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `type` int(2) DEFAULT NULL COMMENT '类型：1=》色情  2=》反动  3=》暴恐  4=》民生 5=》贪腐 6=》其他=》其他',
  `key_words` varchar(255) DEFAULT NULL COMMENT '敏感词',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4040 DEFAULT CHARSET=utf8mb4 COMMENT='敏感词库';

-- ----------------------------
--  Table structure for `services`
-- ----------------------------
DROP TABLE IF EXISTS `services`;
CREATE TABLE `services` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `service_id` varchar(255) DEFAULT NULL COMMENT '服务全局唯一id',
  `company_id` varchar(255) DEFAULT NULL COMMENT '关联公司全局唯一id',
  `category_id` int(11) DEFAULT NULL COMMENT '类别id',
  `weight` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '权重影响力',
  `price` decimal(10,2) DEFAULT NULL COMMENT '价格',
  `title` varchar(255) DEFAULT NULL COMMENT '服务名称',
  `description` varchar(255) DEFAULT NULL COMMENT '描述',
  `content` text COMMENT '服务内容',
  `address` varchar(255) DEFAULT NULL COMMENT '举办地址',
  `telphone` varchar(255) DEFAULT NULL COMMENT '联系电话',
  `promotee` varchar(255) DEFAULT NULL COMMENT '举办方',
  `attachment` json DEFAULT NULL COMMENT '附件',
  `images` json DEFAULT NULL COMMENT '图片',
  `video` json DEFAULT NULL COMMENT '视频地址',
  `view_num` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '浏览人数',
  `created_id` varchar(255) DEFAULT NULL,
  `updated_id` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL,
  `status` tinyint(1) unsigned NOT NULL DEFAULT '3' COMMENT '状态：0删除 1正常  2下架 3待审核 4审核通过 5未通过',
  `score` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '评分（平均分）',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COMMENT='服务';

-- ----------------------------
--  Table structure for `shopping_carts`
-- ----------------------------
DROP TABLE IF EXISTS `shopping_carts`;
CREATE TABLE `shopping_carts` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `uid` varchar(255) DEFAULT NULL COMMENT '购物车关联用户uid',
  `cart_id` varchar(255) DEFAULT NULL COMMENT '购物车全局唯一id',
  `product_id` varchar(255) DEFAULT NULL COMMENT '产品id关联产品表asin',
  `quantity` int(11) DEFAULT NULL COMMENT '购买数量',
  `status` tinyint(1) DEFAULT '0' COMMENT '状态：1正常 2删除 3已经购买',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COMMENT='购物车';

-- ----------------------------
--  Table structure for `tags`
-- ----------------------------
DROP TABLE IF EXISTS `tags`;
CREATE TABLE `tags` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '标签id',
  `tag_id` varchar(255) DEFAULT NULL COMMENT '标签全局唯一id',
  `name` varchar(255) DEFAULT NULL COMMENT '标签名称',
  `created_id` varchar(255) DEFAULT NULL COMMENT '创建者id',
  `updated_id` varchar(255) DEFAULT NULL COMMENT '更新者id',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=183 DEFAULT CHARSET=utf8mb4 COMMENT='标签';

-- ----------------------------
--  Table structure for `tags_relations`
-- ----------------------------
DROP TABLE IF EXISTS `tags_relations`;
CREATE TABLE `tags_relations` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `tag_id` varchar(255) DEFAULT NULL COMMENT '标签全局唯一id',
  `relation_id` varchar(255) DEFAULT NULL COMMENT '关联其他全局唯一id（文章，问题等全局唯一id）',
  `created_id` varchar(255) DEFAULT NULL,
  `updated_id` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL COMMENT '状态：1正常 0删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=287 DEFAULT CHARSET=utf8mb4 COMMENT='标签关联表（文章，问题）';

-- ----------------------------
--  Table structure for `templates`
-- ----------------------------
DROP TABLE IF EXISTS `templates`;
CREATE TABLE `templates` (
  `id` int(11) NOT NULL,
  `template_id` varchar(255) DEFAULT NULL COMMENT '模版全局唯一id',
  `type` tinyint(1) DEFAULT NULL COMMENT '模版类型：1短信 2邮件 3消息',
  `content` varchar(255) DEFAULT NULL COMMENT '模版内容',
  `created_id` varchar(255) DEFAULT NULL,
  `updated_id` varchar(255) DEFAULT NULL,
  `cteated_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `status` tinyint(1) DEFAULT NULL COMMENT '状态：1正常 0删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='模版表';

-- ----------------------------
--  Table structure for `user_orders`
-- ----------------------------
DROP TABLE IF EXISTS `user_orders`;
CREATE TABLE `user_orders` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` varchar(255) DEFAULT NULL COMMENT '订单全局唯一id',
  `order_pid` varchar(255) DEFAULT '' COMMENT '订单父id',
  `order_no` varchar(255) DEFAULT NULL COMMENT '订单编号',
  `product_id` varchar(255) DEFAULT NULL COMMENT '订单关联产品表asin',
  `uid` varchar(255) DEFAULT NULL COMMENT '订单关联用户uid',
  `price` decimal(10,2) DEFAULT NULL COMMENT '单价',
  `total_price` decimal(10,2) DEFAULT NULL COMMENT '总价',
  `quantity` int(11) DEFAULT NULL COMMENT '数量',
  `logistics_no` varchar(255) DEFAULT NULL COMMENT '物流编号',
  `status` tinyint(1) DEFAULT NULL COMMENT '状态 1未付款 2已付款 3已发货 4已收货 5删除',
  `is_comment` tinyint(1) DEFAULT NULL COMMENT '是否评价：1已评价 0未评价',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `address_id` varchar(255) DEFAULT NULL COMMENT '关联地址id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='商家订单';

-- ----------------------------
--  Table structure for `users`
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT '用户名',
  `tel` char(11) COLLATE utf8_unicode_ci NOT NULL COMMENT '手机号码',
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT '邮箱',
  `status` int(1) NOT NULL DEFAULT '0',
  `password` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT '密码',
  `remember_token` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '记住我令牌',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='用户表';

-- ----------------------------
--  Table structure for `videos`
-- ----------------------------
DROP TABLE IF EXISTS `videos`;
CREATE TABLE `videos` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `video_id` varchar(255) DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL COMMENT '视频分类id',
  `title` varchar(255) DEFAULT NULL COMMENT '视频标题',
  `description` text COMMENT '视频描述',
  `video_url` varchar(255) DEFAULT NULL COMMENT '视频地址',
  `view_num` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '观察次数',
  `cover` varchar(255) DEFAULT NULL COMMENT '视频封面图片url',
  `created_id` varchar(255) DEFAULT NULL COMMENT '视频上传者id',
  `updated_id` varchar(255) DEFAULT NULL COMMENT '视频编辑者id',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL COMMENT '状态：1正常 0删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='视频';

-- ----------------------------
--  Table structure for `visit_logs`
-- ----------------------------
DROP TABLE IF EXISTS `visit_logs`;
CREATE TABLE `visit_logs` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `relation_id` varchar(255) NOT NULL COMMENT '访问来源全局唯一id（文章，视频，问题，活动，商品，服务等）',
  `created_id` varchar(255) NOT NULL COMMENT '访问者uid',
  `created_at` timestamp NULL DEFAULT NULL COMMENT '访问时间',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `visit_num` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '访问次数',
  `visit_id` varchar(255) NOT NULL COMMENT '访问全局唯一id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='访问记录表';

-- ----------------------------
--  Table structure for `votes`
-- ----------------------------
DROP TABLE IF EXISTS `votes`;
CREATE TABLE `votes` (
  `id` int(255) NOT NULL AUTO_INCREMENT,
  `upvote_id` varchar(255) DEFAULT NULL COMMENT '点赞全局唯一id',
  `source_id` varchar(255) DEFAULT NULL COMMENT '来源全局唯一id（文章，视频，问题，活动，商品等）',
  `like` tinyint(1) DEFAULT NULL COMMENT '1喜欢0不喜欢',
  `created_id` varchar(255) DEFAULT NULL COMMENT '用户id',
  `updated_id` varchar(255) DEFAULT NULL COMMENT '编辑者id',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `status` tinyint(1) DEFAULT NULL COMMENT '状态：1正常 0删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COMMENT='点赞表';

SET FOREIGN_KEY_CHECKS = 1;
