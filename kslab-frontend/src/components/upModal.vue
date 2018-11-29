<template>
  <!--确认删除模态框-->
  <div class="modalBox" v-show="modelDelete">
    <div class="modalBox_title">
      <p><img src="/static/img/logo/logo_block.png" alt=""></p>
      <div class="modelDelete" @click="cancelClick">
        <p></p>
        <p></p>
      </div>
    </div>


    <div class="modalBox_box">
      <!--<span><img src="/static/img/caveat.png" alt=""></span>-->
      <div class="up_num">
        <p>输入库存数量：</p>
        <el-input
          placeholder="请输入数量"
          onkeyup="value=value.replace(/^(0+)|[^\d]+/g,'')"
          size="mini"
          v-model="number">
        </el-input>
      </div>
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
        isSingle:true,
        modelDelete:false,
        number: null
      }
    },
    methods: {
      cancelClick(){
        this.modelDelete=false
      },
      deleteClick(){
        if(this.number>0){
          this.$emit('confirm',this.isSingle,this.number);
          this.modelDelete=false
        }else {
          this.$message.error('请输入库存')
        }

      }
    },
  }
</script>

<style src="../assets/css/modalBox.css"></style>
<style lang="less">
  .up_num{
    display: flex;
    margin: 0 20px;
    p{
      width: 120px;
      height: 28px;
      line-height: 28px;
    }
  }
</style>
