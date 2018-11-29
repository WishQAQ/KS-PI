ALTER  TABLE  `answers` add type smallint (4) unsigned not null default 0 comment '类型：1文章 2视频 3问题 4活动 5商品 ...',
add score smallint(4) unsigned not null default 0 comment '评分';