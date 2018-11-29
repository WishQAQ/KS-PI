<template>
  <div class="uploading_background">
    <section>
      <uploading-head></uploading-head>
      <div class="mod_uploading mod_uploading_product mod_uploading_bargains">
        <div class="mod_uploading_main">
          <div class="mod_uploading_item">
            <div class="uploading_item_img uploading_item_product_img" :class="{activeBorder:!isDrag}">
              <el-upload
                action="http://test.kslab.com/api/article/null"
                list-type="picture-card"
                class="main_product_img"
                :drag="isDrag"
                :limit="5"
                multiple
                :file-list="imageFileList"
                :on-preview="handlePictureCardPreview"
                :on-remove="handleImageRemove"
                :on-change="handleChangeImg"
                :before-upload="beforeImageUpload"
                :before-remove="handleBeforeImageRemove"
                :on-success="handleImageSuccess"
                :on-error="handleError">
                <i class="el-icon-plus" v-show="!isDrag"></i>
                <div class="upload_tips" @dragover.prevent="onDragoverImg" @dragleave="dragLeaveImg" v-if="!ImgFlag">
                  <i class="el-icon-circle-plus" v-show="!dragOverImg"></i>
                  <span class="upload_tips_txt" v-show="!dragOverImg">(选填)</span>
                  <div class="el-upload__text" v-show="!dragOverImg">添加封面图</div>
                  <span class="upload_tips_suggest" v-show="!dragOverImg">推荐640×640像素,JPG/PNG,5M以内,最多上传5张</span>
                  <span class="dragOver_txt" v-show="dragOverImg && !dragDoneImg">松开图片以上传</span>
                </div>
              </el-upload>
              <div v-show="dialogVisible" class="product_img_preview" :class="editVisible?'img_preview':''">
                <img width="100%" :src="dialogImageUrl" alt="">
              </div>
            </div>
            <div class="uploading_item_video uploading_item_product_video">
              <el-upload
                ref="uploads"
                class="avatar-uploader main_product_img service_upload"
                action="http://test.kslab.com/api/article/null"
                :on-success="handleVideoSuccess"
                :show-file-list="false"
                :file-list="deleteFile"
                :on-progress="uploadVideoProcess"
                :on-change="uploadOnChange"
                :before-upload="beforeUploadVideo">
                <div class="upload_tips" v-if="remarkVisible && videoVisible">
                  <i class="el-icon-upload up_icon" v-show="!dragOver"></i>
                  <span class="upload_tips_txt" v-show="!dragOver">(选填)</span>
                  <div class="el-upload__text" v-show="!dragOver">将视频拖到此处，或<em>点击上传</em></div>
                  <span class="upload_tips_suggest" v-show="!dragOver">视频长度在30s以内，小于等于20MB</span>
                  <span class="dragOver_txt" v-show="dragOver && !dragDone">松开视频以上传</span>
                </div>
                <video class="up_video" v-if="!videoVisible" :src="videoSrc" controls="controls">您的浏览器不支持视频播放</video>
                <el-progress v-if="videoFlag" type="circle" :percentage="videoUploadPercent"
                             style="position: absolute;top: 72px;left: 110px;"></el-progress>
              </el-upload>
              <i @click="handleRemoveVideo" v-if="!videoVisible" class="el-icon-delete" :class="'delete_icon'"></i>
            </div>
          </div>
          <div class="mod_uploading_describe">
            <div class="uploading_main_item uploading_main_title">
              <div class="main_head">
                <i class="icon icon_title"></i>
                <span class="main_txt">标题</span>
              </div>
              <input type="text" class="main_title_input" @change="getMarketTitle" placeholder="标题限定25字以内" v-model="articleTitleName"
                     maxlength="25">
              <!-- <input type="text" class="main_title_input" placeholder="标题限定25字以内" v-else v-model="titleVakue" maxlength="25" @change="Article_titleName_component"> -->
              <div class="mod_uploading_date">
              </div>
            </div>
            <div class="uploading_main_item uploading_main_tag">
              <div class="main_head">
                <i class="icon icon_tag"></i>
                <span class="main_txt">标签</span>
                <span class="main_txt_describe">(至少1个标签,最多3个，每个2~5个字)</span>
              </div>
              <div class="main_tag_add">
                <div class="main_tag_add_box" :class="{active: dynamicTags&&dynamicTags.length>0}">
                  <el-input
                    class="input-new-tag"
                    v-model="inputValue"
                    ref="saveTagInput"
                    maxlength="5"
                    size="small"
                    @keyup.enter.native="handleInputConfirm"
                  >
                  </el-input>
                  <div class="main_tag_list">
                    <i class="el-icon-circle-plus" :class="{active:dynamicTags&&dynamicTags.length>0}"
                       @click="handleInputConfirm"></i>
                    <el-tag
                      :key="tag"
                      v-for="tag in dynamicTags"
                      closable
                      size="small"
                      style="margin-right:5px;"
                      :disable-transitions="false"
                      @close="handleClose(tag)">
                      {{tag}}
                    </el-tag>
                  </div>
                </div>
              </div>
            </div>
            <div class="uploading_main_item uploading_main_repertory">
              <div class="main_head">
                <i class="icon icon_repertory"></i>
                <span class="main_txt">商品数量</span>
              </div>
              <input type="text" oninput="value=value.replace(/[^\d]/g,'')" v-model="product_num" @change="getProductNumber" class="main_title_input main_repertory_input">
            </div>
            <div class="uploading_main_item uploading_main_uprice">
              <div class="main_head">
                <i class="icon icon_uprice"></i>
                <span class="main_txt">商品单价</span>
              </div>
              <i class="icon icon_price"></i>
              <input type="text" oninput="value=value.replace(/[^\d]/g,'')" v-model="product_price" @change="getProductPrice" class="main_title_input main_uprice_input">
            </div>
            <div class="uploading_main_item uploading_main_type">
              <div class="main_head">
                <i class="icon icon_type"></i>
                <span class="main_txt">类别</span>
              </div>
              <div class="main_type_list">
                <ul class="figure_list">
                  <li class="list_item" :class="{active:item.id===checkedIndex}" v-for="(item,index) in categoryType"
                      :key="index" @click.stop="checkedType(item.name,index,item.id, item.menu_id)">
                    <div class="type_list_content">
                      <div class="type_content_img_box"><i class="icon" :class="'icon-qiche'"></i></div>
                      <div class="type_content_txt">
                        <p class="content_txt_title">{{item.name}}</p>
                      </div>
                    </div>
                  </li>
                </ul>
              </div>
            </div>
            <!--<main-item-Tips ref="question"></main-item-Tips>-->
          </div>
          <div class="uploading_main_item uploading_main_title">
            <div class="main_head">
              <i class="icon icon_title"></i>
              <span class="main_txt">描述</span>
            </div>
            <textarea  class="main_title_input" @change="getMarketDescription" placeholder="描述限定60字以内" v-model="description"
                       maxlength="59"
            style="height: 75px; resize: none"></textarea>
            <!-- <input type="text" class="main_title_input" placeholder="标题限定25字以内" v-else v-model="titleVakue" maxlength="25" @change="Article_titleName_component"> -->
            <div class="mod_uploading_date">
            </div>
          </div>
          <div class="uploading_main_item uploading_main_pDetail" id="uploading_main_item">
            <div class="main_head">
              <i class="icon icon_content"></i>
              <span class="main_txt">商品详情页</span>
              <span class="main_txt_describe">(最多5个，最大5MB)</span>
            </div>

            <div class="main_pDetail_editor">
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
                ref="myQuillEditor"
                :options="editorOption"
                @blur="onEditorBlur($event)" @focus="onEditorFocus($event)"
                @change="onEditorChange($event,5000)">
              </quill-editor>
            </div>
          </div>

          <!--选择城市-->
          <div class="service_city">
            <div class="main_head">
              <i class="icon icon_location"></i>
              <span class="main_txt">选择城市</span>
              <span class="main_txt_describe"></span>
            </div>
            <div class="service_choose">
              <el-select
                class="choose_province"
                v-model="provinceName"
                size="mini"
                @change="handleChooseProvince"
                placeholder="请选择省">
                <el-option
                  v-for="item in provinceOptions"
                  :key="item.id"
                  :label="item.name"
                  :value="item.id">
                </el-option>
              </el-select>
              <el-select
                class="choose_city"
                v-model="cityName"
                size="mini"
                @change="handleChooseCity"
                placeholder="请选择市">
                <el-option
                  v-for="item in cityOptions"
                  :key="item.id"
                  :label="item.name"
                  :value="item.id">
                </el-option>
              </el-select>
              <el-select
                class="choose_district"
                v-model="districtName"
                size="mini"
                @change="handleChooseDistrict"
                placeholder="请选择市">
                <el-option
                  v-for="item in districtOptions"
                  :key="item.id"
                  :label="item.name"
                  :value="item.id">
                </el-option>
              </el-select>
            </div>
          </div>


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
              :file-list="fileFilesFileList"
              :on-preview="handleFileCardPreview"
              :on-remove="handleFileRemove"
              :before-remove="handleBeforeFileRemove"
              :on-exceed="handleFileExceed"
              :on-change="handleFileChange"
              :on-success="handleFileSuccess"
              :on-error="handleFileError"
              :before-upload="beforeFileUpload">
              <div class="uploading_tips" @dragover.prevent="onFileDragover" @dragleave="dragFileLeave">
                <i class="el-icon-plus" v-show="!dragFilesOver"></i>
                <div class="el-upload__text" v-show="!dragFilesOver">将文件拖到此处，或<em>点击上传</em></div>
                <div class="el-upload__txt" v-show="dragFilesOver && !dragFilesDone">松开文件上传</div>
              </div>
            </el-upload>
            <el-dialog :visible.sync="dialogFilesVisible">
              <img width="100%" :src="dialogFilesImageUrl" alt="">
            </el-dialog>
          </div>
        </div>

        <div class="upload_bargains_submit">
          <el-button>取消</el-button>
          <el-button type="primary" @click="handleSubmit">发布</el-button>
        </div>
      </div>
    </section>
    <!--<protocol-div ref="protocol"></protocol-div>-->
  </div>
</template>

<script>

  import FloatingDiv from '@/components/floating'
  import ProtocolDiv from '@/views/upload/protocol'
  import UploadingMainTitle from '@/views/upload/uploadingMainTitle'
  import UploadingMarketMainTag from '@/views/upload/uploadingMarketMainTag'
  import MainItemTips from '@/views/upload/mainItemTips'
  import ModUploadingConfirm from '@/views/upload/modUploadingConfirm'
  import UploadingMarketMainFile from '@/views/upload/uploadingMarketMainFile'
  import ElCascaderMenu from 'element-ui/packages/cascader/src/menu'
  //import QEditor from 'vue-quill-editor'

  var UploadingHead = {
    template: "<div class='mod_uploading_head'><div class='uploading_head_txt'>上传淘货</div></div>",
    data() {
      return {}
    },
  };

  // region
  import {quillEditor} from 'vue-quill-editor'
  import * as Quill from 'quill'  //引入编辑器
  import moment from 'moment'

  //quill图片可拖拽改变大小
  import ImageResize from 'quill-image-resize-module';

  Quill.register('modules/imageResize', ImageResize);

  //quill图片可拖拽上传
  import {ImageDrop} from 'quill-image-drop-module';

  Quill.register('modules/imageDrop', ImageDrop);

  // 自定义字体大小
  let fontSize = ['10px', '12px', '14px', '16px', '18px', '20px'];
  let Size = Quill.import('attributors/style/size');
  Size.whitelist = fontSize;
  Quill.register(Size, true);

  var fonts = ['SimSun', 'SimHei', 'Microsoft-YaHei', 'KaiTi', 'FangSong', 'Arial', 'Times-New-Roman', 'sans-serif'];
  var Font = Quill.import('formats/font');
  Font.whitelist = fonts; //将字体加入到白名单

  import {container, ImageExtend, QuillWatch} from 'quill-image-extend-module'

  Quill.register('modules/ImageExtend', ImageExtend)

  var toolbarOptions = [
    ['italic', 'underline', 'strike', 'bold'],
    ['blockquote', 'code-block'],
    // [{'header':1},{'header':2}],
    [{'list': 'ordered'}, {'list': 'bullet'}],
    [{'script': 'sub'}, {'script': 'super'}],
    [{'indent': '-1'}, {'indent': '+1'}],
    [{'direction': 'rtl'}],
    [{'size': fontSize}],
    // [{'header':[1,2,3,4,5,6,false]}],
    [{'color': []}],
    // [{'font':fonts}],
    [{'align': []}],
    // ['clear'],
    ['image']
  ];
  // endregion
  export default {
    name: "uploadingBargains",
    data() {
      return {
        editVisible: false,
        description: '',
        product_num: null,
        product_price: null,
        category_id: null,
        articleTitleName: '',
        dialogImageUrl: '',
        dialogVisible: false,
        videoFlag: false,
        dragOver: false,
        dragDone: false,
        isDrag: true,
        ImgFlag: false,
        pass: null,
        remarkVisible: true, //提示
        deleteFile: [],
        dragOverImg: false,
        dragDoneImg: false,
        videoUploadPercent: 0,
        videoSrc: '',
        videoVisible: true,
        content: null,
        // editorOption: {
        //   modules: {
        //     toolbar: toolbarOptions
        //   }
        // },
        categoryType: [],
        typeList: [ //类别列表
          {type: '汽车', img: 'icon-qiche'},
          {type: '摩托车', img: 'icon-motuoche'},
          {type: '无人机', img: 'icon-wurenji--'},
          {type: 'DIY', img: 'icon-weixiu'},
          {type: '其他', img: 'icon-weixiu'},
          {type: '智能设备', img: 'icon-zhinengshebei'}
        ],
        checkedValue: '',//大类已选值
        checkedIndex: null,//大类已选值下标,
        imageFileList: [],
        beforeImageFileList: [], //上传之后，删除之前的fileList,
        editImageFileList: [],  //修改服务时获得的路径
        marketData: {
          title: '',
          province: null,
          price: null,
          stock: null,
          tags: null,
          content: '',
          category_id: null,
          description: null,
          city: null,
          district: null,
          serial_number: null,
        },
        /*城市*/
        provinceId: null,
        provinceName: '',
        provinceOptions: [],
        cityId: null,
        cityName: '',
        cityOptions: [],
        districtId: null,
        districtName: '',
        districtOptions: [],
        allCity: [], //所有省市区,
        telphone: null,
        address: '',

        dynamicTags: [],
        inputValue: '',

        /**富文本编辑器**/
        editorOption: {
          modules: {
            toolbar: {
              container: toolbarOptions,
              handlers: {
                'image': function (value) {
                  if (value) {
                    document.querySelector('#xx input').click()
                  } else {
                    this.quill.format('image', false);
                  }
                }
              }
            },
            imageDrop: true,
            imageResize: {
              displayStyles: {
                backgroundColor: 'black',
                border: 'none',
                color: 'white'
              },
              modules: ['Resize', 'DisplaySize', 'Toolbar']
            },
            ImageExtend: {
              loading: true,
              name: 'img',
              size: 1,
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
              start: () => {}, //this.ImgStart(),//() => {},  //自定义开始上传触发事件
              end: () => {
              },  //自定义上传结束触发的事件，无论成功或者失败
              error: () => {
              },  //上传失败触发的事件
              success: () => {
              },  //上传成功触发的事件
              change: (xhr, formData) => {
                // xhr.setRequestHeader('myHeader','myValue')
                // formData.append('token', 'myToken')
              } //每次选择图片触发，也可用来设置头部，但比headers多了一个参数，可设置formData
            },
          }
        },
        theme: 'snow',

        /****附件****/
        dialogFilesImageUrl: '',
        dialogFilesVisible: false,
        dragFilesOver:false,
        dragFilesDone:false,
        updata:{
          token:window.localStorage.token
        },
        fileFilesList: [],
        beforeFilesFileList: [], //上传之后，删除之前的fileList,
        fileFilesFileList: [],
        editFilesFileList: [], //修改服务时获得的路径
        marketEditData: {},
      }
    },
    components: {
      FloatingDiv,
      ProtocolDiv,
      UploadingHead,
      UploadingMainTitle,
      UploadingMarketMainTag,
      MainItemTips,
      ElCascaderMenu,
      ModUploadingConfirm,
      UploadingMarketMainFile,
    },
    created() {
      if(this.$route.query.id){
        this.HttpClient.post('/web/user/updateGoodsInfo',{asin:this.$route.query.id}).then(res =>{
          if(res.data.code === 200){
            console.log(res.data)
            const detailData = res.data.data;
            this.articleTitleName = detailData.title;
            this.description = detailData.description;
            this.dynamicTags = detailData.tagsname;
            this.product_num = parseInt(detailData.stock);
            this.product_price = parseInt(detailData.price);
            this.category_id = detailData.category_id;
            this.content = detailData.content;
            this.provinceId = parseInt(detailData.province.id);
            this.provinceName = detailData.province.name;
            this.cityId = parseInt(detailData.city.id);
            this.cityName = detailData.city.name;
            this.districtId = parseInt(detailData.district.id);
            this.districtName = detailData.district.name;
            this.checkedIndex = detailData.category_id;
            this.videoSrc = this.Tools.handleImg(detailData.video[0].path);
            this.videoVisible = false;
            const images = detailData.show_picture;
            let arrayImage = [];
            images.map((item, index) =>{
              var temp = {
                name: item.name,
                url: this.Tools.handleImg(item.path)
              };
              arrayImage.push(temp)
            });
            console.log(arrayImage)
            this.imageFileList = arrayImage;
            this.beforeImageFileList = arrayImage;
            this.editImageFileList = detailData.show_picture;
            //this.dialogFilesImageUrl = this.Tools.handleImg(detailData.show_picture[0].path)
            this.dialogImageUrl = this.Tools.handleImg(detailData.show_picture[0].path)
            this.ImgFlag = true;
            this.dialogVisible = true;
            this.editVisible = true;
            this.marketData.serial_number = detailData.serial_number;

            const files = detailData.attachment;
            let arrayFiles = [];
            files.map((item, index) =>{
              var temp = {
                name: item.name,
                url: this.Tools.handleImg(item.path)
              };
              arrayFiles.push(temp)
            });
            console.log(arrayFiles)
            this.fileFilesFileList = arrayFiles;
            this.beforeFilesFileList = arrayFiles;
            this.editFilesFileList = detailData.attachment;
          }
        })
      }else{
        this.marketData.serial_number = this.Tools.GetNumber();
        console.log(this.marketData.serial_number)
      }
      this.getAllAddress();
      this.getTypeList();

    },
    computed: {
      proStatus() {//上传状态
        if (this.pass) {
          return 'success'
        } else if (this.pass == false) {
          return 'exception'
        } else {
          return ''
        }
      }
    },
    methods: {
      handleOpen(key, keyPath) {
        console.log(key, keyPath);
      },
      /***
       * 获取淘货类型
       */
      getTypeList() {
        this.HttpClient.get('/goods/homeCategory').then(res =>{
          if(res.data.code === 200) {
            this.categoryType = res.data.data;
          }
        })
      },
      /***
       * 获取淘货标题
       */
      getMarketTitle(e) {
        this.marketData.title = this.articleTitleName;
        console.log(this.marketData)
      },
      getMarketDescription() {
        this.marketData.description = this.description;
        console.log(this.marketData)
      },
      /***
       * 获取商品数量
       */
      getProductNumber(e) {
        this.marketData.stock = parseInt(this.product_num);
        console.log(this.marketData)
      },
      /***
       * 获取商品价格
       */
      getProductPrice(e) {
        this.marketData.price = parseInt(this.product_price);
        console.log(this.marketData)
      },
      // handleClose(key, keyPath) {
      //   console.log(key, keyPath);
      // },

      /***********************图片上传*********************************/
      // region
      handleImageRemove(file, fileList) {
        console.log(file, fileList);
        if (fileList.length <= 0) {
          this.isDrag = true;
          this.dialogVisible = false;
          this.ImgFlag = false;
          this.dragOverImg = false;
          this.dragDoneImg = false;
        } else {
          this.dialogImageUrl = fileList[fileList.length - 1].url;
        }
      },
      handleError(err, file, fileList) {
        this.$message.error('上传失败!')
        console.log(file);
        console.log(fileList);
        if (fileList.length > 0) {
          this.dialogImageUrl = fileList[fileList.length - 1].url;
          console.log(this.dialogImageUrl);
        } else {
          this.dialogVisible = false;
        }
      },
      handleChangeImg(file, fileList) {
        console.log(file);
        console.log(fileList);
        if (fileList.length > 0) {
          this.dragOverImg = true;
          this.dragDoneImg = true;
          this.isDrag = false;
          this.dialogVisible = true;
          this.dialogImageUrl = fileList[fileList.length - 1].url;
        } else {
          this.isDrag = true;
          this.dragOverImg = false;
          this.dragDoneImg = false;
          this.ImgFlag = false;
          this.dialogVisible = false;
        }
      },
      handlePictureCardPreview(file) {
        this.dialogImageUrl = file.url;
      },
      beforeImageUpload(file) {
        console.log(file)
        const isJPG = file.type === 'image/jpeg';
        const isPNG = file.type === 'image/png';
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
          images: file,
          serial_number: this.marketData.serial_number
        };
        this.HttpClient.form('/goods/uploadImg', param)
          .then((res) => {
            //console.log(res)
            if (res.data.code === 200) {
              this.imageFileList.push(res.data.path)
              this.$message.success(res.data.msg)
              //console.log(this.fileList)
            } else {
              this.$message.error(res.data.msg)
              return false
            }
          });
        return isJPG || isPNG && isLt2M;
      },
      handleImageSuccess(response, file, fileList) {
        this.beforeImageFileList = fileList;
      },
      async handleBeforeImageRemove(file, fileList) {
        let result = null;
        console.log(file, fileList, this.beforeImageFileList, this.imageFileList);
        const isJPG = file.type === 'image/jpeg';
        const isPNG = file.type === 'image/png';
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
        let index = this.beforeImageFileList.map(item => item.name).indexOf(file.name)
        console.log(index)
        let urls = this.imageFileList[index];
        console.log(this.editImageFileList)
        if(this.$route.query.id) {
          urls = this.Tools.handleImg(this.editImageFileList[index].path);
        }
        console.log(urls)
        if(this.$route.query.id) {
          await this.HttpClient.post('/updateDelete', {path: urls}).then(res => {
            if (res.data.code === 200) {
              this.imageFileList.splice(index, 1);
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
              this.imageFileList.splice(index, 1);
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
      onDragoverImg() {
        this.dragOverImg = true;
      },
      dragLeaveImg() {
        this.dragOverImg = false;
      },
      // endregion


      /***********************************视频上传***************************/
      // region
      async beforeUploadVideo(file) {
        const isLt10M = file.size / 1024 / 1024 < 20;
        if (['video/mp4', 'video/ogg', 'video/flv', 'video/avi', 'video/wmv', 'video/rmvb'].indexOf(file.type) === -1) {
          this.$message.error('请上传正确的视频格式');
          this.dragOver = false;
          this.dragDone = false;
          this.videoFlag = false;
          return false;
        }
        /*if (!isLt10M) {
          this.$message.error('上传视频大小不能超过20MB哦!');
          return false;
        }*/

        var FromData = new FormData()
        //文章上传图片接口
        FromData.append('token', window.localStorage.token)
        FromData.append('video', file)
        FromData.append('serial_number', this.marketData.serial_number)
        const param = {
          video: file,
          serial_number: this.marketData.serial_number
        };
        await this.HttpClient.form('/goods/uploadVideo', param)
          .then((res) => {
            console.log(res)
            if (res.data.code === 200) {
              this.videoSrc = res.data.path;
              this.videoVisible = false;
              this.videoFlag = false;
              this.$message.success('上传成功!')
            } else {
              this.$message.error(res.data.msg);
              //this.remarkVisible = true;
              this.videoFlag = false;
              return false;
            }

          })
      },
      handleVideoSuccess(response, file, fileList) {
        this.deleteFile = fileList;
        this.videoFlag = false;
        console.log(this.deleteFile)
      },
      handleRemoveVideo() {
        const isLt10M = file.size / 1024 / 1024 < 20;
        if (['video/mp4', 'video/ogg', 'video/flv', 'video/avi', 'video/wmv', 'video/rmvb'].indexOf(file.type) === -1) {
          this.$message.error('请上传正确的视频格式');
          return false;
        }
        /*if (!isLt10M) {
          this.$message.error('上传视频大小不能超过20MB哦!');
          return false;
        }*/
        this.HttpClient.post('/services/destroyFile', {url: this.videoSrc}).then(res => {
          if (res.data.code === 200) {
            this.$refs.uploads.clearFiles();
            this.deleteFile = [];
            this.videoSrc = '';
            this.videoVisible = true;
            this.remarkVisible = true;
            this.$message.success('删除成功');
          } else {
            this.$message.error('删除失败');
          }
        });
        this.videoFlag = false;
      },
      uploadVideoProcess(event, file, fileList) {
        console.log(file, file.percentage)
        this.videoFlag = true;
        this.videoUploadPercent = parseInt(file.percentage.toFixed(0));//Math.floor(event.percent)
      },
      uploadOnChange(file) {
        console.log("——————————change——————————")
        console.log(file)
        if(file.status === 'ready'){
          console.log("ready")
          this.videoFlag = true;
          this.remarkVisible = false;
          this.videoUploadPercent = 0;
        }else if(file.status === 'fail'){
          this.$message.error("图片上传出错，请刷新重试！")
        }else if(file.status === 'success') {
          this.remarkVisible = !(!this.videoVisible && !this.videoFlag);
        }
      },
      handleChange(file, fileList) {
        if (fileList.length > 0) {
          this.dragOver = true;
          this.dragDone = true;
        } else {
          this.dragOver = false;
          this.dragDone = false;
          this.videoFlag = false;
        }
      },
      onDragover() {
        this.dragOver = true;
      },
      dragLeave() {
        this.dragOver = false;
      },
      // endregion


      /************************************标签**********************************/
      // region
      handleClose(tag) {
        this.dynamicTags.splice(this.dynamicTags.indexOf(tag), 1);
        console.log(this.dynamicTags);
        this.marketData.tags = this.dynamicTags;
        console.log(this.marketData)

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
        console.log(this.dynamicTags)
        this.marketData.tags = this.dynamicTags;
        console.log(this.marketData)

      },
      // endregion

      /***********************************文档编辑器**********************************/
      // region
      beforeContentUpload(file) {
        const param = {
          images: file,
          serial_number: this.marketData.serial_number
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
      onEditorBlur() {//失去焦点事件
      },
      onEditorFocus() {//获得焦点事件
      },
      onEditorChange(e, decimalNum) {//内容改变事件
        console.log(this.content)
        var lengthcontent = this.content;
        function removeHTMLTag(str) {
          var str;
          str = str.replace(/<\/?[^>]*>/g, ''); //去除HTML tag
          str = str.replace(/[ | ]*\n/g, '\n'); //去除行尾空白
          str = str.replace(/\n[\s| | ]*\r/g, '\n'); //去除多余空行
          str = str.replace(/ /ig, '');//去掉
          return str;
        }
        console.log(removeHTMLTag(lengthcontent).length)
        e.quill.deleteText(decimalNum, 1);//保留 strValue 的 前 decimalNum 位字符，
        this.$emit('Quescthon', this.content)
        if (removeHTMLTag(lengthcontent).length < 1001) {
          this.marketData.content = this.content;
          console.log(this.marketData)
        } else {
          this.$message.error('字数超过限制');
        }
      },
      // 显示宽度修改框
      _showWidthBox(event) {
        // 获取当前图片对象
        let currentImg = event.target;
        // 弹出宽度输入框
        this.$prompt('请输入宽度', '提示', {
          inputValue: currentImg.width,
          confirmButtonText: '确定',
          cancelButtonText: '取消'
        }).then(({value}) => {
          // 赋值新宽度
          currentImg.width = value
        }).catch(() => {
        })
      },
      // 监听图片点击
      _listenerImage() {
        // 获取DOM对象
        let editor = document.getElementsByClassName('ql-editor')[0]
        let img = editor.getElementsByTagName('img')
        // 非空验证
        if (img.length === 0) {
          return
        }
        for (let i = 0; i < img.length; i++) {
          let currentImg = img[i];
          // 绑定且防止重复绑定
          currentImg.removeEventListener('dblclick', this._showWidthBox, false);
          currentImg.addEventListener('dblclick', this._showWidthBox, false)
        }
      },
      // endregion

      /***类别事件***/
      checkedType(name, index, id, menu_id) {//大类点击事件
        this.checkedValue = name;
        this.checkedIndex = id;
        this.category_id = menu_id;
        console.log(name, index)
        this.marketData.category_id = menu_id;
      },
      /**************城市********************/
      // region
      /***
       * 获取所有城市地区
       */
      getAllAddress() {
        this.HttpClient.get('/city/getAllCities').then(res => {
          console.log(res)
          if (res.data.code === 200) {
            this.allCities = res.data.data;
            this.provinceOptions = this.allCities;
          }
        })
      },
      /***
       * 选择省
       */
      handleChooseProvince(value) {
        this.cityOptions = this.handleGetObjectByKey(this.provinceOptions, value).child;
        this.provinceId = value;
        this.marketData.province = this.provinceId;
      },
      /***
       * 选择市
       */
      handleChooseCity(value) {
        this.districtOptions = this.handleGetObjectByKey(this.cityOptions, value).child;
        this.cityId = value;
        this.marketData.city = this.cityId;
      },
      /***
       * 选择区
       */
      handleChooseDistrict(value) {
        this.districtId = value;
        this.marketData.district = this.districtId;
      },
      /***
       * 根据key查询数组对象中的item
       * @param arr
       * @param value
       * @returns {*}
       */
      handleGetObjectByKey(arr,value) {
        return arr.find(function (obj) {
          return obj.id === value
        });
      },
      // endregion

      /***********上传附件****************/
      // region
      handleFileRemove(file, fileList) {

        if(fileList.length<=0){
          this.dragFilesOver=false;
        }
      },
      handleFileCardPreview(file) {
        this.dialogFilesImageUrl = file.url;
        this.dialogFilesVisible = true;
      },
      handleFileExceed(files, fileList) {
        this.$message.warning(`当前限制选择 5 个文件，本次选择了 ${files.length} 个文件，共选择了 ${files.length + fileList.length} 个文件`);
      },
      handleFileChange(file,fileList){
        if(fileList.length>0){
          this.dragFilesOver=true;
          this.dragFilesDone=true;
        }else{
          this.dragFilesOver=false;
          this.dragFilesDone=false;
        }
      },
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
          serial_number: this.marketData.serial_number
        };
        this.HttpClient.form('/goods/uploadAttachment', param)
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
      async handleBeforeFileRemove(file, fileList) {
        let result = null;
        console.log(file, fileList, this.beforeFilesFileList, this.fileFilesList);
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
        //console.log(222,this.beforeFileList,file.name)
        let index = this.beforeFilesFileList.map(item => item.name).indexOf(file.name)
        console.log(index)
        let urls = this.fileFilesList[index];
        if(this.$route.query.id) {
          urls = this.Tools.handleImg(this.editFilesFileList[index].path);
        }
        console.log(urls)
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
      handleFileSuccess(response, file, fileList){
        console.log(file, fileList)
        this.beforeFilesFileList = fileList;
      },
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

      /******提交和取消**********/
      handleSubmit() {
        console.log(this.marketData)

        if(this.$route.query.id) {
          const data = {
            asin: this.$route.query.id,
            title: this.articleTitleName,
            province: parseInt(this.provinceId),
            price: parseInt(this.product_price),
            stock: parseInt(this.product_num),
            tags: this.dynamicTags,
            content: this.content,
            category_id: this.category_id,
            description: this.description,
            serial_number: this.marketData.serial_number,
            city: parseInt(this.cityId),
            district: parseInt(this.districtId)
          };
          console.log(data)
          this.HttpClient.post('/web/user/updateGoods',data).then(res =>{
            console.log(res.data)
            if(res.data.code === 200) {
              this.$message.success(res.data.msg);
            }else {
              this.$message.error(res.data.msg);
            }
          })
        }else{
          this.marketData.integrity = 40;
          this.HttpClient.post('/goods/create',this.marketData).then(res =>{
            if(res.data.code === 200) {
              this.$message.success(res.data.msg);
            }else{
              this.$message.error(res.data.msg);
            }
          })
        }

      }
    },
    watch: {
      inputValue: function () {
        let reg = /[a-zA-Z]/i;
        let len = 0;
        for (let tem of this.inputValue) {
          //console.log(tem);
          //console.log(reg.test(tem));
          if (reg.test(tem)) {
            len++;
          } else {
            len += 3;
          }
        }
        if (len > 15) {
          this.inputValue = this.inputValue.slice(0, -1);
        }
        console.log(len);
        console.log(this.inputValue);
      },
      marketData: {
        handler(newValue, oldValue) {
          console.log(newValue)
        },
        deep: true
      }
    },
    mounted() {
      // this.$refs.question.fixedEnd("uploading_main_item");
      // this.$refs.protocol.handleTimer();
    },
  }
</script>

<style src="@/assets/css/uploading.css"></style>
<style src="@/assets/css/uploadService.css"></style>
<style scoped>
  .img_preview{
    display: -webkit-box;
    display: -ms-flexbox;
    display: flex;
    -webkit-box-align: center;
    -ms-flex-align: center;
    align-items: center;
    position: absolute;
    top: 28px;
    left: 30px;
    width: 300px;
    height: 240px;
    overflow: hidden;
  }
  .upload_tips {
    height: 100%;
    line-height:initial!important;
  }

  .up_icon {
    margin-top: 80px;
    font-size: 30px;
  }

  .upload_tips_txt {
    position: absolute;
    top: 10px;
    right: 10px;
    color: #8c8c8c;
  }

  .upload_tips_suggest {
    position: absolute;
    bottom: 10px;
    right: 60px;
    font-size: 12px;
    color: #8c8c8c;
  }

  .el-upload-dragger .el-icon-upload {
    margin-top: 72px;
  }

  .mod_uploading .mod_uploading_main .main_type_list {
    margin-bottom: 0 !important;
  }

  .mod_uploading_bargains .uploading_main_type .figure_list {
    width: 458px;
  }

  .mod_uploading_bargains .uploading_main_type .list_item {
    margin-bottom: 20px;
  }

  .mod_uploading_main .main_type_list .list_item:nth-child(4) .content_txt_title {
    text-align: center;
    text-align-last: center;
  }
</style>
<style lang="less">
  .mod_uploading_product.mod_uploading_bargains .uploading_main_file .main_file_upload {
    width: 800px;
  }

  .mod_uploading_bargains {
    .service_city {
      margin-bottom: 30px;
    }

    .upload_bargains_submit {
      margin-top: 50px;
      display: flex;
      justify-content: flex-end;
      width: 820px;

      .el-button {
        padding: 10px 30px !important;
      }
      .el-button--default {
        border-color: #15befe !important;
        color: #15befe !important;
      }
      .el-button--primary {
        background: #15befe !important;
        border-color: #15befe !important;
      }
    }

    .uploading_item_product_video{
        border:1px dashed #ccc!important;
    }
    .uploading_item_product_video:hover{
        border:1px dashed #15bafe!important;
    }
  }
</style>


<style lang="less">
  .el-upload-list--picture-card .el-upload-list__item-actions span+span{
    margin-left: 5px !important;
  }

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
    border: 2px dotted #cccccc;
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

  .uploading_item_video:hover {
    border: 2px dotted #15bafe !important;
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
