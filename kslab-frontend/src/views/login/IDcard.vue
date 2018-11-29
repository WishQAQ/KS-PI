<template lang="html">
  <div class="Odiv_magrint">
    <div class="BackImg backNone" v-show="NoewBlock">
  			<div class="RetrieveCont">
  				<a href="javascript :history.back(-1)">
  					<img src="/static/img/icon/leftcont.gif" alt="">
  					<span>|</span>
  				</a>
  			</div>
  			<div class="RetrieveCont_title NewPasswrod_title">
  				<span>绑定身份证</span>
          <span class="span_clic_idCard">
            <span @click="slipUser">
              忘记账号？
            </span>
          </span>
  			</div>
  			<div class="RetrieveCont_Input">
  				<label class="ContIname">
  					<input id="Passwrod" v-model="username" class="input_user_card" name="RetrieveCont_Logoin" type="text" placeholder="姓名" />
  					<div></div>
  				</label>
  				<label class="ContIname">
  					<input id="ContIdPassd" v-model="usercard" class="input_user_card" name="Passcontws" type="text" placeholder="身份证号" />
  					<div></div>
  				</label>
  			</div>
  			<div class="RetrieveCont_Submin">
  				<button class="Fuc-NoneBtn">取消</button>
  				<button id="Fuc-NewPasswrod" @click="btnSureclick">确定</button>
  			</div>
  	</div>
    <scont-css v-show="UserCsont"></scont-css>
  </div>
</template>

<script>
 import ScontCss from '@/views/login/IDcarend'
export default {
    data(){
      return{
          NoewBlock:true,
          UserCsont:false,
          username:null,
          usercard:null
      }
    },
    components:{
      ScontCss
    },
    methods:{
      slipUser(){
        console.log("1")
        this.NoewBlock = false
        this.UserCsont = true
      },
      btnSureclick(){
        this.$ajax.post(this.request.axiosPort+this.request.axiosApi+'forgetpassword/idcardistrue',{
          actual_name:this.username,
          id_cerd:this.usercard
        })
        .then((res) => {
          if(res.data.code != 200){
            this.$message.error(res.data.msg);
          }
          else if(res.data.code == 200){
            this.$message({
              message: res.data.msg,
              type: 'success'
            });

            this.$router.push({
              path:'/NewPasswrod'
            })
          }
          else{
            this.$message({
              message: res.data.msg,
              type: 'warning'
            });
          }
        })
      }
    },
    beforeRouteLeave(to,from,next){ //离开组件的时候触发
        document.body.removeAttribute("class","UserLoginLogin")
        next()
    }
}
</script>

<style scoped src="../../assets/css/IDcard.css"></style>
<style>
.input_user_card{
  width: 380px !important;
  color: #FFF;
  height: 20px;
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
