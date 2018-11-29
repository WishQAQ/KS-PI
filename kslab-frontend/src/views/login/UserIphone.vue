<template lang="html">
  <div class="Odiv_magrint">
    <div class="BackImg backNone">
  		<form class="UserForm" id="form" action="post" method="" onsubmit="return fux()">
  			<div class="RetrieveCont">
  				<a href="javascript :history.back(-1)">
  					<img src="/static/img/icon/leftcont.gif" alt="">
  					<span>|</span>
  				</a>
  			</div>
  			<div class="RetrieveCont_title NewPasswrod_title">
  				<span>输入新手机</span>
  			</div>
  			<div class="RetrieveCont_Input">
  				<label class="ContIname">
  					<input id="Passwrod" class="input_user" name="RetrieveCont_Logoin" type="text" placeholder="手机号" />
  					<div></div>
  				</label>
  				<label class="ContIname">
  					<input id="ContIdPassd" class="input_user" name="Passcontws" type="text" placeholder="验证码" />
  					<div></div>
  				</label>
  			</div>
  			<div class="RetrieveCont_Submin">
  				<button class="Fuc-NoneBtn">取消</button>
  				<button id="Fuc-NewPasswrod">确定</button>
  			</div>
  		</form>
  	</div>
  </div>
</template>

<script>
  export default {
      data(){
        return{

        }
      },
      beforeRouteLeave(to,from,next){ //离开组件的时候触发
          document.body.removeAttribute("class","UserLoginLogin")
          next()
        }
  }
</script>

<style scoped src="../../assets/css/UserIphone.css"></style>
<style lang="css">
.UserLoginLogin{
  background-image:url('/static/img/BackImg.jpg');
  overflow: hidden;
  position: relative;
}
</style>
