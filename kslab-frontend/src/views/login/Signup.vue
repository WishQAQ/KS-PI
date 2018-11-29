<template>
    <div class="Retrieve_html">
      <div class="BackImg">
        <form class="oForm" action="1.html" method="post" enctype="application/xxx-www">
          <div class="RetrieveCont">
            <a href="javascript :history.back(-1)">
              <img src="/static/img/icon/leftcont.gif" alt="">
              <span>|</span>
            </a>
          </div>
          <div class="RetrieveCont_title">
            <span>找回密码</span>
          </div>
          <div class="RetrieveCont_Input">
            <label class="ContIname">
              <input id="email_Coiphone" class="input_user" name="Dc_title_emild" type="text" placeholder="手机号/邮箱" />
              <div></div>
              <div></div>
            </label>
            <label class="ContIname">
              <input class="input_user Code" name="RetrieveCont_Logoin" type="text" placeholder="验证码" />
              <button class="Block_btn">获取验证码</button>
            </label>
          </div>
          <div class="RetrieveCont_Submin">
            <button class="Fuc-NoneBtn">取消</button>
            <button type="submit" class="Fuc-NoneBtn Fuc-Form-submit">确定</button>
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

<style>
.UserLoginLogin{
  background-image:url('/static/img/BackImg.jpg');
  overflow: hidden;
  position: relative;
}
</style>
<style scoped src="../../assets/css/Signup.css"></style>
