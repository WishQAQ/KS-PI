ALTER  TABLE  `actives` add quantity int(10) comment '活动限制总票数',add pics json DEFAULT NULL comment '活动图片',add enrollment int(11) unsigned not null DEFAULT 0 comment '报名人数'
,add province int(10) unsigned not null DEFAULT 0 comment '一级城市id',add city int(10) unsigned not null DEFAULT 0 comment '二级城市id',
add district int(10) unsigned not null DEFAULT 0 comment '三级城市id',add description text(0) comment '活动简介',add sale_num int(10) unsigned NOT NULL DEFAULT 0 comment '售出票数',
add registration_deadline timestamp NULL DEFAULT null comment '报名截止时间',add view_num int(11) unsigned not null DEFAULT 0 comment '浏览量',add video json DEFAULT NULL comment '活动视频'
,add score float(2,1) not null DEFAULT 0.0 comment '评分(平均分)',add like_num int(11) unsigned not null DEFAULT 0 comment '点赞数',add cancel_des text(0) comment '取消状态下的备注（原因）',
add initial_status tinyint(1) comment '初始状态：1正常 0删除 2待审核 3审核未通过 4已取消 5已停止报名 6已暂停 7 正在审核',
modify column status tinyint(1) comment '状态：1正常 0删除 2待审核 3审核未通过 4已取消 5已停止';