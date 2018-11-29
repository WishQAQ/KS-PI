<template>
    <div>
        <div class="mod_uploading_item">
            <div class="uploading_item_video uploading_item_product_video">
                <el-upload
                        class="avatar-uploader service_upload"
                        :show-file-list="false"
                        action="http://test.kslab.com/api/article/null"
                        :on-success="handleSuccess"
                        :on-remove="handleRemove"
                        :before-upload="beforeUploadVideo">
                    <div class="upload_tips" v-if="videoVisible">
                        <i class="el-icon-upload" v-show="!dragOver"></i>
                        <span class="upload_tips_txt" v-show="!dragOver">(选填)</span>
                        <div class="el-upload__text" v-show="!dragOver">将视频拖到此处，或<em>点击上传</em></div>
                        <span class="upload_tips_suggest" v-show="!dragOver">视频长度在30s以内，小于等于20MB</span>
                        <span class="dragOver_txt" v-show="dragOver && !dragDone">松开视频以上传</span>
                    </div>
                    <video class="up_video" v-if="!videoVisible" :src="videoSrc" controls="controls">您的浏览器不支持视频播放</video>
                    <el-progress v-if="videoFlag==true" type="circle" :percentage="videoUploadPercent" style="margin-top:65px;"></el-progress>
                </el-upload>
            </div>
        </div>
        <div class="mod_uploading_describe">
            <uploading-main-title :mainTxt="title" @ArticletitleName="ArticletitleName"></uploading-main-title>
            <div class="uploading_main_item uploading_main_synopsis">
                <div class="main_head">
                    <i class="icon icon_synopsis"></i>
                    <span class="main_txt">简介</span>
                </div>
                <el-input
                        type="textarea"
                        :rows="2"
                        @change="handleDescription"
                        maxlength="50"
                        placeholder="简介限定50字以内"
                        v-model="textarea">
                </el-input>
            </div>
        </div>
    </div>
</template>

<script>

    import UploadingMainTitle from '@/views/upload/uploadingMainTitle'
    import moment from 'moment';

    export default {
        name: "uploadingMainSynopsis",
        props: ['video'],
        data(){
            return {
                title:'标题',
                textarea:'',
                dragOver:false,
                dragDone:false,
                videoFlag:false,
                videoUploadPercent:0,
                videoSrc: '',
                videoVisible: true,
                childData: {
                  video: null, //视频编次号
                  title: null,
                  description: ''
                },
              localUrl: window.location.pathname,
              pathName: '/home/uploadingService'
            }
        },
        components:{
            UploadingMainTitle
        },
        created() {
          console.log(window.location.pathname)
          console.log(this.$store.state.serviceUpload.serviceUploadData);
          this.childData.video = this.$store.state.serviceUpload.serviceUploadData;
        },
        methods:{
          /**
           * 获取简介
           */
          handleDescription(value) {
            if(this.localUrl === this.pathName){
              this.childData.description = value;
              const serviceData = {
                description: value
              };
              this.$store.dispatch('getServiceUploadData',serviceData).then(res =>{
                console.log(this.$store.state.serviceUpload.serviceUploadData)
              });
            }

          },
          /***
           * 获取title
           */
          ArticletitleName(value) {
            if(this.localUrl === this.pathName) {
              this.childData.title = value;
              const serviceData = {
                title: value
              };
              this.$store.dispatch('getServiceUploadData',serviceData).then(res=>{
                console.log(this.$store.state.serviceUpload.serviceUploadData)
              });
            }

          },

            handleSuccess(response, file, fileList){
                this.$message.success('上传成功!')
            },
            handleError(){
                this.$message.error('上传失败!')
            },
            async beforeUploadVideo(file) {
              console.log(file)
              console.log(this.childData.video)
                const isLt10M = file.size / 1024 / 1024  < 20;
                if (['video/mp4', 'video/ogg', 'video/flv','video/avi','video/wmv','video/rmvb'].indexOf(file.type) === -1) {
                    this.$message.error('请上传正确的视频格式');
                    this.dragOver=false;
                    this.dragDone=false;
                    this.videoFlag=false;
                    return false;
                }
                if (!isLt10M) {
                    this.$message.error('上传视频大小不能超过20MB哦!');
                    return false;
                }
                if(this.localUrl === this.pathName) {
                  var FromData = new FormData()
                  //文章上传图片接口
                  FromData.append('token',window.localStorage.token)
                  FromData.append('video',file)
                  FromData.append('serialnum',this.childData.video)
                  await this.$ajax.post(this.request.axiosPort+this.request.axiosApi+'services/uploadVideo',FromData)
                    .then((res) => {
                      console.log(res)
                      if(res.data.code === 200){
                        this.videoSrc = res.data.path;
                        this.videoVisible = false;
                      }else{
                        this.$message.error(res.data.msg);
                        return false;
                      }

                    })
                }

            },
          /***
           * 删除video之前
           */
            handleBeforeRemove(file, fileList) {

            },
          handleRemove(file) {

          },
          handlePreview(file) {
              console.log(file)
            this.videoSrc = file.url
          },
            uploadVideoProcess(event, file, fileList){
              console.log(file,file.percentage)
              this.videoFlag = true;
              this.videoUploadPercent = file.percentage;
            },
            handleChange(file,fileList){
                console.log(fileList);
                if(fileList.length>0){
                    this.dragOver=true;
                    this.dragDone=true;
                }else{
                    this.dragOver=false;
                    this.dragDone=false;
                    this.videoFlag=false;
                }
              this.videoUploadPercent = file.percentage;
            },
            onDragover(){
                this.dragOver=true;
            },
            dragLeave(){
                this.dragOver=false;
            },
          /***
           * 获取唯一值
           * @returns {string}
           */
          handleSerialNum() {
            return moment().format('YYYYMMDDHHmmssS')
          },

        }
    }
</script>

<style scoped>
    .upload_tips{
      margin-top: 80px;
    }
    .upload_tips_txt{
        position:absolute;
        top:10px;
        right:10px;
        color:#8c8c8c;
    }
    .el-upload-dragger .el-icon-upload{
        margin-top:55px;
    }
    .upload_tips_suggest{
        position:absolute;
        bottom:10px;
        right:41px;
        font-size:12px;
        color:#8c8c8c;
    }
    .dragOver_txt{
        display:block;
        margin-top:94px;
        font-size:14px;
    }
</style>
<style lang="less">
  .service_upload{
    width: 100%;
    height: 100%;
    .el-upload{
      height: 100%;
      width: 100%;
    }
    .up_video{
      width: 100%;
      height: 100%;
      object-fit: fill;
    }
  }
</style>
