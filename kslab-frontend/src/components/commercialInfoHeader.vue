<template>
  <div class="information width_1200">
    <!--个人资料背景-->
    <div class="information_top_bg">
      <div class="information_top_bg_img">
        <img id="result" src="/static/img/user_background.jpg" alt="">

        <div class="corner">
          <div class="information_bg_replace" @click="dialogVisible = true">
            <i class="icon icon-tianjiatupian"></i>
          </div>
        </div>

      </div>
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


    <!--个人资料-->
    <div class="information_center_box">
      <div class="information_center_left">
        <div class="user_avatar">
          <img  id="userResult" :src="request.picUrl+info.avatar+'?imageView2/1/w/160/h/160'" alt="">
        </div>
        <div class="user_box">
          <div class="user_name">{{info.nickname}}</div>
          <div class="user_introduction">{{info.signature}}</div>
        </div>
      </div>
      <!--设置--> <!--userEdit-->
      <div class="information_center_right">
        <el-dropdown trigger="click">
          <img src="/static/img/icon/setting.png" alt="">
          <el-dropdown-menu slot="dropdown">
            <router-link :to="{ name: '', params: {} }">
              <el-dropdown-item>修改密码</el-dropdown-item>
            </router-link>
            <router-link to="/home/merchantInfo">
              <el-dropdown-item>修改基本信息</el-dropdown-item>
            </router-link>
            <router-link to="/home/companyIntroduction">
              <el-dropdown-item>修改公司信息</el-dropdown-item>
            </router-link>
          </el-dropdown-menu>
        </el-dropdown>
      </div>
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
  </div>

</template>

<script>
  export default {
    name: "commercialInfoHead",
    data(){
      return {
        info:{},
        dialogVisible: false, //修改背景框

        // 导航栏
        headerName:[
          {id:1, name:'HOME' , router:'/home/commercialIndex'},
          {id:2,  name:'仓库' , router:'/home/merchantWarehouse'},
          {id:3,  name:'活动' , router:'/home/commercial-activity'},
          {id:4,  name:'服务' , router:'/home/commercial-service'},
          {id:5,  name:'收入' , router:'/home/merchantIncome'},
          {id:6,  name:'对话' , router:'/home/merchantKsChat'},
          {id:7,  name:'上传管理' , router:'/home/uploadManage'},
        ],
      }
    },
    mounted() {
      this.indexAcativ = this.$route.id;
    },
    created(){
      this.HttpClient.post('/web/user/profile')
        .then(res =>{
          console.log(res);
          if(res.data.code === 200){
            this.info = res.data.data[0];
            console.log(this.info);
          }
        })
    },
    methods:{
      headerNameClick(index){
        this.indexAcativ = index;
        window.sessionStorage.setItem('tabId',index);
        this.sessionId = index;
      },
    },
  }
</script>

<style lang="less">
    .information_center_left{
        display: flex;
        align-items: flex-end;
    }


  .information{
    background-color: #fff;
    box-shadow: 1px 1px 5px 2px rgba(34,24,21,.16);
    margin-bottom: 30px;
    margin-top:0!important;
  }

  .information_top_bg{
    height: 200px;
    background-color: #eee;
    position: relative;
  }

  .information_top_bg_img{
    max-width: 1200px;
    height: 200px;
    overflow: hidden;
  }
  .information_top_bg_img img{
    width: 100%;
    height: 100%;
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




    .information_center_box{
    display: flex;
    justify-content: space-between;
    align-items: flex-end;
    height: 80px;
  }


  /*个人头像*/
  .user_avatar{
    width: 170px;
    height: 170px;
    border: 5px solid #fff;
    border-radius: 2px;
    display: inline-block;
    margin-left: 45px;
    box-shadow: 1px 1px 5px 2px rgba(34,24,21,.16);
    background-color: #ccc;
    position: relative;
    z-index: 2;
  }
  .user_avatar img{
    width:100%;
    height: 100%;
  }

  /*个人头像上传*/
  .user_avatar:hover .user_avatar_file{
    display: block;
  }
  .user_avatar_file{
    width: 20px;
    height: 20px;
    background: url("/static/img/icon/information_img_modify.png") no-repeat;
    background-size: contain;
    position: absolute;
    right: 10px;
    top: 10px;
    display: none;
    cursor: pointer;
  }
  .user_avatar_file input{
    opacity: 0;
    display: block;
    width: 100%;
    height: 100%;
  }

  .user_avatar_file_mode{
    display: none;
    width: 250px;
    height: 250px;
    position: absolute;
    left: 200px;
    top: 0;
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
  }
    .user_nav ul li:hover a{
      transform: translate3d(0,40px,0);
    }
  .user_nav ul li{
    display: inline-block;
    font-size: 16px;
    color: #37313f;
    overflow: hidden;
    position: relative;

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
    /*border-bottom: 2px solid #fff;*/
    color: #000 ;
    height: 40px;
    overflow: hidden;
    transition: all ease-out .3s;
  }
  .user_nav .router-link-active{
    /*border-bottom: 2px solid #15bafe !important;*/
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
