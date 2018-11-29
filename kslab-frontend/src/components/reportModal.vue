<template>
  <!--举报模态框-->
  <div class="modalBox reportModal" v-if="modelReport">
    <div class="modalBox_title">
      <p><img src="/static/img/logo/logo_block.png" alt=""></p>
      <div class="modelDelete" @click="reportCodeClick">
        <p></p>
        <p></p>
      </div>
    </div>


    <div class="modalBox_box">

      <div class="reportModal_box">
        <h4>举报</h4>
        <div class="reportModal_text">
          <textarea placeholder="举报详细说明（必填）"></textarea>
        </div>

        <div class="reportModal_upload">
          <el-upload
            action="http://test.kslab.com/api/article/null"
            list-type="picture-card"
            :limit="5"
            :multiple="true"
            :on-preview="handlePictureCardPreview"
            :on-remove="handleRemove">
            <i class="el-icon-plus"></i>
          </el-upload>
          <el-dialog :visible.sync="dialogVisible">
            <img width="100%" :src="dialogImageUrl" alt="">
          </el-dialog>
        </div>

      </div>

      <div class="modalBox_box_btm">
        <p @click="reportCodeClick">取消</p>
        <p @click="handleOK">确定</p>
      </div>
    </div>


  </div>
</template>

<script>
  export default {
    name: "modalBox",
    props: ['modelReport'],
    data(){
      return{
        dialogImageUrl: '',
        dialogVisible: false
      }
    },
    methods: {
      reportCodeClick(){
        this.modelReport = false
        this.$emit('getReportModal',11111)
      },
      handleRemove(file, fileList) {
        console.log(file, fileList);
      },
      handlePictureCardPreview(file) {
        this.dialogImageUrl = file.url;
        this.dialogVisible = true;
      },
      handleOK() {
        this.$emit('getReportModal','111111')
      }
    },
  }
</script>

<style src="../assets/css/modalBox.css"></style>
