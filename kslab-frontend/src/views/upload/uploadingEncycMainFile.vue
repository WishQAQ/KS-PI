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
              :file-list="showList"
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
        props:['http','attachments','bkID','infoData','qsID'],
        data(){
            return {
                timeData:null,//附件编码
                dialogImageUrl: '',
                dialogVisible: false,
                dragOver:false,
                dragDone:false,
                updata:{
                  token:window.localStorage.token
                },
              serialnum: null,
              showList: [],
              fileList:[],
              beforeFileList: [], //上传之后，删除之前的fileList,
              infoId:null,
            }
        },
        watch:{
        },
      created() {
        // this.serialnum = this.$store.state.activityUpload.activityUploadData.serial_number;
        setTimeout(() => {
            console.log(this.infoData)
            console.log(this.qsID)
            console.log(this.bkID)
            // console.log(this.infoData.data.question_id)
            // console.log(this.infoData.data.encyclopedia_id)
            if(this.qsID != undefined ){  //判断是否含有问题ID，有的话就请求问题详情
            console.log('我是问题')
                this.$ajax.post(this.request.axiosPort + this.request.axiosApi + 'my/question/info',{
                    token:window.localStorage.token,
                    question_id:this.qsID,
                })
                .then((res) => {
                    console.log(res)
                    console.log(res.data.data.attachment.length)
                    this.showList = res.data.data.attachment;
                    for(let i=0;i<this.showList.length;i++){
                        this.showList[i].path = this.request.picUrl+this.showList[i].path;
                    }
                    console.log(this.showList)
                    if(res.data.data.attachment != null){
                        if(res.data.data.attachment.length > 0){
                            this.dragOver=true;
                            this.dragDone=true;
                            for(let i=0;i<res.data.data.attachment.length;i++){
                                this.fileList.push(res.data.data.attachment[i].path)
                            }
                            console.log(this.fileList)
                            // this.showList = this.fileList;
                        }else{
                            this.dragOver=false;
                            this.dragDone=false;
                        }
                    }else{
                        this.fileList = [];
                        this.dragOver=false;
                        this.dragDone=false;
                    }
                    console.log(this.showList)
                    // console.log(res)
                    // this.showList = res.data.data.attachment;
                    // if(!this.showList){
                    //     this.showList=[]
                    // }
                    // if(res.data.data.attachment.length >0){  //如果进入组件的附件数量大于0，隐藏添加。
                    //     this.dragOver=true;
                    //     this.dragDone=true;
                    // }else{
                    //     this.dragOver=false;
                    //     this.dragDone=false;
                    // }
                })
            }else{  //如果没有问题ID，那么就是百科详情
            console.log('我是百科')
                // this.infoId = this.infoData.data.encyclopedia_id;
                this.$ajax.post(this.request.axiosPort + this.request.axiosApi + 'my/encyclopedias/info',{
                    token:window.localStorage.token,
                    encyclopedia_id:this.bkID,
                })
                .then((res) => {
                    console.log(res)
                    console.log(res.data.data.attachment.length)
                    this.showList = res.data.data.attachment;
                    for(let i=0;i<this.showList.length;i++){
                        this.showList[i].path = this.request.picUrl+this.showList[i].path;
                        this.showList[i].url = this.showList[i].path;
                    }
                    console.log(this.showList)
                    if(res.data.data.attachment != null){
                        if(res.data.data.attachment.length > 0){
                            this.dragOver=true;
                            this.dragDone=true;
                            for(let i=0;i<res.data.data.attachment.length;i++){
                                this.fileList.push(res.data.data.attachment[i].path)
                            }
                            console.log(this.fileList)
                            // this.showList = this.fileList;
                        }else{
                            this.dragOver=false;
                            this.dragDone=false;
                        }
                    }else{
                        this.fileList = [];
                        this.dragOver=false;
                        this.dragDone=false;
                    }
                    console.log(this.showList)
                })
            }
        },500);
      },
      mounted(){

      },
        methods:{
            /************************************附件上传**********************************/
            handleBeforeRemove(file, fileList){
                console.log(file.path)
                console.log(fileList)
                console.log(this.beforeFileList);
                 this.$ajax.post(this.request.axiosPort + this.request.axiosApi + 'updateDelete', {
                    token:window.localStorage.token,
                    path:file.path
                 })
                .then((res) => {
                    console.log(res)
                    this.$message.success(res.data.msg)
                })
                .then((error) => {
                    this.$message.warning(error)
                })
            },
            // 删除附件
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
                console.log(file)
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
              //上传图片接口
              //判断是问题还是百科
              if(this.infoData.question_id){//这是问题
                    console.log(this.infoId)
                    console.log(this.serialnum)
                    FromData.append('token', window.localStorage.token)
                    FromData.append('images', file)
                    FromData.append('serialnum',this.qsID)
                    this.$ajax.post(this.request.axiosPort + this.request.axiosApi + 'questions/upload', FromData)
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
                            console.log(this.fileList)
                        })
              }else{//这是百科
                    // console.log(this.infoId)
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
                            console.log(this.fileList)
                            //将子组件文件传给父组件
                            this.$emit('getFile',this.timeData );
                        } else {
                            this.$message.error(res.data.msg)
                            console.log(res.data.msg)
                            return false
                        }
                            console.log(this.fileList)
                        })
                }

            },
            // async handleBeforeRemove(file, fileList) {
            //     if (this.localUrl === this.pathName) {
            //     let result = null;
            //     console.log(file, fileList, this.beforeFileList, this.fileList);
            //     //console.log(222,this.beforeFileList,file.name)
            //     let index = this.beforeFileList.map(item => item.name).indexOf(file.name)
            //     console.log(index)
            //     const urls = this.fileList[index];
            //     console.log(urls)
            //     await this.HttpClient.post('/services/destroyFile', {url: urls}).then(res => {
            //         if (res.data.code === 200) {
            //         this.fileList.splice(index, 1);
            //         result = true
            //         } else {
            //         result = false;
            //         file.status = false;
            //         this.$message.error('删除失败');
            //         this.$message.error(res.data.succeed)
            //         }
            //     });
            //     console.log(result)
            //     return result;
            //     }
            // },
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
