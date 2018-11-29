<template>
    <div class="shopping_bg">

      <div class="edit width_1200">
        <div class="edit_head">
          <router-link to="userIndex">返回个人主页</router-link>
        </div>

        <div class="edit_box">
          <div class="edit_title">
            <p class="edit_title_cn"><span></span>基本信息</p><p class="edit_title_en">Basic Information</p>
          </div>

          <div class="edit_basic">
            <form>

              <!--头像-->
              <div class="edit_avatar">
                <p class="edit_box_title"><span><img src="/static/img/icon/userEdit_avatar.png" alt=""></span>头像</p>
                <div class="edit_avatar_box">
                  <el-upload
                    class="avatar-uploader"
                    action="http://test.kslab.com/api/article/null"
                    :show-file-list="false"
                    :on-success="handleAvatarSuccess"
                    :before-upload="beforeAvatarUpload">
                    <img v-if="imageUrl" :src="imageUrl" class="avatar">
                    <i v-else class="el-icon-plus avatar-uploader-icon"></i>
                  </el-upload>
              </div>
              </div>

              <!--昵称-->
              <div class="edit_name">
                <p class="edit_box_title"><span><img src="/static/img/icon/userEdit_userName.png" alt=""></span>昵称</p>

                <div class="edit_name_box">
                  <div v-if="noneUserName" class="edit_name_box_userName">
                    <p>{{this.username}}
                      <span>
                        <span @click="modify" >修改</span>
                      </span>
                    </p>
                  </div>

                  <div v-if="showUserName" class="showUserNameInput">
                    <div>
                      <input type="text" v-model="input_username" placeholder="请输入昵称">
                      <span><img src=""></span>
                    </div>
                    <div class="showUserNameInput_btm">
                      <span class="btm_false" @click="cancelModify"><span >取消</span></span>
                      <span class="btm_true" @click="seve">确认</span>
                    </div>
                  </div>


                </div>
              </div>


              <!--性别-->
              <div class="edit_sex">
                <p class="edit_box_title"><span><img src="/static/img/icon/userEdit_sex.png" alt=""></span>性别</p>

                <div class="edit_sex_box">
                  <el-radio v-model="radio" label="1" @change="consl">男</el-radio>
                  <el-radio v-model="radio" label="2" @change="consl">女</el-radio>
                  <el-radio v-model="radio" label="3" @change="consl">保密</el-radio>
                </div>
              </div>


              <!--签名-->
              <div class="edit_introduction">
                <p class="edit_box_title"><span><img src="/static/img/icon/userEdit_introduction.png" alt=""></span>签名</p>

                <div class="edit_intro_box">

                  <input type="text" placeholder="不超过20个汉字" v-model="userdescribe" @onchange="inpchange">
                  <span class="edit_errors"></span>
                </div>
              </div>

            </form>
          </div>


          <div class="edit_social">
            <div class="edit_title">
              <p class="edit_title_cn"><span></span>社交帐号绑定</p><p class="edit_title_en">Social account</p>
            </div>

            <div class="edit_social_box">
              <!--QQ-->
              <div class="edit_social_qq edit_social_main">
                <div class="edit_social_name">
                  <img src="/static/img/icon/footer_qq.png" alt="">
                  <div class="edit_social_text">QQ</div>
                </div>

                <div class="edit_social_status" >
                  <span v-if="qq_state">QQ账号</span>
                  <span v-if="qq_state">{{bindData.qq}}</span>
                  <span v-if="!qq_state">未绑定</span>
                </div>

                <div class="edit_social_modify">
                  <p v-if="!qq_state" style="color: #fff;background: #827f7f;border: 1px solid #827f7f;" @click="bindQq">绑定</p>
                  <p v-if="qq_state">修改</p>
                  <span v-if="qq_state" @click="unbindQq">取消绑定</span>
                  
                </div>
              </div>

              <!--支付宝-->
              <div class="edit_social_weibo edit_social_main">
                <div class="edit_social_name">
                  <img src="/static/img/icon/Alipay.png" alt="" style="border-radius: 50%;">
                  <div class="edit_social_text">支付宝</div>
                </div>

                <div class="edit_social_status">
                  <span v-if="alip_state">支付宝账号</span>
                  <span v-if="alip_state">王超超</span>
                  <span v-if="!alip_state">未绑定</span>
                </div>

                <div class="edit_social_modify">
                  <p v-if="!alip_state" style="color: #fff;background: #827f7f;border: 1px solid #827f7f;" @click="bindAlip">绑定</p>
                  <p v-if="alip_state">修改</p>
                  <span v-if="alip_state" @click="unbindAlip">取消绑定</span>
                  
                </div>
              </div>

              <!--微信-->
              <div class="edit_social_WeChat edit_social_main">
                <div class="edit_social_name">
                  <img src="/static/img/icon/wechar_block.png" alt="">
                  <div class="edit_social_text">微信</div>
                </div>

                <div class="edit_social_status">
                  <span v-if="wx_state">微信账号</span>
                  <span v-if="wx_state">李超超</span>
                  <span v-if="!wx_state">未绑定</span>
                </div>

                <div class="edit_social_modify">
                  <p v-if="!wx_state" style="color: #fff;background: #827f7f;border: 1px solid #827f7f;" @click="bindWx">绑定</p>
                  <p v-if="wx_state">修改</p>
                  <span v-if="wx_state" @click="unbindWx">取消绑定</span>
                  
                </div>
              </div>

            </div>


          </div>

        </div>
        <div class="userEdit_bottom">
          <router-link to="userIndex" class="userEdit_bottom_btm">取消</router-link>
          <p class="userEdit_bottom_btm" @click="userClick">保存</p>
        </div>

      </div>

      <!--侧边悬浮框-->
      <floating-div></floating-div>
    </div>
</template>

<script>
  import FloatingDiv from "@/components/floating"
  import userInfoHeaderDiv from "@/components/userInfoHeader"
  import myUpload from 'vue-image-crop-upload';
  export default {
    data(){
      return{
        qq_state:false,
        wx_state:false,
        alip_state:false,
        imageUrl: '',
        input_username:'',//输入的昵称
        userdescribe:'',
        usergender:'',
        username:'',
        show: false,
        userNameSeve:'',
        noneUserName: true,
        inputUserName:'123',
        showUserName:false,
        radio: 2,
        bindData:null,//绑定账号的数据
      }
    },
    components:{
      FloatingDiv,
      userInfoHeaderDiv,
      myUpload
    },
    created(){
      if(this.$route.query.name){
        this.transfer();
         this.$ajax.post(this.request.axiosPort+this.request.axiosApi+'web/user/profile',{
            token:window.localStorage.getItem('token'),
        })
        .then((res) => {
            console.log(res)
            this.imageUrl = this.request.picUrl+res.data.data[0].avatar;
        });
      }else{
        //判断是否是页面跳转进入 不是的话就获取个人信息
        this.$ajax.post(this.request.axiosPort+this.request.axiosApi+'web/user/profile',{
            token:window.localStorage.getItem('token'),
        })
        .then((res) => {
            console.log(res)
            this.imageUrl = this.request.picUrl+res.data.data[0].avatar;
            this.radio = res.data.data[0].gender.toString(),
            this.userdescribe = res.data.data[0].signature
        });
      }
      //获取绑定信息
      this.getUserInfo();

    },
    methods: {
      //获取用户个人资料（绑定信息）
      getUserInfo(){
        this.$ajax.post(this.request.axiosPort+this.request.axiosApi+'user/userInfo',{
            token:window.localStorage.getItem('token'),
        })
        .then((res) => {
          console.log(res)
          this.bindData = res.data.data;
          if(res.data.data.qq === ''){ //判断是否绑定QQ，绑定状态为true
            this.qq_state = false;
          }else{
            this.qq_state = true;
          }
          if(res.data.data.weChat === ''){ //判断是否绑定微信，绑定状态为true
            this.wx_state = false;
          }else{
            this.wx_state = true;
          }
          if(res.data.data.alipay === ''){ //判断是否绑定支付宝，绑定状态为true
            this.alip_state = false;
          }else{
            this.alip_state = true;
          }

        })
      },
      /////////////////////////////////////////测试代码，可删
      consl(){
        console.log(this.radio)
      },
      ////////////////////////
      inpchange(){
        console.log(this.userdescribe)
      },
      //点击修改
      modify(){
        console.log(this.username)
        this.input_username = this.username;
        this.noneUserName = !this.noneUserName
        this.showUserName = ! this.showUserName;
      },
      //取消修改
      cancelModify(){
        this.username = this.input_username
        this.noneUserName = !this.noneUserName;
        this.showUserName = !this.showUserName
      },
      // 保存修改昵称
      seve(){
        this.username = this.input_username;
        this.showUserName = !this.showUserName;
        this.noneUserName = !this.noneUserName;
      },
      transfer(){
        this.username = this.$route.query.name;
        this.userdescribe = this.$route.query.code;
        this.radio = this.$route.query.gender.toString();
      },
      userClick(){
        console.log(this.username,this.userdescribe,this.radio)
        this.$ajax.post(this.request.axiosPort+this.request.axiosApi+"user/userInfoUpdate",{ 
            token:window.localStorage.token,
            nickname:this.username,
            signature:this.userdescribe,
            gender:parseInt(this.radio)
          })
          .then((res) => {
            console.log(res)
          })
      },
      handleAvatarSuccess(res, file) {
        this.imageUrl = URL.createObjectURL(file.raw);
      },
      beforeAvatarUpload(file){
                console.log(file)
                // console.log(file)
                // console.log(this.bkID)
                // const isLt5M = file.size / 1024 / 1024 < 5;
                // if (!isLt5M) {
                //     this.$message.error('上传文件大小不能超过5M!')
                //     return false;
                // }
              var FromData = new FormData()
              var dataNuberm = Number(new Date())+1;
              //头像上传图片接口
              FromData.append('token', window.localStorage.token)
              FromData.append('images', file)
              FromData.append('serial_number',dataNuberm)
              FromData.append('type',1)
              this.$ajax.post(this.request.axiosPort + this.request.axiosApi + 'updateAvatar', FromData)
                .then((res) => {
                    console.log(res)
                  if (res.data.code === 200) {
                    this.$message.success(res.data.msg)
                    return true
                  } else {
                    this.$message.error(res.data.msg)
                    console.log(res.data.msg)
                    return false
                  }
                })
        },
        bindQq(){ //绑定QQ
           this.$ajax.post('http://server.kushualab.com/api/qqLogin',{
          })
          .then((res) => {
              console.log(res)     
              if(res.data.code === 200){
                this.$message.success(res.data.msg)
                console.log(res.data.data.url)
                window.location.href = res.data.data.url;
              }else{
                this.$message.error(res.data.msg)
              }   
          })
        },
        unbindQq(){  //取消绑定qq
          this.$ajax.post(this.request.axiosPort + this.request.axiosApi + 'user/unBindSocial',{
              token:window.localStorage.token,
              type:'qq'
          })
          .then((res) => {
              console.log(res)     
              if(res.data.code === 200){
                this.$message.success(res.data.msg)
                this.getUserInfo();
              }else{
                this.$message.error(res.data.msg)
              }   
          })
        },
        bindWx(){ //绑定微信
           this.$ajax.post('http://server.kushualab.com/api/weChatLogin',{
          })
          .then((res) => {
              console.log(res)     
              if(res.data.code === 200){
                this.$message.success(res.data.msg)
                console.log(res.data.data.url)
                window.location.href = res.data.data.url;
              }else{
                this.$message.error(res.data.msg)
              }   
          })
        },
        unbindWx(){  //取消绑定微信
          this.$ajax.post(this.request.axiosPort + this.request.axiosApi + 'user/unBindSocial',{
              token:window.localStorage.token,
              type:'weChat'
          })
          .then((res) => {
              console.log(res)  
              if(res.data.code === 200){
                this.$message.success(res.data.msg)
                this.getUserInfo();
              }else{
                this.$message.error(res.data.msg)
              }         
          })
        },
        bindAlip(){ //绑定支付宝
           this.$ajax.post('http://server.kushualab.com/api/alipayLogin',{
          })
          .then((res) => {
              console.log(res)     
              if(res.data.code === 200){
                this.$message.success(res.data.msg);
                console.log(res.data.data.url)
                window.location.href = res.data.data.url;
              }else{
                this.$message.error(res.data.msg)
              }   
          })
        },
        unbindAlip(){  //取消绑定支付宝
          this.$ajax.post(this.request.axiosPort + this.request.axiosApi + 'user/unBindSocial',{
              token:window.localStorage.token,
              type:'alipay'
          })
          .then((res) => {
              console.log(res) 
              if(res.data.code === 200){
                this.$message.success(res.data.msg)
                this.getUserInfo();
              }else{
                this.$message.error(res.data.msg)
              }          
          })
        },

    },
    
  }
</script>

<style scoped src="../../assets/css/userEdit.css"></style>
<style scoped>
.avatar-uploader .el-upload {
    border: 1px dashed #d9d9d9;
    border-radius: 6px;
    cursor: pointer;
    position: relative;
    overflow: hidden;
  }
  .avatar-uploader .el-upload:hover {
    border-color: #409EFF;
  }
  .avatar-uploader-icon {
    font-size: 28px;
    color: #8c939d;
    width: 178px;
    height: 178px;
    line-height: 178px;
    text-align: center;
  }
  .avatar {
    width: 110px;
    height: 110px;
    display: block;
    border-radius: 50%;
  }
</style>

