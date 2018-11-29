<template lang="html">
    <div class="">
      <div class="BackImg backNone">
        <form class="UserForm" id="form" action="post" method="" onsubmit="return fux()">
          <div class="RetrieveCont">
            <a href="javascript :history.back(-1)">
              <img src="/static/img/icon/leftcont.gif" alt="">
              <span>|</span>
            </a>
          </div>
          <div class="RetrieveCont_title NewPasswrod_title">
            <span>验证身份</span>
            <span class="span_clic_idCard">
            </span>
          </div>
          <div class="RetrieveCont_Input">
            <label class="ContIname">
              <input class="input_user" name="RetrieveCont_Logoin" type="text" placeholder="姓名" />
              <div></div>
            </label>
            <label class="ContIname">
              <input class="input_user" name="Passcontws" type="text" placeholder="输入之前的手机号码" />
              <div></div>
            </label>
            <label class="ContIname">
              <input class="input_user" name="Passcontws" type="text" placeholder="身份证号" />
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

<style scoped src="../../assets/css/IDcard.css"></style>
<style lang="css">
.UserLoginLogin{
  background-image:url('/static/img/BackImg.jpg');
  overflow: hidden;
  position: relative;
}
</style>
