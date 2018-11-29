export default {
  menus: [{
    id: 1000,
    title: '主页',
    urls: '/index/home',
    icons: 'icon-home',
    children: [{
      id: 1001,
      title: '搜索',
      urls: '/index/test',
      icons: 'icon-shouye',
    },{
      id: 1002,
      title: '上传',
      urls: '/index/test',
      icons: 'icon-shouye',
      children: [{
        id: 10021,
        title: '上传1',
        urls: '/index/test1',
        icons: 'icon-shouye',
      },{
        id: 10022,
        title: '上传2',
        urls: '/index/test2',
        icons: 'icon-shouye',
      }]
    }]
  }, {
    id: 2000,
    title: '菜单分类管理',
    urls: '/index/system',
    icons: 'icon-setting',
    children: [{
      id: 2001,
      title: '菜单管理',
      urls: '/index/system/menu',
      icons: 'icon-shouye',
    },{
      id: 2002,
      title: '菜单权限',
      urls: '/index/system/menu-jurisdiction',
      icons: 'icon-shouye',
    }]
  }, {
    id: 3000,
    title: '内部管理',
    urls: '/index/inside',
    icons: 'icon-geren',
    children: [{
      id: 3001,
      title: '权限管理',
      urls: '/index/inside/jurisdiction',
      icons: 'icon-shouye',
    },{
      id: 3002,
      title: '角色管理',
      urls: '/index/inside/role',
      icons: 'icon-shouye',
    },{
      id: 3003,
      title: '用户管理',
      urls: '/index/inside/user',
      icons: 'icon-shouye',
    },{
      id: 3004,
      title: '部门管理',
      urls: '/index/inside/department',
      icons: 'icon-shouye',
    },{
      id: 3005,
      title: '职位管理',
      urls: '/index/inside/job',
      icons: 'icon-shouye',
    }]
  }, {
    id: 4000,
    title: '活动',
    urls: '/index/activity',
    icons: 'icon-fenlei',
    children: [{
      id: 4001,
      title: '活动数据',
      urls: '/index/activity/data',
      icons: 'icon-fenlei',
    },{
      id: 4002,
      title: '活动申请',
      urls: '/index/activity/apply',
      icons: 'icon-fenlei',
    },{
      id: 4003,
      title: '活动审批',
      urls: '/index/activity/examine-approve',
      icons: 'icon-fenlei',
    },{
      id: 4004,
      title: '定时活动状态',
      urls: '/index/activity/timed-active-state',
      icons: 'icon-fenlei',
    },{
      id: 4005,
      title: '长期活动状态',
      urls: '/index/activity/long-term-activity',
      icons: 'icon-fenlei',
    },{
      id: 4006,
      title: '票务管理',
      urls: '/index/activity/ticket-management',
      icons: 'icon-fenlei',
    },{
      id: 4007,
      title: '查看报名',
      urls: '/index/activity/activity-seeSignUp',
      icons: 'icon-fenlei',
    },{
      id: 4008,
      title: '活动被修改',
      urls: '/index/activity/activity-modify',
      icons: 'icon-fenlei',
    },{
      id: 4009,
      title: '评价',
      urls: '/index/activity/activity-evaluate',
      icons: 'icon-fenlei',
    }]
  },{
    id:5000,
    title:'后端页面',
    urls: '/index/page',
    icons: 'icon-faxian',
    children:[{
      id: 5001,
      title: '小视频标题',
      urls: '/index/page/video-title',
      icons: 'icon-fenlei',
    },{
      id: 5002,
      title: '收支管理',
      urls: '/index/page/account',
      icons: 'icon-fenlei',
    },{
      id: 5003,
      title: '产品目录分配',
      urls: '/index/page/pagedirectory-allocation',
      icons: 'icon-fenlei',
    },{
      id: 5004,
      title: '目录管理',
      urls: '/index/page/page-directory-management',
      icons: 'icon-fenlei',
    },{
      id: 5005,
      title: '新增产品类型',
      urls: '/index/page/page-new-product-type',
      icons: 'icon-fenlei',
    },{
      id: 5006,
      title: '修改产品类型',
      urls: '/index/page/Page-modification-type',
      icons: 'icon-fenlei',
    },{
      id: 5007,
      title: '产品类别列表',
      urls: '/index/page/page-product-category-list',
      icons: 'icon-fenlei',
    },{
      id: 5008,
      title: '删除产品类型',
      urls: '/index/page/page-delete-product-type',
      icons: 'icon-fenlei',
    },{
      id: 5009,
      title: '收支提示',
      urls: '/index/page/page-revenue-expenditure-hints',
      icons: 'icon-fenlei',
    },{
      id: 5010,
      title: '内容下目录管理',
      urls: '/index/page/page-frame-administration',
      icons: 'icon-fenlei',
    },{
      id: 5011,
      title: '弹框内容',
      urls: '/index/page/page-frame-content',
      icons: 'icon-fenlei',
    },{
      id: 5012,
      title: '专业添加目录',
      urls: '/index/page/page-add-directory',
      icons: 'icon-fenlei',
    },{
      id: 5013,
      title: '专业目录管理',
      urls: '/index/page/page-professional-category',
      icons: 'icon-fenlei',
    },{
      id: 5014,
      title: '词汇管理',
      urls: '/index/page/page-sensitive-vocabulary',
      icons: 'icon-fenlei',
    },{
      id: 5015,
      title: '类型管理',
      urls: '/index/page/page-type-management',
      icons: 'icon-fenlei',
    },{
      id: 5016,
      title: '板块管理',
      urls: '/index/page/page-plate-management',
      icons: 'icon-fenlei',
    },{
      id: 5017,
      title: '上传百科&问题',
      urls: '/index/page/page-upload-Encyclopedias-problem',
      icons: 'icon-fenlei',
    },{
      id: 5018,
      title: '上传菜单的上传服务',
      urls: '/index/page/upload-service',
      icons: 'icon-fenlei',
    },{
      id: 5019,
      title: '网站管理',
      urls: '/index/page/page-website-management',
      icons: 'icon-fenlei',
    },{
      id: 5020,
      title: '网站管理的上传服务',
      urls: '/index/page/page-upload-service',
      icons: 'icon-fenlei',
    },{
      id: 5021,
      title: '页面背景',
      urls: '/index/page/page-background',
      icons: 'icon-fenlei',
    },{
      id: 5022,
      title: '评论审核管理',
      urls: '/index/page/page-review-audit-management',
      icons: 'icon-fenlei',
    },{
      id: 5023,
      title: '回复审核管理',
      urls: '/index/page/page-reply-audit-management',
      icons: 'icon-fenlei',
    },{
      id: 5024,
      title: '用户审核管理',
      urls: '/index/page/page-user-audit-management',
      icons: 'icon-fenlei',
    },{
      id: 5025,
      title: '举报审核',
      urls: '/index/page/page-report-review',
      icons: 'icon-fenlei',
    },{
      id: 5026,
      title: '视频问题百科驳回理由',
      urls: '/index/page/page-rejection',
      icons: 'icon-fenlei',
    },{
      id: 5027,
      title: '商家管理',
      urls: '/index/page/page-business-management',
      icons: 'icon-fenlei',
    },{
      id: 5028,
      title: '活动&服务驳回类别',
      urls: '/index/page/page-dismiss-category',
      icons: 'icon-fenlei',
    },{
      id: 5029,
      title: '上传协议管理',
      urls: '/index/page/page-upload-protocol-management',
      icons: 'icon-fenlei',
    },{
      id: 5030,
      title: '上传商品提示',
      urls: '/index/page/page-upload-product-tips',
      icons: 'icon-fenlei',
    },{
      id: 5031,
      title: '上传提示的上传服务',
      urls: '/index/page/page-tips-upload-service',
      icons: 'icon-fenlei',
    },{
      id: 5032,
      title: '上传提示的上传活动',
      urls: '/index/page/page-tips-upload-activity',
      icons: 'icon-fenlei',
    },{
      id: 5033,
      title: '上传提示的上传文章',
      urls: '/index/page/page-tips-upload-article',
      icons: 'icon-fenlei',
    },{
      id: 5034,
      title: '上传提示的上传视频',
      urls: '/index/page/page-tips-upload-video',
      icons: 'icon-fenlei',
    },{
      id: 5035,
      title: '上传提示的提出问题',
      urls: '/index/page/page-tips-ask-questions',
      icons: 'icon-fenlei',
    },{
      id: 5036,
      title: '例子1',
      urls: '/index/moty',
      icons: 'icon-fenlei',
    },{
      id: 5037,
      title: '例子2',
      urls: '/index/list',
      icons: 'icon-fenlei',
    }]
  },{
    id: 6000,
    title: '外部管理',
    urls: '/index/external',
    icons: 'icon-shop',
    children: [{
      id: 6001,
      title: '菜单创建',
      urls: '/index/external/menu',
      icons: 'icon-fenlei'
    },{
      id: 6002,
      title: '页面权限分配',
      urls: '/index/external/jurisdiction',
      icons: 'icon-fenlei'
    },{
      id: 6003,
      title: '页面权限管理',
      urls: '/index/external/business-jurisdiction',
      icons: 'icon-fenlei'
    }]
  },{
    id: 7000,
    title: '文章管理',
    urls: '/index/article',
    icons: 'icon-menu',
    children: [{
      id: 7001,
      title: '文章状态',
      urls: '/index/article/status',
      icons: 'icon-fenlei'
    },{
      id: 7002,
      title: '文章管理',
      urls: '/index/article/article-management',
      icons: 'icon-fenlei'
    },{
      id: 7003,
      title: '文章修改',
      urls: '/index/article/article-modify',
      icons: 'icon-fenlei'
    },{
      id: 7004,
      title: '评论管理',
      urls: '/index/article/comment',
      icons: 'icon-fenlei'
    },{
      id: 7005,
      title: '回复管理',
      urls: '/index/article/article-reply',
      icons: 'icon-fenlei'
    },{
      id: 7006,
      title: '文章浏览量统计',
      urls: '/index/article/article-pageview',
      icons: 'icon-fenlei'
    },{
      id: 7007,
      title: '最佳作者',
      urls: '/index/article/article-best-author',
      icons: 'icon-fenlei'
    }]
  },{
    id: 8000,
    title: '招聘',
    urls: '/index/recruit',
    icons: 'icon-menu',
    children: [{
      id: 8001,
      title: '职位管理',
      urls: '/index/recruit/recruit-job-management',
      icons: 'icon-fenlei'
    },{
      id: 8002,
      title: '社会招聘',
      urls: '/index/recruit/recruit-social-recruitment',
      icons: 'icon-fenlei'
    },{
      id: 8003,
      title: '校园招聘',
      urls: '/index/recruit/recruit-campus-recruitment',
      icons: 'icon-fenlei'
    }]
  },{
    id: 9000,
    title: '服务',
    urls: '/index/service',
    icons: 'icon-menu',
    children:[{
      id: 9001,
      title: '服务数据',
      urls: '/index/service/service-data',
      icons: 'icon-fenlei'
    },{
      id: 9002,
      title: '新服务申请',
      urls: '/index/service/service-application',
      icons: 'icon-fenlei'
      },{
      id: 9003,
      title: '服务审批',
      urls: '/index/service/service-approval',
      icons: 'icon-fenlei'
    },{
      id: 9004,
      title: '服务状态',
      urls: '/index/service/service-status',
      icons: 'icon-fenlei'
    },{
      id: 9005,
      title: '评价',
      urls: '/index/service/service-evaluation',
      icons: 'icon-fenlei'
    }]
  },{
    id: 10000,
    title: '问题',
    urls: '/index/question',
    icons: 'icon-menu',
    children: [{
      id: 10001,
      title: '问题状态',
      urls: '/index/question/question-data',
      icons: 'icon-fenlei'
    },{
      id: 10002,
      title: '问题管理',
      urls: '/index/question/question-management',
      icons: 'icon-fenlei'
    },{
      id: 10003,
      title: '问题修改',
      urls: '/index/question/question-modify',
      icons: 'icon-fenlei'
    },{
      id: 10004,
      title: '专业目录分配',
      urls: '/index/question/question-distribution',
      icons: 'icon-fenlei'
    }]
  }]
}
