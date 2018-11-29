<template>
  <div class="uploading_main_item uploading_main_file">
    <div class="main_head">
      <i class="icon icon_accessory"></i>
      <span class="main_txt">附件</span>
      <span class="main_txt_describe">(选填，最多5个，每个最大5MB)</span>
    </div>
    <el-upload
      drag
      multiple
      class="main_file_upload"
      action="http://test.kslab.com/api/article/null"
      :data="updata"
      list-type="picture-card"
      :file-list="showList"
      :limit="5"
      :on-preview="handleFileCardPreview"
      :on-remove="handleRemove"
      :before-remove="handleBeforeRemove"
      :on-exceed="handleExceed"
      :on-change="handleChange"
      :on-success="handleSuccess"
      :on-error="handleError"
      :before-upload="beforeFileUpload">
      <div class="uploading_tips" @dragover.prevent="onDragover" @dragleave="dragLeave">
        <i class="el-icon-plus" v-show="!dragOver"></i>
        <div class="el-upload__text" v-show="!dragOver">将文件拖到此处，或<em>点击上传</em></div>
        <div class="el-upload__txt" v-show="dragOver && !dragDone">松开文件上传</div>
      </div>
    </el-upload>
    <el-dialog :visible.sync="dialogVisible">
      <img width="100%" :src="dialogImageUrl" alt="">
    </el-dialog>
  </div>
</template>

<script>


  export default {
    name: "uploadingMainFile",
    props: ['http', 'attachments', 'data'],
    data() {
      return {
        dialogImageUrl: '',
        dialogVisible: false,
        dragOver: false,
        dragDone: false,
        updata: {
          token: window.localStorage.token
        },
        serialnum: null,
        fileList: [],
        beforeFileList: [], //上传之后，删除之前的fileList,
        showList: []
      }
    },
    methods: {
      /************************************附件上传**********************************/
      handleRemove(file, fileList) {
        this.HttpClient.post('/services/destroyFile', {url: file.url})
          .then(res => {
            console.log(res);
            let index = null;
            this.showList.map((item, i) => {
              if (item.url === file.url) {
                index = i
              }
            });
            console.log(index);
            if (res.data.code === 200) {
              this.showList.splice(index, 1);
              this.$message.success(res.data.msg);
              if (fileList.length <= 0) {
                this.dragOver = false;
              }
            } else {
              // this.imageFileList.push()
              this.$message.error('删除失败!');
              fileList.splice(index, 0, file);
              console.log(fileList);
            }
          });
      },
      handleFileCardPreview(file) {
        this.dialogImageUrl = file.url;
        this.dialogVisible = true;
      },
      handleExceed(files, fileList) {
        this.$message.warning(`当前限制选择 5 个文件，本次选择了 ${files.length} 个文件，共选择了 ${files.length + fileList.length} 个文件`);
      },
      handleChange(file, fileList) {
        if (fileList.length > 0) {
          this.dragOver = true;
          this.dragDone = true;
        } else {
          this.dragOver = false;
          this.dragDone = false;
        }
      },
      beforeFileUpload(file) {
        const isLt5M = file.size / 1024 / 1024 < 5;
        if (!isLt5M) {
          this.$message.error('上传文件大小不能超过5M!')
          return false;
        }
        const fileType = file.name.split('.')[1];
        if (fileType !== 'txt' && fileType !== 'doc' && fileType !== 'docx') {
          this.$message.error('只能上传txt,doc,docx格式文件');
          return false;
        }
        var FromData = new FormData()
        //活动上传图片接口
        FromData.append('token', window.localStorage.token)
        FromData.append('attachment', file)
        FromData.append('serial_number', this.serialnum)
        FromData.append('type', 1)
        this.$ajax.post(this.request.axiosPort + this.request.axiosApi + 'actives/uploadAttachment', FromData)
          .then((res) => {
            //console.log(res)
            if (res.data.code === 200) {
              this.fileList.push(res.data.path);
              this.showList.push({url: res.data.path});
              this.$message.success(res.data.msg)
              //console.log(this.fileList)
            } else {
              this.$message.error(res.data.msg);
              return false
            }

          })
      },
      async handleBeforeRemove(file, fileList) {
        const isLt5M = file.size / 1024 / 1024 < 5;
        if (!isLt5M) {
          this.$message.error('上传文件大小不能超过5M!')
          return false;
        }
        const fileType = file.name.split('.')[1];
        if (fileType !== 'txt' && fileType !== 'doc' && fileType !== 'docx') {
          this.$message.error('只能上传txt,doc,docx格式文件');
          return false;
        }
        if (this.localUrl === this.pathName) {
          let result = null;
          console.log(file, fileList, this.beforeFileList, this.fileList);
          //console.log(222,this.beforeFileList,file.name)
          let index = this.beforeFileList.map(item => item.name).indexOf(file.name)
          console.log(index)
          const urls = this.fileList[index];
          console.log(urls)
          await this.HttpClient.post('/services/destroyFile', {url: urls}).then(res => {
            console.log(res);
            if (res.data.code === 200) {
              this.fileList.splice(index, 1);
              result = true
            } else {
              result = false;
              file.status = false;
              this.$message.error('删除失败');
              this.$message.error(res.data.succeed)
            }
          });
          console.log(result)
          return result;
        }

      },
      handleSuccess(response, file, fileList) {
        this.beforeFileList = fileList;
      },
      handleError(err, file, fileList) {
        this.$message.error('上传失败！');
        console.log(file);
      },
      onDragover() {
        this.dragOver = true;
      },
      dragLeave() {
        this.dragOver = false;
      }
    },
    created() {
      // this.serialnum=this.Tools.GetNumber()
    },
    watch: {
      data: {
        handler() {
          this.serialnum = this.data.serial_number;
          console.log(this.data.fileList);
          this.showList = this.data.fileList
        },
        immediate: true
      }
    }
  }
</script>

<style scoped>
  .uploading_main_file .icon {
    width: 20px;
    height: 20px;
    vertical-align: middle;
  }

  .uploading_main_file .main_txt {
    font-size: 16px;
    font-weight: 800;
  }

  .uploading_main_file .main_head {
    margin-bottom: 7px;
  }
</style>
