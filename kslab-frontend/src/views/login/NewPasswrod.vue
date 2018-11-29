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
  				<span>请输入新密码</span>
  			</div>
  			<div class="RetrieveCont_Input">
  				<label class="ContIname">
  					<input id="Passwrod" v-model="passwrod" class="input_user_newPassr" name="RetrieveCont_Logoin" type="text" placeholder="新密码" />
  					<div></div>
  				</label>
  				<label class="ContIname">
  					<input id="ContIdPassd" @keyup="sureKyup" v-model="surepass" class="input_user_newPassr" name="Passcontws" type="text" placeholder="确认新密码" />
            <div>{{font}}</div>
            <div></div>
  				</label>
  			</div>
  			<div class="RetrieveCont_Submin">
  				<button class="Fuc-NoneBtn">取消</button>
  				<button id="Fuc-NewPasswrod" @click="subMint">确定</button>
  			</div>
  	</div>
  </div>
</template>

<script>
export default {
  data(){
    return{
      passwrod:"",
      surepass:"",
      font:null
    }
  },
  beforeRouteLeave(to,from,next){ //离开组件的时候触发
      document.body.removeAttribute("class","UserLoginLogin")
      next()
    },
    methods:{
      sureKyup(){
        if(this.passwrod != this.surepass){
          this.font = "两次密码应该一样哦"
        }else{
          this.font = ""
        }
      },
      subMint(){
        //点击后更改密码 错误返回，成功返回
        if(this.passwrod == this.surepass){
          this.$ajax.post(this.request.axiosPort + this.request.axiosApi + 'forgetpassword/captcha' ,{
               password:this.surepass
            })
            .then((res) => {
              if(res.data.code == 300){
                this.$message({
                  message: res.data.msg,
                  type: 'warning'
                });
              }else{
                this.$message({
                  message: res.data.msg,
                  type: 'success'
                });
              }
            })
        }else{
          this.$message.error('俩次密码必须保持一致哦');
        }
      }
    }
}
</script>

<style scoped src="../../assets/css/NewPwd.css"></style>
<style>
#Fuc-NewPasswrod{
  cursor: pointer;
}
.Fuc-NoneBtn{
  cursor: pointer;
}
.input_user_newPassr{
  width:100%;
  color: #FFF;
  height: 20px;
  padding: 7px;
  background-color: rgb(14,16,19,0.8);
  border: 1px solid #6b6d6f;
  border-radius: 5px;
  margin-top: 30px;
}
.UserLoginLogin{
  background-image:url(/static/img/BackImg.jpg);
  overflow: hidden;
  position: relative;
}
</style>
