<template>
  <!--取消关注模态框-->
  <div class="modalBox" v-if="modelRefund">
    <div class="modalBox_title">
      <p><img src="/static/img/logo/logo_block.png" alt=""></p>
      <div class="modelDelete" @click="refundClick">
        <p></p>
        <p></p>
      </div>
    </div>


    <div class="modalBox_box">
      <span><img src="/static/img/caveat.png" alt=""></span>
      <p>确定取消关注吗？</p>
      <div class="modalBox_box_btm">
        <p @click="refundClick">取消</p>
        <p>确定</p>
      </div>
    </div>


  </div>
</template>

<script>
  export default {
    name: "modalBox",
    data(){
      return{
        modelRefund: true,
      }
    },
    methods: {
      refundClick(){
        this.modelRefund = false
      }
    },
  }
</script>

<style src="../../assets/css/modalBox.css"></style>
