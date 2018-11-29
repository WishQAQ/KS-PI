<template>
  <!--活动码模态框-->
  <div class="modalBox activityCodeModel" v-if="modelActivityCode">
    <div class="modalBox_title">
      <p><img src="/static/img/logo/logo_block.png" alt=""></p>
      <div class="modelDelete" @click="activityCodeClick">
        <p></p>
        <p></p>
      </div>
    </div>


    <div class="modalBox_box">

      <span class="activityCode_active">{{number}}</span>

      <div class="modalBox_box_btm">
        <p @click="activityCodeClick">取消</p>
        <p>确定</p>
      </div>
    </div>


  </div>
</template>

<script>
  export default {
    name: "modalBox",
    props:['codNumber'],
    data(){
      return{
        number:'',
        modelActivityCode: true,
      }
    },
    created(){
      // this.$watch('codNumber',function(curVal,oldVal){
      //   console.log(curVal)
      // })
    },
    watch:{
      codNumber:function(curVal,oldVal){
        console.log(curVal)
          // this.number = this.codNumber;
      }
    },
    methods: {
      activityCodeClick(){
        this.modelActivityCode = false
      }
    },
  
  }
</script>

<style src="../../assets/css/modalBox.css"></style>
