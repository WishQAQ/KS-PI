<template>
  <!--修改回答框-->
    <div class="replyMode">

      <el-dialog
        title="修改回答"
        :visible.sync="replyMode"
        width="30%">
        <div class="replyMode_editor">
          <quill-editor ref="myTextEditor"
                        v-model="content"
                        :options="editorOption"
                        @blur="onEditorBlur($event)"
                        @focus="onEditorFocus($event)"
                        @ready="onEditorReady($event)">
          </quill-editor>
        </div>

        <div class="replyMode_upload">
          <el-upload
            action="http://test.kslab.com/api/article/null"
            list-type="picture-card"
            :file-list="attachment"
            :on-preview="handlePictureCardPreview"
            :on-remove="handleRemove"
            :before-upload="beforeFileUpload">
            <i class="el-icon-plus"></i>
          </el-upload>
          <el-dialog :visible.sync="dialogVisible">
            <img width="100%" :src="dialogImageUrl" alt="">
          </el-dialog>
        </div>

        <p class="replyModeUploadPrompt">最多5个，最大5M</p>
        <span slot="footer" class="dialog-footer replyMode_submit">
          <el-button @click="dialogVisible = false">取 消</el-button>
          <el-button type="primary" @click="butContSubmit">确 定</el-button>
        </span>
      </el-dialog>

    </div>
</template>

<script>
    export default {
        props:['answer'],
        name: "replyMode",
      data() {
        return {
          replyMode: false,
          id:'',//回答id
          dialogImageUrl: '',
          dialogVisible: false,
          content:null,//内容
          serialNumber:'',//附件编号
          attachment:[{name:'',path:'',url:''}],//附件展示表
          // 富文本编辑器
          editorOption: {
            modules: {
              toolbar: [
                ['bold', 'italic', 'underline', 'strike'],
              ],
              syntax: {
                highlight: text => hljs.highlightAuto(text).value
              }
            }
          }
        };

      },

      methods: {
        butContSubmit(){
          this.HttpClient.post('/my/answer/edit',{
            answer_id:this.id,
            content:this.content
          })
          .then((res) => {
            console.log(res)
          })
        },
        beforeFileUpload(file){
          var answerForm = new FormData();
          answerForm.append('token',window.localStorage.token);
          answerForm.append('images',file);
          answerForm.append('serialnum',this.serialNumber);
          this.$ajax.post(this.request.axiosPort+this.request.axiosApi+'questions/upload',answerForm)
          .then((res) => {
            console.log(res)
          })
        },
        handleRemove(file, fileList) {
          // console.log(file, fileList);
        },
        handlePictureCardPreview(file) {
          this.dialogImageUrl = file.url;
          this.dialogVisible = true;
        },
        // 富文本
        onEditorBlur(editor) {
          console.log('editor blur!', editor)
        },
        onEditorFocus(editor) {
          console.log('editor focus!', editor)
        },
        onEditorReady(editor) {
          console.log('editor ready!', editor)
        }


      },
      watch:{
        answer:{
            handler(){
            console.log(this.answer);
            //请求回答详情
            this.HttpClient.post('/my/answer/info',{answer_id:this.answer.answer_id})
                .then(res=>{
                    console.log(res);
                    let {code,data} = res.data;
                    if(code===200){
                        this.content = data.content;
                        this.id=data.answer_id;
                        this.attachment=data.attachment;
                        this.serialNumber=data.serial_number;
                    }
                })
            },
            deep:true
        }
      }

    }
</script>

<style lang="less">
  .replyMode{
    /*弹出框内边距*/
    .el-dialog__body{
      padding: 0 !important;


      /*富文本*/
      .replyMode_editor{
      margin-bottom: 20px;
        /*边框 bar*/
        .ql-toolbar.ql-snow{
          border-left: none !important;
          border-right: none !important;
          border-bottom-color: #dedede !important;
        }
        /*边框 content*/
        .ql-container.ql-snow{
          border-left: none !important;
          border-right: none !important;

          /*content height*/
          .ql-editor{
            height: 150px !important;
          }
        }
      }


      /*附件框*/
      .replyMode_upload{
        margin: 0 20px;
        /*附件 upladBtm*/
        .el-upload--picture-card{
          width: 80px !important;
          height: 80px !important;
          line-height: 80px !important;
        }

        .el-upload-list--picture-card .el-upload-list__item{
          width: 80px !important;
          height: 80px !important;
        }
      }
    }

    /*上传提示*/
    .replyModeUploadPrompt{
      text-align: right;
      font-size: 12px;
      color: #999;
      padding-right: 20px;
    }

    /*点击按钮*/
    .replyMode_submit{
      display: flex;
      justify-content: flex-end;
      align-items: center;

      /*取消按钮*/
      .el-button--default{
        border-color: #15befe !important;
        color: #15befe !important;
      }

      .el-button{
        margin-left: 20px;
        padding: 10px 30px !important;
      }
    }
  }
</style>
