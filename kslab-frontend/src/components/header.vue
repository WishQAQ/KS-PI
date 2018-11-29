<template>
  <header class="header_box">
    <div class="header">
      <div class="header_left">
        <div class="header_logo"><router-link to="index"><i class="icon icon-huaban4"></i></router-link></div>
        <div class="header_nav" @mouseleave="nowIndex=parseInt(sessionId)-1">
          <transition name="slide-fade">
            <ul v-show="showNav" :class="showNav">
              <li @mouseenter.stop="nowIndex=index" :class="parseInt(sessionId)?(parseInt(sessionId)===headerNameindex.id?'active':''):indexAcativ===headerNameindex.id?'active':''" v-for="(headerNameindex ,index) in headerName" @click="headerNameClick(headerNameindex.id)" :key="index">
                <router-link :to="headerNameindex.router" >{{headerNameindex.name}}</router-link>
                <router-link :to="headerNameindex.router" >{{headerNameindex.name}}</router-link>
              </li>
            </ul>
          </transition>
          <div class="slider" :style="{'transform':'translate3d('+nowIndex*80+'px,0,0)'}"></div>
        </div>

      </div>

      <div class="header_center" :class="{headerSearchNone:headerSearchBtm,headerSearchClose:headerSearchCloseBtm}">
        <div class="header_center_btm" @click="showNavClick">
          <a :href="headerSearchLink">
            <i @click="headerSearchClick" class="icon icon-huaban2"></i>
          </a>
        </div>
        <el-input
          placeholder="搜索"
          v-model="headerInput"
          @change="labelFunction"
          clearable>
        </el-input>
        <transition name="el-fade-in-linear">
        <div class="header_center_btm headerBtmClose" v-show="header_center_btm_close" @click="showNavClickClose"><i class="icon icon-close"></i> </div>
        </transition>
      </div>

      <div class="header_right">
        <div class="header_userInfo" v-if="this.$store.state.Userstatus">
          <div>
            <el-popover
              popper-class="header_upload_box"
              placement="bottom"
              width="130"
              transition="el-zoom-in-top"
              trigger="hover">
              <div class="header_upload">
                <router-link to="/home/uploadVideo"><i class="icon icon-huaban7"></i><span>发布视频</span></router-link>
                <router-link to="/home/uploadArticle"><i class="icon icon-huaban8"></i><span>写文章</span></router-link>
                <router-link to="/home/uploadingEncyclopedia"><i class="icon icon-huaban9"></i><span>写百科</span></router-link>
              </div>
              <el-button slot="reference"><i class="icon icon-huaban3"></i></el-button>
            </el-popover>
          </div>
          <div>
            <el-popover
              popper-class="header_message_box"
              placement="bottom"
              width="350"
              transition="el-zoom-in-top"
              trigger="hover">
              <div class="header_message">
                <div class="header_message_title">
                  <div><i class="icon icon-ziyuan20"></i>消息</div>
                  <el-button type="text" @click="getReadMessage">查看更多</el-button>
                </div>

                <div class="header_message_list">
                  <ul>
                    <li class="header_message_link" v-for="(item, index) in noReadMessage" :key="index">
                      <div class="header_message_status">{{item.content.action}}</div>
                      <div class="header_message_text">
                        <p>{{item.content.title}}</p>
                        <p>
                          <span>{{item.content.info}}</span>
                          <span>{{item.created_at}}</span>
                        </p>
                      </div>
                    </li>

                  </ul>
                </div>

              </div>
              <el-button slot="reference"><el-badge is-dot class="item"><i class="icon icon-huaban1"></i></el-badge></el-button>
            </el-popover>
          </div>
          <el-dropdown>
            <div class="header_avatar el-dropdown-link" @click="userinfoIndex">
              <img :src="request.picUrl + userFile" alt="">
            </div>
            <el-dropdown-menu slot="dropdown">
              <div @click='close'>
                <el-dropdown-item >退出登录</el-dropdown-item>
              </div>
            </el-dropdown-menu>
          </el-dropdown>
        </div>
        <div class="header_userLogin" v-else>
          <div class="header_userLogin_btm">
            <router-link to="/login"><i><img src="/static/img/icon/chilun.png" alt=""></i><p>登陆</p></router-link>
          </div>
        </div>
      </div>



      <el-dialog :visible.sync="dialogVisible" width="600px">
        <div class="header_message_logo"><i class="icon icon-huaban4"></i></div>

        <div class="header_message_box_list">
          <ul class="box_list_ul">
            <!--<transition name="el-fade-in-linear" v-for="(item, index) in readMessage" :key="index">
            <li class="header_message_return"  v-show="headerMessageReadDelete" v-bind:class="{ header_message_read: readAll }">
              <i class="icon icon-delete" @click="headerMessageDelete"></i>
              <div class="header_message_status">{{item.content.action}}</div>
              <div class="header_message_text">
                <p>{{item.content.title}}</p>
                <p>
                  <span>{{item.content.info}}</span>
                  <span>{{item.created_at}}</span>
                </p>
              </div>
            </li>
            </transition>-->
            <transition name="el-fade-in-linear"  v-for="(item, index) in readMessage" :key="index">
            <li class="header_message_read" @click="handleSetRead(item.message_id)" :style="item.flag===0?{background:'#ffffff'}:{}" v-show="headerMessageReadDelete" v-bind:class="{ header_message_read: readAll }">
              <i class="icon icon-delete" @click="headerMessageDelete"></i>
              <div class="header_message_status">{{item.content.action}}</div>
              <div class="header_message_text">
                <p>{{item.content.title}}</p>
                <p>
                  <span>{{item.content.info}}</span>
                  <span>{{item.created_at}}</span>
                </p>
              </div>
            </li>
            </transition>
          </ul>
          <el-pagination
            background
            @change="handleMessagePage"
            layout="prev, pager, next"
            :total="messageTotal">
          </el-pagination>
        </div>

        <div slot="footer" class="dialog-footer header_dialog_footer">
          <el-button @click="headerMessageAllDelete">删除已读</el-button>
          <el-button type="primary" @click="headerMessageReadAll">全部已读</el-button>
        </div>

      </el-dialog>

    </div>

  </header>
</template>

<script>
  const sessionStorage = window.sessionStorage;
export default {
  name: 'HelloWorld',
  created() {
    console.log(111,this.indexAcativ)
    this.nowIndex=window.sessionStorage.tabId-1;
    const param = {
      size: 4,
      all: true
    };
    this.getNoReadMessage(param);

    /*
      获取用户信息
    */
    this.HttpClient.post('/web/user/profile',{
      token:window.localStorage.token
    })
    .then((res) => {
      this.userFile = res.data.data[0].avatar
    })
  },
  data () {
    return {
      nowIndex: '',
      activeName: 'index',
      headerInput:'',
      dialogVisible: false,
      headerSearchBtm:false,
      headerSearchCloseBtm:false,
      showInput:false,
      showNav: true,
      header_center_btm_close:false,
      msg: 'Welcome to Your Vue.js App',
      isAcssa:false,
      indexAcativ:1,
      headerName:[
        {id:1, name:'主页' , router:'/'},
        {id:2,  name:'商城' , router:'/home/store-index'},
        {id:3,  name:'淘货' , router:'/home/marketpage-index'},
        {id:4,  name:'服务' , router:'/home/service-page-index'},
        {id:5,  name:'活动' , router:'/home/activity-index'}
      ],
      headerSearchLink:null,
      headerMessageReadDelete: true,  //已读信息显示
      readAll:false,
      sessionId: sessionStorage.getItem('tabId'),
      noReadMessage: [],
      readMessage: [],
      messageTotal: null,
      userFile:null   //用户信息
    }
  },
  methods:{
    /*
      标签搜索
    */
    labelFunction(){
      if(this.headerInput != "" || this.headerInput == null){
         this.$router.push({
           path:"/home/searchIndex",
           query:{
             label:this.headerInput
           }
         })
      }
    },
    //region
    handleClick(tab, event) {

    },
    showNavClick(){
      this.showNav = false;
      this.header_center_btm_close = true;
    },

    showNavClickClose(){
      this.showNav = true;
      this.headerSearchBtm = false;
      this.headerSearchCloseBtm = true;
      this.header_center_btm_close = false;
      this.headerSearchLink = 'javascript:;';
    },

    headerSearchClick(){
      if (this.headerSearchBtm == false){
        this.headerSearchBtm = true;
        this.headerSearchCloseBtm = false;
        this.headerSearchLink = '/home/searchIndex';
      }
    },

    headerNameClick(index){
      // this.indexAcativ = index;
      // sessionStorage.setItem('indexAcativ', this.indexAcativ);
      // console.log(index)
      this.indexAcativ = index
      window.sessionStorage.setItem('tabId',index)
      this.sessionId = index;
    },
    close(){
      console.log("1")
      this.$ajax.post('http://test.kslab.com/api/serviceComment/loginout',{
        token:localStorage.token
      })
      .then(function(response){
        this.$router.push({
          path:'/'
        })
      })
      .catch(function(error){
        console.log(error)
      })
      localStorage.removeItem('token')
      localStorage.removeItem('uid')
      this.$store.commit('USERCLOSE')
    },
    userinfoIndex(){
      if(window.localStorage.differentiate == 1){
        this.$router.push({
          path:'/home/userIndex'
        })
      }else{
        this.$router.push({
          path:'/home/commercialIndex'
        })
      }
    },

    headerMessageDelete(){
      // this.headerMessageReadDelete=false
    },


    headerMessageAllDelete(){
      this.headerMessageReadDelete=false
    },
    //endregion
    headerMessageReadAll(){
      this.readAll=true
    },

    /***
     * 获取未读信息
     * @param param
     */
    getNoReadMessage(param) {
      this.HttpClient.post('/my/message/unReadLists',param).then(res =>{
        if(res.data.code === 200) {
          this.noReadMessage = res.data.data.data;
        }
      })
    },
    /***
     * 获取已读信息
     * @param param
     */
    getReadMessage() {
      const param = {
        size: 6,
        all: false,
        page: 1
      };
      this.dialogVisible = true;
      this.HttpClient.post('/my/message/unReadLists',param).then(res =>{
        if(res.data.code === 200) {
          this.readMessage = res.data.data.data;
          this.messageTotal = res.data.data.total;
        }
      })
    },
    /***
     * 标记为已读
     * @param id
     */
    handleSetRead(id) {
      console.log(id)
      this.HttpClient.post('/my/message/setRead',{message_id: id}).then(res =>{
        console.log(res.data)
        if(res.data.code === 200) {
          this.getReadMessage();
        }
      })
    },
    handleMessagePage(value) {
      this.page = value;
      const param = {
        size: 6,
        all: false,
        page: value
      };
      this.dialogVisible = true;
      this.HttpClient.post('/my/message/unReadLists',param).then(res =>{
        if(res.data.code === 200) {
          this.readMessage = res.data.data.data;
          this.messageTotal = res.data.data.total;
        }
      })
    }



  },

  mounted(){
    this.indexAcativ = this.$route.id
  }
}
</script>


<style>
  @media screen and (max-width: 1200px) {
    .header{
      padding: 0 30px;
    }
  }

.box_list_ul{
  height: 460px;
}

  /*头部背景*/
  .header_box{
    background-color: #37313f;
    height: 58px;
    display: flex;
    justify-content: center;
    align-items: center;
    border-bottom: 2px solid #7d7d7d;
  }
  .header{
    max-width: 1200px;
    width: 100vw;
    min-width: 960px;
    display: flex;
    align-items: flex-start;
    position: relative;
  }

  .header_left{
    display: flex;
    align-items: flex-start;
  }

  /*logo*/
  .header_logo{
    display: flex;
    justify-content: center;
    align-items: center;
    margin-right: 40px;
    margin-left: 10px;
    cursor: pointer;
  }
  .header_logo .icon{
    font-size: 40px;
    color: #15bafe;
  }


  /*navTab样式*/
  .header_nav{
    overflow: hidden;
    position: relative;
    height: 60px;
  }

  /*导航栏动画*/
  .header_nav .slide-fade-enter-active {
    transition: all .5s;
  }
  .header_nav .slide-fade-leave-active {
    transition: all .5s cubic-bezier(1.0, 0.5, 0.8, 1.0);
  }
  .header_nav .slide-fade-enter,
  .header_nav .slide-fade-leave-to
    /* .slide-fade-leave-active for below version 2.1.8 */ {
    transform: translateX(-300px);
    opacity: 0;
  }

  .header_nav .slider{
    position: absolute;
    transition: all .5s cubic-bezier(0.4, -0.3, 0.57, 1.38);
    width: 80px;
    height: 2px;
    background: #15befe;
    bottom: 0;
    left: 0;
    z-index: 1;
  }

  .header_nav ul{
    display: flex;
    align-items: flex-end;
    position: relative;
    overflow: hidden;
  }
  .header_nav ul li{
    height: 58px;
    width: 80px;
    display: flex;
    justify-content: center;
    align-items: center;
    font-size: 18px;
    flex-wrap: wrap;
  }
  .header_nav ul li:hover a{
    transform: translate3d(0,-58px,0);
  }
  .header_nav ul li a{
    color: #fff;
    display: flex;
    justify-content: center;
    align-items: center;
    width: 100%;
    height: 100%;
    transition: all ease-out .4s;
  }
  .header_nav ul .active{
    font-weight: bold;
    background-color: #261f2f;
  }


  /*搜索框*/
  .header_center{
    height: 60px;
    display: flex;
    justify-content: center;
    align-items: center;
    overflow: hidden;
    margin: 0 0 0 auto;
    position: relative;
  }
  .header_center_btm{
    display: flex;
    justify-content: center;
    align-items: center;
    height: 55px;
  }
  .header_center_btm:hover{
    background-color: #261f2f;
  }
  .header_center_btm a{
    width: 100%;
    height: 100%;
  }
  .header_center_btm .icon{
    color: #fff;
    font-size: 25px;
    padding: 0 18px;
    margin-right: 5px;
    height: 100%;
    width: 100%;
    display: flex;
    justify-content: center;
    align-items: center;
  }
  .headerBtmClose{
    position: absolute;
    right: 0;
  }
  .headerBtmClose .icon{
    font-size: 12px !important;
  }

  .header_center input{
    display: none;
    opacity: 0;
    background: transparent;
    border: none;
    color: #fff;
    font-size: 16px;
    padding-left: 10px;
  }
  .header_center input::placeholder{
    font-size: 16px;
    color: #999;
    font-weight: lighter;
  }

  /*搜索框动画*/
  .headerSearchNone{
    position: relative;
  }
  .headerSearchNone .el-input__suffix{
    right: 50px !important;
  }

  .headerSearchNone input{
    display: block !important;
    opacity: 1 !important;
    padding-right: 100px !important;
    animation: headerSearch 1.8s forwards;
  }
  @keyframes headerSearch {
    from {
      width: 0;
    }
    to {
      width: 44vw;
    }
  }

  @media screen and (min-width: 1431px) and (max-width: 1600px){
    .headerSearchNone input{
      animation: headerSearch1700 1.8s forwards;
    }
    @keyframes headerSearch1700 {
      from {
        width: 0;
      }
      to {
        width: 50vw;
      }
    }
  }

  @media screen and (min-width: 301px) and (max-width: 1430px){
    .headerSearchNone input{
      animation: headerSearch1400 2s forwards;
    }
    @keyframes headerSearch1400 {
      from {
        width: 0;
      }
      to {
        width: 58vw;
      }
    }
  }
  .headerSearchClose input{
    opacity: 1 !important;
    display: block;
    animation: headerSearchClose .8s forwards;
    padding: 0 !important;
  }
  @keyframes headerSearchClose {
    from {
      width: 25vw;
    }
    to {
      width: 0;
      padding: 0 !important;
    }
  }



    /*icon颜色*/
  .header_right{
    color: #fff;
    display: flex;
    align-items: center;
  }
  .header_userInfo{
    display: flex;
    align-items: center;
  }
  .header_userInfo>div{
    width: 60px;
    height: 60px;
    display: flex;
    justify-content: center;
    align-items: center;
    position: relative;
    top: -2px;
  }
  .header_userInfo>div>span{
    width: 100%;
    height: 100%;

  }
  .header_userInfo>div button{
    width: 100% !important;
    height: 100% !important;
    background: transparent !important;
    border-radius: 0 !important;
    border: none !important;
    color: #fff !important;
  }
  .header_userInfo .icon{
    font-size: 25px;
  }
  /*hover颜色*/
  .header_userInfo>div:hover{
    background-color: #261f2f;
  }
  .header_userInfo>div:hover .icon{
    color: #15bafe;
  }


  /*上传*/
  .header_upload_box{
    padding: 0 !important;
    min-width: 130px !important;
  }
  .header_upload{
  }
  .header_upload a{
    display: flex;
    align-items: center;
    padding: 10px 10px;
  }
  .header_upload a:hover{
    background-color: #e8fdff;
  }
  .header_upload a:not(:last-child){
    border-bottom: 1px solid #dadada;
  }
  .header_upload .icon{
    color: #15bafe;
    font-size: 20px;
    margin-right: 15px;
  }
  .header_upload span{
    font-size: 12px;
    color: #222 !important;
  }



  /*信息*/
  .header_message_box{
    min-width: 350px !important;
    padding: 0 !important;
    border-radius: 0 !important;
  }
  .header_message{}
  .header_message_title{
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 10px;
    border-bottom: 1px solid #eaeaea;
  }
  .header_message_title>div{
    display: flex;
    align-items: center;
    font-size: 12px;
    color: #222;
  }
  .header_message_title>div .icon{
    background-color: #15bafe;
    color: #fff;
    font-size: 10px;
    margin-right: 10px;
    width: 25px;
    height: 25px;
    border-radius: 50%;
    display: flex;
    justify-content: center;
    align-items: center;
  }

  .header_message_title>button span{
    font-size: 12px !important;
    color: #222 !important;
  }
  .header_message_title>button:hover span{
    color: #15bafe !important;
  }

  .header_message_list{

  }
  .header_message_list ul li{
    display: flex;
    align-items: center;
    border-bottom: 1px solid #dcdcdc;
    position: relative;
    left: -1px;
  }
  .header_message_status{
    border-left: 3px solid;
    border-right: 1px solid #dcdcdc;
    width: 60px;
    height: 60px;
    display: flex;
    justify-content: center;
    align-items: center;
  }
  .header_message_text{
    padding: 0 10px;
    font-size: 12px;
    width: 100%;
  }
  .header_message_text p:nth-child(1){
    color: #999;
    max-width: 240px;
    overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
    margin-bottom: 10px;
  }
  .header_message_text p:last-child{
    color: #222;
    display: flex;
    justify-content: space-between;
    align-items: center;
  }


  .header_message_box_list ul li{
    position: relative;
  }
  .header_message_box_list ul li i{
    display: none;
    position: absolute;
    top: 5px;
    right: 10px;
    font-size: 12px;
    cursor: pointer;
  }
  .header_message_box_list ul li i:hover{
    color: #15bafe;
  }

  /*点赞*/
  .header_message_link .header_message_status{
    border-left-color: #15bafe;
  }
  /*退货*/
  .header_message_return .header_message_status{
    border-left-color: #f55959;
  }
  /*已阅*/
  .header_message_read{
    background-color: #f2f2f2;
    cursor: pointer;
  }
  .header_message_read .header_message_status{
    border-left-color: #ccc;
  }

  .header_message_read:hover i{
    display: block;
  }


  /*信息小红点*/
  .header .el-badge__content{
    border: none !important;
  }


  /*信息弹窗*/
  .header .el-dialog__header{
    padding: 30px 20px 10px !important;
    border-bottom: 1px solid #eaeaea !important;
  }
  .header .el-dialog__headerbtn{
    top: 12px !important;
  }
  .header_message_logo{
    position: absolute;
    left: 3%;
    top: 0;
    color: #15bafe;
  }
  .header_message_logo i{
    font-size: 25px !important;
  }

  .header_message_box_list ul li{
    display: flex;
    align-items: center;
    margin: 10px 0;
    border-top: 1px solid #dcdcdc;
    border-bottom: 1px solid #dcdcdc;
    border-right: 1px solid #dcdcdc;
  }
  .header_message_box_list ul li:nth-child(1){
    margin-top: 0 !important;
  }
  .header_message_box_list ul li:last-child{
    margin-bottom: 0 !important;
  }

  .header .el-dialog__body{
    padding: 20px !important;
    overflow: auto;
    height: 535px;
    margin: 10px 10px 0 10px !important;
  }

  .header_message_box_list .header_message_text p:nth-child(1){
    max-width: 400px;
  }


  /*全部已阅按钮*/
  .header .el-dialog__footer{
    padding: 10px 20px !important;
    border-top: 1px solid #dcdcdc !important;
  }
  .header .el-button{
    padding: 7px 17px !important;
  }


  /*滚动条样式*/
  .header .el-dialog__body::-webkit-scrollbar{
    width: 16px;
    height: 16px;
  }
  .header .el-dialog__body::-webkit-scrollbar-track{
    border-radius: 10px;
    background-color: #f2f2f2;
  }

  .header .el-dialog__body::-webkit-scrollbar-thumb{
    border-radius: 10px;
    background: url("/static/img/icon/commercial_scrollBar.png") no-repeat #2ab0f7 center center;
    background-size: 100%;
  }


  /*头像*/
  .header_avatar{
    padding: 15px;
    display: flex;
    justify-content: center;
    align-items: center;
    overflow: hidden;
    cursor: pointer;
    width: 100%;
    height: 100%;
  }
  .header_avatar img{
    width: 100%;
    height: 100%;
    border: 1px solid #15bafe;
    border-radius: 5px;
  }


  /*登录*/
  .header_userLogin{
    display: flex;
    align-items: center;
  }


  .header_userLogin_btm{
    width: 120px;
    height: 58px;
    display: flex;
    justify-content: center;
    align-items: center;
    font-size: 16px;
  }
  .header_userLogin_btm a{
    display: flex;
    align-items: center;
    justify-content: center;
    width: 100%;
    height: 100%;
  }

  .header_userLogin_btm p{
    color: #fff;
  }
  .header_userLogin_btm:hover{
    background-color: #261f2f;
  }

  .header_userLogin_btm i{
    font-size: 24px;
    width: 24px;
    height: 24px;
    color: #15bafe;
    margin-right: 15px;
    display: flex;
    justify-content: center;
    align-items: center;
    -webkit-animation: xuanzhuan 17s linear;
    -webkit-animation-iteration-count: infinite;
  }
  .header_userLogin_btm i img{
    width: 100%;
    height: 100%;
  }

  /*齿轮旋转动画*/
  @-webkit-keyframes xuanzhuan{
    0%, 2%{  -webkit-transform:rotateZ(0);  }
    3%{  -webkit-transform:rotateZ(12deg);  }
    4.3%, 6.3%{  -webkit-transform:rotateZ(15deg);  }
    7%{  -webkit-transform:rotateZ(27deg);  }
    8.6%, 10.6%{  -webkit-transform:rotateZ(30deg);  }
    11%{  -webkit-transform:rotateZ(42deg);  }
    12.9%, 14.9%{  -webkit-transform:rotateZ(45deg);  }
    16%{  -webkit-transform:rotateZ(57deg);  }
    17.2%, 19.2%{  -webkit-transform:rotateZ(60deg);  }
    20%{  -webkit-transform:rotateZ(72deg);  }
    21.5%, 23.5%{  -webkit-transform:rotateZ(75deg);  }
    24%{  -webkit-transform:rotateZ(87deg);  }
    25.8%, 27.8%{  -webkit-transform:rotateZ(90deg);  }
    29%{  -webkit-transform:rotateZ(102deg);  }
    30.1%, 32.1%{  -webkit-transform:rotateZ(105deg);  }
    33%{  -webkit-transform:rotateZ(117deg);  }
    34.4%, 36.4%{  -webkit-transform:rotateZ(120deg);  }
    37%{  -webkit-transform:rotateZ(132deg);  }
    38.7%, 40.7%{  -webkit-transform:rotateZ(135deg);  }
    42%{  -webkit-transform:rotateZ(147deg);  }
    43%, 45%{  -webkit-transform:rotateZ(150deg);  }
    46%{  -webkit-transform:rotateZ(162deg);  }
    47.3%, 49.3%{  -webkit-transform:rotateZ(165deg);  }
    50%{  -webkit-transform:rotateZ(177deg);  }
    51.6%, 53.6%{  -webkit-transform:rotateZ(180deg);  }
    55%{  -webkit-transform:rotateZ(192deg);  }
    55.9%, 57.9%{  -webkit-transform:rotateZ(195deg);  }
    59%{  -webkit-transform:rotateZ(212deg);  }
    60.2%, 62.2%{  -webkit-transform:rotateZ(215deg);  }
    63.5%{  -webkit-transform:rotateZ(227deg);  }
    64.5%, 66.5%{  -webkit-transform:rotateZ(230deg);  }
    68%{  -webkit-transform:rotateZ(242deg);  }
    68.8%, 70.8%{  -webkit-transform:rotateZ(245deg);  }
    72%{  -webkit-transform:rotateZ(257deg);  }
    73.1%, 75.1%{  -webkit-transform:rotateZ(260deg);  }
    76%{  -webkit-transform:rotateZ(272deg);  }
    77.4%, 79.4%{  -webkit-transform:rotateZ(275deg);  }
    81%{  -webkit-transform:rotateZ(287deg);  }
    81.7%, 83.7%{  -webkit-transform:rotateZ(290deg);  }
    85%{  -webkit-transform:rotateZ(312deg);  }
    86%, 88%{  -webkit-transform:rotateZ(315deg);  }
    89%{  -webkit-transform:rotateZ(327deg);  }
    90.3%, 92.3%{  -webkit-transform:rotateZ(330deg);  }
    93.5%{  -webkit-transform:rotateZ(342deg);  }
    94.6%, 96.6%{  -webkit-transform:rotateZ(345deg);  }
    98%{  -webkit-transform:rotateZ(357deg);  }
    98.9%, 100%{  -webkit-transform:rotateZ(360deg);  }
  }




  .header_userLogin_btm .icon:before{
    display: flex;
    justify-content: center;
    align-items: center;
  }

  .header_dialog_footer{
    display: flex;
    align-items: center;
    justify-content: space-between;
  }
</style>


<!-- Add "scoped" attribute to limit CSS to this component only -->
<!--<style scoped>-->
  <!---->
  <!--.header_user_none{-->
      <!--width: 80px;-->
      <!--margin-right: 110px;-->
      <!--background-color: #15bafe;-->
      <!--text-align: center;-->
      <!--font-size:14px;-->
    <!--position: relative;-->
    <!--z-index: 2;-->
  <!--}-->

  <!--.header_user_none a{-->
    <!--display: block;-->
    <!--color:#FFF !important;-->
    <!--padding: 15px;-->
  <!--}-->
  <!--.header{-->
    <!--width: 100%;-->
    <!--min-width: 960px;-->
    <!--z-index: 999;-->
    <!--position: relative;-->
    <!--margin: 0 auto;-->
  <!--}-->
  <!--.header_top{-->
    <!--display: flex;-->
    <!--justify-content: space-between;-->
    <!--align-items: center;-->
    <!--background-color: #37313f;-->
    <!--height: 50px;-->
    <!--border-bottom: 1px solid #7d7d7d;-->
  <!--}-->
  <!--/*logo*/-->
  <!--.logo{-->
    <!--width: 100px;-->
    <!--margin-left: 50px;-->
  <!--}-->

  <!--/*搜索框盒子*/-->
  <!--.search{-->
    <!--position: relative;-->
  <!--}-->
  <!--.search div{-->
    <!--display: flex;-->
    <!--justify-content: center;-->
    <!--align-items: center;-->
  <!--}-->
  <!--/*搜索框*/-->
  <!--.search .search_input{-->
    <!--width: 500px;-->
    <!--height: 26px;-->
    <!--background-color: #656477;-->
    <!--font-size: 12px;-->
    <!--color: #a9a9a9;-->
    <!--padding-left: 10px;-->
    <!--border-radius: 5px;-->
    <!--border: 1px solid transparent;-->
    <!--transition: all .4s;-->
  <!--}-->

  <!--.search .search_input:hover{-->
    <!--border: 1px solid #15bafe;-->
  <!--}-->

  <!--.search .search_input:focus{-->
    <!--background-color: #fff;-->
    <!--border: 1px solid #15bafe;-->
  <!--}-->

  <!--.search div a{-->
    <!--position: absolute;-->
    <!--right: 0;-->
    <!--width: 40px;-->
    <!--height: 30px;-->
    <!--display: block;-->
    <!--border: none;-->
    <!--border-top-right-radius: 5px;-->
    <!--border-bottom-right-radius: 5px;-->
    <!--background: url("/static/img/icon/search.png") no-repeat center center #15bafe;-->
    <!--background-size: 50%;-->

  <!--}-->


  <!--/*用户盒子*/-->
  <!--.header_top_box{-->
    <!--display: flex;-->
    <!--justify-content: center;-->
    <!--align-items: center;-->
    <!--position: relative;-->
    <!--z-index: 99;-->
  <!--}-->

  <!--.header_top_box>div:not(:last-child){-->
    <!--margin-right: 45px;-->
  <!--}-->
  <!--.header_top_box>div:last-child{-->
    <!--margin-right: 100px;-->
  <!--}-->

  <!--/*上传,信息*/-->
  <!--.upload a,-->
  <!--.message a{-->
    <!--width: 32px;-->
    <!--position: relative;-->
    <!--display: flex;-->
    <!--justify-content: center;-->
    <!--align-items: center;-->
  <!--}-->
  <!--.upload img,-->
  <!--.message img{-->
    <!--width: 80%;-->
  <!--}-->

  <!--.upload:hover+.upload_box,-->
  <!--.upload_box:hover{-->
    <!--display: block;-->
  <!--}-->


  <!--/*上传框占位*/-->
  <!--.upload_box_top_border{-->
    <!--width: 40px;-->
    <!--height: 80px;-->
    <!--position: absolute;-->
    <!--right: 57px;-->
    <!--top: -80px;-->
  <!--}-->
  <!--/*上传框*/-->
  <!--.upload_box{-->
    <!--position: fixed;-->
    <!--top: 50px;-->
    <!--right: 150px;-->
    <!--background-color: #fff;-->
    <!--z-index: 9991;-->
    <!--padding: 15px 0;-->
    <!--display: none;-->
    <!--box-shadow: 1px 1px 5px 2px rgba(34,24,21,.16);-->
  <!--}-->

  <!--.upload_box li{-->
    <!--height: 40px;-->
    <!--display: flex;-->
    <!--align-items: center;-->
    <!--padding: 0 25px;-->
    <!--font-size: 16px;-->
  <!--}-->
  <!--.upload_box li:hover{-->
    <!--background-color: #eeeeee;-->
  <!--}-->

  <!--.upload_box li a{-->
    <!--display: flex;-->
    <!--align-items: center;-->
    <!--color: #000 !important;-->
  <!--}-->

  <!--.upload_box li span{-->
    <!--display: inline-block;-->
    <!--width: 20px;-->
    <!--margin-right: 20px;-->
  <!--}-->





  <!--/*信息小红点*/-->
  <!--.message{-->
    <!--position: relative;-->
  <!--}-->
  <!--.message span{-->
    <!--position: absolute;-->
    <!--right: -9px;-->
    <!--top: -9px;-->
    <!--display: flex;-->
    <!--justify-content: center;-->
    <!--align-items: center;-->
    <!--background-color: red;-->
    <!--color: #fff;-->
    <!--font-size: 10px;-->
    <!--font-weight: bold;-->
    <!--width: 18px;-->
    <!--height: 18px;-->
    <!--border-radius: 50%;-->
  <!--}-->

  <!--/*hover效果*/-->
  <!--.message:hover+.message_box,.message_box:hover{-->
    <!--display: block;-->
  <!--}-->


  <!--/*hover占位框*/-->
  <!--.message_box_top_border{-->
    <!--height: 80px;-->
    <!--width: 45px;-->
    <!--position: absolute;-->
    <!--top: -80px;-->
    <!--right: 10px;-->
  <!--}-->


  <!--/*信息框*/-->
  <!--.message_box{-->
    <!--z-index: 999;-->
    <!--background-color: #fff;-->
    <!--width: 410px;-->
    <!--position: fixed;-->
    <!--top: 50px;-->
    <!--right: 113px;-->
    <!--box-shadow: 1px 1px 10px 1px rgba(34,24,21,.16);-->
    <!--display: none;-->
  <!--}-->

  <!--/*三角形*/-->
  <!--.message_box_triangle{-->
    <!--width: 0;-->
    <!--height: 0;-->
    <!--border-bottom: 15px solid #eee;-->
    <!--border-left: 17px solid transparent;-->
    <!--border-right: 17px solid transparent;-->
    <!--position: absolute;-->
    <!--bottom: 0;-->
  <!--}-->

  <!--.message_box_title{-->
    <!--display: flex;-->
    <!--align-items: center;-->
    <!--background-color: #eee;-->
    <!--height: 48px;-->
    <!--padding-left: 15px;-->
    <!--font-size: 18px;-->
    <!--color: #000;-->
  <!--}-->
  <!--.message_box  ul li{-->
    <!--padding: 15px 0;-->
    <!--display: flex;-->
    <!--align-items: center;-->
    <!--border-bottom: 1px solid #eee;-->
    <!--color: #000;-->
  <!--}-->

  <!--/*动画*/-->
  <!--.message_box  ul li:hover{-->
    <!--background-color: #f5f6f6;-->
  <!--}-->
  <!--.message_box  ul li:hover .message_box_text{-->
    <!--border-left: 5px solid #15bafe;-->
  <!--}-->



  <!--.message_box_text{-->
    <!--padding-left: 25px;-->
    <!--border-left: 5px solid #c6c6c6;-->
  <!--}-->
  <!--.message_box_text h4{-->
    <!--font-size: 16px;-->
    <!--color: #000;-->
  <!--}-->
  <!--.message_box_text p{-->
    <!--font-size: 14px;-->
    <!--color: #9b9b9b;-->
  <!--}-->
  <!--.message_box_text h4,-->
  <!--.message_box_text p{-->
    <!--width: 280px;-->
    <!--overflow: hidden;-->
    <!--white-space: nowrap;-->
    <!--text-overflow: ellipsis;-->
  <!--}-->
  <!--.message_box_text span{-->
    <!--display: block;-->
    <!--font-size: 12px;-->
    <!--color: #9b9b9b;-->
  <!--}-->
  <!--.message_box_more{-->
    <!--display: flex;-->
    <!--justify-content: center;-->
    <!--align-items: center;-->
    <!--flex-wrap: wrap;-->
    <!--width: 5px;-->
    <!--margin: 0 30px 0 auto;-->
  <!--}-->
  <!--.message_box_more span{-->
    <!--display: block;-->
    <!--width: 3px;-->
    <!--height: 3px;-->
    <!--background-color: #7d7d7d;-->
    <!--margin: 1px;-->
  <!--}-->




  <!--/*头像*/-->
  <!--.avatar{-->
    <!--width: 35px;-->
    <!--height: 35px;-->
    <!--position: relative;-->
    <!--border-radius: 50%;-->
    <!--overflow: hidden;-->
    <!--cursor: pointer;-->
  <!--}-->
  <!--.avatar img{-->
    <!--width: 35px;-->
    <!--height: 35px;-->
    <!--position: absolute;-->
    <!--top: 50%;-->
    <!--left: 50%;-->
    <!--margin-top: -17.5px;-->
    <!--margin-left: -17.5px;-->
  <!--}-->


  <!--/*导航栏*/-->
  <!--.nav ul{-->
    <!--height: 50px;-->
    <!--display: flex;-->
    <!--justify-content: center;-->
    <!--align-items: center;-->
    <!--color: #fff;-->
    <!--text-align: center;-->
    <!--background-color: #484250;-->
  <!--}-->
  <!--.nav ul li{-->
    <!--width: 204px;-->
    <!--height: 50px;-->
    <!--line-height: 50px;-->
    <!--display: flex;-->
    <!--align-items: center;-->
    <!--position: relative;-->
  <!--}-->
  <!--.nav ul li a{-->
    <!--height: 100%;-->
    <!--width: 99%;-->
    <!--display: flex;-->
    <!--align-items: center;-->
    <!--justify-content: center;-->
    <!--color: #fff;-->
    <!--font-size: 18px !important;-->
  <!--}-->
  <!--.nav ul .active{-->
    <!--border-bottom: 5px solid #15bafe;-->
    <!--font-weight: bold;-->
  <!--}-->
  <!--.nav ul .active span{-->
    <!--display: block;-->
    <!--width: 1px;-->
    <!--height: 18px;-->
    <!--background-color: #fff;-->
  <!--}-->

  <!--/*导航栏动画*/-->
  <!--.nav ul li::after {-->
    <!--content: '';-->
    <!--position: absolute;-->
    <!--width: 100%;-->
    <!--transform: scaleX(0);-->
    <!--height: 5px;-->
    <!--bottom: 0;-->
    <!--left: 0;-->
    <!--background-color: #15bafe;-->
    <!--transform-origin: bottom right;-->
    <!--transition: transform 0.25s ease-out;-->
  <!--}-->
  <!--.nav ul .active::after{-->
    <!--display: none;-->
  <!--}-->
  <!--.nav ul li:hover::after {-->
    <!--transform: scaleX(1);-->
    <!--transform-origin: bottom left;-->
  <!--}-->
<!--</style>-->
