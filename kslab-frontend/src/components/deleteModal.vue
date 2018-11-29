<template>
  <!--确认删除模态框-->
  <div class="modalBox" v-if="modelDelete">
    <div class="modalBox_title">
      <p><img src="/static/img/logo/logo_block.png" alt=""></p>
      <div class="modelDelete" @click="cancelClick">
        <p></p>
        <p></p>
      </div>
    </div>


    <div class="modalBox_box">
      <span><img src="/static/img/caveat.png" alt=""></span>
      <p>确定要删除吗？</p>
      <div class="modalBox_box_btm">
        <p @click="cancelClick">取消</p>
        <p @click="deleteClick">确定</p>
      </div>
    </div>


  </div>
</template>

<script>
  export default {
    name: "modalBox",
    data(){
      return{
        isSingle: true,//是否单个删除
        modelDelete: false//是否显示
      }
    },
    methods: {
      cancelClick(){
        console.log(11111)
        this.modelDelete=false
      },
      deleteClick(){
          this.$emit('confirm',this.isSingle);
        this.modelDelete=false
      }
    },
  }
</script>

<style src="../assets/css/modalBox.css"></style>
