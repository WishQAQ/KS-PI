import Vue from 'vue'
import Router from 'vue-router'
import HelloWorld from '@/components/header'
import Index from '@/views/index'
import Home from '@/views/Home'
import StoreIndex from '@/views/store/storeIndex'
import Marketpage from '@/views/Market/marketpage'
import ServicePage from '@/views/service/servicePage'
import ActivityIndex from '@/views/activity/activityIndex'
import ArticlePage from '@/views/article/articlePage'
import SearchIndex from '@/views/search/searchindex'
import UserIndex from '@/views/userInfo/userIndex'
import UserShopping from '@/views/userInfo/userShopping'
import UserActivities from '@/views/userInfo/userActivities'
import UserFocus from '@/views/userInfo/userFocus'
import UserIncome from '@/views/userInfo/userIncome'
import UserHistoryRecord from '@/views/userInfo/userHistoryRecord'
import UserUploadCenter from '@/views/userInfo/userUploadCenter'
import UserBargain from '@/views/userInfo/userBargain'
import UserEdit from '@/views/userInfo/userEdit'
import Others from '@/views/userInfo/others'
import UploadingService from '@/views/upload/uploadingService'
import UploadingActivity from '@/views/upload/uploadingActivity'
import UploadingQuestion from '@/views/upload/uploadingQuestion'
import UploadingProduct from '@/views/upload/uploadingProduct'
import UploadingVideo from '@/views/upload/uploadingVideo'
import UploadVideo from '@/views/upload/uploadVideo'
import UploadingEncyclopedia from '@/views/upload/uploadingEncyclopedia'
import UploadingModifyEncyclopedia from '@/views/upload/uploadingModifyEncyclopedia'  //编辑百科
import UploadingModifyQuestion from '@/views/upload/uploadingModifyQuestion'  //编辑问题
import UploadingArticle from '@/views/upload/uploadingArticle'
import UploadArticle from '@/views/upload/uploadArticle'
import UploadingBargains from '@/views/upload/uploadingBargains'
import VideoDetail from '@/views/video/videoDetail'
import VideoSort from '@/views/video/VideoSort'
import VideoIndex from '@/views/video/VideoIndex'
import BaikeIndex from '@/views/baike/BaikeIndex'
import BaikeClassIfy from '@/views/baike/BaikeClassify'
import EncyclopIndex from '@/views/search/EncyclopIndex'
import VideoSearch from '@/views/search/VideoSearch'
import ServiceDetails from '@/views/service/serviceDetails'
import BaikeDetail from '@/views/baike/baikeDetail'
import ArticleDetails from '@/views/article/articleDetails'
import MarKetDetails from '@/views/Market/MarketDetails'
import ActvitySearch from '@/views/activity/actvitySearch'
import ActivityDetails from '@/views/activity/activityDetails'
import ActivitySignUp from '@/views/activity/ActivitySignUp'
import CommercialActivity from '@/views/merchant/commercialActivity'
import CommercialService from '@/views/merchant/commercialService'
import MerchantViewReviews from '@/views/merchant/merchantViewReviews'
import CommercialEvaluate from '@/views/merchant/commercialEvaluate'
import MerchanInfo from '@/views/merchant/merchantInfo'
import CompanyIntroduction from'@/views/merchant/companyIntroduction'
import CommercialDetailActivity from '@/views/merchant/commercialDetailActivity'
import CommercialIndex from'@/views/merchant/commercialIndex'
import MerchantIncome from '@/views/merchant/merchantIncome'
import MerchantWarehouse from '@/views/merchant/merchantWarehouse'
import merchantProductReview from '@/views/merchant/merchantProductReview'
import merchantMarketReviews from '@/views/userInfo/merchantMarketReviews'
import UploadManage from '@/views/merchant/uploadManage'
import ProductClassify from '@/views/store/productClassify'
import BusinessCooperation from '@/views/footerInfo/businessCooperation'
import Recruitment from '@/views/footerInfo/recruitment'
import Opinion from '@/views/footerInfo/opinion'
import ProductDetail from "@/views/store/productDetail"
import ShoppingCart from '@/views/store/shoppingCart'
import ProductIndex from '@/views/problem/problemIndex'
import problemDetails from '@/views/problem/problemDetails'
import ProductClass from '@/views/problem/problemClassification'
import UserKsChat from '@/views/userInfo/userKsChat'
import MerchantKsChat from '@/views/merchant/merchantKsChat'
import ChangePassword from '@/views/userInfo/changePassword'  // 个人主页修改密码
import ChangePhoneNumber from '@/views/userInfo/changePhoneNumber'  // 个人主页修改手机

Vue.use(Router)
export default new Router({
  mode: 'history',
  routes: [
    //主页面路由
    {
      path: '/',
      redirect: '/home/index'
    },
    /*********************************************登陆页面***************************************************/
    //登陆页面路由
    {
      path: '/login',
      name: 'Login',
      component: () => import('@/views/login/login'),
      beforeEnter: (to, from, next) => {
        document.body.setAttribute("class","UserLoginLogin");
        if(window.localStorage.token){
          next({
            path:'/'
          })
        }
        next()
      }
    },
    {
      path: '/home',
      name: 'Home',
      component: Home,
      children: [{
        path: '/home/index',
        name: 'Index',
        component: Index
      },{//商城主页
        path: '/home/store-index',
        name: 'StoreIndex',
        component: StoreIndex,
        hidden:true,
        meta:{
          skipSreach:1
        }
      },{//商城分类页
          path: '/home/product-classify',
          name: 'productClassify',
          component: ProductClassify
      },{//商城详情页
          path:'/home/product-detail/:id',
          name:'productDetail',
          component:ProductDetail,
      },{//商城购物车
          path:'/home/shopping-cart',
          name:'shoppingCart',
          component:ShoppingCart,
      },{
        //淘货主页
        path: '/home/marketpage-index',
        name: 'Marketpage',
        component: Marketpage
      },{
        //服务主页
        path: '/home/service-page-index',
        name: 'ServicePage',
        component: ServicePage
      },{
        //活动主页
        path: '/home/activity-index',
        name: 'ActivityIndex',
        component: ActivityIndex
      },{
        //文章主页
        path:'/home/articlePage',
        component: ArticlePage,
        hidden:true
      },{
        //搜索页面
        path: '/home/searchindex',
        name: 'SearchIndex',
        component: SearchIndex,
      },{
        //视频搜索主页
        path: '/home/videoSearch',
        name: 'VideoSearch',
        component: VideoSearch,
      },{
        /*********************************************个人页面***************************************************/
        //个人资料页面
        path:'/home/userIndex',
        component: UserIndex,
        hidden:true,
        meta:{
          requireAuth:true
        }
      },{
        //个人购物车页面
        path:'/home/userShopping',
        component: UserShopping,
        hidden:true,
        meta:{
          requireAuth:true
        }
      },{
        //个人活动页面路由
        path:'/home/userActivities',
        component: UserActivities,
        hidden:true,
        meta:{
          requireAuth:true
        }
      },{
        //个人关注页面
        path:'/home/userFocus',
        component: UserFocus,
        hidden:true,
        meta:{
          requireAuth:true
        }
      },{
        //个人收入页面
        path:'/home/userIncome',
        component: UserIncome,
        hidden:true,
        meta:{
          requireAuth:true
        }
      },{
        //个人历史纪录页面
        path:'/home/userHistoryRecord',
        component: UserHistoryRecord,
        query:{num:3},
        hidden:true,
        meta:{
          requireAuth:true
        }
      },{
        //个人上传管理页面
        path:'/home/userUploadCenter',
        component: UserUploadCenter,
        hidden:true,
        meta:{
          requireAuth:true
        }
      },{
        //个人淘货管理页面
        path:'/home/userBargain',
        component: UserBargain,
        hidden:true,
        meta:{
          requireAuth:true
        }
      },{
        //个人资料修改页面
        path:'/home/userEdit',
        component: UserEdit,
        hidden:true,
        meta:{
          requireAuth:true
        }
      },{
        //个人修改密码页面
        path:'/home/changePassword',
        component: ChangePassword,
        hidden:true,
        meta:{
          requireAuth:true
        }
      },{
        //个人修改手机页面
        path:'/home/changePhoneNumber',
        component: ChangePhoneNumber,
        hidden:true,
        meta:{
          requireAuth:true
        }
      },{
        //他人主页
        path:'/home/others',
        component: Others,
        hidden:true
      },{
          /*********************************************上传***************************************************/
        //上传服务
        path:'/home/uploading-service',
        component:UploadingService,
        hidden:true
      },{
        //上传活动
        path:'/home/uploading-activity',
        component: UploadingActivity,
        hidden:true
      },{
        //提出问题
        path:'/home/uploadingQuestion',
        component: UploadingQuestion,
        hidden:true
      },{
        //编辑问题
        path:'/home/uploadingModifyQuestion',
        component: UploadingModifyQuestion,
        hidden:true
      },{
        //上传商品
        path:'/home/uploadingProduct',
        component: UploadingProduct,
        hidden:true
      },{
        //上传视频
        path:'/home/uploadingVideo',
        component: UploadingVideo,
        hidden:true
      },{
        //上传视频
        path:'/home/uploadVideo',
        component: UploadVideo,
        hidden:true
      },{
        //上传百科
        path:'/home/uploadingEncyclopedia',
        component: UploadingEncyclopedia,
        hidden:true
      },{
        //编辑百科
        path:'/home/uploadingModifyEncyclopedia',
        component: UploadingModifyEncyclopedia,
        hidden:true
      },{
        //上传文章
        path:'/home/uploadingArticle',
        component: UploadingArticle,
        hidden:true,
        meta:{
          requireAuth:true
        }
      },{
        //上传文章
        path:'/home/uploadArticle',
        component: UploadArticle,
        hidden:true,
        meta:{
          requireAuth:true
        }
      },{
          //上传淘货
          path:'/home/uploadingBargains',
          component:UploadingBargains,
          hidden:true
      },{
         /*****************************************视频*******************************************/
        //视频详情页
        path:'/home/videoDetail',
        component: VideoDetail,
        hidden:true
      },{
        //视频分类页
        path:'/home/VideoSort',
        component: VideoSort,
        hidden:true
      },{
        //视频主页
        path:'/home/VideoIndex',
        component: VideoIndex,
        hidden:true
      }
        /*********************************************百科***************************************************/
        ,{
        //百科主页
        path:'/home/BaikeIndex',
        component: BaikeIndex,
        hidden:true
      },{
        //百科内燃机
        path:'/home/BaikeClassify',
        component: BaikeClassIfy,
        hidden:true
      },{
        //百科搜索页
        path:'/home/EncyclopIndex',
        component: EncyclopIndex,
        hidden:true
      },{
        //服务详情
        path:'/home/service-detail',
        component: ServiceDetails,
        hidden:true
      },{
        //百科详情
        path:'/home/baikeDetail',
        component: BaikeDetail,
        hidden:true
      },{
        //文章详情页主页
        path:'/home/articleDetails',
        component: ArticleDetails,
        hidden:true
      },{
        //淘货详情页
        path:'/home/market-detail',
        component: MarKetDetails,
        hidden:true
      },{
          //淘货评论页
          path:'/home/merchant-market-reviews',
          component: merchantMarketReviews,
          hidden:true
      },{
        //搜索小主页
        path:'/home/actvitySearch',
        component: ActvitySearch,
        hidden:true
      },{
        /*********************************************活动***************************************************/
        //活动详情
        path:'/home/activity-detail',
        component: ActivityDetails,
        hidden:true
      },{
        //商户，活动
        path:'/home/commercial-activity',
        component: CommercialActivity,
        hidden:true,
        meta:{
          requireAuth:true
        }
      },{
          //活动报名结算页
          path:'/home/activitySignUp',
          component: ActivitySignUp,
          hidden:true
        },{
        /***********************************************商户******************************************/
        //商户，服务
        path:'/home/commercial-service',
        component: CommercialService,
        hidden:true,
        meta:{
          requireAuth:true
        }
      },{
        //商户服务评价
        path:'/home/commercialEvaluate',
        component: CommercialEvaluate,
        hidden:true,
        meta:{
          requireAuth:true
        }
      },{
          //商户服务查看评价评价
          path:'/home/merchantViewReviews',
          component: MerchantViewReviews,
          hidden:true,
          meta:{
            requireAuth:true
          }
        },{
         //商户基本信息
          path:'/home/merchantInfo',
          component:MerchanInfo,
          hidden:true,
          meta:{
            requireAuth:true
          }
      },{
        //公司介绍
          path:'/home/companyIntroduction',
          component:CompanyIntroduction,
          hidden:true
      },{
        //商户活动查看报名
        path:'/home/commercialDetailActivity/:id/:title',
        component:CommercialDetailActivity ,
        hidden:true,
        meta:{
          requireAuth:true
        }
      },{
        //商户个人主页
        path:'/home/commercialIndex',
        component: CommercialIndex,
        hidden:true,
        meta:{
          requireAuth:true
        }
      },{
        //商户仓库
        path: '/home/merchantWarehouse',
        component: MerchantWarehouse,
        hidden: true,
        meta:{
          requireAuth:true
        }
      },{
          //商户仓库商品查看评论
          path:'/home/merchantProductReview',
          component:merchantProductReview,
          hidden:true,
          meta:{
            requireAuth:true
          }
        },{
          path:'/home/merchantIncome',
          component:MerchantIncome
        },{
        //商户上传管理
          path:'/home/uploadManage',
          component:UploadManage,
          hidden:true,
          meta:{
            requireAuth:true
          }
      },{
        /*****************************************页面底部功能页面******************************************/
        //企业合作
        path:'/home/businessCooperation',
        component: BusinessCooperation,
        hidden:true
      },{
        //人才招聘
        path:'/home/recruitment',
        component: Recruitment,
        hidden:true
      },{
        //提出意见
        path:'/home/opinion',
        component: Opinion,
        hidden:true
      },{
        //问题主页
        path:'/home/problemIndex',
        component: ProductIndex,
        hidden:true
      },{
          //问题详情页
          path:'/home/problemDetails',
          component: problemDetails,
          hidden:true
        },{
        //问题分类页
        path:'/home/problemClassification',
        component: ProductClass,
        hidden:true
      },{
          // 用户个人对话
          path:'/home/userKsChat',
          component: UserKsChat,
          hidden:true
        }, {
          // 商户个人对话
          path:'/home/merchantKsChat',
          component: MerchantKsChat,
          hidden:true
        }]
    },
    //新密码页面路由
    {
      path: '/newPasswrod',
      name: 'NewPasswrod',
      component: () => import('@/views/login/NewPasswrod'),
      beforeEnter: (to, from, next) => {
        document.body.setAttribute("class","UserLoginLogin");
        next()
      }
    },
    //注册页面路由
    {
      path: '/signup',
      name: 'Signup',
      component: () => import('@/views/login/signup'),
      beforeEnter: (to, from, next) => {
        document.body.setAttribute("class","UserLoginLogin");
        next()
      }
    },
    //快捷注册路由
    {
      path: '/quickRegistration',
      name: 'QuickRegistration',
      component: () => import('@/views/login/quickRegistration'),
      beforeEnter: (to, from, next) => {
        document.body.setAttribute("class","UserLoginLogin");
        next()
      }
    },
    //个人注册页面路由
    {
      path: '/login/usersignup',
      name: 'UserSignup',
      component: () => import('@/views/login/usersignup'),
      beforeEnter: (to, from, next) => {
        document.body.setAttribute("class","UserLoginLogin");
        next()
      }
    },
    //公司注册页面路由
    {
      path: '/gsretrieve',
      name: 'GsRetrieve',
      component: () => import('@/views/login/gsretrieve'),
    },
    //绑定身份证页面路由
    {
      path: '/idcard',
      name: 'IDcard',
      component: () => import('@/views/login/idcard'),
      beforeEnter: (to, from, next) => {
        console.log(to)
        document.body.setAttribute("class","UserLoginLogin");
        next()
      }
    },
    //输入新手机页面路由
    {
      path: '/useriphone',
      name: 'UserIphone',
      component: () => import('@/views/login/useriphone'),
      beforeEnter: (to, from, next) => {
        console.log(to)
        document.body.setAttribute("class","UserLoginLogin");
        next()
      }
    },
    //找回密码页面路由
    {
      path: '/Redo',
      name: 'Redo',
      component: () => import('@/views/login/Redo'),
      beforeEnter: (to, from, next) => {
        console.log(to)
        document.body.setAttribute("class","UserLoginLogin");
        next()
      }
    },


    //商户上传管理

    //商户收入
    {
        path:'/merchantIncome',
        component:()=>import('@/views/merchant/merchantIncome'),
        hidden:true,
        meta:{
          requireAuth:true
        }
    },
    //商户他人页面
    {
      path:'/merchantHomePage',
      component:()=>import('@/views/merchant/merchantHomePage'),
      hidden:true
    },
  /***********************************************商城******************************************/
    //商城主页
    {
      path:'/storeIndex',
      name:'storeIndex',
      component:()=>import('@/views/store/storeIndex'),
      hidden:true
    },
    //商品详情页
    {
      path:'/home/product-detail/:id',
      name:'productDetail',
      component:ProductDetail,
      meta:{
          requireAuth:true
      }
    },
    //商品分类页
    {
        path:'/productClassify',
        name:'productClassify',
        component:()=>import('@/views/store/productClassify')
    },
    //购物车
    {
      path:'/shoppingCart',
      component: () => import('@/views/store/shoppingCart'),
      hidden:true
    },
    //结算页
    {
      path:'/closeAccount',
      name:'closeAccount',
      component: ()=>import('@/views/store/closeAccount'),
      hidden:true
    },
    //身份验证
    {
        path:'/authentication',
        name:'authentication',
        component:()=>import('@/views/store/authentication'),
        hidden:true
    },
    //修改手机号码
    {
        path:'/updatePhone',
        name:'updatePhone',
        component:()=>import('@/views/store/updatePhone'),
        hidden:true
    },
    //身份证绑定
    {
        path:'/idCardAuthentication',
        name:'idCardAuthentication',
        component:()=>import('@/views/store/idCardAuthentication'),
        hidden:true
    },

    /***********************************************问题******************************************/
    //问题主页

    //问题搜索主页
    {
      path:'/problemDetail',
      component: () => import('@/views/problem/problemDetail'),
      hidden:true
    },
    // 404
    {
      path:'/notFound',
      component: () => import('@/views/404'),
      hidden:true
    },
    {
      path:'*',
      redirect:'/notFound'
    },





  ]
})
