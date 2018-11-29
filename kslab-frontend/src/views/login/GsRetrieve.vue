<template>
    <div class="BodyBack">
      <div class="bodyBack_bg"></div>
      <div class="Company">
        <form class="Form_Company" action="1.html" method="post">
          <div class="Title_Company">
            <a href="javascript:history.go(-1)">
              <img src="/static/img/icon/leftcont.png" alt="">
              <span>|</span>
            </a>
          </div>
          <div class="Title_Company_two">
            <div><span></span>公司注册</div>
          </div>

          <div class="retrieve_box">
            <div class="Title_Company_tree">
              <label class="Float_input">
                <div>
                  <img src="/static/img/icon/gs_user.png" alt="" class="Fuc-img-matop">
                </div>
                <input class="User_input" type="text" placeholder="公司名字" v-model="name">
              </label>

              <label class="Float_input">
                <div>
                  <img src="/static/img/icon/gs_iphone.png" alt="" class="Fuc-img-matop">
                </div>
                <input class="User_input" type="text" placeholder="电话" v-model="telphone">
              </label>

              <label class="Float_input">
                <div>
                  <img src="/static/img/icon/gs_userz.png" alt="" class="Fuc-img-matop">
                </div>
                <input class="User_input" type="text" placeholder="帐号" v-model="nicename">
              </label>

              <label class="Float_input">
                <div>
                  <img src="/static/img/icon/gs_js.png" alt="" class="Fuc-img-matop">
                </div>
                <input class="User_input" type="password" placeholder="密码" v-model="password">
              </label>
              <label class="Float_input">
                <div>
                  <img src="/static/img/icon/gs_paswrd.png" alt="" class="Fuc-img-matop">
                </div>
                <input class="User_input" type="password" placeholder="确认密码" v-model="conPassword">
              </label>

            </div>


            <!--百度UEditor-->
            <div class="Fuc-Div-title">
              <!---图片展示上传-->
              <div class="Fuc-Img-cont">
                <img src="/static/img/icon/imges.png" alt="">
                <span>工商执照</span>
                <div class="kv-main">
                  <br>
                  <upload-main :axiosHTTP="axiosHTTP" @TransmitModule="transmitmodule"></upload-main>
                </div>
              </div>
            </div>

          </div>


          <div class="retrieve_btm">
            <div class="retrieve_cancel">取消</div>
            <div class="retrieve_determine" @click="enterpriseSubmit">确定</div>
          </div>
        </form>
      </div>
    </div>
</template>

<script>
import UploadMain from '@/views/upload/uploadingMainImg'
import '../../assets/js/login.js'
export default {
  data(){
    return{
      name:"",     //公司名称
      telphone:"",     //手机号
      nicename:"",     //账号
      password:"",     //密码
      conPassword:"",  //确认密码
      source:"",        //公司执照
      axiosHTTP:this.request.axiosPort+this.request.axiosApi+'uploadLicense',     //上传接口
      license:''
    }
  },
  components:{
    UploadMain
  },
  methods:{
    enterpriseSubmit(){
      this.$ajax.post(this.request.axiosPort+this.request.axiosApi+'reg/company',{   //分装aioxs,此处为ajax请求。
          name:this.name,
          telphone:this.telphone,
          nicename:this.nicename,
          password:this.password,                       //需要传递的参数
          conPassword:this.conPassword,
          license:this.license          //this.source
      })
      .then((res)=>{
        console.log(res)              //成功后返回
        this.$message({
          message: res.data.msg+'，请耐心等待管理员审核',
          type: 'success'
        });
        window.localStorage.token = res.data.data.token
        this.$store.commit('USERTOKEN',res.data.data.token)
        this.$router.push({
          path:'/'
        })
      })
      .catch((err)=>{
        console.log(err)              //失败后返回
      })
    },
    transmitmodule(msg){
      this.license = msg
      console.log(this.license)
    }
  },
}
</script>

<style scoped src="../../assets/css/GsRetrieve.css"></style>
<style>
.Fuc-Img-cont>.kv-main>.uploading_main_img>.uploading_img_box>.el-upload-list>.el-upload-list__item{
  width: 100%;
  height: 210px !important;
}
  body,html{
    height: 100%;
  }
body{
  max-width:100%;
  position: relative;
  display: block;
}
.Fuc-Img-cont>.kv-main>.uploading_main_img>.uploading_img_box>.el-upload-list{
  position: absolute;
  z-index: 99999 !important;
  top:0px;
}
.Fuc-Img-cont>.kv-main>.uploading_main_img>.main_head{
  display: none !important;
}
.Fuc-Img-cont>.kv-main>.uploading_main_img>.uploading_img_box{
  width:100%;
}

.retrieve_box .el-upload--picture-card{
  border: none;
}

.retrieve_box .el-upload-dragger{
  width: 260px !important;
  height: 210px !important;
  line-height: normal !important;
}
  .retrieve_box .uploading_tips{
    height: 100% !important;
  }
  .retrieve_box .el-upload--picture-card i {
    padding-top: 80px !important;
  }
  .retrieve_box .el-upload__txt{
    padding-top: 95px !important;
  }
</style>
