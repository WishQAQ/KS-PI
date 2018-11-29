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
              :file-list="fileList2"
              list-type="picture-card"
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
        name: "uploadingEncycMainFile",
        props:['http','attachments','bkID',],
        data(){
            return {
                fileList2:[],
                timeData:null,//附件编码
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
            }
        },
      created() {

        // this.serialnum = this.$store.state.activityUpload.activityUploadData.serial_number;
        setTimeout(() => {
              this.$ajax.post(this.request.axiosPort + this.request.axiosApi + 'encyclopedias/info',{
                    token:window.localStorage.token,
                    encyclopedia_id:this.bkID,
                })
                .then((res) => {
                    console.log(res.data.data)
                    this.fileList2 = res.data.data.attachment;
                    for(var i = 0; i < this.fileList.length;i++){
                        this.fileList[i].path = this.request.picUrl+this.fileList[i].path;
                    }
                    console.log(this.fileList2)
                })
          }, 500);
      },
      mounted(){
          
      },
        methods:{
            /************************************附件上传**********************************/
            // 删除附件
            handleRemove(file, fileList) {
                console.log(fileList)
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
                // console.log(file)
                // console.log(this.bkID)
                const isLt5M = file.size / 1024 / 1024 < 5;
                if (!isLt5M) {
                    this.$message.error('上传文件大小不能超过5M!')
                    return false;
                }
              var FromData = new FormData()
              var dataNuberm = Number(new Date())+1;
              this.timeData = dataNuberm; //储存文件编码，传给父组件，以供接口传参。
              //文章上传图片接口
              FromData.append('token', window.localStorage.token)
              FromData.append('attachment', file)
              FromData.append('serial_number',this.bkID)
              this.$ajax.post(this.request.axiosPort + this.request.axiosApi + 'encyclopedias/uploadattachment', FromData)
                .then((res) => {
                    console.log(res)
                  //console.log(res)
                  if (res.data.code === 200) {
                    this.fileList.push(res.data.path)
                    this.$message.success(res.data.msg)
                    //console.log(this.fileList)
                    //将子组件文件传给父组件
                    this.$emit('getFile',this.timeData );
                  } else {
                    this.$message.error(res.data.msg)
                    console.log(res.data.msg)
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
              const urls = this.fileList[index];
              console.log(urls)
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
              console.log(result)
              return result;
            }

          },
            handleSuccess(response, file, fileList){
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
            }
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
