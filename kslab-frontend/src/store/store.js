import Vue from 'vue'
import Vuex from 'vuex'
import axios from 'axios'
import serviceDetail from './modules/serviceDetail'
import activityDetail from './modules/activityDetail'
import serviceUpload from './modules/serviceUpload'
import activityUpload from './modules/activityUpload'
import marketUpload from './modules/marketUpload'
import getCurrentLocation from './modules/getCurrentLocation'
import chatList from './modules/chatList'

Vue.use(Vuex)
var stockpile=window.localStorage;
export default new Vuex.Store({
  modules: {
    serviceDetail, //获取服务详情的id
    activityDetail, //获取活动详情的id
    serviceUpload, //服务上传
    activityUpload, //活动上传
    marketUpload,  //淘货上传
    getCurrentLocation, // 获取当前位置
    chatList, //获取对话列表
  },
  state:{
    count:0,
    RouterVuex:"",     //当前路由状态分发,
    Userstatus:'',      //当前用户登录状态分发
    headerstatus:stockpile['header'],      //当前hader点击
    token:stockpile['token'],              //用户登陆token
    userUid:stockpile['uid'],              //用户uid
    userTime:true,                        //商户页面时间月日切换状态
    sreachId:null                         //判断当前位置跳入搜索
  },
  mutations:{
    //当前路由提交状态方法
    RouterPath(state,path){
      console.log(path)
      state.RouterVuex = path
    },
    UserStatus(state,statusUser){
      state.Userstatus = statusUser;
    },
    Headerstatus(state,statusheader){
      stockpile['header'] = statusheader;
    },
    USERTOKEN(state,statusToken){
      stockpile['Userstatus'] = true
      state.Userstatus = stockpile['Userstatus']
    },
    USERCLOSE(state){
      state.Userstatus = false;
    },
    USERUID(state,useruid){
      stockpile['uid'] = useruid
      state.userUid = useruid;
    },
    USERINFOINDEX(state,userinfoindex){
      stockpile['infoHeader'] = userinfoindex;
    },
    //商户时间日期切换
    USERDATE(state,userdate){
      state.userTime = userdate
      console.log(state.userTime)
      console.log("进入vuex")
    },
    SREACHROUTER(state,sreachid){
      state.sreachId = sreachid;
    },
  },
  actions:{

  },
  getters:{

  }
})
