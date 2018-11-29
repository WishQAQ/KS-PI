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
              :limit="5"
              :file-list="fileFileList"
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


    import * as cfg from "../../../config/app";

    export default {
        name: "uploadingMainFile",
        props:['http','attachments','serviceFileData'],
        data(){
            return {
                dialogImageUrl: '',
                dialogVisible: false,
                dragOver:false,
                dragDone:false,
                updata:{
                  token:window.localStorage.token
                },
              serialnum: null,
              fileList: [],
              beforeFileList: [], //上传之后，删除之前的fileList,
              fileFileList: [],
              editFileList: [], //修改服务时获得的路径
            }
        },
      created() {
        this.serialnum = this.$store.state.serviceUpload.serviceUploadData.serial_number;
      },
      watch: {
        serviceFileData: {
          handler(newData, oldData) {
            console.log(newData, oldData)
            const images = newData.attachment;
            let array = [];
            images.map((item, index) =>{
              var temp = {
                name: item.name,
                url: this.handleImg(item.path)
              };
              array.push(temp)
            });
            console.log(array)
            this.fileFileList = array;
            this.beforeFileList = array;
            this.editFileList = newData.attachment;
          },
          deep: true
        }
      },
        methods:{
            /************************************附件上传**********************************/
            handleRemove(file, fileList) {

                if(fileList.length<=0){
                    this.dragOver=false;
                }
            },
            handleFileCardPreview(file) {
                this.dialogImageUrl = file.url;
                this.dialogVisible = true;
            },
            handleExceed(files, fileList) {
                this.$message.warning(`当前限制选择 5 个文件，本次选择了 ${files.length} 个文件，共选择了 ${files.length + fileList.length} 个文件`);
            },
            handleChange(file,fileList){
                if(fileList.length>0){
                    this.dragOver=true;
                    this.dragDone=true;
                }else{
                    this.dragOver=false;
                    this.dragDone=false;
                }
            },
            beforeFileUpload(file){
                const isLt5M = file.size / 1024 / 1024 < 5;
                if (!isLt5M) {
                    this.$message.error('上传文件大小不能超过5M!')
                    return false;
                }
              var FromData = new FormData()
              //文章上传图片接口
              FromData.append('token', window.localStorage.token)
              FromData.append('attachment', file)
              FromData.append('serial_number', this.serialnum)
              this.$ajax.post(this.request.axiosPort + this.request.axiosApi + 'services/uploadAttachment', FromData)
                .then((res) => {
                  //console.log(res)
                  if (res.data.code === 200) {
                    this.fileList.push(res.data.path)
                    this.$message.success(res.data.msg)
                    //console.log(this.fileList)
                  } else {
                    this.$message.error(res.data.msg)
                    return false
                  }

                })
            },
          async handleBeforeRemove(file, fileList) {
            /***
             * 服务上传页面
             * by zxd
             */
            if (this.localUrl === this.pathName) {
              let result = null;
              console.log(file, fileList, this.beforeFileList, this.fileList);
              //console.log(222,this.beforeFileList,file.name)
              let index = this.beforeFileList.map(item => item.name).indexOf(file.name)
              console.log(index)
              let urls = this.fileList[index];
              if(this.$route.query.id) {
                urls = this.handleImg(this.editFileList[index].path);
              }
              console.log(urls)
              if(this.$route.query.id) {
                await this.HttpClient.post('/updateDelete', {path: urls}).then(res => {
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
              }else {
                await this.HttpClient.post('/services/destroyFile', {url: urls}).then(res => {
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
              }

              console.log(result)
              return result;
            }

          },
            handleSuccess(response, file, fileList){
              console.log(file, fileList)
              this.beforeFileList = fileList;
            },
            handleError(err, file, fileList){
                this.$message.error('上传失败！');
                console.log(file);
            },
            onDragover(){
                this.dragOver=true;
            },
            dragLeave(){
                this.dragOver=false;
            },
          /***
           * 图片格式化
           * @param url
           * @returns {*}
           */
          handleImg(url) {
            return cfg.imageUrl+url;
          },
        },
    }
</script>

<style scoped>
    .uploading_main_file .icon{
        width:20px;
        height:20px;
        vertical-align:middle;
    }
    .uploading_main_file .main_txt{
        font-size:16px;
        font-weight:800;
    }
    .uploading_main_file .main_head{
        margin-bottom:7px;
    }
</style>
