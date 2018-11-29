<template>
  <div class="information width_1200">
    <!--个人资料背景-->
    <div>
      <div class="information_top_bg_img">
        <img id="result" src="/static/img/user_background.jpg" alt="">

        <div class="corner">
          <div class="information_bg_replace" @click="dialogVisible = true">
            <i class="icon icon-tianjiatupian"></i>
          </div>
        </div>

      </div>

      <div class="information_file">
        <input type="file" id="input">
      </div>
    </div>
    <!--个人资料-->
    <div class="information_center_box">
      <div class="information_center_left">
        <div class="user_avatar">
          <img  id="userResult" :src="request.picUrl + userinfo.avatar" alt="">
        </div>
        <div class="user_box">
          <div class="user_name">{{userinfo.nickname}}</div>
          <div class="user_introduction">{{userinfo.signature}}</div>
        </div>
      </div>
      <!--设置-->
      <!---->

      <el-dropdown trigger="click">
        <div class="information_center_right el-dropdown" ref="userInfoSetting">
          <img src="/static/img/icon/setting.png" alt="">
        </div>

        <el-dropdown-menu slot="dropdown">
          <a @click="transmit">
            <el-dropdown-item>个人资料编辑</el-dropdown-item>
          </a>
          <a @click="handleAuthentication">
            <el-dropdown-item>实名认证</el-dropdown-item>
          </a>
          <router-link to="/home/changePassword">
            <el-dropdown-item>修改密码</el-dropdown-item>
          </router-link>
          <router-link to="/home/changePhoneNumber">
            <el-dropdown-item>修改手机</el-dropdown-item>
          </router-link>
        </el-dropdown-menu>
      </el-dropdown>
    </div>


    <!--个人资料分类列表-->
    <div class="user_nav">
      <ul>
        <li v-for="(headerNameindex ,index) in headerName" @click="headerNameClick(headerNameindex.id)" :key="index">
          <router-link :to="headerNameindex.router" >{{headerNameindex.name}}</router-link>
          <router-link :to="headerNameindex.router" >{{headerNameindex.name}}</router-link>
          <span class="userNavLine"></span>
        </li>
      </ul>
    </div>

    <!--修改背景框-->
    <el-dialog
      title="修改个人背景"
      :visible.sync="dialogVisible"
      width="40%">
      <div class="infoReplace_box">
        背景裁剪框


      </div>
    </el-dialog>

  </div>



</template>

<script>
    export default {
        name: "userInfoHead",
        // props: [
        //   'userData'
        // ],
        data(){
          return{
            avatar:'',
            userdescribe:'klmdgdslkngdfdgdf',   //用户描述
            username:'dsjnfskjdnfds',       //用户ID
            updatedAt:null,       //用户上次更新时间
            actualName:null,      //用户真实ID
            usergender:null   ,   //用户性别
            userinfo:{},

            dialogVisible: false, //修改背景框

            // 导航栏
            headerName:[
              {id:1, name:'HOME' , router:'/home/userIndex'},
              {id:2,  name:'购物车' , router:'/home/userShopping'},
              {id:3,  name:'活动' , router:'/home/userActivities'},
              {id:4,  name:'对话' , router:'/home/userKsChat'},
              {id:5,  name:'关注' , router:'/home/userFocus'},
              {id:6,  name:'收入' , router:'/home/userIncome'},
              {id:7,  name:'历史记录' , router:'/home/userHistoryRecord'},
              {id:8,  name:'上传管理' , router:'/home/userUploadCenter'},
              {id:9,  name:'淘货管理' , router:'/home/userBargain'}
            ],
          }
        },

        mounted(){
          this.indexAcativ = this.$route.id;
          //获取个人信息
          this.$ajax.post(this.request.axiosPort+this.request.axiosApi+'web/user/profile',{
              token:window.localStorage.getItem('token'),
          })
          .then((res) => {
              console.log(res)
              this.userinfo = res.data.data[0];
              this.avatar = this.request.picUrl+res.data.data[0].avatar;
          });
        },
        beforeCreate(to,from,next){

        },
        methods:{
          //实名认证
          handleAuthentication(){
            console.log('跳转认证')
            this.$router.push({
                path:'/idCardAuthentication',
                query:{
                  name:123
                }
              })
          },
          transmit(){
              this.$router.push({
                path:'/home/userEdit',
                query:{
                  name:this.userinfo.nickname,
                  code:this.userinfo.signature,
                  gender:this.userinfo.gender
                }
              })
          },
          headerNameClick(index){
            this.indexAcativ = index;
            window.sessionStorage.setItem('tabId',index);
            this.sessionId = index;
          },
        },


    }

</script>

<style lang="less">
  /* .max-min-width{
    max-width: 1400px;
    min-width: 960px;
    margin: 0 auto;
  }; */
  .information{
    background-color: #fff;
    box-shadow: 1px 1px 5px 2px rgba(34,24,21,.16);
    margin-bottom: 20px;
    margin-top: 0;
  }

  .information_top_bg{
    height: 200px;
    background-color: #eee;
    position: relative;
  }
  @media screen and (max-width: 1200px) {
        .width_1200{
            width: 960px;
            margin: 20px auto;
        }
        .expressInfo{
          width: 390px;
          /* height: 85px; */
          background-color: #f4f4f4;
          cursor: pointer;
          font-size: 12px;
          color: #666;
          padding: 10px;
          position: relative;
        }
        .information{
          margin-top: 0;
        }
    }

  .information_top_bg_img:hover .corner {
    width: 45px;
    height: 45px;
  }
  .information_top_bg_img:hover .corner:before,
  .information_top_bg_img:hover .corner:after {
    box-shadow: 0 24px 30px rgba(0, 0, 0, .3);
  }


  .information_top_bg_img:hover .information_bg_replace{
    animation: userReplace .5s forwards;
  }
  @keyframes userReplace {
    0%{
      opacity: 0;
    }
    15%{
      opacity: 0;
    }
    100%{
      opacity: 1;
    }
  }

  .information_top_bg_img{
    /* max-width: 1200px;
    min-width: 960px; */
    width: 100%;
    height: 200px;
    overflow: hidden;
    position: relative;

    .information_bg_replace{
      opacity: 0;
      position: absolute;
      right: 5px;
      top: 0;
      cursor: pointer;
      .icon{
        color: #ccc;
        transition: all .3s;
      }
      .icon:hover{
        color: #15bafe;
      }
    }


    .corner {
      width: 0;
      height: 0;
      position: absolute;
      top: 0;
      right: 0;
      background: linear-gradient( 225deg, #fff, #f3f3f3 45%, #ddd 50%, #aaa 50%, #bbb 56%, #ccc 62%, #f3f3f3 80%, #fff 100%);
      box-shadow: 0 0 10px rgba(30, 152, 225, .2);
      transition: all .5s ease;
    }
    .corner:before,
    .corner:after {
      content: '';
      position: absolute;
      z-index: -1;
      right: 12.5%;
      bottom: 5.8%;
      width: 70%;
      max-width: 300px;
      max-height: 100px;
      height: 55%;
      box-shadow: 0 12px 15px rgba(0, 0, 0, .3);
      transform: skew(10deg) rotate(6deg);
    }
    .corner:after {
      right: 5.8%;
      left: auto;
      bottom: auto;
      top: 14.16%;
      transform: skew(15deg) rotate(84deg);
    }

  }

  .information_top_bg:hover .information_file{
    display: block;
  }

  .information_file{
    display: none;
    position: absolute;
    right: 20px;
    top: 20px;
    width: 30px;
    height: 30px;
    background: url("/static/img/icon/information_img_modify.png") no-repeat;
    background-size: contain;
    border: none;
    opacity: 1;
    cursor: pointer;
  }
  .information_file input{
    opacity: 0;
    display: block;
    width: 100%;
    height: 100%;
  }
  .information_center_box{
    display: flex;
    justify-content: space-between;
    align-items: flex-end;
    height: 80px;
  }


  .information_center_left{
    display: flex;
    align-items: flex-end;
  }

  /*个人头像*/
  .user_avatar{
    width: 120px;
    height: 120px;
    border: 4px solid #fff;
    border-radius: 2px;
    display: flex;
    justify-content: center;
    align-items: center;
    margin-left: 25px;
    box-shadow: 1px 1px 5px 2px rgba(34,24,21,.16);
    background-color: #ccc;
    position: relative;
    z-index: 2;
  }
  .user_avatar img{
    width: 100%;
    height: 100%;
  }
  .user_box{
    display: inline-block;
    margin-left: 25px;
    position: relative;
  }

  .user_name{
    font-size: 26px;
    color: #37313f;
  }
  .user_introduction{
    font-size: 14px;
    height: 20px;
    color: #989898;
    margin-top: 10px;
    width: 550px;
    overflow: hidden;
    white-space: nowrap;
    text-overflow: ellipsis;
  }

  .user_introduction input{
    font-size: 14px;
    color: #000;
    width: 550px;
  }




  /*设置*/
  .information_center_right{
    width: 30px;
    height: 30px;
    margin-right: 30px;
  }




  .user_nav{
    padding: 0 30px;
    margin-top: 35px;
    overflow: hidden;
  }
  .user_nav ul{
    height: 45px;
    display: flex;
    align-items: flex-end;
    position: relative;
  }
  .user_nav ul li:hover a{
    transform: translate3d(0,40px,0);
  }
  .user_nav ul li{
    display: inline-block;
    font-size: 16px;
    color: #37313f;
    position: relative;
    overflow: hidden;

    .userNavLine{
      position: absolute;
      bottom: -2px;
      height: 2px;
      width: 100%;
      background-color: #15befe;
      transition: all .3s;
    }
  }
  .user_nav ul li:hover .userNavLine{
    bottom: 0 !important;
  }

  .router-link-active~.userNavLine{
    bottom: 0 !important;
  }

  .user_nav ul li:not(:last-child){
    margin-right: 35px;
  }
  .user_nav ul li a{
    display: block;
    padding: 0 5px 15px 5px;
    color: #000 ;
    height: 40px;
    overflow: hidden;
    transition: all ease-out .3s;
  }



  /*分页符*/
  .box_page{
    background-color: #fff;
    padding: 30px 0;
  }
  .box_page ul{
    display: flex;
    justify-items: center;
    align-items: center;
    width: 350px;
    margin: 0 0 0 auto;
  }

  .box_page .page_index{
    width: 12px;
    height: 15px;
  }

  .box_page .page_arrow_right,
  .box_page .page_arrow_left{
    width: 10px;
    height: 15px;
  }
  .box_page .page_arrow_right{
    transform: rotate(180deg);
  }

  .box_page ul li{
    border-radius: 2px;
    margin: 0 5px;
    font-size: 16px;
    width: 20px;
    height: 20px;
    text-align: center;
  }
  .box_page ul li a{
    color: #9d9d9d;
  }
  .box_page ul .active{
    background-color: #15bafe;
  }
  .box_page ul .active a{
    color: #fff;
  }


</style>
