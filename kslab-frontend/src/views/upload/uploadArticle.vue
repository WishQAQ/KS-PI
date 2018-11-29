<script src="../../../config/test.js"></script>
<template>
  <div class="body uploading_background">
    <section>
      <div class='mod_uploading_head'><div class='uploading_head_txt'>上传文章</div></div>
      <div class="mod_uploading mod_uploading_article">
        <div class="mod_uploading_main">
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
                :before-remove="beforeImageRemove"
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
          <div class="mod_uploading_describe">
            <div class="uploading_main_item uploading_main_title">
              <div class="main_head">
                <i class="icon icon_title "></i>
                <span class="main_txt">标题</span>
              </div>
              <input type="text" class="main_title_input" placeholder="标题限定25字以内" v-model="articleData.title" maxlength="25">
              <div class="mod_uploading_date">
              </div>
            </div>
            <div class="uploading_main_item uploading_main_synopsis">
              <div class="main_head">
                <i class="icon icon_synopsis"></i>
                <span class="main_txt">简介</span>
              </div>
              <el-input
                type="textarea"
                :rows="2"
                maxlength="50"
                placeholder="简介限定50字以内"
                v-model="articleData.profile">
              </el-input>
            </div>
          </div>
          <div class="uploading_main_item uploading_main_content">
            <div class="main_head">
              <i class="icon icon_content"></i>
              <span class="main_txt">内容描述</span>
              <span class="tip">(最多100字)</span>
            </div>
            <div id='edit'>
              <quill-editor
                v-model="content"
                ref="myQuillEditor"
                :options="editorOption"
                @blur="onEditorBlur($event)" @focus="onEditorFocus($event)"
                @change="onEditorChange($event,5000)">
              </quill-editor>
            </div>
          </div>
          <!--标签-->
          <div class="uploading_main_item uploading_main_tag">
            <div class="main_head">
              <i class="icon icon_tag"></i>
              <span class="main_txt">标签</span>
              <span class="main_txt_describe">(至少1个标签,最多3个，每个2~5个字)</span>
            </div>
            <div class="main_tag_add">
              <div class="main_tag_add_box" :class="{active: dynamicTags.length>0}">
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
                <div class="main_tag_list">
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
            </div>
          </div>
          <!--类别-->
          <div class="upload_article_category">
            <div class="main_head">
              <i class="icon icon-leibieguanli"></i>
              <span class="main_txt">类别</span>
            </div>
            <el-radio-group v-model="articleData.category_id">
              <el-radio-button :label="item.menu_id" v-for="(item, index) in articleTypeList" :key="index">
                <i class="icon" :class="item.images"></i>
                <p>{{item.name}}</p>
              </el-radio-button>
            </el-radio-group>
          </div>
          <!--零部件-->
          <!--<div class="partContent">
            <div class="main_head">
              <i class="icon icon-chilun-"></i>
              <span class="main_txt">使用零件/软件</span>
              <span class="main_txt_describe" style="margin-top: 6px;">（选填）</span>
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
          </div>-->
          <!--附件-->
          <div class="upload_annexes">
            <div class="main_head">
              <i class="icon icon-icon--"></i>
              <span class="main_txt">附件</span>
              <span class="main_txt_describe">(选填，最多5个，每个最大5MB）</span>
            </div>
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
              <el-dialog :visible.sync="dialogVisible">
                <img width="100%" :src="dialogImageUrl" alt="">
              </el-dialog>
            </div>
          </div>
        </div>
        <div class="upload_btm">
          <div class="upload_btm_clone">取消</div>
          <div class="upload_btm_submit" @click="handleSubmit"><i class="icon icon-fabu"></i>发布</div>
        </div>
      </div>
    </section>
    <aside>
      <floating-div></floating-div>
    </aside>
    <!-- <protocol-div ref="protocol"></protocol-div> -->
  </div>
</template>

<script>

  import FloatingDiv from '@/components/floating'
  import ProtocolDiv from '@/views/upload/protocol'
  import MainItemTips from '@/views/upload/mainItemTips'
  import UploadingMainTag from '@/views/upload/uploadingMainTag'
  import UploadingMainFile from '@/views/upload/uploadingMainFile'
  import UploadingMainPart from '@/views/upload/uploadingMainPart'
  import UploadingMainTitle from '@/views/upload/uploadingMainTitle'
  import ModUploadingConfirm from '@/views/upload/modUploadingConfirm'
  import UploadingMainContent from '@/views/upload/uploadingMainContent'


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
    name: "uploadingArticle",
    data(){
      return {
        articleId: '', // 文章id
        dragOver: false,
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
        imageFileList: [], //上传图片列表
        imageFilesFileList: [], // 存储真实的文件路径数组
        beforeImageFileList: [], //上传之后，删除之前的fileList,
        dialogVisible:false,
        dialogImageUrl:'',
        articleData: {
          category_id: '', // 分类id
          title: '', // 文章标题
          profile: '', // 文章简介
          content: '', // 文章描述
          label: [], // 文章标签
          integrity: '', // 文章完善度
          //source: [], // 使用零件
          serial_number: ''
        },
        // 标签
        dynamicTags: [], // 标签数组
        inputVisible: false,
        inputValue: '', // 单个标签的值
        articleTypeList: [], // 文章类型别
        // 零部件
        partList: [], // 零部件数组
        partValue: '', // 零部件单个值
        // 附件
        fileFilesList: [], // 文档列表el-uplaod自定义的文件数组
        beforeFilesFileList: [], //上传之后，删除之前的fileList,
        fileFilesFileList: [], // 存储真实的文件路径数组
        editFilesFileList: [], //修改服务时获得的路径
      }
    },
    components:{
      FloatingDiv,
      ProtocolDiv,
      MainItemTips,
      UploadingMainTag,
      UploadingMainFile,
      UploadingMainPart,
      UploadingMainTitle,
      UploadingMainContent,
      ModUploadingConfirm
    },
    created(){
      this.articleData.serial_number = this.Tools.GetNumber();
      this.getArticleTypeList();
      if(this.$route.query.id) {
        this.articleId = this.$route.query.id;
        this.getArticleDetail(this.articleId);
      }

    },
    mounted(){
    },
    methods:{
      /************************文档编辑器****************************/
      // region
      /**编辑器**/
      onEditorBlur() {//失去焦点事件
      },
      onEditorFocus() {//获得焦点事件
      },
      onEditorChange(e, decimalNum) {//内容改变事件
        //this.content = event.html
        console.log(this.content);
        let lengthcontent = this.content;
        function removeHTMLTag(str) {
          //var str;
          str = str.replace(/<\/?[^>]*>/g, ''); //去除HTML tag
          str = str.replace(/[ | ]*\n/g, '\n'); //去除行尾空白
          str = str.replace(/\n[\s| | ]*\r/g, '\n'); //去除多余空行
          str = str.replace(/ /ig, '');//去掉
          return str;
        }
        //console.log(removeHTMLTag(lengthcontent).length);
        e.quill.deleteText(decimalNum, 1);//保留 strValue 的 前 decimalNum 位字符，
        this.$emit('Quescthon', this.content);
        //console.log(this.content);
        if (removeHTMLTag(lengthcontent).length < 1001) {
          this.articleData.content = this.content;
        } else {
          this.$message.error('字数超过限制');
        }
      },
      /*****
       * 提交评论时富文本编辑框上传图片
       * @param file
       */
      beforeContentUpload(file) {
        var FromData = new FormData();
        //文章上传图片接口
        FromData.append('token', window.localStorage.token);
        FromData.append('images', file);
        FromData.append('serial_number', this.videoData.serial_number);
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
              quill.insertEmbed(length, 'image', res.data.path);
              quill.setSelection(length + 1);
              this.$message.success(res.data.msg);
              //console.log(this.fileList)
            } else {
              this.$message.error(res.data.msg);
              return false
            }

          })
      },
      // endregion

      /************************新增标签******************************/
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
        } else if(this.dynamicTags.length < 1) {
          this.$message({
            message: '请添加标签内容',
            type: 'warning'
          })
        }
        this.inputValue = '';
        this.$emit("MainTagLength", this.dynamicTags);
        this.articleData.label = this.dynamicTags;
      },

      // endregion

      /************************封面图********************************/
      // region
      handleImageRemove(file, fileList) {
        console.log(file, fileList);
        if(fileList.length<=0){
          this.dragOver=false;
        }
      },
      handleImageSuccess(response, file, fileList){
        this.beforeImageFileList = fileList;
      },
      handleImageError(){
        this.$message.error('上传失败!')
      },
      handleImageExceed(){
        this.$message.warning(`当前限制选择 1 个文件，本次选择了 ${files.length} 个文件，共选择了 ${files.length + fileList.length} 个文件`)
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
      handlePictureCardPreview(file) {
        this.dialogImageUrl = file.url;
        this.dialogVisible = true;
      },
      async beforeImageUpload(file) {
        console.log(file)
        const isLt5M = file.size / 1024 / 1024 < 5;
        const fileType = file.name.split('.')[1];
        if (fileType !== 'png' && fileType !== 'jpg') {
          this.$message.error('上传头像图片只能是 JPG/PNG 格式!');
          return false;
        }
        if (!isLt5M) {
          this.$message.error('上传头像图片大小不能超过 5MB!');
          return false;
        }
        const param = {
          image_path: file,
          serial_number: this.articleData.serial_number
        };
        await this.HttpClient.form('/article/uploadimage',param)
          .then(res =>{
            console.log(res);
            this.dialogImageUrl= res.data.path;
            this.imageFilesFileList.push(res.data.path);
            if(this.articleId) {
              this.imageFileList = [{
                name: 'xx',
                url: res.data.path
              }];
            }
            this.$message.success('上传成功!');
          });
      },
      async beforeImageRemove(file, fileList) {
        console.log(file)
        let urls;
        console.log(this.articleId)
        if(this.articleId !== '' && this.articleId !== null && this.articleId !== 'undefined') { // 假删除，提交成功后真删
          console.log(this.imageFileList)
          urls = this.imageFileList[0].url;
          console.log(urls)
          await this.HttpClient.post('/updateDelete', {path: urls}).then(res => {
            if (res.data.code === 200) {
              //this.imageFileList = [];
            } else {
              file.status = false;
              this.$message.error('删除失败');
              return false;
            }
          });
        }else {
          let index = this.beforeImageFileList.map(item => item.name).indexOf(file.name);
          console.log(index);
          let urls = this.imageFilesFileList[index];
          await this.HttpClient.post('/services/destroyFile', {url: urls}).then(res => { // 真实删除
            if (res.data.code === 200) {
              this.imageFilesFileList.splice(index, 1);
            } else {
              this.$message.error('删除失败');
              return false;
            }
          });
        }
      },
      onDragover(){
        this.dragOver=true;
      },
      dragLeave(){
        this.dragOver=false;
      },
      // endregion

      /************************类别事件******************************/
      // region
      getArticleTypeList() {
        this.HttpClient.post('/category/list',{type: 6, level: 1})
          .then(res =>{
            if(res.data.code === 200) {
              this.articleTypeList = res.data.data;
            }
          })
      },
      // endregion

      /***********************零部件*********************************/
      // region
      /*/!*****
       * 删除字零部件
       *!/
      handleDeletePart(index) {
        this.partList.splice(index, 1);
        this.articleData.source = this.partList;
      },
      /!*****
       * 添加零部件
       *!/
      addPart() {
        console.log(this.partValue)
        if(this.partValue !== '') {
          this.partList.push({
            partName: this.partValue,
            link: ''
          });
          console.log(this.partList)
          this.articleData.source = this.partList;
        }else {
          this.$message.error('零件名称不能为空')
        }
      },*/

      // endregion

      /**********************上传附件********************************/
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
        console.log(file);
        const isLt5M = file.size / 1024 / 1024 < 5;
        const fileType = file.name.split('.')[1];
        console.log(fileType);
        if(fileType !== 'txt' && fileType !== 'doc' && fileType !== 'docx'){
          this.$message.error('文档类型只能为txt、doc、docx');
          return false;
        }
        if (!isLt5M) {
          this.$message.error('上传文件大小不能超过5M!');
          return false;
        }
        var FromData = new FormData();
        //文章上传图片接口
        FromData.append('token', window.localStorage.token);
        FromData.append('attachment', file);
        FromData.append('serial_number', this.articleData.serial_number)
        this.$ajax.post(this.request.axiosPort + this.request.axiosApi + 'article/uploadattachment', FromData)
          .then((res) => {
            //console.log(res)
            if (res.data.code === 200) {
              this.fileFilesList.push(res.data.path);
              this.$message.success(res.data.msg);
              //console.log(this.fileList)
            } else {
              this.$message.error(res.data.msg);
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
        //console.log(222,this.beforeFileList,file.name)
        let index = this.beforeFilesFileList.map(item => item.name).indexOf(file.name)
        console.log(index);
        let urls = this.fileFilesList[index];
        if(this.$route.query.id) {
          urls = this.editFilesFileList[index].url;
        }
        console.log(urls);
        if(this.$route.query.id) {
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
              result = true;
            } else {
              result = false;
              file.status = false;
              this.$message.error('删除失败');
              this.$message.error(res.data.succeed)
            }
          });
        }


        console.log(result);
        return result;

      },

      /*****
       * 上传成功
       */
      handleFileSuccess(response, file, fileList){
        console.log(file, fileList);
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

      /**********************提交文章********************************/
      //region
      handleSubmit() {
        console.log(this.articleData);
        const len = this.articleData.label.length;
        if(len > 0) {
          this.articleData.integrity = len * 20;
        }else {
          this.$message.warning('标签不能为空')
        }
        if(this.articleData.content > 600) {
          this.articleData.integrity += 40;
        }
        if(this.articleId) {
          console.log(this.articleData);
          delete this.articleData.serial_number;
          this.HttpClient.post('/my/article/edit',this.articleData) // 文章修改
            .then(res =>{
              if(res.data.code === 200) {
                this.$message.success('修改文章成功');
              }else {
                this.$message.error(res.data.msg)
              }
            })
        }else {
          this.HttpClient.post('/article/upload',this.articleData) // 文章创建
            .then(res =>{
              if(res.data.code === 200) {
                this.$message.success('发布文章成功');
              }else {
                this.$message.error(res.data.msg)
              }
            })
        }
      },
      //endregion

      /***********************获取文章详情***************************/
      getArticleDetail(id) {
        this.HttpClient.post('/my/article/info', {article_id: id})
          .then(res =>{
            if(res.data.code === 200) {
              console.log(res.data);
              const data = res.data.data;
              this.articleData = {
                article_id: data.article_id,
                category_id: data.category_id,
                title: data.title,
                profile: data.profile,
                content: data.content,
                label: data.label,
                serial_number: data.article_id,
              };
              this.dialogImageUrl = data.image_path;
              this.content = data.content;
              this.dynamicTags = data.label;
              this.imageFileList = [{
                name: 'xx',
                url: this.Tools.handleImg(data.image_path),
              }];
              if(data.attachment) {
                data.attachment.map((item) =>{
                  this.fileFilesFileList.push({
                    name: item.name,
                    url: this.Tools.handleImg(item.path)
                  })
                });
                this.beforeFilesFileList = this.fileFilesFileList;
                this.editFilesFileList = this.fileFilesFileList;
              }
            }
          })
      }

    },

  }
</script>
<style lang="less">
  /*附件*/
  .upload_annexes{
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
</style>
<style lang="less" scoped>
  /*取消/发布按钮*/
  .upload_btm{
    display: flex;
    align-items: center;
    justify-content: flex-end;
    width: 70%;
    padding-bottom: 10px;
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
<style scoped>
  .uploading_background{
    background:#f2f2f2;
    padding-bottom: 30px;
  }
  .mod_uploading{
    position:relative;
    display:block;
    width:62.5%;
    margin:0 auto;
    background:#fff;
    padding-bottom:43px;
    width:1200px;
    border-top:1px solid #dcdcdc;
    box-shadow: 0 2px 5px 0 rgba(34, 24, 21, 0.16);
  }
  .mod_uploading_head{
    display:block;
    /* width:62.5%; */
    margin:0 auto 0;
    padding-top: 30px;
    background:#f2f2f2;
    width:1200px;
  }
  .mod_uploading_head .uploading_head_txt{
    width:14.42%;
    height:51px;
    border:1px solid #dedede;
    background:#fff;
    border-left:none;
    border-bottom:none;
    line-height:51px;
    font-size:24px;
    font-weight:800;
    text-align:center;
    box-shadow: 0 5px 5px 0 rgba(34, 24, 21, 0.16);
  }
  .mod_uploading .mod_uploading_main{
    margin:23px 0 0 21px;
  }
  .mod_uploading .mod_uploading_main .uploading_main_item{
    position:relative;
    margin-bottom:31px;
  }
  .mod_uploading .mod_uploading_main .main_head{
    margin-bottom:7px;
  }
  .icon_title {
    width: 24px;
  }
  .mod_uploading .mod_uploading_main .icon{
    height:24px;
    vertical-align:bottom;
  }
  .mod_uploading .mod_uploading_main .main_txt{
    font-size:20px;
    font-weight:800;
  }
  .mod_uploading .mod_uploading_main .main_txt_describe{
    font-size:14px;
    margin-left:8px;
    vertical-align:middle;
  }
  .mod_uploading .mod_uploading_main .main_title_input{
    width:800px;
    height:32px;
    border:1px solid #ccc;
    border-radius:5px;
    /*outline:#15bafe;*/
    padding-left:10px;
    box-sizing:border-box;
  }
  .mod_uploading .mod_uploading_main .main_title_input:hover{
    border-color:#aaa;
  }
  .mod_uploading .mod_uploading_main .main_title_input:focus{
    border-color:#15bafe;
  }
  .mod_uploading .mod_uploading_main .main_tag_input{
    width:27.75%;
    height:30px;
    padding-left:12px;
    border:1px solid #dcdcdc;
    border-radius:5px;
  }
  .mod_uploading_main .main_tag_add .icon_add_sm{
    width:20px!important;
    height:20px!important;
    line-height:20px;
    border-radius:50%;
    background:#d2d2d2;
    color:#fff;
    font-size:12px;
    text-align:center;
    cursor:pointer;
    vertical-align:middle;
    margin-left:10px;
    margin-right:24px;
  }
  .mod_uploading_main .main_tag_add .main_tag_view{
    display:inline-block;
    vertical-align:middle;
  }
  .main_tag_add .main_tag_view .list_item{
    display:inline-block;
    position:relative;
    font-size:14px;
    color:#15bafe;
    padding:2px 5px;
    margin-right:9px;
    border:1px solid #15bafe;
    border-radius:5px;
  }
  .main_tag_view .list_item .icon_delete{
    position:absolute;
    top:-5px;
    right:-19px;
    width:10px!important;
    height:10px!important;
    cursor:pointer;
  }
  .mod_uploading .uploading_main_file .main_file_list{
    display:block;
    width:50%;
    height:141px;
    border:1px solid #dcdcdc;
  }
  .mod_uploading .uploading_main_file .figure_list{
    display:inline-block;
  }
  .mod_uploading .uploading_main_type .icon_type{
    width:20px;
    height:24px;
  }
  .mod_uploading .mod_uploading_main .main_type_list{
    display:inline-block;
    margin-top:14px;
    margin-bottom:85px;
    width:50%;
  }
  .mod_uploading_main .main_type_list .list_item{
    display:inline-block;
    position:relative;
    width:120px;
    height:120px;
    border:1px solid transparent;
    margin-right:10px;
    text-align:center;
    cursor:pointer;
    box-sizing:border-box;
    background:#fff;
    user-select:none;
  }
  .mod_uploading_main .main_type_list .list_item.active{
    border-color:#dfdfdf;
    box-shadow:1px 1px 5px 1px #dfdfdf;
  }
  .mod_uploading_main .main_type_list .list_item:hover{
    border-color:#dfdfdf;
    box-shadow:1px 1px 5px 1px #dfdfdf;
  }
  .mod_uploading_main .main_type_list .type_content_img_box{
    display:block;
    margin:27px auto 0;
    /*overflow:hidden;*/
  }
  .mod_uploading_main .main_type_list .type_content_img_box .icon{
    width:auto;
    height:36px;
    line-height:36px;
    font-size:28px;
    color:#ccc;
    margin-right:0;
  }
  .mod_uploading_main .main_type_list .list_item.active .type_content_img_box .icon{
    color:#15bafe;
  }
  .mod_uploading_main .main_type_list .type_content_img_box .icon.icon-motuoche{
    font-size:50px;
  }
  .mod_uploading_main .main_type_list .type_content_img_box .icon.icon-wurenji--,
  .mod_uploading_main .main_type_list .type_content_img_box .icon-zhinengshebei{
    font-size:32px;
  }


  .main_type_list .type_content_txt{
    position:relative;
    margin-top:4px;
    text-align:center;
  }
  .main_type_list .type_content_txt .content_txt_title{
    display:inline-block;
    width:63px;
    word-break: keep-all;
    text-align:justify;
    text-align-last:justify;
  }
  .main_type_list .type_content_txt .content_txt_type{
    position:absolute;
    left:50%;
    width:59px;
    text-align:center;
    margin-left:-29.5px;
  }
  .mod_uploading_main .main_type_list .content_txt_title{
    font-size:16px;
    font-weight:800;
  }
  .mod_uploading .main_type_list .type_list_class{
    position:relative;
  }
  .mod_uploading .main_type_list .type_list_nav{
    /*position:absolute;*/
    float:left;
    background:#fff;
    /*padding:22px 35px 29px 33px;*/
    /*margin-top:28px;*/
    font-size:14px;
    color:#fff;
    width:535px;
    height:331px;
    text-align:left;
    margin-top:8px;
    /*border-top:8px solid #fff;*/
    z-index:1;
  }
  .mod_uploading .main_type_list .type_list_nav:first-child{
    z-index:10;
  }
  .mod_uploading .main_type_list .type_list_nav:before{
    display:block;
    position:absolute;
    top:-8px;
    left:8%;
    content:'';
    width:0;
    height:0;
    border:9px solid transparent;
    border-bottom-color:#fff;
  }
  .mod_uploading .main_type_list .type_list_nav:nth-child(2):before{
    left:31%;
  }
  .mod_uploading .main_type_list .type_list_nav:nth-child(3):before{
    left:52.5%;
  }
  .mod_uploading .main_type_list .type_list_nav:nth-child(4):before{
    left:75.5%;
  }
  .mod_uploading  .type_list_nav ul{
    display:inline-block;
    vertical-align:top;
  }
  .mod_uploading  .type_list_nav .list_nav_father{
    width:100%;
    /*padding-right:49px;*/
    border:1px solid #f2f2f2;
    box-shadow:0 2px 4px 0 rgba(0,0,0,.12), 0 0 6px 0 rgba(0,0,0,.04);
  }
  .mod_uploading  .type_list_nav .nav_father_item{
    display:inline-block;
    width:50%;
    padding:7px 13px 7px 13px;
    box-sizing:border-box;
    text-align:center;
  }
  .mod_uploading  .type_list_nav .nav_father_item:hover{
    background-color: #fafafa;
  }
  .mod_uploading  .type_list_nav .nav_father_item.active{
    background-color:#fafafa;
  }
  .mod_uploading  .type_list_nav .nav_father_item:nth-child(odd){
    border-right:1px solid #f2f2f2;
  }
  /*.mod_uploading  .type_list_nav .nav_father_item:nth-child(even) .list_nav_txt{*/
  /*margin-left:52px;*/
  /*}*/
  /*.mod_uploading  .type_list_nav .list_nav_children{*/
  /*margin-left:51px;*/
  /*}*/
  .mod_uploading  .type_list_nav .list_nav_slide{
    content:'';
    display:inline-block;
    width:0;
    height:0;
    border-top-width:7px;
    border-bottom-width:7px;
    border-left-width:2px;
    border-right-width:2px;
    border-color:transparent;
    border-style:solid;
  }
  .mod_uploading  .type_list_nav .list_nav_slide.active{
    border-color:#fff;
  }
  .mod_uploading  .type_list_nav a{
    color:#666;
  }
  .mod_uploading .mod_uploading_main .main_type_list_describe{
    display: inline-block;
    position:absolute;
    top:52px;
    width:211px;
    height:467px;
    border:1px solid #e0e0e0;
    border-radius:5px;
    background:#fff;
    box-shadow:0 1px 7px rgba(0,0,0,.5);
  }
  .mod_uploading_main .main_type_list_describe .type_describe_title{
    width:100%;
    height:34px;
    line-height:34px;
    background:#f0f0f0;
    font-size:16px;
  }
  .mod_uploading_main .main_type_list_describe .icon_baike{
    margin-left:9px;
    margin-right:10px;
  }
  .mod_uploading_main .main_type_list_describe .type_describe_content{
    margin:15px;
    font-size:14px;
  }

  /******************************确认按钮*******************************/
  .mod_uploading .mod_uploading_confirm{
    position:absolute;
    bottom:50px;
    right:52px;
  }
  .mod_uploading .mod_uploading_confirm a{
    display:inline-block;
    padding:5px 12px;
    border:1px solid #15bafe;
    border-radius:5px;
    font-size:14px;
    transition:all .1s ease-in-out;
  }
  .mod_uploading .mod_uploading_confirm a.active{
    color:#fff;
    background:#15bafe;
  }
  .mod_uploading .mod_uploading_confirm .icon_release{
    width:22px;
    height:19px;
    vertical-align:middle;
  }
  .mod_uploading .mod_uploading_confirm a.active .icon_release{
    background:url("/static/img/icon/release_1.png") 0 0 no-repeat;
  }

  /******************************提示信息******************************/
  .mod_uploading .main_item_tips{
    display:block;
    position:absolute;
    top:54px;
    right:35px;
    width:310px;
    background:#fff;
    border-radius:5px;
    box-shadow:0 1px 7px rgba(0,0,0,.5);
  }
  .mod_uploading .main_item_tips.scroll{
    width:310px;
  }
  .mod_uploading .main_item_tips .main_tips_title{
    height:30px;
    line-height:30px;
    background:#f4f4f4;
    text-align:center;
    font-size:16px;
    border-top-left-radius:5px;
    border-top-right-radius:5px;
  }
  .mod_uploading .main_item_tips .main_item_tips_list{
    margin: 15px 20px 15px 15px;
    overflow: hidden;
  }.mod_uploading .main_item_tips_list .list_item{
     text-align: left;
     color: #888;
     letter-spacing: normal;
     line-height: 22px;
     white-space: nowrap;
   }
  @media screen and (max-width: 1200px) {
    .mod_uploading_head{
      width: 960px;
    }
    .mod_uploading{
      width: 960px;
    }
  }

</style>
<style>
  /*.mod_uploading .mod_uploading_main .main_type_list{*/
  /*margin-bottom:0!important;*/
  /*}*/
  /*.mod_uploading .main_type_list .list_item{*/
  /*width:114px!important;*/
  /*height:114px!important;*/
  /*background:#fff;*/
  /*}*/
  .mod_uploading .uploading_main_img .main_img_view{
    width:50%;
    height:141px;
    border:1px solid #f4f4f4;
    background:#fff;
  }
  /*.mod_uploading .uploading_main_img{*/
  /*margin-bottom: 0!important;*/
  /*}*/
  .mod_uploading .main_city_detail{
    margin-top:11px;
  }
  .mod_uploading .main_city_detail .main_city_map{
    width:800px;
    height:361px;
  }
  .mod_uploading .main_city_detail .main_city_address{
    margin-top:16px;
    margin-bottom:13px;
  }
  .mod_uploading .main_city_detail .main_city_txt{
    color:#939393;
    font-size:16px;
  }
  .mod_uploading .main_city_detail .main_city_input{
    width:30%;
    padding:6px 13px;
    font-size:16px;
    outline:none;
    border-radius:5px;
    border:1px solid #eee;
  }
  .mod_uploading .main_city_detail .main_city_input:focus{
    border-color:#15bafe;
  }
  .mod_uploading .main_city_detail .main_city_address_txt,
  .mod_uploading .main_city_detail .main_city_tel_txt{
    font-size:14px;
  }
  .mod_uploading .main_city_tel .main_city_input{
    width:15%;
  }
  .mod_uploading .uploading_main_price,
  .mod_uploading .uploading_main_people{
    display:inline-block;
  }
  .mod_uploading .uploading_main_people{
    margin-left:42px;
  }
  .mod_uploading .uploading_main_people .main_price_num{
    padding-left:10px;
  }
  .mod_uploading .main_price_detail{
    margin-top:22px;
  }
  .mod_uploading select{
    padding:8px 26px 8px 13px;
    font-size:14px;
    outline:none;
    margin-right:15px;
    border:1px solid #eee;
  }
  select {
    border:none;
    appearance:none;
    -moz-appearance:none;
    -webkit-appearance:none;
    background: url("/static/img/icon/bottom_video.png") no-repeat scroll 90% center #fff;
    padding-right: 14px;
  }
  select::-ms-expand { display: none; }
  option:hover{
    background:#15bafe!important;
    border:none;
    outline:none;
  }
  .mod_uploading .main_price_detail .main_price_input{
    position:relative;
  }
  .mod_uploading .main_price_num{
    width:100px;
    /*margin-left:15px;*/
    padding:8px 0 8px 29px;
    box-sizing:border-box;
    border:none;
    outline:none;
    border:1px solid #eee;
  }
  .mod_uploading .main_price_detail .icon_price{
    position:absolute;
    top:-7px;
    right:60px;
  }
  .mod_uploading .mod_uploading_confirm{
    position:initial!important;
    width:821px;
    text-align:right;
  }
  .mod_uploading .mod_uploading_confirm a:first-child{
    margin-right:10px;
  }
  .uploading_img_box .el-upload-list--picture-card .el-upload-list__item,
  .main_file_upload .el-upload-list--picture-card .el-upload-list__item{
    width:80px;
    height:80px;
  }
  .uploading_img_box .el-upload--picture-card,
  .main_file_upload .el-upload--picture-card{
    width:80px;
    height:80px;
    line-height:90px;
  }
  .uploading_img_box .el-progress-circle,
  .main_file_upload .el-progress-circle{
    position:relative;
    width:80px!important;
    height:80px!important;
    left:5px;
  }
  .uploading_img_box .el-progress__text,
  .main_file_upload .el-progress__text{
    left:-15px;
  }

  /********************************上传活动******************************/
  .mod_uploading .time_date_activity{
    margin-left:7px;
    width:30%;
    padding-bottom:10px;
    border-bottom:1px solid #d1d1d1;
  }
  .mod_uploading .time_date_activity .time_date_activity_txt{
    font-size:16px;
    margin-left:13px;
    margin-right:13px;
  }
  .mod_uploading .time_date_activity input{
    width:14.9%;
    border:none;
    background:transparent;
    font-size:18px;
    color:#15bafe;
    text-align:center;
  }
  .mod_uploading.mod_uploading_activity .mod_uploading_main .uploading_item_product_video,
  .mod_uploading.mod_uploading_service .mod_uploading_main .uploading_item_product_video{
    width:280px;
    height:226px;
    border: 1px dotted #cccccc;
  }
  .mod_uploading.mod_uploading_activity .mod_uploading_main .uploading_item_product_video:hover{
    border:1px dotted #15bafe!important;
  }
  .mod_uploading.mod_uploading_activity .mod_uploading_main .mod_uploading_describe .main_title_input,
  .mod_uploading.mod_uploading_service .mod_uploading_main .mod_uploading_describe .main_title_input{
    width:504px;
  }
  .mod_uploading_activity .mod_uploading_item .el-upload-dragger,
  .mod_uploading_service .mod_uploading_item .el-upload-dragger{
    width:280px;
    height:226px;
  }
  .mod_uploading .time_date_activity input::-webkit-input-placeholder { /* WebKit browsers */
    color:#15bafe;
    font-size:16px;
  }

  .mod_uploading .time_date_activity input:-moz-placeholder { /* Mozilla Firefox 4 to 18 */
    color:#999;
    font-size:16px;
  }

  .mod_uploading .time_date_activity input::-moz-placeholder { /* Mozilla Firefox 19+ */
    color:#999;
    font-size:16px;
  }

  .mod_uploading .time_date_activity input:-ms-input-placeholder { /* Internet Explorer 10+ */
    color:#999;
    font-size:16px;
  }
  .mod_uploading .uploading_main_synopsis{
    width:504px;
  }
  .mod_uploading .uploading_main_synopsis textarea{
    resize:none;
    height:107px;
  }


  /********************************************上传商品**************************************************/
  .mod_uploading .mod_uploading_main .mod_uploading_item{
    display:inline-block;
    margin-bottom:31px;
  }
  .mod_uploading .mod_uploading_main .uploading_item_product_img{
    width:320px;
    height:320px;
    margin-bottom:15px;
    /*padding-left:7px;*/
    /*padding-top:10px;*/
    background:#fff;
    /*border:2px dashed #c6c6c6;*/
  }
  .mod_uploading .mod_uploading_main .uploading_item_product_img.activeBorder{
    position:relative;
    border:2px dashed #ccc;
    overflow:hidden;
  }
  .mod_uploading .mod_uploading_main .uploading_item_product_img.activeBorder .main_product_img{
    padding-top:256px;
    padding-left:10px;
  }
  .mod_uploading .mod_uploading_main .uploading_item_product_img.activeBorder .product_img_preview{
    display:flex;
    align-items:center;
    position:absolute;
    top:9px;
    left:10px;
    width:300px;
    height:240px;
    overflow:hidden;
  }
  .mod_uploading .mod_uploading_main .uploading_item_product_img.activeBorder .product_img_preview img{
    /*height:100%;*/
  }
  .mod_uploading .mod_uploading_main .uploading_item_product_img.activeBorder .el-upload--picture-card{
    width:56px !important;
    height:56px !important;
    border:1px solid #ccc;
  }
  .mod_uploading .mod_uploading_main .uploading_item_product_img.activeBorder .el-upload--picture-card:hover{
    border-color:#aaa;
  }
  .mod_uploading .mod_uploading_main .uploading_item_product_img.activeBorder .el-icon-plus{
    margin:13px auto 0;
    color:#ccc;
  }
  .mod_uploading .mod_uploading_main .uploading_item_product_img.activeBorder .el-upload--picture-card:hover .el-icon-plus{
    color:#aaa;
  }
  .mod_uploading .mod_uploading_main .uploading_item_product_img.activeBorder .el-upload-list--picture-card{
    position:initial;
  }
  .mod_uploading .mod_uploading_main .uploading_item_product_img.activeBorder .el-upload-list--picture-card .el-upload-list__item{
    width:56px !important;
    height:56px !important;
    margin-right:5px;
  }
  .mod_uploading .mod_uploading_main .uploading_item_product_img.activeBorder .el-upload-list--picture-card .el-upload-list__item-actions:hover span{
    display:inline-block;
  }
  .mod_uploading .mod_uploading_main .uploading_item_product_img.activeBorder .el-upload-list--picture-card .el-upload-list__item-actions span+span{
    margin-left:6px;
  }
  .mod_uploading .mod_uploading_main .uploading_item_product_img .el-upload--picture-card{
    border:none;
  }
  .mod_uploading .mod_uploading_main .uploading_item_product_img .main_product_img{
    position:relative;
    width:320px;
    height:320px;
  }
  .mod_uploading .mod_uploading_main .uploading_item_product_img .el-upload-list--picture-card{
    position: absolute;
    bottom: 16px;
    left: 10px;
    z-index: 1;
  }
  .mod_uploading .mod_uploading_main .uploading_item_product_img .el-upload-list--picture-card .el-upload-list__item{
    width:50px;
    height:50px;
  }
  .mod_uploading .mod_uploading_main .uploading_item_product_img .el-upload-dragger{
    position:relative;
    width:320px;
    height:320px;
  }
  .mod_uploading .mod_uploading_main .uploading_item_product_img .el-icon-circle-plus{
    color:#ccc;
    font-size:67px;
    margin-top:79px;
  }
  .mod_uploading .mod_uploading_main .uploading_item_product_img .upload_tips_suggest{
    position: absolute;
    font-size: 12px;
    color: #8c8c8c;
    bottom:115px;
    right:21px;
  }
  /*.mod_uploading .mod_uploading_main .uploading_item_product_img:hover{*/
  /*border-color:#15bafe;*/
  /*}*/
  .mod_uploading .mod_uploading_main .uploading_item_product_video{
    /*position:relative;*/
    display:flex;
    align-items:center;
    width:320px;
    height:260px;
    border:none;
  }
  .mod_uploading .mod_uploading_main .uploading_item_product_video.background{
    background:#000;
  }
  .mod_uploading .uploading_item_product_video .uploading_video_view{
    /*position:absolute;*/
    /*left:0;*/
    /*top:0;*/
    width:318px;
  }
  .mod_uploading .uploading_item_product_video .uploading_video_delete{
    position: relative;
    font-size: 14px;
    right: 15px;
    top: -119px;
    color: #fff;
    z-index: 10;
    cursor:pointer;
  }
  .mod_uploading .uploading_item_product_video .uploading_video_delete:hover{
    color:#15bafe;
  }
  .mod_uploading .mod_uploading_main .mod_uploading_describe{
    display:inline-block;
    width:543px;
    margin-left:19px;
    vertical-align:top;
  }
  .mod_uploading .mod_uploading_describe .uploading_item_file{
    width:100%;
    height:121px;
    padding:12px 0 0 10px;
    border:1px solid #dcdcdc;
    background:#fff;
  }
  .mod_uploading .mod_uploading_main .mod_uploading_describe .uploading_main_item{
    margin-bottom:24px
  }
  .mod_uploading .mod_uploading_main .main_txt{
    font-size:16px;
    vertical-align:middle;
  }
  .mod_uploading .mod_uploading_main .icon{
    vertical-align:middle;
  }
  .mod_uploading .mod_uploading_main .mod_uploading_describe .icon_price{
    margin-right:0;
  }
  /*.mod_uploading .mod_uploading_main .uploading_main_repertory,*/
  /*.mod_uploading .mod_uploading_main .uploading_main_uprice{*/
  /*display:inline-block;*/
  /*}*/
  /*.mod_uploading .mod_uploading_main .uploading_main_uprice{*/
  /*margin-left:24px;*/
  /*}*/
  .mod_uploading .mod_uploading_main .mod_uploading_describe .main_title_input{
    width:460px;
  }
  /*.mod_uploading .mod_uploading_main .uploading_main_repertory .main_repertory_input{*/
  /*width:193px;*/
  /*}*/
  .mod_uploading .mod_uploading_main .uploading_main_uprice .main_uprice_input{
    width:438px;
  }
  .mod_uploading_product .main_tag_add_box{
    width:460px;
  }
  .mod_uploading_product .uploading_main_file .main_file_upload{
    width:458px
  }
  .mod_uploading_product .uploading_main_file .main_file_upload .el-upload-list--picture-card{
    top:28px;
    left:13px;
  }
  .mod_uploading .mod_uploading_main .uploading_main_tag .main_tag_input{
    width:208.37px;
  }
  .mod_uploading .mod_uploading_describe .main_item_tips{
    /*left:68%!important;*/
  }
  .mod_uploading .uploading_main_pDetail .main_pDetail_editor{
    width:800px;
  }
  .mod_uploading_product .uploading_main_file .main_file_upload .el-upload-dragger{
    height:135px!important;
  }
  .mod_uploading_product .uploading_main_file .main_file_upload .uploading_tips .el-icon-plus{
    margin-top:35px;
  }

  /********************************************************类别手风琴********************************************/
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
  /****分类选项****/
  .mod_uploading .main_type_select .step_type{
    display:flex;
    justify-content:flex-start;
  }
  .mod_uploading .main_type_select .step_type_item{
    width:100px;
    height:100px;
    line-height:50px;
    text-align:center;
    cursor:pointer;
    margin-right:10px;
  }
  .mod_uploading .main_type_select .step_type_item:last-child{
    margin-right:0;
  }
  .mod_uploading .main_type_select .step_type_item:hover,
  .mod_uploading .main_type_select .step_type_item.active
  {
    box-shadow:1px 1px 5px 1px #dfdfdf;
  }
  .mod_uploading .main_type_select .step_type_img .icon{
    color:#ccc;
    font-size:28px;
  }
  .mod_uploading .main_type_select .step_type_img .icon.icon-motuoche{
    font-size:50px;
  }
  .mod_uploading .main_type_select .step_type_img .icon.icon-wurenji--,
  .mod_uploading .main_type_select .step_type_img .icon.icon-zhinengshebei{
    font-size:32px;
  }
  .mod_uploading .main_type_select .step_type_item:hover .step_type_img .icon,
  .mod_uploading .main_type_select .step_type_item.active .step_type_img .icon{
    color:#15bafe;
  }
  /****一级目录****/
  .mod_uploading .main_type_select .step_first_catalog,
  .mod_uploading .main_type_select .step_second_catalog,
  .mod_uploading .main_type_select .step_third_catalog,
  .mod_uploading .main_type_select .step_fourth_catalog{
    display:flex;
    justify-content:flex-start;
    padding-bottom:5px;
    border-bottom:1px dashed #ccc;
    min-width:618px;
    max-width:756px;
    margin-top:35px;
  }
  .uploading_main_file .main_file_upload .el-upload--picture-card
  .mod_uploading .main_type_select .step_catalog{
    width:100px;
    height:32px;
    color:#fff;
    font-size:14px;
    line-height:32px;
    text-align:center;
    background:#15bafe;
  }
  .mod_uploading .main_type_select .step_catalog_list {
    display: flex;
    flex-wrap: wrap;
    /*justify-content: space-between;*/
    min-width: 498px;
    max-width:626px;

  }
  .mod_uploading .main_type_select .step_catalog_item{
    position:relative;
    min-width:117px;
    height:31px;
    line-height:31px;
    text-align:center;
    font-size:12px;
    cursor:pointer;
    margin: 0 5px 10px;
    border:1px solid #ccc;
    padding: 0 10px;

  }
  .mod_uploading .main_type_select .step_catalog_item.active{
    border-color:#15bafe;
  }
  .mod_uploading .main_type_select .step_catalog_item .icon{
    position:absolute;
    bottom:0;
    right:-15px;
    color:#15bafe;
  }
  /*商品属性*/
  .mod_uploading .main_type_select .step_property{
    margin-top:35px;
  }
  .mod_uploading .main_type_select .step_property_head{
    width:100px;
    height:32px;
    line-height:32px;
    text-align:center;
    color:#fff;
    font-size:14px;
    background:#15bafe;
  }
  .mod_uploading .main_type_select .step_property_list{
    display:flex;
    flex-wrap:wrap;
    justify-content:space-between;
    width:100%;
    margin-top:15px;
  }
  .mod_uploading .main_type_select .step_property_item{
    width:47%;
    margin-top:20px;
  }
  .mod_uploading .main_type_select .step_property_title{
    width:100%;
    padding-bottom:4px;
    border-bottom:1px dashed #d9d9d9;
  }
  .mod_uploading .main_type_select .step_property_dot{
    display:inline-block;
    width:6px;
    height:6px;
    margin-right:4px;
    border-radius:50%;
    background:#000;
    vertical-align:middle;
  }
  .mod_uploading .main_type_select .step_property_child{
    display:flex;
    flex-wrap:wrap;
    margin-top:10px;
  }
  .mod_uploading .main_type_select .step_child_item{
    min-width:60px;
    height:25px;
    color:#666;
    text-align:center;
    line-height:25px;
    padding:0 8px;
    margin:0 5px 10px;
    cursor:pointer;
    user-select:none;
    border-radius:5px;
    box-shadow:1px 1px 1px 1px #dfdfdf;
  }
  .mod_uploading .main_type_select .step_child_item.active{
    color:#fff;
    background:#15bafe;
  }
  .mod_uploading .main_type_select .step_property_import,
  .mod_uploading .main_type_select .step_property_input_box{
    display:inline-block;
  }
  .mod_uploading .main_type_select .step_property_input_box{
    position:relative;
    margin-left:5px;
  }
  .mod_uploading .main_type_select .step_property_input{
    border:none;
    border-bottom:1px solid #ccc;
    padding-bottom:3px;
    padding-left:10px;
    box-sizing:border-box;
  }
  .mod_uploading .main_type_select .step_property_line{
    position:absolute;
    bottom:-0.5px;
    right:0;
    display:block;
    width:100%;
  }
  .mod_uploading .main_type_select .step_property_line_inner{
    display:block;
    width:0;
    height:1px;
    background:#000;
    margin:0 auto;
  }
  .mod_uploading .main_type_select .step_property_input:focus+.step_property_line .step_property_line_inner{
    animation:borderShow .8s ease-out forwards;
  }
  /*2个及以上输入框*/
  .mod_uploading .main_type_select .step_property_input_box.step_property_input_two{
    width:86%;
  }
  .mod_uploading .main_type_select .step_property_input_two .step_property_input,
  .mod_uploading .main_type_select .step_property_input_two .step_property_line{
    display:inline-block;
    width:47%;
  }
  .mod_uploading .main_type_select .step_property_input_two .step_property_line{
    left:0;
  }
  .mod_uploading .main_type_select .step_property_input_two .step_property_line~.step_property_line{
    left:52%;
  }
  /*3个及以上输入框*/
  .mod_uploading .main_type_select .step_property_type{
    display:flex;
    flex-wrap:wrap;
  }
  .mod_uploading .main_type_select .step_property_input_other{
    display:flex;
    justify-content:space-between;
    width:86%;
  }
  .mod_uploading .main_type_select .step_input_others{
    position:relative;
    width:29%;
  }
  .mod_uploading .main_type_select .step_input_others .step_property_input,
  .mod_uploading .main_type_select .step_input_others .step_property_line{
    width:100%;
  }
  .mod_uploading .main_type_select .step_input_others .step_property_line{
    bottom:0;
  }
  /*border动画*/
  @keyframes borderShow{
    0%{
      width:0;
    }
    100%{
      width:100%;
    }
  }
  /*******************************************类别导航************************************************/
  .el-menu-vertical-demo{
    /*position:relative;*/
    position:initial;
    color:#fff;
    background:#292233;
    border-right:none;
  }
  .el-menu-vertical-demo span{
    color:#fff;
  }
  .el-menu--inline{
    position:absolute;
    top:0;
    left:120px;
  }
  .el-menu-vertical-demo .el-menu--inline .el-submenu__title{
    padding:0!important;
    text-align:center;
  }
  .el-menu-vertical-demo .el-menu--inline .el-menu--inline{
    left:171px;
  }
  .el-menu-vertical-demo .el-menu--inline .el-menu--inline .el-menu-item{
    padding:0!important;
    margin:0 auto;
    min-width:0;
  }
  .el-menu-vertical-demo .el-menu--inline .el-menu--inline .el-menu-item.is-active{
    background:#15bafe;
  }
  .el-menu-vertical-demo .el-menu--inline .el-menu--inline .el-menu-item div{
    width:140px;
    margin:0 auto;
    border-bottom:1px solid #eaeaea;
  }
  .el-menu-vertical-demo .el-menu--inline .el-menu--inline .el-menu-item:last-child div{
    border-bottom:none;
  }
  .is-opened{
    color:#15bafe;
    background:#362e43;
  }
  .is-opened span{
    color:#15bafe;
  }
  .el-submenu__title:hover{
    background:#362e43!important;
  }
  .el-menu-vertical-demo .el-menu--inline{
    background:#fff!important;
    width:170px;
    color:#000;
  }
  .is-opened .el-menu--inline .is-opened{
    color:#fff;
    background:#15bafe!important;
  }
  .is-opened .el-menu--inline .is-opened .el-submenu__title{
    color:#fff;
  }
  .is-opened .el-menu--inline .el-submenu__title:hover{
    background:#ecf5ff!important;
  }
  .el-icon-arrow-down{
    display:none;
  }
  /*********************************************图片上传***********************************/
  .uploading_img_box .el-upload-dragger{
    width:800px;
    height:112px;
    border-width:1px;
  }
  .uploading_img_box .el-upload-dragger.is-dragover{
    background-color:#f2f2f2;
  }
  .uploading_img_box .el-upload--picture-card{
    border:none;
  }
  .uploading_img_box .el-upload-dragger .uploading_tips{
    width:100%;
    height:100%;
    line-height:initial;
  }
  .uploading_img_box .el-upload-list--picture-card{
    position:absolute;
    top:16px;
    left:10px;
    z-index:1;
  }
  .uploading_img_box .el-upload-dragger .el-icon-plus{
    margin-top:29px;
  }
  .uploading_img_box .el-upload-dragger .el-upload__txt{
    margin-top:39px;
    font-size:16px;
  }
  .el-upload-list--picture-card .el-upload-list__item{
    width:95px;
    height:95px;
    margin-bottom:0;
  }
  .el-upload--picture-card{
    width:95px;
    height:95px;
    line-height:initial;
  }
  .el-upload-list--picture-card .el-progress{
    margin-left:17px;
  }
  .uploading_item_product_img .el-progress__text,
  .uploading_item_file .el-progress__text{
    left:-15px;
  }

  /*******************************************文件上传********************************/
  .uploading_main_file .main_file_upload{
    width:60.32%;
    background:#fff;
  }
  .main_file_upload .el-progress__text{
    left:-15px;
  }
  .main_file_upload .el-upload-list--picture-card .el-upload-list__item{
    margin-bottom:0;
  }

  /********************************************视频上传*********************************/
  .upload-demo .el-upload-dragger{
    width:320px!important;
    height:266px!important;
    border:2px dashed #c6c6c6!important;
  }
  .upload-demo .el-upload-dragger.is-dragover{
    background-color:#f2f2f2!important;
  }
  .upload-demo .el-upload-dragger:hover{
    border-color:#15bafe!important;
  }
  .upload-demo .el-upload-dragger .el-icon-upload{
    margin-top:36px!important;
  }
  .el-progress-circle{
    width:93px!important;
    height:93px!important;
  }

  /***********************************文本编辑器**********************************/
  .mod_uploading .ql-container{
    height:302px;
    background:#fff;
  }



  /***************************************视频上传**********************************/
  .mod_uploading .mod_uploading_video{
    position:relative;
    width:800px;
    height:160px;
    margin-bottom:22px;
  }
  .mod_uploading .mod_uploading_video .upload_video{
    display:inline-block;
    width:517px;
    height:160px;
    vertical-align:middle;
  }
  .mod_uploading .mod_uploading_video .encyclopedia_cover_box{
    display:inline-block;
    width:271px;
    height:160px;
    margin-left:6px;
    vertical-align:middle;
  }
  .mod_uploading .mod_uploading_video .encyclopedia_cover_box .el-upload{
    display:block;
  }
  .mod_uploading .mod_uploading_video .encyclopedia_cover_box .el-upload-dragger{
    width:271px!important;
    height:160px!important;
  }
  .mod_uploading .mod_uploading_video .encyclopedia_cover_box .el-upload-dragger:hover{
    border-color:#15bafe!important;
  }
  .mod_uploading .mod_uploading_video .encyclopedia_cover_box .el-upload--picture-card, .el-upload:focus{
    border:none;
  }
  .mod_uploading .mod_uploading_video .encyclopedia_cover_box .el-upload--picture-card{
    width:100%;
    height:100%;
  }
  .mod_uploading .mod_uploading_video .encyclopedia_cover_box .el-upload-list--picture-card .el-upload-list__item{
    width:100%;
    height:100%;
  }
  .mod_uploading .mod_uploading_video .encyclopedia_cover_box .el-upload-dragger .uploading_tips{
    width:100%;
    height:100%;
  }
  .mod_uploading .mod_uploading_video .encyclopedia_cover_box .el-upload-dragger .uploading_tips i{
    margin-top:42px;
  }
  .mod_uploading .mod_uploading_video .encyclopedia_cover_box .el-upload-dragger .uploading_tips .el-upload__txt{
    margin-top:62px;
    color: #aaaaaa;
    font-size: 18px;
  }
  .mod_uploading .mod_uploading_video .encyclopedia_cover_box .el-upload-dragger .el-icon-circle-plus{
    font-size:67px;
    color:#ccc;
  }
  .mod_uploading .mod_uploading_video .el-upload-dragger{
    width:517px;
    height:160px;
    border-width:1px;
  }
  .mod_uploading .mod_uploading_video .upload_video_status{
    margin-top:22px;
  }
  .mod_uploading .mod_uploading_video .upload_video_status .video_error_txt,
  .mod_uploading .mod_uploading_video .upload_video_status .video_success_msg{
    color:#000;
    font-size:22px;
    font-weight:800;
  }
  .mod_uploading .mod_uploading_video .upload_video_status .video_error_msg{
    color:#adadad;
  }
  .mod_uploading .uploading_video_title .icon{
    vertical-align:bottom;
  }
  .mod_uploading .uploading_video_title .main_title_input{
    width:800px;
    height:32px;
    box-sizing:border-box;
  }
  .mod_uploading .uploading_main_part .part_info{
    display:inline-block;
    width:765px;
    margin-left:11px;
    padding-bottom:3px;
    border-bottom:1px solid #ccc;
  }
  .mod_uploading .uploading_main_part .part_info:hover{
    border-color:#aaa;
  }
  .mod_uploading .uploading_main_part .part_info.active{
    border-color:#aaa;
  }
  .mod_uploading .uploading_main_part .figure_list{
    margin-top:17px;
  }
  .mod_uploading .uploading_main_part .list_item{
    width:800px;
    margin-bottom:10px;
  }
  .mod_uploading .uploading_main_part .figure_list .el-icon-delete{
    color:#999999;
    font-size:20px;
    cursor:pointer;
    vertical-align:middle;
  }
  .mod_uploading .uploading_main_part .figure_list .el-icon-delete:hover{
    color:#15bafe;
  }
  .mod_uploading .uploading_main_part .part_info_name{
    height:24px;
    padding:5px 8px;
    line-height:24px;
    color: #999999;
    font-size:16px;
    background:#fff;
    border:1px solid #dcdcdc;
  }
  .mod_uploading .uploading_main_part .part_info .el-input__inner{
    border:none;
  }
  .mod_uploading .main_part_detail .el-input--suffix{
    width:800px;
  }
  .mod_uploading .el-input--suffix .el-input__inner{
    height:32px;
    padding-right:75px;
  }
  .main_part_detail .el-icon-circle-plus{
    color:#d2d2d2;
    font-size:24px;
    border-right:none;
    cursor:pointer;
  }
  .main_part_detail .el-input .el-input__clear{
    position:relative;
    left:-41px;
  }
  .mod_uploading_video_box .quill-editor{
    width:800px!important;
  }
  .mod_uploading_video_box .uploading_main_tag .input-new-tag{
    width:100%;
  }
  .mod_uploading_video_box .mod_uploading_confirm{
    width:800px;
  }
  .mod_uploading .uploading_main_radio .main_radio_txt{
    display:inline-block;
    color:#999;
    font-size:14px;
    padding:3px 8px;
    border:1px solid #ccc;
    border-radius:5px;
    cursor:pointer;
    user-select:none;
  }
  .mod_uploading .uploading_main_radio .el-icon-success{
    margin-left:5px;
  }
  .mod_uploading .uploading_main_radio .main_radio_txt.active{
    color:#fff;
    background:#15bafe;
    border-color:#15bafe;
  }
  .mod_uploading_video_box .uploading_main_part .el-icon-circle-plus{
    top:4px!important;
  }

  /****************************************上传百科***************************************************/
  .uploading_encyclopedia_nav .el-tabs--border-card{
    background:#f2f2f2;
    box-shadow:none;
    border:0;
  }
  .uploading_encyclopedia_nav .el-tabs--border-card>.el-tabs__header .el-tabs__item{
    position:relative;
    margin-right:20px;
    background:#fff;
    transition:all -1s;
  }
  .uploading_encyclopedia_nav .el-tabs--border-card>.el-tabs__header .el-tabs__item:after{
    content:'';
    position:absolute;
    top:-4px;
    right:-21.4px;
    width:0;
    height:0;
    border-right:11px solid transparent;
    border-top:23px solid transparent;
    border-bottom:23px solid transparent;
    border-left:11px solid #fff;
  }
  .uploading_encyclopedia_nav .el-tabs--border-card>.el-tabs__header .el-tabs__item:not(:nth-child(1)):before{
    content:'';
    position:absolute;
    top:-3px;
    right:75.6px;
    width:0;
    height:0;
    border-right:11px solid transparent;
    border-top:23px solid transparent;
    border-bottom:23px solid transparent;
    border-left:11px solid #f4f4f4;
  }
  .uploading_encyclopedia_nav .el-tabs--border-card>.el-tabs__header .el-tabs__item.is-active{
    background:#15bafe;
    color:#fff;
  }
  .uploading_encyclopedia_nav .el-tabs--border-card>.el-tabs__header .el-tabs__item.is-active:after{
    border-left-color:#15bafe;
  }

  .uploading_encyclopedia_nav .el-tabs--border-card>.el-tabs__header{
    margin-bottom:17px;
    background-color:#f2f2f2;
    border-bottom:none;
  }
  .uploading_encyclopedia_nav .el-tabs--border-card>.el-tabs__content{
    background:#fff;
    box-shadow:0 2px 4px 0 rgba(0,0,0,.12), 0 0 6px 0 rgba(0,0,0,.04);
  }
  .uploading_encyclopedia_step{
    color:#c9c9c9;
    font-size:20px;
    margin-bottom:37px;
  }
  .uploading_encyclopedia_step:before{
    content:'';
    position:relative;
    left:-15px;
    width:0;
    height:0;
    border-right-width:3.5px;
    border-top-width:0;
    border-bottom-width:0;
    border-left-width:3.5px;
    border-color:#15bafe;
    border-style:solid;
  }
  .uploading_encyclopedia_info{
    margin-left:38px;
  }
  .encyclopedia_info_cover,
  .encyclopedia_info_details{
    display:inline-block;
  }
  .encyclopedia_info_details{
    margin-left:28px!important;
    margin-top:0!important;
    vertical-align:top;
  }
  .encyclopedia_cover_box{
    overflow:hidden;
    width:320px;
    height:320px;
    background:#f4f4f4;
    /*border:1px dashed #cbcbcb;*/
    text-align:center;
  }
  .encyclopedia_cover_box .el-upload--picture-card{
    width:320px!important;
    height:320px!important;
    line-height:initial!important;
    border:none;
    background:#f4f4f4;
  }
  .encyclopedia_cover_box .el-upload--picture-card .el-upload-dragger{
    width:320px!important;
    height:320px!important;
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
    width:320px;
    height:320px;
  }
  .encyclopedia_cover_box .el-progress__text{
    left:-15px;
  }
  .mod_uploading .uploading_encyclopedia_info .uploading_tips{
    height:320px;
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
  .uploading_submit{
    position:absolute;
    bottom:20px;
    left:44%;
    width:213px;
    margin:26px auto 0;
  }
  .uploading_submit .submit_btn{
    color:#fff;
    padding:10px 50px;
    font-size:20px;
    border-radius:5px;
    background:#15bafe;
  }
  .uploading_submit .submit_btn.active{
    background:#ccc;
    cursor:not-allowed;
  }
  .uploading_submit .submit_btn .icon{
    width:20px;
    height:20px;
    vertical-align:middle;
    background:url(/static/img/icon/release_1.png) 0 0 no-repeat;
  }
  .mod_uploading .uploading_create_catalogue{
    margin-bottom:51px;
  }
  .mod_uploading .catalogue_list,
  .mod_uploading .catalogue_compile,
  .mod_uploading .compile_encyclopedia_detail{
    display:inline-block;
    min-height:400px;
    vertical-align:top;
  }
  .mod_uploading .catalogue_list{
    min-width:200px;
    margin-left:68px;
    padding-right:80px;
    border-right:1px solid #b4b4b4;
  }
  .mod_uploading .catalogue_list li{
    cursor:pointer;
  }
  .mod_uploading .catalogue_list .list_item{
    margin-top:10px;
  }
  .mod_uploading .uploading_create_catalogue .catalogue_compile{
    width:700px;
    margin-left:87px;
    vertical-align:top;
  }
  .mod_uploading .uploading_create_catalogue .catalogue_compile .icon{
    width:20px;
    height:20px;
    vertical-align:middle;
  }
  .mod_uploading .uploading_create_catalogue .catalogue_compile .main_txt{
    font-size:18px;
    font-weight:800;
  }
  .mod_uploading .uploading_create_catalogue .first_level_input .main_txt_describe{
    color:#15bafe;
  }
  .mod_uploading .uploading_create_catalogue .catalogue_compile input{
    width:100%;
    margin:10px 0 15px;
    border:none;
    border-bottom:1px solid #dcdcdc;
  }
  .mod_uploading .first_level{
    list-style:disc;
  }
  .mod_uploading .second_level{
    list-style:square inside url('/static/img/icon/score.png');
  }
  .mod_uploading .uploading_create_catalogue .first_level_input,
  .mod_uploading .uploading_create_catalogue .second_level_input{
    position:relative;
  }
  .mod_uploading .catalogue_list .first_level_txt{
    font-size:16px;
    font-weight:800;
  }
  .mod_uploading .catalogue_list .first_level_txt.active{
    color:#15bafe;
  }
  .mod_uploading .catalogue_list .second_level_txt.active{
    color:#15bafe;
  }

  .mod_uploading .uploading_create_catalogue .catalogue_compile .el-icon-circle-plus{
    position:absolute;
    cursor:pointer;
    color:#e2e2e2;
    font-size:20px;
    bottom:20px;
    right:10px;
  }

  .mod_uploading .compile_encyclopedia_detail{
    margin-left:87px;
  }
  .mod_uploading .compile_encyclopedia_detail .icon_rectangle{
    display:inline-block;
    width:5px;
    height:20px;
    background:#15bafe;
    vertical-align:bottom;
  }
  .mod_uploading .compile_encyclopedia_detail .main_txt{
    font-size:16px;
    font-weight:800;
    vertical-align:bottom
  }
  .mod_uploading .compile_encyclopedia_detail .encyclopedia_editor{
    width:700px;
    height:305px;
    margin-top:14px;
  }
  .mod_uploading .compile_encyclopedia_detail .encyclopedia_editor .ql-container{
    height:210px;
  }
  .mod_uploading .compile_encyclopedia_detail .uploading_main_file .main_file_upload{
    width:700px;
    height:141px;
    /*border:1px solid #dcdcdc;*/
    margin-top:10px;
    /*padding-left:10px;*/
    /*padding-top:30px;*/
  }
  .mod_uploading .compile_encyclopedia_detail .uploading_main_file .icon{
    width:20px;
    height:20px;
    vertical-align:middle;
  }
  .mod_uploading .compile_encyclopedia_detail .main_file_upload .el-upload--picture-card{
    width:700px;
  }

  .mod_uploading .compile_encyclopedia_detail .main_file_upload .el-upload-dragger{
    width:700px;
  }
  .mod_uploading .compile_encyclopedia_detail .uploading_main_part{
    margin-bottom:70px;
  }
  .mod_uploading .compile_encyclopedia_detail .main_part_detail .el-input--suffix{
    width:698px;
  }
  .mod_uploading .compile_encyclopedia_detail .uploading_main_part .main_head{
    margin-bottom:14px;
  }
  .mod_uploading .compile_encyclopedia_detail .el-input--suffix .el-input__inner{
    width:100%;
  }
  .mod_uploading .compile_encyclopedia_detail .uploading_main_part .list_item{
    width:100%;
  }
  .mod_uploading .compile_encyclopedia_detail .uploading_main_part .part_info{
    width:664px;
  }
  .compile_encyclopedia_detail .uploading_main_part .el-icon-circle-plus{
    position: relative;
    top: 4px;
    left: -32px;
  }



  /*****************************************上传文章****************************************************/
  .mod_uploading_article .mod_uploading_main{
    margin-left:0;
    margin-bottom:80px;
  }
  .mod_uploading_article .el-input{
    width:800px;
    margin-bottom:8px;
  }
  .mod_uploading_article .quill-editor{
    width:800px;
    margin-bottom:31px;
  }
  .mod_uploading_article .uploading_main_file .main_file_upload{
    width:800px;
  }
  .uploading_main_file .main_file_upload{
    position:relative;
    width:800px;
    /*padding:15px 0 15px 10px;*/
    /*border:1px solid #dcdcdc;*/
  }
  .mod_uploading_article .mod_uploading_main .main_type_list_describe{
    width:207px;
  }
  .mod_uploading_article .main_type_list .type_list_nav{
    border-color:#fff;
  }
  .mod_uploading_article .mod_uploading_confirm{
    position:relative!important;
    top:-60px;
    right:0;
    width:800px;
  }
  .mod_uploading_article .uploading_item_video{
    border:none;
  }

  .uploading_main_file .main_file_upload .el-upload-dragger{
    width:100%!important;
    height:112px!important;
    border-width:1px!important;
  }
  .uploading_main_file .main_file_upload .el-upload-dragger.is-dragover{
    background-color:#f2f2f2;
  }
  .uploading_main_file .main_file_upload .el-upload--picture-card{
    width:100%!important;
    height:112px!important;
    border:none!important;
    line-height:initial!important;
  }
  .uploading_main_file .main_file_upload .el-upload-list--picture-card{
    position:absolute;
    top:16px;
    left:10px;
    z-index:1;
  }
  .uploading_main_file .main_file_upload .uploading_tips{
    width:100%;
    height:100%;
  }
  .uploading_main_file .main_file_upload .uploading_tips .el-icon-plus{
    margin-top:29px;
  }
  .uploading_main_file .main_file_upload .uploading_tips .el-upload__txt{
    margin-top:39px;
    font-size:16px;
  }

</style>
<style scoped>
  .uploading_main_type .main_type_list .type_list_content{
    position:relative;
  }
  .uploading_main_type .main_type_list .type_content_children{
    position:absolute;
    left:50%;
    width:59px;
    margin-left:-29.5px;
  }
  .mod_uploading .mod_uploading_main .main_type_list{
    margin-bottom:0!important;
  }
  .mod_uploading .main_type_list .list_item{
    width:114px!important;
    height:114px!important;
  }
  /**类别选择项**/
  .uploading_main_type .main_type_list .type_list_select_box{
    position:absolute;
    top:120px;
    left:0;
    z-index:10;
  }
  .uploading_main_type .main_type_list .type_list_select_box .triangle_up{
    position:absolute;
    top:-14px;
    left:20px;
    z-index:11;
    border-bottom-color:#e4e4e4;
  }
  .uploading_main_type .main_type_list .type_list_select_box .triangle_inner{
    top:-7px;
    left:-8px;
    border-width:8px;
  }
  .uploading_main_type .main_type_list .type_list_select_box .type_list_select{
    width:130px;
    border:1px solid #e4e4e4;
    background:#fff;
    overflow:hidden;
  }
  .uploading_main_type .main_type_list .type_list_select_box .type_select_item{
    width:100%;
    height:34px;
    line-height:34px;
    text-align:center;
  }
  .uploading_main_type .main_type_list .type_list_select_box .type_select_item:hover{
    background:#fafafa;
  }
  .uploading_main_type .main_type_list .type_list_select_box .type_select_line{
    display:block;
    width:70%;
    height:0;
    border-bottom:1px dashed #f2f2f2;
    margin:0 auto;
  }
  .uploading_main_type .main_type_list .type_list_select_box .type_select_item:last-child .type_select_line{
    border:none;
  }
  /***类别列表动画***/
  .spread-enter-active {
    animation: spread-in .5s;
  }
  .spread-leave-active {
    animation: spread-in .1s reverse;
  }
  @keyframes spread-in {
    0% {
      height:0;
    }
    100% {
      height:240px;
    }
  }
</style>
<style lang="less">
  .main_head{
    i{
      width: 24px;
      margin-bottom: 2px;
      color: #15BAFE;
    }
  }
  .mod_uploading_main {
    width: 70%;

    /*icon/标题*/
    > div {
      margin-bottom: 20px;
      > p {
        font-size: 16px;
        color: #000;
        margin-bottom: 10px;
        .icon {
          font-size: 16px;
          color: #15befe;
          margin-right: 10px;
        }
        span {
          font-size: 12px;
          color: #666;
        }
      }
    }
  }
  /*类别*/
  .upload_article_category{
    .el-radio-button{
      margin-right: 10px;
    }
    /*初始化样式*/
    .el-radio-button__inner{
      border: none !important;
      border-radius: 0;
      width: 140px;
      height: 140px;
      text-align: center;
      line-height: 30px;
      padding-top: 40px;
      i{
        font-size: 40px;
        margin-bottom: 10px;
      }
    }
    /*选中样式*/
    .el-radio-button__orig-radio:checked+.el-radio-button__inner{
      background-color: #15befe;
    }
  }
</style>
<!--标签-->
<style>
  /*.main_tag_add{*/
  /*width:60.32%;*/
  /*}*/
  .main_tag_add_box {
    position: relative;
    display: inline-block;
    width: 800px;
    /*border:1px solid #dcdcdc;*/
    border-radius: 5px;
    /*padding-right:20px;*/
    background: #fff;
  }
  .main_tag_add_box .el-tag{
    background: none;
    border: 1px solid #15bafe;
    color: #15bafe;
    border-radius: 3px;
    padding: 0 5px;
    height: 25px;
    line-height: 23px;
  }

  .main_tag_add_box:visited {
    border-color: #15bafe;
  }

  .el-icon-circle-plus {
    color: #d2d2d2;
    font-size: 20px;
    padding: 0 10px;
    /*margin-right:10px;*/
    /*border-right:1px solid #dcdcdc;*/
    vertical-align: middle;
  }

  .el-icon-circle-plus.active {
    margin-right: 10px;
    border-right: 1px solid #dcdcdc;
  }

  .input-new-tag {
    display: inline-block;
    width: 100%;
  }

  .el-input--small .el-input__inner:hover {
    /*border:none;*/
    border-color: #bbb;
  }

  .main_tag_list {
    display: inline-block;
    position: absolute;
    top: 4px;
    right: 0;
    height: 24px;
    line-height: 24px;
  }
</style>
<style scoped>
  .body{
    background:#f4f4f4;
  }
  .mod_uploading_article{
    background:#fff;
    margin-top:0;
    padding:20px 0 0 21px;
    border-top:1px solid #dcdcdc
  }
  .mod_uploading_head{
    display:block;
    width:62.5%;
    margin:20px auto 0;
    background:#f4f4f4;
    min-width:1200px;
  }
  .mod_uploading_head .uploading_head_txt{
    width:14.42%;
    height:51px;
    border:1px solid #dedede;
    background:#fff;
    border-left:none;
    border-bottom:none;
    line-height:51px;
    font-size:24px;
    font-weight:800;
    text-align:center;
    box-shadow: 0 5px 5px 0 rgba(34, 24, 21, 0.16);
  }
  .mod_uploading_article .mod_uploading_main .mod_uploading_item{
    width:225px;
    height:225px;
  }
  .mod_uploading_article .mod_uploading_main .uploading_item_product_video{
    width:100%;
    height:100%;
  }
  .mod_uploading_article .mod_uploading_main .encyclopedia_cover_box{
    width:100%;
    height:100%;
  }
  .mod_uploading_article .mod_uploading_main .mod_uploading_describe,
  .mod_uploading_article .uploading_main_synopsis{
    width:552px;
  }
  .mod_uploading .mod_uploading_main .main_type_list{
    margin-bottom:0!important;
  }
</style>
<style>
  .mod_uploading_article .encyclopedia_cover_box .el-upload--picture-card{
    width:100%!important;
    height:100%!important;
  }
  .mod_uploading_article .encyclopedia_cover_box .el-upload--picture-card .el-upload-dragger{
    width:100%!important;
    height:100%!important;
  }
  .mod_uploading_article .encyclopedia_cover_box .el-upload-list--picture-card .el-upload-list__item{
    width:100%!important;
    height:100%!important;
  }
  .mod_uploading_article .encyclopedia_cover_box .el-upload--picture-card i{
    margin-top:70px;
  }
  .mod_uploading_article .uploading_tips{
    width:100%;
    height:100%;
  }
  .mod_uploading_article .mod_uploading_main .mod_uploading_describe .main_title_input{
    width:100%;
  }
</style>
