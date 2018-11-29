<template>
  <div class="merchantKsChat appBackground">

    <!--个人页面头部-->
    <merchantInfoHeader-div></merchantInfoHeader-div>
    <ksChat-div></ksChat-div>


  </div>
</template>

<script>
  import merchantInfoHeaderDiv from "@/components/commercialInfoHeader"
  import ksChatDiv from "../ksChat/ksChat"

    export default {
        name: "merchantKsChat",
      data(){
        return{

        }
      },
      components:{
        merchantInfoHeaderDiv,
        ksChatDiv
      }
    }
</script>

<style scoped>
  .merchantKsChat{
    padding: 30px 0;
  }
</style>
