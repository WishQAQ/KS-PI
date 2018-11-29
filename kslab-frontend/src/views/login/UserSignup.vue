<template>
    <div class="signUp">
      <!--注册背景-->
      <div class="signUp_background"></div>
      <!--注册框-->
      <div class="signUp_box">
        <!--个人注册-->
        <div class="userSignUp signUp_main" v-if="userSignUp">
          <div class="title">
            <div class="title_name"><i class="icon icon-ziyuan19"></i><span>账号注册</span></div>
            <div class="cutover" @click="userSignUp = ! userSignUp"><i class="icon icon-gongsi"></i><span>公司注册</span></div>
          </div>
          <!--基本信息-->
          <div class="signUp_basic">
            <div class="signUp_basic_title">
              <span></span>
              <p>基本信息</p>
              <i></i>
            </div>
            <!--账号-->
            <div class="basic_list">
              <div class="basic_list_title">账号</div>
              <div class="basic_list_input">
                <el-input class="list_input" v-model="userAccount"></el-input>
                <p class="loginPrompt">账号用于登录，不超过12位，只能为英文和数字，不分大小写</p>
              </div>
            </div>
            <!--密码-->
            <div class="basic_list">
              <div class="basic_list_title">登陆密码</div>
              <div class="basic_list_input">
                <el-input type="password" v-model="passwordUser" class="list_input"></el-input>
                <p class="loginPrompt">6-12位，且包含英文、大写、小写以及数字</p>
              </div>
            </div>
            <!--确认密码-->
            <div class="basic_list">
              <div class="basic_list_title">确认密码</div>
              <div class="basic_list_input">
                <el-input type="password" v-model="passwordCont" class="list_input"></el-input>
              </div>
            </div>
          </div>
          <!--手机信息-->
          <div class="signUp_basic">
            <div class="signUp_basic_title">
              <span></span>
              <p>手机信息</p>
              <i></i>
            </div>
            <!--手机号码-->
            <div class="basic_list basic_list_phoneNumber">
              <div class="basic_list_title">手机号码</div>
              <div class="basic_list_input">
                <el-select v-model="select" class="phoneNumber_select">
                  <el-option label="+86" value="1"></el-option>
                  <el-option label="+1" value="2"></el-option>
                  <el-option label="+30" value="3"></el-option>
                </el-select>

                <el-input class="phoneNumber_input" v-model="templateNumber"></el-input>

              </div>
            </div>
            <!--验证码-->
            <div class="basic_list">
              <div class="basic_list_title">验证码</div>
              <div class="basic_list_input basic_list_code">
                <el-input class="code_input" v-model="temCode"></el-input>
                <div class="code_btm" @click="phoneNote">发送短信验证码</div>
              </div>
            </div>
          </div>

          <!--确认取消按钮-->
          <div class="signUpBtm">
            <router-link to="/login" class="cancel">取消</router-link>
            <div class="submit" @click="userClick">提交</div>
          </div>
        </div>

        <!--公司注册-->
        <div class="companySignUp signUp_main" v-else>
          <div class="title">
            <div class="title_name"><i class="icon icon-gongsi"></i><span>公司注册</span></div>
            <div class="cutover" @click="userSignUp = ! userSignUp"><i class="icon icon-ziyuan19"></i><span>个人注册</span></div>
          </div>
          <!--基本信息-->
          <div class="signUp_basic">
            <div class="signUp_basic_title">
              <span></span>
              <p>基本信息</p>
              <i></i>
            </div>
            <!--账号-->
            <div class="basic_list license_margin">
              <div class="basic_list_title">账号</div>
              <div class="basic_list_input">
                <el-input class="list_input" v-model="companyName"></el-input>
                <p class="loginPrompt">账号用于登录，不超过12位，只能为英文和数字，不分大小写</p>
              </div>
            </div>
            <!--手机号码-->
            <div class="basic_list basic_list_phoneNumber">
              <div class="basic_list_title">联系电话</div>
              <div class="basic_list_input">
                <el-select v-model="select" class="phoneNumber_select">
                  <el-option label="+86" value="1"></el-option>
                  <el-option label="+1" value="2"></el-option>
                  <el-option label="+30" value="3"></el-option>
                </el-select>

                <el-input class="phoneNumber_input" v-model="companyTemp"></el-input>

              </div>
            </div>
            <!--密码-->
            <div class="basic_list license_margin">
              <div class="basic_list_title">登陆密码</div>
              <div class="basic_list_input">
                <el-input type="password" class="list_input" v-model="companyPassword"></el-input>
                <p class="loginPrompt">6-12位，且包含英文、大写、小写以及数字</p>
              </div>
            </div>
            <!--确认密码-->
            <div class="basic_list">
              <div class="basic_list_title" >确认密码</div>
              <div class="basic_list_input">
                <el-input type="password" v-model="companyCont" class="list_input"></el-input>
              </div>
            </div>
          </div>
          <!--企业资料-->
          <div class="signUp_basic">
            <div class="signUp_basic_title">
              <span></span>
              <p>企业资料</p>
              <i></i>
            </div>
            <!--企业名称-->
            <div class="basic_list license_margin">
              <div class="basic_list_title">企业名称</div>
              <div class="basic_list_input">
                <el-input class="list_input" v-model="companyContName"></el-input>
                <p class="loginPrompt">工商注册登记全称</p>
              </div>
            </div>
            <!--工商执照-->
            <div class="basic_list license_list">
              <div class="basic_list_title">工商执照</div>
              <div class="basic_list_input basic_list_license">
                <p class="license_message">请上传高清彩色原件，图片不能超过10mb</p>
                <div class="license_box">

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
            </div>
          </div>

          <!--确认取消按钮-->
          <div class="signUpBtm companySignUpBtm">
            <router-link to="/login" class="cancel">取消</router-link>
            <div class="submit" @click="RouterCompany">提交</div>
          </div>
        </div>
      </div>


    </div>
</template>

<script>
// import '../../assets/js/login'
export default {
    data(){
      return{
        select : '1',
        userSignUp : true,
        imageUrl: '',
        userAccount:null,    //用户账号
        passwordUser:null,    //用户密码
        passwordCont:null,     //用户密码确定
        templateNumber:null,   //手机号码
        temCode:null,           //验证码
        tirget:null,             //验证头部转换
        companyName:null,        //公司账号
        companyTemp:null,       //公司联系电话
        companyPassword:null,    //公司密码
        companyCont:null,        //公司确认密码
        companyContName:null,    //公司名称
        serial_number:Number(new Date())  //上传公司附件批次号
      }
    },
  methods:{
    /*
      公司注册
    */
    RouterCompany(){
      this.HttpClient.post('/reg/company',{
        name:this.companyContName,
        telphone:this.companyTemp,
        username:this.companyName,
        password:this.companyPassword,
        country_code:"+86",
        serial_number	:this.serial_number
      })
      .then((res) => {
        this.stipulateRemind(res)
        if(res.data.code == 200){
          this.$router.push({
            path:'/'
          })
        }
      })
    },
    /*
      验证码接收
    */
    phoneNote(){
      this.HttpClient.post('/user/captcha',{
        phone:this.templateNumber
      })
      .then((res) => {
        const str = res.headers['cache-control']
        this.tirget = str.split(':')[1]

        this.tirget = this.tirget.replace(", no-cache, private",'')

      })
    },
    /*
      判断俩次密码是否一致，true提交
    */
    userClick(){
      if(this.passwordUser == this.passwordCont){

        this.HttpClient.post('/user/register',{
          username:this.userAccount,
          phone:this.templateNumber,
          password:this.passwordUser,
          captcha:this.temCode,
          rediskey:this.tirget
        })
        .then((res) => {
          console.log(res)
        })
      }else{
        this.$message.error("两次输入密码不对哦");
      }
    },
    /*
      上传营业执照
    */
    handleAvatarSuccess(res, file) {
      console.log(file)
      this.imageUrl = URL.createObjectURL(file.raw);
    },
    beforeAvatarUpload(file) {
      console.log(file)
      const isJPG = file.type === 'image/jpeg';
      const isLt2M = file.size / 1024 / 1024 < 2;

      if (!isJPG) {
        this.$message.error('上传执照原件照片只能是 JPG 格式!');
      }
      else if (!isLt2M) {
        this.$message.error('上传执照原件照片大小不能超过 2MB!');
      }
      else{
        var a = new FormData()
        a.append("serial_number",this.serial_number)
        a.append("images",file)
        this.$ajax.post(this.request.axiosPort + this.request.axiosApi +'reg/uploadTestImg',a)
        .then((res) => {
          if(res.data.code == 200){
            this.$message({
              message:res.data.msg ,
              type: 'success'
            });
          }else{
            this.$message({
              message: res.data.msg,
              type: 'warning'
            });
          }
        })
      }
      return isJPG && isLt2M;
    }
  }
}

</script>

<style lang="less">
  /*用户注册*/
  .signUp{
    min-width: 980px;
    width: 100vw;
    height: 100vh;
    display: flex;
    justify-content: center;
    align-items: center;
    overflow: hidden;
    background-color: #fff;
    position: relative;

    /*背景*/
    .signUp_background{
      background: url("/static/img/signupBackground.png") no-repeat center center;
      background-size: cover;
      width: 100vw;
      height: 630px;
      min-width: 980px;
      position: fixed;
    }

    /*注册框*/
    .signUp_box{
      display: flex;
      justify-content: flex-end;
      align-items: center;
      z-index: 10;
      position: relative;
      width: 100vw;
      height: 100vh;
      max-width: 1200px;
      min-width: 980px;

      /*注册盒子*/
      .signUp_main{
        background-color: #fff;
        width: 540px;
        margin-right: 40px;
        height: 700px;
        overflow: auto;
        box-shadow: 0 0 5px 1px rgba(0,0,0,.2);
        padding-top: 30px;

        /*标题*/
        .title{
          display: flex;
          justify-content: space-between;
          align-items: center;
          margin-bottom: 40px;
          .title_name{
            background: linear-gradient(to right, #87dbfd,#15bafe);
            width: 140px;
            height: 40px;
            display: flex;
            justify-content: center;
            align-items: center;
            border-top-right-radius: 8px;
            border-bottom-right-radius: 8px;
            box-shadow: 0 2px 6px 1px rgba(0, 0, 0, 0.3);
            .icon{
              font-size: 16px;
              color: #fff;
            }
            span{
              font-size: 18px;
              color: #fff;
              margin-left: 5px;
            }
          }
          .cutover{
            margin-right: 20px;
            display: flex;
            align-items: center;
            cursor: pointer;
            .icon{
              font-size: 19px;
              color: #999;
            }
            span{
              text-decoration: underline;
              margin-left: 10px;
              font-size: 14px;
              color: #999;
            }
          }
        }

        /*注册列表 - 基本信息*/
        .signUp_basic:not(:last-child){
          margin-bottom: 30px;
        }
        .signUp_basic{
          padding: 0 25px;
          /*标题*/
          .signUp_basic_title{
            display: flex;
            align-items: center;
            margin-bottom: 35px;
            span{
              width: 5px;
              height: 20px;
              display: inline-block;
              background: #15befe;
              margin-right: 10px;
            }
            p{
              font-size: 14px;
              color: #000;
              margin-right: 10px;
            }
            i{
              display: inline-block;
              height: 1px;
              background: #f2f2f2;
              flex: 1;
            }
          }

          /*列表*/
          .basic_list{
            display: flex;
            justify-content: center;
            align-items: flex-start;
            padding-bottom: 25px;
            position: relative;
            /*标题*/
            .basic_list_title{
              height: 30px;
              width: 60px;
              line-height: 30px;
              text-align: justify;
              margin-right: 15px;
              color: #010101;
              font-size: 12px;
            }
            .basic_list_title:after{
              content: " ";
              display: inline-block;
              width: 100%;
            }
            /*输入框*/
            .basic_list_input{
              .list_input{
                width: 230px;
                .el-input__inner{
                  height: 30px;
                  line-height: 30px;
                }
              }
              .loginPrompt{
                position: absolute;
                font-size: 12px;
                color: #999;
                white-space:nowrap;
                margin-top: 5px;
              }
            }
          }

          /*区号 - 手机号*/
          .basic_list_phoneNumber{
            /*输入框*/
            .basic_list_input{
              width: 230px;
              display: flex;
              align-items: center;
              /*下拉清除样式*/
              .phoneNumber_select{
                width: 120px;
                margin-right: 5px;
                .el-input__inner{
                  height: 30px;
                  line-height: 30px;
                  padding: 0 10px;
                  border: none;
                  background: #f2f2f2;
                  color: #666;
                }
                .el-input__icon{
                  line-height: 30px;
                  color: #242424;
                }
              }
              /*手机号输入框*/
              .phoneNumber_input{
                .el-input__inner{
                  height: 30px;
                  line-height: 30px;
                }
              }
            }
          }
          /*验证码*/
          .basic_list_code{
            width: 230px;
            display: flex;
            align-items: center;
            /*验证码输入框*/
            .code_input{
              flex: 1;
              .el-input__inner{
                height: 30px;
                line-height: 30px;
              }
            }
            /*验证码按钮*/
            .code_btm{
              margin-left: 5px;
              border-radius: 5px;
              display: flex;
              justify-content: center;
              align-items: center;
              height: 30px;
              cursor: pointer;
              background: #15befe;
              color: #fff;
              flex: 1;
            }
          }
        }

        /*按钮*/
        .signUpBtm{
          display: flex;
          justify-content: center;
          align-items: center;
          margin-top: 50px;
          .cancel,
          .submit{
            width: 100px;
            height: 30px;
            border: 1px solid #15befe;
            border-radius: 5px;
            display: flex;
            justify-content: center;
            align-items: center;
            margin: 0 15px;
            font-size: 14px;
            cursor: pointer;
          }
          .cancel{
            color: #15befe;
          }
          .submit{
            background: #15befe;
            color: #fff;
          }
        }
      }

      /*个人注册*/
      .userSignUp{
        /*列表间距*/
        .basic_list{
          margin-bottom: 10px;
        }
      }

      /*公司注册*/
      .companySignUp{
        /*标题icon大小*/
        .title{
          margin-bottom: 15px !important;
          .title_name{
            background: url("/static/img/icon/companySignUp_title.png") no-repeat;
            background-size: 100% 100%;
            .icon{
              font-size: 20px;
            }
          }
        }
        .signUp_basic:not(:last-child){
          margin-bottom: 0 !important;
        }
        .signUp_basic{
          .license_margin{
            margin-bottom: 10px;
          }

          .signUp_basic_title{
            margin-bottom: 10px !important;
          }
          .license_list{
            .basic_list_title{
              line-height: unset !important;
            }

            .basic_list_license{
              /*工商执照说明*/
              .license_message{
                font-size: 12px;
                color: #999;
              }
              /*工商执照上传框*/
              .license_box{
                margin-top: 10px;
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
                  width: 230px;
                  height: 130px;
                  line-height: 130px;
                  text-align: center;
                }
                .avatar {
                  width: 230px;
                  display: block;
                }
              }
            }
          }
        }

      }
      .companySignUpBtm{
        margin-top: 0 !important;
      }
    }




  }


</style>
