<template>
    <div class="uploadVideo">

      <div class="uploadVideo_title"><span>上传视频</span></div>
      <div class="uploadVideo_main">
        <div class="uploadVideo_left">

          <!--上传-->
          <div class="upload_box">
            <el-upload
              action=""
              class="upload_video"
              drag
              :limit='1'
              :show-file-list="false"
              :file-list="videoFileList"
              :on-progress="uploadVideoProcess"
              :before-upload="beforeUploadVideo"
              :on-success="uploadVideoSuccess"
              :before-remove="beforeRemoveVideo"
              :on-remove="uploadVideoRemove"
              :disabled="!!videoId"
              >
              <i class="el-icon-upload" v-if="remarkFlag"></i>
              <div class="el-upload__text" v-if="remarkFlag">
                <p style="font-size: 14px;color: #000">点击选择上传的视频</p>
                <p style="font-size: 12px;color: #8c8c8c">或将视频拖拽到此处</p>
                <br />
                <p style="font-size: 12px;color: #8c8c8c">上传的视频长度在5秒-1小时以内</p>
              </div>
              <video preload="auto" id="videoPlayer" class="up_video" v-if="videoFlag" :src="videoSrc" controls="controls">您的浏览器不支持视频播放</video>
              <el-progress v-if="progressFlag" type="circle" :percentage="videoUploadPercent"
                           style="position: absolute;top: 64px;left: 186px;"></el-progress>
            </el-upload>
            <i @click="handleRemoveVideo" v-if="videoId ? false : videoFlag" class="el-icon-delete" :class="'delete_icon'"></i>

            <!--<el-upload
              class="upload_video_img"
              action=""
              :show-file-list="false"
              :limit="1"
              :on-success="handleImageSuccess"
              :before-remove="handleBeforeImageRemove"
              :on-remove="handleImageRemove"
              :before-upload="beforeImageUpload">
              <img v-if="imageUrl" :src="imageUrl" class="avatar">
              <i v-else class="el-icon-plus avatar-uploader-icon"></i>
              <div class="el-upload__text">
                <p style="font-size: 14px;color: #000">添加封面图</p>
                <p style="font-size: 12px;color: #8c8c8c">JPG/PNG，1M以内</p>
              </div>
            </el-upload>-->
            <div class="mod_uploading_item">
              <div class="uploading_item_video uploading_item_product_video">
                <el-upload
                  class="encyclopedia_cover_box"
                  action="http://test.kslab.com/api/article/null"
                  list-type="picture-card"
                  drag
                  :file-list="imageFileList"
                  :limit="1"
                  :multiple="true"
                  :on-preview="handlePictureCardPreview"
                  :on-remove="handleImageRemove"
                  :before-upload="beforeImageUpload"
                  :before-remove="handleBeforeImageRemove"
                  :on-change="handleImageChange"
                  :on-success="handleImageSuccess"
                  :on-error="handleImageError"
                  :on-exceed="handleImageExceed">
                  <div class="uploading_tips" @dragover.prevent="onDragover" @dragleave="dragLeave">
                    <i class="el-icon-plus" v-show="!dragOver"></i>
                    <p class="encyclopedia_cover_describe" v-show="!dragOver">添加封面图</p>
                    <p class="encyclopedia_cover_suggest" v-show="!dragOver">推荐640x640像素，JPG/PNG,5M以内</p>
                    <div class="el-upload__txt" v-show="dragOver && !dragDone">松开图片以上传</div>
                  </div>
                </el-upload>
                <el-dialog :visible.sync="dialogVisible">
                  <img width="100%" :src="dialogImageUrl" alt="">
                </el-dialog>
              </div>
            </div>
          </div>

          <!--标题-->
          <div class="upload_title">
            <p><i class="icon icon-lunwentimu"></i> 标题</p>
            <el-input v-model="videoData.title" maxlength="20" placeholder="标题限定20字以内"></el-input>
          </div>

          <!--标签-->
          <div class="upload_label">
            <p><i class="icon icon-biaoqian"></i>标签<span>（至少1个标签，最多3个，每个标签2-5个字）</span></p>
            <div class="upload_label_box">
              <el-input
                class="input-new-tag"
                v-model="inputValue"
                maxlength="5"
                ref="saveTagInput"
                size="small"
                @keyup.enter.native="handleInputConfirm"
                @blur="handleInputConfirm"
              >
              </el-input>
              <i class="el-icon-circle-plus" :class="{active:dynamicTags.length>0}" @click="handleInputConfirm"></i>
              <el-tag
                :key="tag"
                v-for="tag in dynamicTags"
                closable
                :disable-transitions="false"
                @close="handleClose(tag)">
                {{tag}}
              </el-tag>

            </div>
          </div>

          <!--视频描述-->
          <div class="upload_description">
            <p><i class="icon icon-neirong"></i>视频描述</p>
            <el-upload
              id="xx"
              style="display: none;"
              class="avatar-uploader up_content"
              action="http://test.kslab.com/api/article/null"
              name="img"
              :show-file-list="false"
              :before-upload="beforeContentUpload">
            </el-upload>
            <quill-editor
              v-model="content"
              :options="editorOption"
              ref="myQuillEditor"
              @blur="onEditorBlur($event)" @focus="onEditorFocus($event)"
              @change="onEditorChange($event,5000)">
            </quill-editor>
          </div>

          <!--类别-->
          <div class="upload_category">
            <p><i class="icon icon-leibieguanli"></i>类别</p>
            <el-radio-group v-model="videoData.category_id">
              <el-radio-button :label="item.menu_id" v-for="(item, index) in videoTypeList" :key="index">
                <i class="icon" :class="item.images"></i>
                <p>{{item.name}}</p>
              </el-radio-button>
            </el-radio-group>
          </div>

          <!--教程-->
          <div class="upload_tutorial">
            <p><i class="icon icon-ziyuan32"></i>是否为教程<span>（选填）</span></p>
            <el-switch
              v-model="videoData.is_course"
              active-color="#15befe"
              inactive-color="#13ce66"
              active-text="教程视频"
              inactive-text="普通视频"
            ></el-switch>
          </div>

          <!--附件-->
          <div class="upload_annex">
            <p><i class="icon icon-icon--"></i>附件<span>(选填，最多5个，每个最大5MB）</span></p>
            <div class="upload_annex_box">
              <el-upload
                action="http://test.kslab.com/api/article/null"
                list-type="picture-card"
                :limit="5"
                :file-list="fileFilesFileList"
                :on-preview="handleFileCardPreview"
                :on-remove="handleFileRemove"
                :before-remove="handleBeforeFileRemove"
                :on-exceed="handleFileExceed"
                :on-change="handleFileChange"
                :on-success="handleFileSuccess"
                :on-error="handleFileError"
                :before-upload="beforeFileUpload">
                <i class="el-icon-plus"></i>
              </el-upload>
              <!--<el-upload
                drag
                multiple
                action="http://test.kslab.com/api/article/null"
                :data="updata"
                list-type="picture-card"
                :limit="5"
                :file-list="fileFilesFileList"
                :on-preview="handleFileCardPreview"
                :on-remove="handleFileRemove"
                :before-remove="handleBeforeFileRemove"
                :on-exceed="handleFileExceed"
                :on-change="handleFileChange"
                :on-success="handleFileSuccess"
                :on-error="handleFileError"
                :before-upload="beforeFileUpload">
              </el-upload>-->
              <el-dialog :visible.sync="dialogVisible">
                <img width="100%" :src="dialogImageUrl" alt="">
              </el-dialog>
            </div>
          </div>

          <div class="partContent">
            <div class="main_head">
              <i class="icon icon-chilun-"></i><p>使用零件/软件<span>（选填）</span></p>
            </div>
            <div class="part_info_content">
              <el-input
                placeholder="添加零件/软件名字"
                v-model="partValue"
                clearable
                @keyup.enter.native="addPart">
                <el-button slot="append" @click="addPart" icon="el-icon-circle-plus"></el-button>
              </el-input>
              <div class="part_list">
                <div class="part_item" v-for="(item, index) in partList" :key="index">
                  <i class="el-icon-delete delete_icon" @click="handleDeletePart(index)"></i>
                  <div class="part_item_content">
                    <p>{{item.partName}}</p>
                    <input type="text" v-model="item.link" placeholder="输入链接...">
                  </div>
                </div>
              </div>
            </div>

          </div>


          <div class="upload_btm">
            <div class="upload_btm_clone">取消</div>
            <div class="upload_btm_submit" @click="handleSubmit"><i class="icon icon-fabu"></i>发布</div>

          </div>
        </div>
      </div>
      <protocol ref="protocol"></protocol>
    </div>
</template>

<script>
  import Protocol from '@/views/upload/protocol';
  import { quillEditor } from 'vue-quill-editor'
  import * as Quill from 'quill'  //引入编辑器

  //quill图片可拖拽改变大小
  import  ImageResize   from 'quill-image-resize-module';
  Quill.register('modules/imageResize', ImageResize);

  //quill图片可拖拽上传
  import { ImageDrop } from 'quill-image-drop-module';
  Quill.register('modules/imageDrop', ImageDrop);

  // 自定义字体大小
  let fontSize = ['10px', '12px', '14px', '16px', '18px', '20px'];
  let Size = Quill.import('attributors/style/size');
  Size.whitelist = fontSize;
  Quill.register(Size, true);

  var fonts = ['SimSun', 'SimHei','Microsoft-YaHei','KaiTi','FangSong','Arial','Times-New-Roman','sans-serif'];
  var Font = Quill.import('formats/font');
  Font.whitelist = fonts; //将字体加入到白名单

  import {container, ImageExtend, QuillWatch} from 'quill-image-extend-module'
  Quill.register('modules/ImageExtend', ImageExtend)

  var toolbarOptions = [
    [ 'italic', 'underline', 'strike','bold'],
    ['blockquote','code-block'],
    // [{'header':1},{'header':2}],
    [{'list':'ordered'},{'list':'bullet'}],
    [{'script':'sub'},{'script':'super'}],
    [{'indent':'-1'},{'indent':'+1'}],
    [{'direction':'rtl'}],
    [{'size':fontSize}],
    // [{'header':[1,2,3,4,5,6,false]}],
    [{'color':[]}],
    // [{'font':fonts}],
    [{'align':[]}],
    // ['clear'],
    ['image']
  ];

  export default {
    name: "uploadVideo",
    components: {
      Protocol
    },
    data(){
      return{
        dragOver: false,
        imageUrl: '',
        // 标签
        dynamicTags: [],
        inputVisible: false,
        inputValue: '',
        // 描述
        content:null,
        editorOption:{
          modules:{
            toolbar:{
              container: toolbarOptions,
              handlers: {
                'image': function () {  // 劫持原来的图片点击按钮事件
                  QuillWatch.emit(this.quill.id)
                }
              }
            },
            imageDrop:true,
            imageResize: {
              displayStyles: {
                backgroundColor: 'black',
                border: 'none',
                color: 'white'
              },
              modules: [ 'Resize', 'DisplaySize', 'Toolbar' ]
            },
            ImageExtend: {
              loading: true,
              name: 'img',
              size:1,
              action: '',
              response: (res) => {
                return res.info
              },
              headers: (xhr) => {
                // xhr.setRequestHeader('myHeader','myValue')
              },  //设置请求头部
              sizeError: () => {
                this.$message.error('图片大小超过限制1M')
              },  // 图片超过大小的回调
              start: () => {},  //自定义开始上传触发事件
              end: () => {},  //自定义上传结束触发的事件，无论成功或者失败
              error: () => {},  //上传失败触发的事件
              success: () => {},  //上传成功触发的事件
              change: (xhr, formData) => {
                // xhr.setRequestHeader('myHeader','myValue')
                // formData.append('token', 'myToken')
              } //每次选择图片触发，也可用来设置头部，但比headers多了一个参数，可设置formData
            },
          }
        },

        // 类别
        uploadCategory: '',
        // 教程
        delivery: false,
        // 视屏
        remarkFlag: true,
        videoSrc: '',
        progressFlag: false,
        videoFlag: false,
        videoUploadPercent: 0, //视屏上传进度
        serial_number: null,
        videoFileList: [],
        videoData: {
          category_id: '',
          title: '',
          description: '',
          serial_number: '',
          video_length: '',
          integrity: '',
          label: [],
          is_course: false,
          source: [],
        },
        fileFilesList: [],
        beforeFilesFileList: [], //上传之后，删除之前的fileList,
        fileFilesFileList: [],
        editFilesFileList: [], //修改服务时获得的路径
        partList: [],
        partValue: '',
        videoTypeList: [], //视屏类型列表
        // 图片
        dialogImageUrl: '',
        dialogVisible: false,
        imageFileList: [], //上传图片列表
        imageFilesFileList: [], // 存储真实的文件路径数组
        beforeImageFileList: [], //上传之后，删除之前的fileList,
        videoId: '', // 视屏id
      }
    },
    created() {
      this.videoData.serial_number = this.Tools.GetNumber();
      this.getVideoType();
      this.videoId = this.$route.query.id;
      if(this.videoId) {
        this.getVideoDetails(this.videoId);
      }
    },
    watch: {

    },
    mounted() {
      console.log(this.videoId)
      if(!this.videoId) {
        this.$refs.protocol.readProtocol = true;
        this.$refs.protocol.handleTimer();
      }
    },
    methods: {
      /******
       * 获取视屏分类
       *
       */
      getVideoType() {
        this.HttpClient.post('/category/list',{type: 7, level: 1})
          .then(res =>{
            if(res.data.code === 200) {
              this.videoTypeList = res.data.data;
            }
          })
      },
      /******************************上传视屏********************************/

      // region
        /***
         * 上传视屏之前
         */
      async beforeUploadVideo(file) {
          const sizeLimit= file.size / 1024 / 1024 < 20;
          if (['video/mp4', 'video/ogg', 'video/flv', 'video/avi', 'video/wmv', 'video/rmvb'].indexOf(file.type) === -1) {
            this.$message.error('请上传正确的视频格式');
            return false;
          }
          if (!sizeLimit) {
            this.$message.error('上传视频大小不能超过20MB哦!');
            return false;
          }
          this.remarkFlag = false;
          const param = {
            video: file,
            serial_number: this.videoData.serial_number
          };
          this.HttpClient.form('/videos/upload/video', param)
            .then((res) => {
              console.log(res);
              if (res.data.code === 200) {
                this.videoSrc = res.data.path;
                this.videoFlag = true;
                this.progressFlag = false;
                setTimeout(() =>{
                  this.videoData.video_length = $('#videoPlayer')[0].duration;
                },1000);
                this.$message.success('上传成功!')
              } else {
                this.progressFlag = false;
                this.remarkFlag = true;
                this.$message.error(res.data.msg);
                return false;
              }

            })
      },
      /****
       * 删除视屏之前
       */
      beforeRemoveVideo(file, fileList) {
        console.log(file, fileList)
      },
      /****
       * 删除视屏
       */
      uploadVideoRemove(file, fileList) {
        console.log(file, fileList)
      },
      /****
       * 上传进度条
       */
      uploadVideoProcess(event, file) {
        this.progressFlag = true;
        this.videoUploadPercent = parseInt(file.percentage.toFixed(0));
        /*console.log(this.videoUploadPercent);
        console.log($('#videoPlayer').duration)
        setTimeout(() =>{
          console.log($('#videoPlayer'));
          console.log($('#videoPlayer')[0].duration);
          console.log($('#videoPlayer'));
        },500)*/
        if(this.videoUploadPercent === 100) {
          console.log('我到了100');
        }
      },
      /******
       * 上传成功
       */
      uploadVideoSuccess(file, fileList) {
        console.log(file, fileList)
        this.progressFlag = false;
      },
      handleRemoveVideo() {

      },
      //endregion

      /**********************上传图片*********************/

      // region

      beforeImageUpload(file) {
        const isLt2M = file.size / 1024 / 1024 < 5;
        const fileType = file.name.split('.')[1];
        if (fileType !== 'png' && fileType !== 'jpg') {
          this.$message.error('上传头像图片只能是 JPG/PNG 格式!');
          return false;
        }
        if (!isLt2M) {
          this.$message.error('上传头像图片大小不能超过 5MB!');
          return false;
        }
        const param = {
          image_path: file,
          serial_number: this.videoData.serial_number
        };
        this.HttpClient.form('/videos/upload/image', param)
          .then((res) => {
            if (res.data.code === 200) {
              this.dialogImageUrl= res.data.path;
              this.imageFilesFileList.push(res.data.path);
              this.$message.success(res.data.msg)
            } else {
              this.$message.error(res.data.msg)
              return false
            }
          });
      },
      handleImageSuccess(response, file, fileList) {
        this.beforeImageFileList = fileList;
      },
      handleImageError(){
        this.$message.error('上传失败!')
      },
      handleImageExceed(){
        this.$message.warning(`当前限制选择 1 个文件，本次选择了 ${files.length} 个文件，共选择了 ${files.length + fileList.length} 个文件`)
      },
      async handleBeforeImageRemove(file, fileList) {
        let index = this.beforeImageFileList.map(item => item.name).indexOf(file.name)
        console.log(index)
        let urls = this.imageFilesFileList[index];
        if(this.videoId) {
          console.log(this.imageFilesFileList)
          urls = this.imageFilesFileList[0];
          await this.HttpClient.post('/updateDelete', {path: urls}).then(res => {
            if (res.data.code === 200) {
              this.imageFilesFileList = [];
            } else {
              file.status = false;
              this.$message.error('删除失败');
              return false;
            }
          });
        }else {
          await this.HttpClient.post('/services/destroyFile', {url: urls}).then(res => {
            if (res.data.code === 200) {
              this.imageFilesFileList.splice(index, 1);
            } else {
              this.$message.error('删除失败');
              return false;
            }
          });
        }

      },
      handleImageChange(file,fileList){
        if(fileList.length>0){
          this.dragOver=true;
          this.dragDone=true;
        }else{
          this.dragOver=false;
          this.dragDone=false;
        }
      },
      handleImageRemove(file, fileList) {
        console.log(file, fileList);
        if(fileList.length<=0){
          this.dragOver=false;
        }
      },
      // 上传封面图
      handleAvatarSuccess(res, file) {
        this.imageUrl = URL.createObjectURL(file.raw);
      },
      beforeAvatarUpload(file) {
        const isJPG = file.type === 'image/jpeg';
        const isLt2M = file.size / 1024 / 1024 < 2;

        if (!isJPG) {
          this.$message.error('上传图片只能是 JPG 格式!');
        }
        if (!isLt2M) {
          this.$message.error('上传图片大小不能超过 2MB!');
        }
        return isJPG && isLt2M;
      },
      onDragover(){
        this.dragOver=true;
      },
      dragLeave(){
        this.dragOver=false;
      },

      // endregion

      /***********************************文档编辑器**********************************/

      // region

      /**编辑器**/
      onEditorBlur() {//失去焦点事件
      },
      onEditorFocus() {//获得焦点事件
      },
      onEditorChange(e, decimalNum) {//内容改变事件
        //this.content = event.html
        console.log(this.content)
        let lengthcontent = this.content;
        function removeHTMLTag(str) {
          //var str;
          str = str.replace(/<\/?[^>]*>/g, ''); //去除HTML tag
          str = str.replace(/[ | ]*\n/g, '\n'); //去除行尾空白
          str = str.replace(/\n[\s| | ]*\r/g, '\n'); //去除多余空行
          str = str.replace(/ /ig, '');//去掉
          return str;
        }
        console.log(removeHTMLTag(lengthcontent).length)
        e.quill.deleteText(decimalNum, 1);//保留 strValue 的 前 decimalNum 位字符，
        this.$emit('Quescthon', this.content)
        console.log(this.content);
        if (removeHTMLTag(lengthcontent).length < 1001) {
          this.videoData.description = this.content;
        } else {
          this.$message.error('字数超过限制');
        }
      },
      /*****
       * 提交评论时富文本编辑框上传图片
       * @param file
       */
      beforeContentUpload(file) {
        const param = {
          images: file,
          serial_number: this.videoData.serial_number
        };
        this.HttpClient.form('/uploadTestImg', param)
          .then((res) => {
            console.log(res)
            if (res.data.code === 200) {
              let quill = this.$refs.myQuillEditor.quill;
              let length = quill.getSelection().index;
              quill.insertEmbed(length, 'image', res.data.path)
              quill.setSelection(length + 1)
              this.$message.success(res.data.msg)
              //console.log(this.fileList)
            } else {
              this.$message.error(res.data.msg)
              return false
            }

          })
      },

      // endregion

      /*************新增标签*********************/

      // region

      // 新增标签
      handleClose(tag) {
        this.dynamicTags.splice(this.dynamicTags.indexOf(tag), 1);
      },

      showInput() {
        this.inputVisible = true;
        this.$nextTick(_ => {
          this.$refs.saveTagInput.$refs.input.focus();
        });
      },

      handleInputConfirm() {
        let inputValue = this.inputValue;
        if (inputValue) {
          if (this.dynamicTags.length < 3) {
            this.dynamicTags.push(inputValue);
          } else {
            this.$message({
              message: '最多添加三个标签',
              type: 'warning'
            });
          }
        } else {
          this.$message({
            message: '请添加标签内容',
            type: 'warning'
          })
        }
        this.inputValue = '';
        this.$emit("MainTagLength", this.dynamicTags);
        this.videoData.label = this.dynamicTags;
      },

      // 附件
      handleRemove(file, fileList) {
        console.log(file, fileList);
      },
      handlePictureCardPreview(file) {
        this.dialogImageUrl = file.url;
        this.dialogVisible = true;
      },

      // endregion

      /***********上传附件****************/
      // region

      /****
       * 附件删除
       */
      handleFileRemove(file, fileList) {
        if(fileList.length<=0){
          this.dragFilesOver=false;
        }
      },

      /*****
       * 附件预览
       */
      handleFileCardPreview(file) {
        this.dialogFilesImageUrl = file.url;
        this.dialogFilesVisible = true;
      },

      /******
       * 附件限制
       */
      handleFileExceed(files, fileList) {
        this.$message.warning(`当前限制选择 5 个文件，本次选择了 ${files.length} 个文件，共选择了 ${files.length + fileList.length} 个文件`);
      },

      /****
       * 附件改变
       */
      handleFileChange(file,fileList){
        if(fileList.length>0){
          this.dragFilesOver=true;
          this.dragFilesDone=true;
        }else{
          this.dragFilesOver=false;
          this.dragFilesDone=false;
        }
      },

      /*******
       * 附件上传
       */
      beforeFileUpload(file){
        console.log(file)
        const isLt5M = file.size / 1024 / 1024 < 5;
        const fileType = file.name.split('.')[1];
        console.log(fileType)
        if(fileType !== 'txt' && fileType !== 'doc' && fileType !== 'docx'){
          this.$message.error('文档类型只能为txt、doc、docx');
          return false;
        }
        if (!isLt5M) {
          this.$message.error('上传文件大小不能超过5M!')
          return false;
        }
        const param = {
          attachment: file,
          serial_number: this.videoData.serial_number
        };
        this.HttpClient.form('/videos/upload/attachment', param)
          .then((res) => {
            //console.log(res)
            if (res.data.code === 200) {
              this.fileFilesList.push(res.data.path)
              this.$message.success(res.data.msg)
              //console.log(this.fileList)
            } else {
              this.$message.error(res.data.msg)
              return false
            }

          })
      },

      /*****
       * 附件删除
       */
      async handleBeforeFileRemove(file, fileList) {
        let result = null;
        console.log(file, fileList, this.beforeFilesFileList, this.fileFilesList);
        const isLt5M = file.size / 1024 / 1024 < 5;
        const fileType = file.name.split('.')[1];
        console.log(fileType)
        //console.log(222,this.beforeFileList,file.name)
        let index = this.beforeFilesFileList.map(item => item.name).indexOf(file.name)
        console.log(index)
        let urls = this.fileFilesList[index];
        if(this.$route.query.id) {
          console.log(this.editFilesFileList)
          urls = this.Tools.handleImg(this.editFilesFileList[index].url);
        }
        console.log(urls)
        if(this.videoId) {
          await this.HttpClient.post('/updateDelete', {path: urls}).then(res => {
            if (res.data.code === 200) {
              this.fileFilesList.splice(index, 1);
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
              this.fileFilesList.splice(index, 1);
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

      /*****
       * 上传成功
       */
      handleFileSuccess(response, file, fileList){
        console.log(file, fileList)
        this.beforeFilesFileList = fileList;
      },

      /*****
       * 上传失败
       */
      handleFileError(err, file, fileList){
        this.$message.error('上传失败！');
        console.log(file);
      },
      onFileDragover(){
        this.dragFilesOver=true;
      },
      dragFileLeave(){
        this.dragFilesOver=false;
      },
      // endregion

      /********************************零部件*********************/
      // region
      /*****
       * 删除字零部件
       */
      handleDeletePart(index) {
        this.partList.splice(index, 1);
        this.videoData.source = this.partList;
      },
      /*****
       * 添加零部件
       */
      addPart() {
        console.log(this.partValue)
        if(this.partValue !== '') {
          this.partList.push({
            partName: this.partValue,
            link: ''
          });
          console.log(this.partList)
          this.videoData.source = this.partList;
        }else {
          this.$message.error('零件名称不能为空')
        }
      },

      // endregion

      /***********************视屏提交*********************/

      // region

      /***
       * 视屏提交
       */
      handleSubmit() {
        this.videoData.is_course = this.videoData.is_course?1:0;
        if(this.videoData.is_course === 1) {
          this.videoData.integrity = 100;
        }else if(this.videoData.is_course === 0) {
          if(parseInt(this.videoData.video_length) >= 3*60) {
            this.videoData.integrity = 20;
          }else {
            this.videoData.integrity = 0;
          }
          if(this.videoData.description.length > 150) {
            this.videoData.integrity += 15;
          }
          const len = this.videoData.label.length;
          this.videoData.integrity += len * 20;
        }

        console.log(this.videoData)
        if(this.videoId) {
          delete this.videoData.serial_number;
          this.videoData.video_id = this.videoId;
          this.HttpClient.post('/my/video/edit', this.videoData)
            .then(res =>{
              if(res.data.code === 200) {
                this.$message.success('发布成功');
                //this.$router.go(-1);
              }else {
                this.$message.error(res.data.msg);
              }
            })

        }else {
          this.HttpClient.post('/videos/upload', this.videoData)
            .then(res =>{
              if(res.data.code === 200) {
                this.$message.success('发布成功');
                this.$router.go(-1);
              }else {
                this.$message.error(res.data.msg);
              }
            })
        }

      },
      /*****
       * 获取视屏详情
       * @param id
       */
      getVideoDetails(id) {
        this.HttpClient.post('/my/video/info',{video_id: id})
          .then(res =>{
            if(res.data.code === 200) {
              console.log(res)
              const data = res.data.data;
              this.videoData = {
                video_id: id,
                category_id: data.category_id,
                description: data.description,
                label: data.label,
                source: data.source,
                title: data.title,
                serial_number: id,
              };
              this.videoSrc = this.Tools.handleImg(data.video_url);
              this.remarkFlag = false;
              this.videoFlag = true;
              this.imageFileList = [{
                name: 'xx',
                url: this.Tools.handleImg(data.cover)
              }];
              this.beforeImageFileList = this.imageFileList;
              this.imageFilesFileList = [this.Tools.handleImg(data.cover)];
              console.log(this.imageFilesFileList)
              this.content = data.description;
              data.attachment.map(item =>{
                this.fileFilesFileList.push({
                  name: item.name,
                  url: item.path
                })
              })
              this.beforeFilesFileList = this.fileFilesFileList;
              this.editFilesFileList = this.fileFilesFileList;
              this.partList = data.source;
              this.dynamicTags = data.label;
            }
          })
      }

      // endregion

    }
  }
</script>
<style>
  .mod_uploading .mod_uploading_main .main_type_select{
    position:relative;
    width:800px;
    display:flex;
    justify-content:flex-start;
  }
  .mod_uploading .mod_uploading_main .el-steps--vertical{
    position:relative;
    top:43px;
  }
  .mod_uploading .mod_uploading_main .el-step.is-vertical .el-step__head{
    width:44px!important;
    transition:height .3s ease-in;
  }
  .mod_uploading .mod_uploading_main .el-step__head.is-wait{
    height:0;
    overflow:hidden;
  }
  .mod_uploading .mod_uploading_main .el-step__head.is-wait,
  .mod_uploading .mod_uploading_main .el-step__head.is-process{
    color:#ccc!important;
    border-color:#ccc!important;
  }
  .mod_uploading .main_type_select .el-step__head.is-finish{
    color:#15bafe!important;
    border-color:#15bafe!important;
  }
  .mod_uploading .mod_uploading_main .el-step__head .el-step__line{
    transition:height .3s ease-in;
  }
  .mod_uploading .mod_uploading_main .el-step__head.is-process .el-step__line{
    height:0;
    overflow:hidden;
  }
  .mod_uploading .mod_uploading_main .el-step__head.is-finish .el-step__line{
    height:100%;
  }
  .mod_uploading .mod_uploading_main .el-step__head.is-wait .el-step__icon,
  .mod_uploading .mod_uploading_main .el-step__head.is-process .el-step__icon{
    background:#ccc!important;
  }
  .mod_uploading .main_type_select .el-step__head.is-finish .el-step__icon{
    background:#15bafe!important;
  }
  .mod_uploading .mod_uploading_main .el-step__head.is-wait .el-step__icon{
    height:0!important;
  }
  .mod_uploading .main_type_select .el-step.is-vertical .el-step__line{
    top:5px!important;
    bottom:-4px!important;
    left:4.5px!important;
    width:0;
    border:1px dashed #ccc;
    background:none;
  }
  .mod_uploading .main_type_select .el-step__line-inner{
    border-color:#15bafe;
    position:absolute;
    left:-1px;
  }
  .mod_uploading .main_type_select .el-step__icon{
    width:11px!important;
    height:11px!important;
    transition:height 0s ease-in .3s;
    overflow:hidden;
    border:none;
  }
  .mod_uploading .main_type_select .el-step.is-vertical .el-step__main{
    display:none!important;
  }
  .encyclopedia_cover_box{
    overflow:hidden;
    width:270px;
    height:270px;
    background:#f4f4f4;
    /*border:1px dashed #cbcbcb;*/
    text-align:center;
  }

  .encyclopedia_cover_box .encyclopedia_cover_box .el-upload-list--picture-card .el-upload-list__item{
    width: 270px !important;
    height: 270px !important;
    margin: 0 !important;
  }

  .encyclopedia_cover_box .el-upload--picture-card{
    width:270px!important;
    height:270px!important;
    line-height:initial!important;
    border:none;
    background:#f4f4f4;
  }
  .encyclopedia_cover_box .el-upload--picture-card .el-upload-dragger{
    width:270px!important;
    height:270px!important;
    border:1px dashed #ccc!important;
  }
  .encyclopedia_cover_box .el-upload--picture-card .el-upload-dragger:hover{
    border-color:#15bafe!important;
  }
  .encyclopedia_cover_box .el-upload--picture-card i{
    margin-top:100px;
  }
  .encyclopedia_cover_box .el-upload--picture-card .encyclopedia_cover_describe{
    color:#aaaaaa;
    font-size:18px;
  }
  .encyclopedia_cover_box .el-upload--picture-card .encyclopedia_cover_suggest{
    color:#aaaaaa;
  }
  .encyclopedia_cover_box .el-upload-list--picture-card .el-upload-list__item{
    width:270px;
    height:270px;
  }
  .encyclopedia_cover_box .el-progress__text{
    left:-15px;
  }
  .mod_uploading .uploading_encyclopedia_info .uploading_tips{
    height:270px;
  }
  .mod_uploading .uploading_encyclopedia_info .uploading_tips .el-upload__txt{
    margin-top:150px;
    font-size:16px;
  }
  .mod_uploading .uploading_encyclopedia_info .encyclopedia_info_details .main_txt{
    vertical-align:middle;
  }
  .mod_uploading .uploading_encyclopedia_info .encyclopedia_info_details .main_title_input{
    width:779px;
    border:none;
    border-radius:0;
    border-bottom:1px solid #dcdcdc;
  }
  .mod_uploading .uploading_encyclopedia_info .encyclopedia_info_details .main_tag_add_box{
    width:779px;
    border-bottom:1px solid #dcdcdc;
  }
  .mod_uploading .uploading_encyclopedia_info .encyclopedia_info_details .main_tag_add_box.active{
    padding-right:20px;
  }
  .mod_uploading .uploading_encyclopedia_info .encyclopedia_info_details .el-input{
    width:50%;
  }
  .mod_uploading .uploading_encyclopedia_info .encyclopedia_info_details .el-input__inner{
    border:none;
  }
  .mod_uploading .uploading_encyclopedia_info .encyclopedia_info_details .el-icon-circle-plus{
    float:left;
    color:#d2d2d2;
    font-size:20px;
    padding:0 10px;
    /*margin-right:10px;*/
    /*border-right:1px solid #dcdcdc;*/
    vertical-align:middle;
  }
  .mod_uploading .uploading_encyclopedia_info .encyclopedia_info_details .el-icon-circle-plus.active{
    margin-right:10px;
    border-right:1px solid #dcdcdc;
  }
  .mod_uploading .uploading_encyclopedia_info .encyclopedia_info_details .el-tag{
    float:right;
  }
  .mod_uploading .uploading_encyclopedia_info .encyclopedia_info_details .uploading_main_item{
    width:779px;
  }
  .mod_uploading .uploading_encyclopedia_info .encyclopedia_info_details .quill-editor{
    width:100%;
  }
  .mod_uploading .uploading_encyclopedia_info .encyclopedia_info_details .main_type_list_describe{
    width:179px;
    right:30px;
  }
  .mod_uploading .uploading_encyclopedia_info .encyclopedia_info_details .main_type_list{
    width:100%;
  }
  /*.mod_uploading .uploading_encyclopedia_info .encyclopedia_info_details .list_item{*/
  /*width:137.53px;*/
  /*}*/
  /*.mod_uploading .uploading_encyclopedia_info .encyclopedia_info_details .type_list_nav{*/
  /*border-color:#fff;*/
  /*}*/
  .mod_uploading .uploading_encyclopedia_info .encyclopedia_info_details .type_list_nav:first-child:before{
    left:6%;
  }
  .mod_uploading .uploading_encyclopedia_info .encyclopedia_info_details .type_list_nav:nth-child(2):before{
    left:23%;
  }
  .mod_uploading .uploading_encyclopedia_info .encyclopedia_info_details .type_list_nav:nth-child(3):before{
    left:40%;
  }
  .mod_uploading .uploading_encyclopedia_info .encyclopedia_info_details .type_list_nav:last-child:before{
    left:56.5%;
  }

</style>
<style lang="less">
  .partContent{
    .main_head{
      display: flex;
      margin-bottom: 10px;
      i{
        font-size: 16px;
        color: #15BAFE;
      }
      p{
        font-size: 15px;
        margin-left: 10px;
      }
    }
    .part_info_content{
      .part_list{
        .part_item{
          margin-top: 10px;
          display: flex;
          .delete_icon{
            color: white;
            font-size: 22px;
            cursor: pointer;
          }
          .delete_icon:hover{
            color: #15BAFE;
          }
          .part_item_content{
            display: flex;
            border-bottom: 1px solid #f2f2f2;
            padding-bottom: 5px;
            flex: 1;
            p{
              padding: 2px 5px;
              border: 1px solid #f2f2f2;
            }
            input{
              border: none;
              flex: 1;
              margin-left: 10px;
              white-space: nowrap;
            }
          }
        }
      }
    }
  }
</style>
<style lang="less">
  .uploadVideo{
    padding: 30px 0;
    background: #f2f2f2;
    /*标题*/
    .uploadVideo_title{
      max-width: 1200px;
      min-width: 980px;
      display: flex;
      margin: 0 auto;
      span{
        display: inline-block;
        padding: 0 20px;
        height: 50px;
        background-color: #fff;
        border: 1px solid #dedede;
        border-bottom: none;
        line-height: 50px;
        font-size: 20px;
      }
    }
    .uploadVideo_main{
      max-width: 1200px;
      min-width: 980px;
      margin: 0 auto;
      border: 1px solid #dedede;
      background-color: #fff;
      padding: 30px;
      display: flex;
      justify-content: space-between;

      /*左侧*/
      .uploadVideo_left{
        width: 70%;

        /*icon/标题*/
        >div{
          margin-bottom: 20px;
          >p{
            font-size: 16px;
            color: #000;
            margin-bottom: 10px;
            .icon{
              font-size: 16px;
              color: #15befe;
              margin-right: 10px;
            }
            span{
              font-size: 12px;
              color: #666;
            }
          }
        }

        /*上传盒子*/
        .upload_box{
          display: flex;
          justify-content: space-between;
          align-items: center;
          /*上传视频*/
          .upload_video{
            /*上传框样式*/
            .el-upload-dragger{
              height: 270px;
              width: 500px;
            }
            .up_video{
              width: 100%;
              height: 100%;
              position: absolute;
              top: 0;
              left: 0;
            }

          }
          .delete_icon{
            position: relative;
            top: -115px;
            font-size: 18px;
            color: #808080;
            left: -30px;
            cursor: pointer;
          }
          .delete_icon:hover{
            color: #15BAFE;
            cursor: pointer;
          }

          /*上传封面*/
          .upload_video_img{
            .el-upload {
              border: 1px dashed #d9d9d9;
              border-radius: 6px;
              cursor: pointer;
              position: relative;
              overflow: hidden;
              width: 270px;
              height: 270px;
            }
            .el-upload:hover {
              border-color: #409EFF;
            }
            .avatar-uploader-icon {
              font-size: 28px;
              color: #8c939d;
              text-align: center;
              margin: 80px 0 16px;
              line-height: 50px;
            }
            .avatar {
              width: 270px;
              height: 270px;
              display: block;
            }
          }
        }

        /*标题*/
        .upload_title{

        }

        /*标签*/
        .upload_label{
          .upload_label_box{
            display: flex;
            align-items: center;
            border: 1px solid #dcdfe6;
            overflow: hidden;
            border-radius: 4px;
            padding-right: 10px;
            /*输入框*/
            .input-new-tag{
              margin-right: 10px;
              .el-input__inner{
                border: none;
                border-right: 1px solid #dedede;
                border-radius: unset;
              }
            }
            /*标签*/
            .el-tag:not(:last-child){
              margin-right: 5px;
            }
            .el-tag{
              background: none;
              border: 1px solid #15bafe;
              color: #15bafe;
              border-radius: 3px;
              padding: 0 5px;
              height: 25px;
              line-height: 23px;
            }
          }
        }

        /*描述*/
        .upload_description{
          .ql-editor{
            height: 250px;
          }
        }

        /*类别*/
        .upload_category{
          .el-radio-button{
            margin-right: 10px;
          }
          /*初始化样式*/
          .el-radio-button__inner{
            border: none;
            border-radius: 0;
            width: 140px;
            height: 140px;
            text-align: center;
            line-height: 30px;
            padding-top: 40px;
            i{
              font-size: 40px;
            }
          }
          /*选中样式*/
          .el-radio-button__orig-radio:checked+.el-radio-button__inner{
            background-color: #15befe;
          }
        }

        /*附件*/
        .upload_annex{
          .upload_annex_box{
            border: 1px solid #dcdfe6;
            border-radius: 4px;
            padding: 10px;
            /*上传按钮*/
            .el-upload--picture-card{
              background: none;
              border: none;
              border-radius: unset;
              width: 80px;
              height: 80px;
              line-height: 90px;
              i {
                font-size: 28px;
                color: #fff;
                border: 1px solid;
                border-radius: 50%;
                padding: 10px;
                background-color: #dedede;
              }
            }
            /*上传文件框*/
            .el-upload-list__item.is-uploading{
              width: 80px;
              height: 80px;
              line-height: 80px;
              margin: unset;
            }
          }
        }

        /*取消/发布按钮*/
        .upload_btm{
          display: flex;
          align-items: center;
          justify-content: flex-end;
          .upload_btm_clone{
            margin-right: 20px;
            color: #15befe;
          }
          .upload_btm_submit{
            background: #15befe;
            color: #fff;
            .icon{
              margin-right: 5px;
              font-size: 22px;
            }
          }
          .upload_btm_clone,
          .upload_btm_submit{
            display: flex;
            justify-content: center;
            align-items: center;
            height: 33px;
            padding: 0 20px;
            border: 1px solid #15befe;
            border-radius: 4px;
            font-size: 14px;
          }
        }

      }
    }
  }
</style>
