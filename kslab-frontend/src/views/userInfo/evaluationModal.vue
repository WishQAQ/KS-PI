<template>
  <!--发表评论模态框-->
  <div class="modalBox evaluationModal" v-if="modalEvaluation">
    <div class="modalBox_title">
      <p><img src="/static/img/logo/logo_block.png" alt=""></p>
      <span>发表评论</span>
      <div class="modelDelete" @click="commentClick">
        <p></p>
        <p></p>
      </div>
    </div>


    <div class="modalBox_box">

      <textarea placeholder="请输入评论内容..."></textarea>

      <div class="modalBox_box_btm">
        <p @click="commentClick">取消</p>
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
        modalEvaluation: true,
      }
    },
    methods: {
      commentClick(){
        this.modalEvaluation = false
      }
    },
  }
</script>

<style src="../../assets/css/modalBox.css"></style>
