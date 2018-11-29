<template lang="html">
  <div class="Odiv_magrint">
    <div class="BackImg backNone">
  			<div class="RetrieveCont">
  				<a href="javascript :history.back(-1)">
  					<img src="/static/img/icon/leftcont.gif" alt="">
  					<span>|</span>
  				</a>
  			</div>
  			<div class="RetrieveCont_title NewPasswrod_title">
  				<span>找回密码</span>
          <span class="span_clic">
            <router-link to="/idcard">
              忘记手机号？
            </router-link>
          </span>
  			</div>
  			<div class="RetrieveCont_Input">
  				<label class="ContIname">
  					<input id="Passwrod" v-model="phone" class="input_user_redo" name="RetrieveCont_Logoin" type="text" placeholder="手机号" />
  					<div></div>
  				</label>
  				<label class="ContIname">
            <input type="text" v-model="captcha" placeholder="输入验证码" class="chaphInput">
  					<button type="button" class="input_user_cahpan" name="button" @click="captchaClick">获取验证码</button>
  				</label>
  			</div>
  			<div class="RetrieveCont_Submin">
  				<button class="Fuc-NoneBtn">取消</button>
  				<button id="Fuc-NewPasswrod" @click="subMiunClick">确定</button>
  			</div>
  	</div>
  </div>
</template>

<script>
export default {
    data(){
      return{
        phone:'',
        captcha:''
      }
    },
    beforeRouteLeave(to,from,next){ //离开组件的时候触发
        document.body.removeAttribute("class","UserLoginLogin")
        next()
    },
    methods:{
      subMiunClick(){
        this.$ajax.post(this.request.axiosPort+this.request.axiosApi+'forgetpassword/phonecaptchaistrue',{
          phone:this.phone,
          captcha:this.captcha
        })
        .then((res) => {
          this.$router.push({
            path:'/NewPasswrod'
          })
        })
      },
      captchaClick(){
        this.$ajax.post(this.request.axiosPort+this.request.axiosApi+'forgetpassword/create',{
          phone:this.phone
        })
        .then((res) => {
          if(res.data.code != 300){
            this.$message({
              message: res.data.msg,
              type: 'success'
            });
          }else{
             this.$message.error(res.data.msg);
          }
        })
      }
    }
}
</script>

<style scoped src="../../assets/css/Redo.css"></style>
<style lang="css">
#Fuc-NewPasswrod{
  cursor: pointer;
}
.chaphInput{
  width: 110px;
  height: 20px;
  color: #FFF;
  padding: 7px;
  background-color: rgb(14,16,19,0.8);
  border: 1px solid #6b6d6f;
  border-radius: 5px;
  margin-top: 10px;
  margin-right: 10px;
}
.input_user_cahpan{
  padding: 8px;
  background-color: #000;
  border:1px solid #CCC;
  border-radius: 5px;
  color:#FFF;
  cursor: pointer;
}
.input_user_redo{
  width: 380px !important;
    color: #FFF;
    height: 17px;
    padding: 7px;
    background-color: rgba(14,16,19,0.8);
    border: 1px solid #6b6d6f;
    border-radius: 5px;
    margin-top: 30px;
}
.UserLoginLogin{
  background-image:url('/static/img/BackImg.jpg');
  overflow: hidden;
  position: relative;
}
</style>
