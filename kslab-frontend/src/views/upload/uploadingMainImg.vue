<template>
  <div class="uploading_main_item uploading_main_img">
    <div class="main_head">
      <i class="icon icon_img"></i>
      <span class="main_txt">图片展示</span>
      <span class="main_txt_describe">(最多8张，最大5兆)</span>
    </div>
    <el-upload
      class="uploading_img_box"
      action="http://test.kslab.com/api/article/null"
      drag
      list-type="picture-card"
      :limit="8"
      :multiple="true"
      :on-preview="handlePictureCardPreview"
      :on-change="handleChange"
      :before-remove="handleBeforeRemove"
      :on-success="handleUpSuccess"
      :on-exceed="handleExceed"
      :on-remove="handleRemove"
      :before-upload="beforeAvatarUpload">
      <div class="uploading_tips" @dragover.prevent="onDragover" @dragleave="dragLeave">
        <i class="el-icon-plus" v-show="!dragOver"></i>
        <div class="el-upload__text" v-show="!dragOver">将图片拖到此处，或<em>点击上传</em></div>
        <div class="el-upload__txt" v-show="dragOver && !dragDone">松开图片上传</div>
      </div>
    </el-upload>
    <el-dialog :visible.sync="dialogVisible">
      <img width="100%" :src="dialogImageUrl" alt="">
    </el-dialog>
  </div>
</template>

<script>


  export default {
    name: "uploadingMainImg",
    props: ['axiosHTTP'],        //父组件传递过来接口
    data() {
      return {
        dialogImageUrl: '',
        dialogVisible: false,
        dragOver: false,
        dragDone: false,
        pathImg: '',
        serialnum: null,
        fileList: [],
        beforeFileList: [], //上传之后，删除之前的fileList,
        localUrl: window.location.pathname,
        pathName: '/home/uploadingService'
      }
    },
    methods: {
      /***********************图片上传*********************************/
      handleRemove(file, fileList) {
        console.log(file, fileList);
      },
      handlePictureCardPreview(file) {
        this.dialogImageUrl = file.url;
        this.dialogVisible = true;
      },
      handleChange(file, fileList) {
        if (fileList.length > 0) {
          this.dragDone = true;
        } else {
          this.dragOver = false;
          this.dragDone = false;
        }
      },
      handleExceed(files, fileList) {
        this.$message.warning(`当前限制选择 8 个文件，本次选择了 ${files.length} 个文件，共选择了 ${files.length + fileList.length} 个文件`);
      },
      beforeAvatarUpload(file) {
        const isJPG = file.type === 'image/jpeg';
        const isPNG = file.type === 'image/png';
        const isLt2M = file.size / 1024 / 1024 < 5;

        if (!isJPG && !isPNG) {
          this.$message.error('上传图片只能是 JPG/PNG 格式!');
        }
        else {
          //this.HttpAjax(file)   //调用上传接口
        }
        if (!isLt2M) {
          this.$message.error('上传图片大小不能超过 5MB!');
        }
        /***
         * 服务上传页面
         * by zxd
         */
        if (this.localUrl === this.pathName) {
          var FromData = new FormData()
          //文章上传图片接口
          FromData.append('token', window.localStorage.token)
          FromData.append('images', file)
          FromData.append('serialnum', this.serialnum)
          this.$ajax.post(this.request.axiosPort + this.request.axiosApi + 'services/uploadImg', FromData)
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
        }

        return isJPG || isPNG && isLt2M;
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
      /****
       * 图片上传成功
       * @param response
       * @param file
       * @param fileList
       */
      handleUpSuccess(response, file, fileList){
        //console.log(111,file, fileList)
        /***
         * 服务上传页面
         * by zxd
         */
        if (this.localUrl === this.pathName) {
          this.beforeFileList = fileList;
        }

      },
      onDragover() {
        this.dragOver = true;
      },
      dragLeave() {
        this.dragOver = false;
      },
      XMLHttpPost() {
        this.httpPost = String(this.post);
      },
      //上传接口
      HttpAjax(file) {
        var AoxisHttp = new FormData()
        AoxisHttp.append("source", file)
        this.$ajax.post(this.axiosHTTP, AoxisHttp)
          .then((res) => {
            this.pathImg = res.data.data.path
            this.transmitmodule()
            this.$message({
              message: res.data.msg,
              type: 'success'
            });
          })
      },
      //传给父组件 公司注册
      transmitmodule() {
        this.$emit('TransmitModule', this.pathImg)
      }
    },
    created() {
      //this.XMLHttpPost();
      this.serialnum = this.$store.state.serviceUpload.serviceUploadData.images;
    }
  }
</script>

<style scoped>
  .Fuc-Img-cont > .kv-main > .uploading_main_img > .uploading_img_box > .el-upload-list > .el-upload-list__item {
    width: 100%;
    height: 210px !important;
  }

  .uploading_img_box {
    position: relative;
    width: 800px;
    background: #fff;
  }
</style>
