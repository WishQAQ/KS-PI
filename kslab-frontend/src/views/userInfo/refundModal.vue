<template>
  <!--申请退款模态框-->
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
      <p>共有 6 张，600元可退 是否确定退款</p>
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
