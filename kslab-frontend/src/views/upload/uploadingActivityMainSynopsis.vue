<template>
  <div>
    <div class="mod_uploading_item">
      <div class="uploading_item_video uploading_item_product_video">
        <el-upload
          ref="uploads"
          class="avatar-uploader service_upload"
          action="http://test.kslab.com/api/article/null"
          :on-success="handleSuccess"
          :show-file-list="false"
          :file-list="deleteFile"
          :on-remove="handleRemove"
          :before-upload="beforeUploadVideo">
          <div class="upload_tips" v-if="videoVisible">
            <i class="el-icon-upload up_icon" v-show="!dragOver"></i>
            <span class="upload_tips_txt" v-show="!dragOver">(选填)</span>
            <div class="el-upload__text" v-show="!dragOver">将视频拖到此处，或<em>点击上传</em></div>
            <span class="upload_tips_suggest" v-show="!dragOver">视频长度在30s以内，小于等于20MB</span>
            <span class="dragOver_txt" v-show="dragOver && !dragDone">松开视频以上传</span>
          </div>
          <video class="up_video" v-if="!videoVisible" :src="videoSrc" controls="controls">您的浏览器不支持视频播放</video>
          <el-progress v-if="videoFlag==true" type="circle" :percentage="videoUploadPercent"
                       style="margin-top:65px;"></el-progress>
        </el-upload>
        <i @click="handleRemoveVideo" v-if="!videoVisible" class="el-icon-delete" :class="'delete_icon'"></i>
      </div>
    </div>
    <div class="mod_uploading_describe">
      <uploading-service-main-title :mainTxt="titles" :title="data.title"
                                    @ArticleTitleName="ArticleTitleName"></uploading-service-main-title>
      <div class="uploading_main_item uploading_main_synopsis">
        <div class="main_head">
          <i class="icon icon_synopsis"></i>
          <span class="main_txt">简介</span>
        </div>
        <el-input
          type="textarea"
          :rows="2"
          @change="handleDescription"
          minlength="29"
          maxlength="129"
          placeholder="简介限定30-130字以内"
          v-model="textarea">
        </el-input>
      </div>
    </div>
  </div>
</template>

<script>

  import UploadingServiceMainTitle from '@/views/upload/uploadingServiceMainTitle'
  import moment from 'moment';

  export default {
    name: "uploadingMainSynopsis",
    props: ['video', 'data'],
    data() {
      return {
        titles: '标题',
        textarea: '',
        dragOver: false,
        dragDone: false,
        videoFlag: false,
        videoUploadPercent: 0,
        videoSrc: '',
        videoVisible: true,
        childData: {
          video: null, //视频编次号
          title: null,
          content: ''
        },
        deleteFile: [],
      }
    },
    components: {
      UploadingServiceMainTitle
    },
    created() {
      this.childData.video = this.$store.state.activityUpload.activityUploadData.serial_number;
    },
    methods: {
      /**
       * 获取简介
       */
      handleDescription(value) {
        this.childData.content = value;
        const activityData = {
          description: this.textarea
        };
        this.$store.dispatch('getActivityUploadData', activityData).then(res => {
          console.log(this.$store.state.activityUpload.activityUploadData)
        });

      },
      /***
       * 获取title
       */
      ArticleTitleName(value) {
        this.childData.title = value;
        const activityData = {
          title: value
        };
        this.$store.dispatch('getActivityUploadData', activityData).then(res => {
          console.log(this.$store.state.activityUpload.activityUploadData)
        });

      },

      handleSuccess(response, file, fileList) {
        // this.$message.success('上传成功!')
        this.deleteFile = fileList;
        console.log(this.deleteFile)
      },
      handleError() {
        this.$message.error('上传失败!')
      },
      async beforeUploadVideo(file) {
        console.log(file)
        console.log(this.childData.video)
        const isLt20M = file.size / 1024 / 1024 < 20;
        if (['video/mp4', 'video/ogg', 'video/flv', 'video/avi', 'video/wmv', 'video/rmvb'].indexOf(file.type) === -1) {
          this.$message.error('请上传正确的视频格式');
          this.dragOver = false;
          this.dragDone = false;
          this.videoFlag = false;
          return false;
        }
        if (!isLt20M) {
          this.$message.error('上传视频大小不能超过20MB哦!');
          return false;
        }
        var FromData = new FormData();
        //活动上传视频接口
        FromData.append('token', window.localStorage.token);
        FromData.append('video', file);
        FromData.append('type', 1); //1第一次上传 2编辑时上传
        FromData.append('serial_number', this.childData.video);
        await this.$ajax.post(this.request.axiosPort + this.request.axiosApi + 'actives/uploadVideo', FromData)
          .then((res) => {
            console.log(res);
            if (res.data.code === 200) {
              this.$store.dispatch('getActivityUploadData', {video: res.data.path.slice(res.data.path.indexOf('video'))}).then(res => {
                console.log(this.$store.state.activityUpload.activityUploadData)
              });
              this.videoSrc = res.data.path;
              this.videoVisible = false;
              this.$message.success('上传成功!')
            } else {
              this.$message.error(res.data.msg);
              return false;
            }

          })
      },
      /***
       * 删除video之前
       */
      handleBeforeRemove(file, fileList) {

      },
      handleRemove(file) {
        console.log('delete', file)
      },
      /***
       * 删除视屏
       */
      handleRemoveVideo() {
        const isLt20M = file.size / 1024 / 1024 < 20;
        if (['video/mp4', 'video/ogg', 'video/flv', 'video/avi', 'video/wmv', 'video/rmvb'].indexOf(file.type) === -1) {
          this.$message.error('请上传正确的视频格式');
          return false;
        }
        if (!isLt20M) {
          this.$message.error('上传视频大小不能超过20MB哦!');
          return false;
        }
        console.log(11111)
        this.HttpClient.post('/services/destroyFile', {url: this.videoSrc}).then(res => {
          if (res.data.code === 200) {
            this.$refs.uploads.clearFiles();
            this.deleteFile = [];
            this.videoSrc = '';
            this.videoVisible = true;
            this.$message.success('删除成功');
          } else {
            this.$message.error('删除失败');
          }
        });

      },
      handlePreview(file) {
        console.log(file)
        this.videoSrc = file.url
      },
      uploadVideoProcess(event, file, fileList) {
        console.log(file, file.percentage)
        this.videoFlag = true;
        this.videoUploadPercent = file.percentage;
      },
      handleChange(file, fileList) {
        console.log(fileList);
        if (fileList.length > 0) {
          this.dragOver = true;
          this.dragDone = true;
        } else {
          this.dragOver = false;
          this.dragDone = false;
          this.videoFlag = false;
        }
        this.videoUploadPercent = file.percentage;
      },
      onDragover() {
        this.dragOver = true;
      },
      dragLeave() {
        this.dragOver = false;
      },
      /***
       * 获取唯一值
       * @returns {string}
       */
      handleSerialNum() {
        return moment().format('YYYYMMDDHHmmssS')
      },

    },
    watch: {
      data: {
        handler() {
          this.textarea = this.$store.state.activityUpload.activityUploadData.description;
          this.deleteFile = [];
          this.deleteFile.push({url: this.request.picUrl + this.$store.state.activityUpload.activityUploadData.video});
          this.videoSrc = this.request.picUrl + this.$store.state.activityUpload.activityUploadData.video;
          if (this.data.video) {
            this.videoVisible = false
          }
        },
        deep: true
      }
    }
  }
</script>

<style scoped>
  .upload_tips {
    margin-top: 80px;
  }

  .up_icon {
    font-size: 20px;
  }

  .upload_tips_txt {
    position: absolute;
    top: 10px;
    right: 10px;
    color: #8c8c8c;
  }

  .el-upload-dragger .el-icon-upload {
    margin-top: 55px;
  }

  .upload_tips_suggest {
    position: absolute;
    bottom: 10px;
    right: 41px;
    font-size: 12px;
    color: #8c8c8c;
  }

  .dragOver_txt {
    display: block;
    margin-top: 94px;
    font-size: 14px;
  }
</style>
<style lang="less">
  .service_upload {
    position: relative;
    width: 100%;
    height: 100%;
    .el-upload {
      height: 100%;
      width: 100%;
    }
    .up_video {
      width: 100%;
      height: 100%;
      object-fit: fill;
    }
    .icon_delete {

    }

  }

  .uploading_item_video {
    position: relative;
    .delete_icon {
      font-size: 20px;
      cursor: pointer;
      position: absolute;
      right: 10px;
      top: 10px;
      z-index: 1000;
    }
    .delete_icon:hover {
      font-size: 20px;
      cursor: pointer;
      position: absolute;
      right: 10px;
      top: 10px;
      color: #15bafe;
      z-index: 1000;
    }
  }
</style>
