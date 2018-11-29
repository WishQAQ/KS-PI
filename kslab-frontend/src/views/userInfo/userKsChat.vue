<template>
    <div class="userKsChat appBackground">

      <!--个人页面头部-->
      <userInfoHeader-div></userInfoHeader-div>
      <ksChat-div></ksChat-div>


    </div>
</template>

<script>
  import userInfoHeaderDiv from "@/components/userInfoHeader"
  import ksChatDiv from "../ksChat/ksChat"

  export default {
        name: "userKsChat",
    data(){
      return{

      }
    },
    components:{
      userInfoHeaderDiv,
      ksChatDiv
    }
  }
</script>

<style lang="less">
  .userKsChat{
    padding: 30px 0;
  }
</style>
