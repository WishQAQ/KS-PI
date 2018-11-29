<template>
  <div class="UserLoginLogin">
    <div class="quickRegistration">
      <div class="backBtm"><i @click="handleBack" class="icon icon-huaban10"></i></div>
      <div class="content_box">
        <div class="title"><span></span>绑定手机</div>

        <!--手机号-->
        <div class="login_input">
          <div class="User_Input">
            <i class="icon icon-huaban13"></i>
            <el-input
              placeholder="输入手机号"
              v-model="phone"
              @blur="loginLineCloneUser"
              @focus="loginUser"
              clearable>
            </el-input>
            <!--<input name="AccountInput" type="text" placeholder="手机号/账号" v-model="ThisPlaceholderUser" />-->
          </div>
          <div class="login_input_line">
            <span :class="{loginInputLineUser : loginInputLIneUser,loginInputLineCloneUser : loginInputLIneCloneUser}"></span>
          </div>
        </div>

        <!--密码-->
        <!--<div class="login_input login_password">
          <div class="User_Input">
            <i class="icon icon-ai-password"></i>
            <el-input
              name="PasswrodInput"
              type="password"
              placeholder="输入密码"
              @blur="loginLineClone"
              @focus="loginPassword"
              @keyup.enter.native="ClickSubit"
              v-model="newPassword"
              clearable>
            </el-input>
          </div>
          <div class="login_input_line">
            <span :class="{loginInputLine : loginInputLIne,loginInputLineClone : loginInputLIneClone}"></span>
          </div>
        </div>

        &lt;!&ndash;确认密码&ndash;&gt;
        <div class="login_input login_password">
          <div class="User_Input">
            <i class="icon icon-ai-password"></i>
            <el-input
              name="PasswrodInput"
              type="password"
              placeholder="确认密码"
              @blur="confirmLoginLineClone"
              @focus="confirmLoginPassword"
              @keyup.enter.native="ClickSubit"
              v-model="againPassword"
              clearable>
            </el-input>
          </div>
          <div class="login_input_line">
            <span :class="{loginInputLine : confirmLoginInputLIne,loginInputLineClone : confirmLoginInputLIneClone}"></span>
          </div>
        </div>-->

        <!--验证码-->
        <div class="login_break_input">
          <div class="Fuc-Code">
            <i class="icon icon-yanzhengma login_break_icon"></i>
            <!--<input name="rea_Code" class="rea_Code" type="text" v-model="code" @keyup.enter="enterToLogin">-->
            <el-input
              name="rea_Code"
              type="text"
              spellcheck="false"
              placeholder="输入验证码"
              @blur="loginBreakLineClone"
              @focus="loginBreak"
              @keyup.enter.native="searchEnterFun"
              v-model="code"
              clearable>
            </el-input>

            <div class="Code_div">
              <div @click="getPhoneCode">获取手机验证码</div>
            </div>
          </div>

          <div class="login_input_line">
            <span :class="{loginInputLine : loginBreakLIne,loginInputLineClone : loginBreakLIneClone}"></span>
          </div>
        </div>


        <div class="login_btm">
          <!--<router-link to="login/usersignup" class="btn_register">注册</router-link>-->
          <div class="btn_submit" type="submit" @click.13="handleSubmit">登陆</div>
        </div>


      </div>
    </div>
  </div>
</template>

<script>
    export default {
        name: "quickRegistration",
      data(){
          return{
            phone: '',
            newPassword: '',
            againPassword: '',
            code:'',
            ThisPlaceholderUser:"",
            ThisPlaceholderPasword:"",

            loginInputLIneUser:false,  //账号线
            loginInputLIneCloneUser:false,  //账号线关闭

            loginInputLIne:false,  //密码线
            loginInputLIneClone:false,  //密码线关闭

            confirmLoginInputLIne:false,  //确认密码线
            confirmLoginInputLIneClone:false,  //确认密码线关闭

            loginBreakLIne:false,  //验证码线
            loginBreakLIneClone:false,  //验证码线关闭

            log_id: '',
            captcha: '', //手机验证码
            rediskey: '', //验证码

          }
      },
      searchEnterFun:function(){
        console.log(1);
      },
      created() {
          this.log_id = this.$route.query.id;
      },
      methods:{

        // 账号
        loginUser(){
          if(this.loginInputLIneUser===false){
            this.loginInputLIneUser = true;
            this.loginInputLIneCloneUser = false
          }
        },
        loginLineCloneUser(){
          this.loginInputLIneUser = false;
          this.loginInputLIneCloneUser = true
        },


        // 验证码
        loginBreak(){
          if(this.loginBreakLIne===false){
            this.loginBreakLIne = true
            this.loginBreakLIneClone = false
          }
        },
        loginBreakLineClone(){
          this.loginBreakLIne = false
          this.loginBreakLIneClone = true
        },


        // 密码
        loginPassword(){
          if(this.loginInputLIne===false){
            this.loginInputLIne = true
            this.loginInputLIneClone = false
          }
        },
        loginLineClone(){
          this.loginInputLIne = false
          this.loginInputLIneClone = true
        },

        // 确认密码
        confirmLoginPassword(){
          if(this.confirmLoginInputLIne==false){
            this.confirmLoginInputLIne = true
            this.confirmLoginInputLIneClone = false
          }
        },
        confirmLoginLineClone(){
          this.confirmLoginInputLIne = false
          this.confirmLoginInputLIneClone = true
        },
        /***
         * 点击登录
         */
        handleSubmit() {
          const param = {
            phone: this.phone,
            //password: this.newPassword,
            captcha: this.code,
            rediskey: this.rediskey,
            log_id: this.$route.query.id
          };
          if(!this.phone || !this.code) {
            this.$.message.error('手机号或验证码不能为空');
          }else {
            this.HttpClient.post('/boundCell',param).then(res =>{
              console.log(res.data)
              if(res.data.code === 200) {
                localStorage.setItem('token',res.data.data.token)
                this.$router.push({
                  path: '/home/index'
                })
              }
            })
          }
        },
        /***
         * 返回
         */
        handleBack() {
          this.$router.push({
            path: '/login',
          })
        },
        /***
         * 获取验证码
         */
        getPhoneCode() {
          if(this.phone) {
            const param = {
              phone: this.phone
            };
            this.HttpClient.post('/user/captcha', param).then(res =>{
              console.log(res)
              if(res.data.code === 200) {
                this.rediskey = (res.headers['cache-control'].split(':')[1]).split(',')[0];
              }else{
                this.$message.error(res.data.msg);
              }
            })
          }else{
            this.$message.error('手机号不能为空')
          }

        }
      },
    }
</script>

<style lang="less">
  .UserLoginLogin{
    background:url("/static/img/BackImg.jpg") center center;
    background-size: cover;
    overflow: hidden;
    position: relative;
    height: 100vh;
    width: 100vw;
    display: flex;
    justify-content: center;
    align-items: center;
  }


  .quickRegistration{
    width: 520px;
    height: 500px;
    background-color:rgba(0,0,0,0.5);
    padding: 10px;

    /*返回按钮*/
    .backBtm{
      margin-left: 20px;
      margin-bottom: 10px;
      cursor: pointer;
      .icon{
        font-size: 24px;
        color: #9c9c9c;
      }
    }
    .backBtm:hover .icon{
      color: #fff;
    }

    .content_box{

      /*标题*/
      .title{
        width: 60%;
        margin: 0 auto 40px auto;
        font-size: 20px;
        color: #fff;
        display: flex;
        align-items: center;
        span{
          display: inline-block;
          width: 5px;
          height: 20px;
          background-color: #15befe;
          margin-right: 10px;
        }


      }

      /*line*/
      .login_input_line{
        height: 1px;
        span{
          display: block;
          height: 1px;
          background-color: #fff;
          width: 0;
          transition: all .5s;
        }
        .loginInputLine,
        .loginInputLineUser{
          animation: lineOpen 1s forwards;
        }
        @keyframes lineOpen{
          0%{
            width: 0;
          }
          50%{
            width: 7%;
          }
          100%{
            width: 100%;
          }
        }
        .loginInputLineClone,
        .loginInputLineCloneUser{
          animation: lineClone 1s forwards;
        }
        @keyframes lineClone{
          0%{
            width: 100%;
          }
          50%{
            width: 7%;
          }
          100%{
            width: 0;
          }
        }

      }

      /*手机号*/
      .login_input{
        width: 60%;
        margin: 0 auto 20px auto;
        .User_Input{
          display: flex;
          align-items: center;
          position: relative;
          .icon{
            position: absolute;
            left: 0;
            top: 3px;
            font-size: 20px;
            color: #9c9c9c;
          }
          .el-input__inner{
            padding-left: 35px;
            border: none;
            background-color: transparent;
            color: #fff;
          }
          .el-input__inner::placeholder{
            color: #ccc;
          }
          .el-input__inner:focus~.icon{
            color: #15a9fe;
          }
        }

      }

      /*验证码*/
      .login_break_input{
        width: 60%;
        margin: 0 auto;
        position: relative;
        .Fuc-Code{
          width: 100%;
          display: flex;
          align-items: flex-end;
          margin: 0 0 10px 0;
          .login_break_icon{
            position: absolute;
            left: 0;
            top: 7px;
            font-size: 20px;
            color: #9c9c9c;
          }

          .el-input{
            width: 50%;
            .el-input__inner{
              padding-left: 35px;
              border: none;
              background-color: transparent;
              color: #fff;
              height: 20px;
              line-height: 20px;
            }
            .el-input__inner::placeholder{
              color: #ccc;
            }
            .el-input__inner:focus~.icon{
              color: #15a9fe;
            }
          }

          .Code_div{
            display: flex;
            align-items: center;
            height: 33px;
            margin-left: 22px;
            justify-content: center;
            border: 1px solid #15befe;
            border-radius: 4px;
            background: rgba(255,255,255,.1);
            color: #fff;
            cursor: pointer;
            padding: 0 10px;
            width: auto !important;
            img{
              border-top-left-radius: 3px;
              border-bottom-left-radius: 3px;
              height: 100%;
              width: 99px;
            }
            .login_break{
              cursor: pointer;
              height: 33px;
              padding: 0 5px;
              border: 1px solid #15a9fe;
              border-left: none;
              border-top-right-radius: 4px;
              border-bottom-right-radius: 4px;
              display: flex;
              align-items: center;
              justify-content: center;
              background: rgba(255,255,255,0.1);
              span{
                width: 100%;
                height: 100%;
                display: flex;
                align-items: center;
                justify-content: center;
                img{
                  width: 20px;
                  height: 20px;
                  border-radius: 0;
                  color: #fff;
                }
              }

            }
            .login_break:hover{
              span{
                transform: rotate(720deg);
                transition: all 1s;
              }
            }


          }
        }
      }

      /*登陆注册按钮*/
      .login_btm{
        width: 60%;
        margin: 55px auto 0 auto;
        display: flex;
        justify-content: space-between;
        align-items: center;
        flex: 2;

        /*注册按钮*/
        .btn_register{
          display: flex;
          justify-content: center;
          align-items: center;
          border: 1px solid #15a9fe;
          background: rgba(255,255,255,.1);
          border-radius: 4px;
          color: #15a9fe;
          flex: 1;
          margin-right: 12px;
          padding: 7px 0;
          cursor: pointer;
        }

        /*登陆按钮*/
        .btn_submit{
          display: flex;
          justify-content: center;
          align-items: center;
          border: 1px solid #15a9fe;
          background-color: #15a9fe;
          border-radius: 4px;
          color: #fff;
          padding: 7px 0;
          margin: 0 0 0 12px;
          flex: 1;
        }
      }
    }

  }
</style>
