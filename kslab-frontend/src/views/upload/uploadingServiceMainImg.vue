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
      :file-list="imageFileList"
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


  import * as cfg from "../../../config/app";

  export default {
    name: "uploadingMainImg",
    props: ['axiosHTTP', 'serviceImgData'],        //父组件传递过来接口
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
        pathName: '/home/uploadingService',
        imageFileList: [],
        editFileList: [], //修改服务时获得的路径
      }
    },
    watch: {
      serviceImgData: {
        handler(newData, oldData) {
          console.log(newData, oldData)
          const images = newData.images;
          let array = [];
          images.map((item, index) => {
            var temp = {
              name: item.name,
              url: this.handleImg(item.path)
            };
            array.push(temp)
          });
          console.log(array)
          this.imageFileList = array;
          this.beforeFileList = array;
          this.editFileList = newData.images;
          this.serialnum = newData.serial_number;
        },
        deep: true
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
        const isLt5M = file.size / 1024 / 1024 < 5;

        const fileType = file.name.split('.')[1];
        if (fileType !== 'png' && fileType !== 'jpg') {
          this.$message.error('上传图片只能是 JPG/PNG 格式!');
          return false;
        }
        if (!isLt5M) {
          this.$message.error('上传图片大小不能超过 5MB!');
          return false;
        }
        /***
         * 服务上传页面
         * by zxd
         */
        var FromData = new FormData()
        //文章上传图片接口
        FromData.append('token', window.localStorage.token)
        FromData.append('images', file)
        FromData.append('serial_number', this.serialnum)
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

        return isJPG || isPNG && isLt5M;
      },
      async handleBeforeRemove(file, fileList) {
        /***
         * 服务上传页面
         * by zxd
         */
        const isLt5M = file.size / 1024 / 1024 < 5;
        const fileType = file.name.split('.')[1];
        if (fileType !== 'png' && fileType !== 'jpg') {
          this.$message.error('上传图片只能是 JPG/PNG 格式!');
          return false;
        }
        if (!isLt5M) {
          this.$message.error('上传图片大小不能超过 5MB!');
          return false;
        }
        let result = null;
        console.log(file, fileList, this.beforeFileList, this.fileList);
        //console.log(222,this.beforeFileList,file.name)
        let index = this.beforeFileList.map(item => item.name).indexOf(file.name)
        console.log(index)
        let urls = this.fileList[index];
        if (this.$route.query.id) {
          urls = this.handleImg(this.editFileList[index].path);
        }
        console.log(urls)
        if (this.$route.query.id) {
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
        } else {
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

      },
      /****
       * 图片上传成功
       * @param response
       * @param file
       * @param fileList
       */
      handleUpSuccess(response, file, fileList) {
        console.log(111, file, fileList)
        /***
         * 服务上传页面
         * by zxd
         */
        this.beforeFileList = fileList;

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
      },
      /***
       * 图片格式化
       * @param url
       * @returns {*}
       */
      handleImg(url) {
        return cfg.imageUrl + url;
      },
    },
    created() {
      //this.XMLHttpPost();
      this.serialnum = this.$store.state.serviceUpload.serviceUploadData.serial_number;
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
