import Vue from 'vue'
import Router from 'vue-router'
import HelloWorld from '@/components/HelloWorld'
import MOTY from '@/components/MOTY'
import List from '@/components/List'
import Index from '@/components/Index'
import Test from '@/components/Test'
import Test1 from '@/components/Test1'
import Test2 from '@/components/Test2'
import BulletinBoard from '@/components/BulletinBoard'
import Home from '@/components/Home'
import Activity from '@/components/activity/Activity'
import ActivityApply from '@/components/activity/ActivityApply'
import ActivityExamineApprove from '@/components/activity/ActivityExamineApprove'
import ActivityData from '@/components/activity/ActivityData'
import ActivityTimeState from '@/components/activity/ActivityTimeState'
import ActivityLongTerm from '@/components/activity/ActivityLongTerm'
import System from '@/components/system/System'
import SystemMenu from '@/components/system/SystemMenu'
import SystemMenuJurisdiction from '@/components/system/SystemMenuJurisdiction'
import Inside from '@/components/inside/Inside'
import InsideJurisdiction from '@/components/inside/InsideJurisdiction'
import InsideRole from '@/components/inside/InsideRole'
import InsideUser from '@/components/inside/InsideUser'
import InsideUserJurisdiction from '@/components/inside/InsideUserJurisdiction'
// import InsideUserJurisdictionTwo from '@/components/inside/InsideUserJurisdictionTwo'
import InsideDepartment from '@/components/inside/InsideDepartment'
import InsideJob from '@/components/inside/InsideJob'
import ActivityTicketingManagement from '@/components/activity/ActivityTicketingManagement'
import ActivityModify from '@/components/activity/ActivityModify'
import ActivityEvaluate from '@/components/activity/ActivityEvaluate'
import ActivitySeeSignUp from '@/components/activity/ActivitySeeSignUp'
import ActivityScore from '@/components/activity/ActivityScore'
import Page from '@/components/page/Page'
import PageVideoTitle from '@/components/page/PageVideoTitle'
import PageAccount from '@/components/page/PageAccount'
import PageDirectoryAllocation from '@/components/page/PageDirectoryAllocation'
import PageDirectoryManagement from '@/components/page/PageDirectoryManagement'
import PageNewProductType from '@/components/page/PageNewProductType'
import PageModificationType from '@/components/page/PageModificationType'
import PageProductCategoryList from '@/components/page/PageProductCategoryList'
import PageDeleteProductType from '@/components/page/PageDeleteProductType'
import PageRevenueExpenditureHints from '@/components/page/PageRevenueExpenditureHints'
import PageFrameAdministration from '@/components/page/PageFrameAdministration'
import PageFrameContent from '@/components/page/PageFrameContent'
import PageAddDirectory from '@/components/page/PageAddDirectory'
import PageProfessionalCategory from '@/components/page/PageProfessionalCategory'
import PageSensitiveVocabulary from '@/components/page/PageSensitiveVocabulary'
import PageTypeManagement from '@/components/page/PageTypeManagement'
import PagePlateManagement from '@/components/page/PagePlateManagement'  //上传板块管理
import PageUploadEncyclopediasProblem from '@/components/page/PageUploadEncyclopediasProblem'  //上传百科&问题 page-upload-Encyclopedias-problem
import UploadService from '@/components/page/UploadService'  //上传百科&问题
import PageWebsiteManagement from '@/components/page/PageWebsiteManagement'  //网站管理》网站管理
import PageUploadService from '@/components/page/PageUploadService' //网站管理》上传服务
import PageBackground from '@/components/page/PageBackground'   //网站管理》页面背景
import PageReviewAuditManagement from '@/components/page/PageReviewAuditManagement'  //网站管理》评论审核管理
import PageReplyAuditManagement from '@/components/page/PageReplyAuditManagement'  //网站管理》回复审核管理
import PageUserAuditManagement from '@/components/page/PageUserAuditManagement'  //网站管理》用户审核管理
import PageReportReview from '@/components/page/PageReportReview'  //网站管理》举报审核
import PageRejection from '@/components/page/PageRejection'  //网站管理》问题视频百科驳回理由
import PageBusinessManagement from '@/components/page/PageBusinessManagement'  //网站管理》商家管理
import PageDismissCategory from '@/components/page/PageDismissCategory'  //网站管理》活动，服务驳回类别
import PageUploadProtocolManagement from '@/components/page/PageUploadProtocolManagement'  //上传菜单》上传协议管理
import PageUploadProductTips from '@/components/page/PageUploadProductTips'  //上传提示》上传商品提示
import PageTipsUploadService from '@/components/page/PageTipsUploadService'  //上传提示》上传服务
import PageTipsUploadActivity from '@/components/page/PageTipsUploadActivity'  //上传提示》上传活动
import PageTipsUploadArticle from '@/components/page/PageTipsUploadArticle'  //上传提示》上传文章
import PageTipsUploadVideo from '@/components/page/PageTipsUploadVideo'  //上传提示》上传视频
import PageTipsAskQuestions from '@/components/page/PageTipsAskQuestions'  //上传提示》提出问题

import Recruit from '@/components/recruit/Recruit'  //招聘
import RecruitJobManagement from '@/components/recruit/RecruitJobManagement'  //招聘》职位管理
import RecruitSocialRecruitment from '@/components/recruit/RecruitSocialRecruitment'  //招聘》社会招聘
import RecruitCampusRecruitment from '@/components/recruit/RecruitCampusRecruitment'  //招聘》校园招聘

import External from '@/components/external/External'
import ExternalMenu from '@/components/external/ExternalMenu'
import ExternalJurisdiction from '@/components/external/ExternalJurisdiction'
import ExternalBusinessJurisdiction from '@/components/external/ExternalBusinessJurisdiction'

import Article from '@/components/article/Article'  //文章
import ArticleStatus from '@/components/article/ArticleStatus'  //文章状态
import ArticleManagement from '@/components/article/ArticleManagement'  //文章管理
import ArticleModify from '@/components/article/ArticleModify'  //修改文章
import ArticleComment from '@/components/article/ArticleComment'  //评论管理
import ArticleReply from '@/components/article/ArticleReply'  //回复管理
import ArticlePageview from '@/components/article/ArticlePageview'  //回复管理
import ArticleBestAuthor from '@/components/article/ArticleBestAuthor'  //回复管理

import Service from '@/components/service/Service'  //服务
import ServiceData from '@/components/service/ServiceData'  //服务数据
import ServiceApplication from '@/components/service/ServiceApplication'  //新服务申请
import ServiceApproval from '@/components/service/ServiceApproval'  //服务审批
import ServiceStatus from '@/components/service/ServiceStatus'  //服务状态
import ServiceEvaluation from '@/components/service/ServiceEvaluation'  //服务状态

import Question from '@/components/question/Question'  //问题
import QuestionData from '@/components/question/QuestionData'  //问题状态
import QuestionManagement from '@/components/question/QuestionManagement'  //问题管理
import QuestionModify from '@/components/question/QuestionModify'  //问题修改
import QuestionDistribution from '@/components/question/QuestionDistribution'  //问题修改


import Login from '@/components/login/Login'  // 登陆页

Vue.use(Router)

export default new Router({
  mode: 'history',
  routes: [
    {
      path: '/',
      redirect: '/index/home'
    }, {
    // 登陆页
      path: '/login',
      name: 'Login',
      component: Login
    }, {
      path: '/index',
      name: 'Index',
      component: Index,
      children: [{
        path: '/index/test',
        name: 'Test',
        component: Test
      },{
        path: '/index/test1',
        name: 'Test1',
        component: Test1
      },{
        path: '/index/test2',
        name: 'Test2',
        component: Test2
      },{
        path: '/index/bulletin-board',
        name: 'BulletinBoard',
        component: BulletinBoard
      },{
        path: '/index/home',
        name: 'Home',
        component: Home
      },{
        path: '/index/activity',
        name: 'Activity',
        component: Activity,
        children: [{
          path: '/index/activity/apply',
          name: 'ActivityApply',
          component: ActivityApply
        },{
          path: '/index/activity/examine-approve',
          name: 'ActivityExamineApprove',
          component: ActivityExamineApprove
        },{
          path: '/index/activity/data',
          name: 'ActivityData',
          component: ActivityData
        },{
          path: '/index/activity/timed-active-state',
          name: 'ActivityTimeState',
          component: ActivityTimeState
        },{
          path: '/index/activity/long-term-activity',
          name: 'ActivityLongTerm',
          component: ActivityLongTerm
        },{
          path: '/index/activity/ticket-management',
          name: 'ActivityTicketingManagement',
          component: ActivityTicketingManagement
        },{
          path: '/index/activity/activity-seeSignUp',
          name: 'ActivitySeeSignUp',
          component: ActivitySeeSignUp
        },{
          path: '/index/activity/activity-modify',
          name: 'ActivityModify',
          component: ActivityModify
        },{
          path: '/index/activity/activity-score',
          name: 'ActivityScore',
          component: ActivityScore
        },{
          path: '/index/activity/activity-evaluate',
          name: 'ActivityEvaluate',
          component: ActivityEvaluate
        },]
      },{
        path: '/index/system',
        name: 'System',
        component: System,
        children: [{
          path: '/index/system/menu',
          name: 'SystemMenu',
          component: SystemMenu
        },{
          path: '/index/system/menu-jurisdiction',
          name: 'SystemMenuJurisdiction',
          component: SystemMenuJurisdiction
        }]
      },{
        path: '/index/inside',
        name: 'Inside',
        component: Inside,
        children: [{
          path: '/index/inside/jurisdiction',
          name: 'InsideJurisdiction',
          component: InsideJurisdiction,
        },{
          path: '/index/inside/role',
          name: 'InsideRole',
          component: InsideRole,
        },{
          path: '/index/inside/user',
          name: 'InsideUser',
          component: InsideUser,
        },{
          path: '/index/inside/user-jurisdiction',
          name: 'InsideUserJurisdiction',
          component: InsideUserJurisdiction,
        },
        // {
        //     // path: '/index/inside/user-jurisdictionTwo',
        //     // name: 'InsideUserJurisdictionTwo',
        //     // component: InsideUserJurisdictionTwo,
        // },
        {
          path: '/index/inside/department',
          name: 'InsideDepartment',
          component: InsideDepartment,
        },{
          path: '/index/inside/job',
          name: 'InsideJob',
          component: InsideJob,
        }]
      },{  
        path: '/index/page',
        name: 'Page',
        component: Page,
        children:[{
          path: '/index/page/video-title',
          name: 'PageVideoTitle',
          component: PageVideoTitle
        },{
          path: '/index/page/account',
          name: 'PageAccount',
          component: PageAccount
        },{
          path: '/index/page/pagedirectory-allocation',
          name: 'PageDirectoryAllocation',
          component: PageDirectoryAllocation
        },{
          path: '/index/page/page-directory-management',
          name: 'PageDirectoryManagement',
          component: PageDirectoryManagement
        },{
          path: '/index/page/page-new-product-type',
          name: 'PageNewProductType',
          component: PageNewProductType
        },{
          path: '/index/page/Page-modification-type',
          name: 'PageModificationType',
          component: PageModificationType
        },{
          path: '/index/page/page-product-category-list',
          name: 'PageProductCategoryList',
          component: PageProductCategoryList
        },{
          path: '/index/page/page-delete-product-type',
          name: 'PageDeleteProductType',
          component: PageDeleteProductType
        },{
          path: '/index/page/page-revenue-expenditure-hints',
          name: 'PageRevenueExpenditureHints',
          component: PageRevenueExpenditureHints
        },{
          //弹窗内容管理>目录管理
          path: '/index/page/page-frame-administration',
          name: 'PageFrameAdministration',
          component: PageFrameAdministration
        },{
          //弹窗内容
          path: '/index/page/page-frame-content',
          name: 'PageFrameContent',
          component: PageFrameContent
        },{
          //专业目录>添加目录
          path: '/index/page/page-add-directory',
          name: 'PageAddDirectory',
          component: PageAddDirectory
        },{
          //专业目录>目录管理
          path: '/index/page/page-professional-category',
          name: 'PageProfessionalCategory',
          component: PageProfessionalCategory
        },{
          //敏感词汇管理>词汇管理
          path: '/index/page/page-sensitive-vocabulary',
          name: 'PageSensitiveVocabulary',
          component: PageSensitiveVocabulary
        },{
          //敏感词汇管理>类型管理
          path: '/index/page/page-type-management',
          name: 'PageTypeManagement',
          component: PageTypeManagement
        },{
          //板块管理
          path: '/index/page/page-plate-management',
          name: 'PagePlateManagement',
          component: PagePlateManagement
        },{
          //上传百科&问题
          path: '/index/page/page-upload-Encyclopedias-problem',
          name: 'PageUploadEncyclopediasProblem',
          component: PageUploadEncyclopediasProblem
        },{
          //上传服务
          path: '/index/page/upload-service',
          name: 'UploadService',
          component: UploadService
        },{
          //网站管理
          path: '/index/page/page-website-management',
          name: 'PageWebsiteManagement',
          component: PageWebsiteManagement
        },{
          //上传服务
          path: '/index/page/page-upload-service',
          name: 'PageUploadService',
          component: PageUploadService
        },{
          //页面背景
          path: '/index/page/page-background',
          name: 'PageBackground',
          component: PageBackground
        },{
          //评论审核管理
          path: '/index/page/page-review-audit-management',
          name: 'PageReviewAuditManagement',
          component: PageReviewAuditManagement
        },{
          //回复审核管理
          path: '/index/page/page-reply-audit-management',
          name: 'PageReplyAuditManagement',
          component: PageReplyAuditManagement
        },{
          //用户审核管理
          path: '/index/page/page-user-audit-management',
          name: 'PageUserAuditManagement',
          component: PageUserAuditManagement
        },{
          //举报审核
          path: '/index/page/page-report-review',
          name: 'PageReportReview',
          component: PageReportReview
        },{
          //问题视频百科驳回理由
          path: '/index/page/page-rejection',
          name: 'PageRejection',
          component: PageRejection
        },{
          //商家管理
          path: '/index/page/page-business-management',
          name: 'PageBusinessManagement',
          component: PageBusinessManagement
        },{
          //活动&服务驳回类别
          path: '/index/page/page-dismiss-category',
          name: 'PageDismissCategory',
          component: PageDismissCategory
        },{
          //上传协议管理
          path: '/index/page/page-upload-protocol-management',
          name: 'PageUploadProtocolManagement',
          component: PageUploadProtocolManagement
        },{
          //上传商品提示
          path: '/index/page/page-upload-product-tips',
          name: 'PageUploadProductTips',
          component: PageUploadProductTips
        },{
          //上传服务
          path: '/index/page/page-tips-upload-service',
          name: 'PageTipsUploadService',
          component: PageTipsUploadService
        },{
          //上传活动
          path: '/index/page/page-tips-upload-activity',
          name: 'PageTipsUploadActivity',
          component: PageTipsUploadActivity
        },{
          //上传文章
          path: '/index/page/page-tips-upload-article',
          name: 'PageTipsUploadArticle',
          component: PageTipsUploadArticle
        },{
          //上传视频
          path: '/index/page/page-tips-upload-video',
          name: 'PageTipsUploadVideo',
          component: PageTipsUploadVideo
        },{
          //提出问题
          path: '/index/page/page-tips-ask-questions',
          name: 'PageTipsAskQuestions',
          component: PageTipsAskQuestions
        },{
          //例子1
          path: '/index/moty',
          name: 'MOTY',
          component: MOTY
        },{
          //例子2
          path: '/index/list',
          name: 'List',
          component: List
        }]
      },{
        path: '/index/external',
        name: 'External',
        component: External,
        children: [{
          path: '/index/external/menu',
          name: 'ExternalMenu',
          component: ExternalMenu
        },{
          path: '/index/external/jurisdiction',
          name: 'ExternalJurisdiction',
          component: ExternalJurisdiction
        },{
          path: '/index/external/business-jurisdiction',
          name: 'ExternalBusinessJurisdiction',
          component: ExternalBusinessJurisdiction
        }]
      },{
        // 文章管理
        path: '/index/article',
        name: 'Article',
        component: Article,
        children: [{
          //文章状态
          path: '/index/article/status',
          name: 'ArticleStatus',
          component: ArticleStatus
        },{
          //文章管理
          path: '/index/article/article-management',
          name: 'ArticleManagement',
          component: ArticleManagement
        },{
          //修改文章
          path: '/index/article/article-modify',
          name: 'ArticleModify',
          component: ArticleModify
        },{
          //评论管理
          path: '/index/article/comment',
          name: 'ArticleComment',
          component: ArticleComment
        },{
          //评论管理
          path: '/index/article/article-reply',
          name: 'ArticleReply',
          component: ArticleReply
        },{
          //文章浏览量统计
          path: '/index/article/article-pageview',
          name: 'ArticlePageview',
          component: ArticlePageview
        },{
          //文章浏览量统计
          path: '/index/article/article-best-author',
          name: 'ArticleBestAuthor',
          component: ArticleBestAuthor
        }]
      },{
        path:'/index/recruit',     //招聘
        name:Recruit,
        component: Recruit,
        children: [{   //增加招聘职位
          path: '/index/recruit/recruit-job-management',
          name: 'RecruitJobManagement',
          component: RecruitJobManagement
        },{            //社会招聘
          path: '/index/recruit/recruit-social-recruitment',
          name: 'RecruitSocialRecruitment',
          component: RecruitSocialRecruitment
        },{            //校园招聘
          path: '/index/recruit/recruit-campus-recruitment',
          name: 'RecruitCampusRecruitment',
          component: RecruitCampusRecruitment
        }]
      },{
        path:'/index/service', //服务
        name:Service,
        component: Service,
        children: [{   //服务数据
          path: '/index/service/service-data',
          name: 'ServiceData',
          component: ServiceData
        },{   //新服务申请
          path: '/index/service/service-application',
          name: 'ServiceApplication',
          component: ServiceApplication
        },{   //服务审批
          path: '/index/service/service-approval',
          name: 'ServiceApproval',
          component: ServiceApproval
        },{   //服务状态
          path: '/index/service/service-status',
          name: 'ServiceStatus',
          component: ServiceStatus
        },{   //评价
          path: '/index/service/service-evaluation',
          name: 'ServiceEvaluation',
          component: ServiceEvaluation
        }]
      },{
        path:'/index/question', //问题
        name:Question,
        component: Question,
        children: [{  //问题状态
          path: '/index/question/question-data',
          name: 'QuestionData',
          component: QuestionData,
        },{  //问题管理
          path: '/index/question/question-management',
          name: 'QuestionManagement',
          component: QuestionManagement,
        },{  //问题修改
          path: '/index/question/question-modify',
          name: 'QuestionModify',
          component: QuestionModify,
        },{  //目录分配
          path: '/index/question/question-distribution',
          name: 'QuestionDistribution',
          component: QuestionDistribution,
        }]
      }]
    }
  ]
})
