<template>
  <div class="main_box uploading_background">
    <section>
      <div class="mod_uploading mod_uploading_encyclopedia">
        <nav class="uploading_encyclopedia_nav">
          <el-tabs type="border-card" v-model="stepValue">
            <el-tab-pane label="基本信息" name="1">
              <div class="uploading_encyclopedia_step uploading_encyclopedia_step_1">STEP.1 创建百科基本信息</div>
              <div class="uploading_encyclopedia_info">
                <!--上传图片-->
                <div class="encyclopedia_info_cover">
                  <el-upload
                    class="encyclopedia_cover_box"
                    action="http://test.kslab.com/api/article/null"
                    list-type="picture-card"
                    drag
                    :limit="1"
                    :multiple="true"
                    :file-list="imageFileList"
                    :on-preview="handleImagePreview"
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
                      <p class="encyclopedia_cover_suggest" v-show="!dragOver">推荐640×640像素,JPG/PNG,1M以内</p>
                      <div class="el-upload__txt" v-show="dragOver && !dragDone">松开图片以上传</div>
                    </div>
                  </el-upload>
                  <el-dialog :visible.sync="dialogVisible">
                    <img width="100%" :src="dialogImageUrl" alt="">
                  </el-dialog>
                </div>
                <div class="encyclopedia_info_details mod_uploading_main">
                  <!--标题-->
                  <div class="uploading_main_item uploading_main_title">
                    <div class="main_head">
                      <i class="icon icon_title "></i>
                      <span class="main_txt">标题</span>
                    </div>
                    <input type="text" class="main_title_input" placeholder="标题限定25字以内" v-model="baiKeData.title" maxlength="25">
                    <div class="mod_uploading_date">
                    </div>
                  </div>
                  <!--关键词-->
                  <div class="uploading_main_item uploading_main_tag">
                    <div class="main_head">
                      <i class="icon icon_tag"></i>
                      <span class="main_txt">标签</span>
                      <span class="main_txt_describe">(至少1个标签,最多3个，每个2~5个字)</span>
                    </div>
                    <div class="main_tag_add">
                      <div class="main_tag_add_box" style="display: flex;border: 1px solid #dcdcdc" :class="{active: dynamicTags.length>0}">
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
                        <div class="bai_tag_list" style="display: flex;align-items: center;">
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
                  <!--简介-->
                  <div class="uploading_main_item uploading_main_synopsis">
                    <div class="main_head">
                      <i class="icon icon_synopsis"></i>
                      <span class="main_txt">简介</span>
                    </div>
                    <el-input
                      type="textarea"
                      :rows="2"
                      maxlength="600"
                      minlength="40"
                      placeholder="简介限定40-600字以内"
                      v-model="baiKeData.content">
                    </el-input>
                  </div>
                  <div class="bai_type">
                    <div class="bai_type_title">
                      <i class="icon icon-leibieguanli"></i>
                      <p>类别</p>
                    </div>
                    <div class="bai_type_contents">
                      <div class="bai_type_contents_left">
                        <div class="bai_type_content">
                          <div class="bai_type_item" v-for="(item, index) in baiKeType" :key="index" @click="handleSelectType(item.menu_id)" :class="item.menu_id === currentTypeFirstId ? 'bai_type_item_active' : ''">
                            <i class="icon" :class="item.images"></i>
                            <p>{{item.name}}</p>
                          </div>
                        </div>
                        <div class="bai_type_second" v-if="secondType && secondType.length>0">
                          <div class="bai_type_second_left">
                            <div @click="handleSelectSecondType(item.menu_id)" class="bai_type_second_item" :class="item.menu_id === currentTypeSecondId ? 'bai_type_second_item_active' : ''" v-if="index % 2 === 0" v-for="(item, index) in secondType" :key="index">
                              <p>{{item.name}}</p>
                            </div>
                          </div>
                          <div class="bai_type_second_right" v-if="secondType && secondType.length>1">
                            <div @click="handleSelectSecondType(item.menu_id)" class="bai_type_second_item" :class="item.menu_id === currentTypeSecondId ? 'bai_type_second_item_active' : ''" v-if="index % 2 === 1" v-for="(item, index) in secondType" :key="index">
                              <p>{{item.name}}</p>
                            </div>
                          </div>
                        </div>
                      </div>
                      <div class="bai_type_contents_right">
                        <div class="bai_type_gai_title">
                          <i class="icon icon-caidan"></i>
                          <p>概括</p>
                        </div>
                        <p class="bai_type_gai_remark">
                          包括机械学，震动，声学，流体静力学，热力学，及电子理论
                        </p>
                      </div>
                    </div>

                  </div>
                </div>
              </div>
            </el-tab-pane>
            <el-tab-pane label="创建目录" name="2">
              <div class="uploading_encyclopedia_step uploading_encyclopedia_step_2">STEP.2 创建目录</div>
              <!--<div class="uploading_create_catalogue">
                <div class="catalogue_list">
                  <ul class="first_level">
                    <li class="list_item" v-for="(handline,index) in firstLevel" :key="index">
                      <span class="first_level_txt" :class="{active:activeIndex===index}"
                            @click.stop="firstClick(index,$event)">{{handline.name}}</span>
                      <i class="el-icon-delete" @click="removeFirst(index)"></i>
                      <ul class="second_level">
                        <li class="second_level_txt" :class="{active:activeIndex2===(index+'-'+index2)}"
                            v-for="(tmp,index2) in handline.next" :key="index2"
                            @click="secondClick(index,index2,$event)">
                          {{tmp.name}}
                          <i class="el-icon-delete" @click="removeSecond(index,index2)"></i>
                        </li>
                      </ul>
                    </li>
                  </ul>
                </div>
                <div class="catalogue_compile">
                  <div class="first_level_input">
                    <div class="main_head">
                      <i class="icon icon_catalogue"></i>
                      <span class="main_txt">一级目录</span>
                      <span class="main_txt_describe">(必填)</span>
                    </div>
                    <input type="text" placeholder="标题限定15字以内" v-model="firstValue" @keyup.13="addFirst">
                    <i class="el-icon-circle-plus" @click="addFirst"></i>
                  </div>
                  <div class="second_level_input">
                    <div class="main_head">
                      <i class="icon icon_catalogue2"></i>
                      <span class="main_txt">二级目录</span>
                      <span class="main_txt_describe">(可选)</span>
                    </div>
                    <input type="text" placeholder="标题限定15字以内" v-model="secondValue" @keyup.13="addSecond">
                    <i class="el-icon-circle-plus" @click="addSecond"></i>
                  </div>
                </div>
              </div>-->
              <div class="bai_catalog">
                <div class="bai_catalog_left">
                  <div class="bai_catalog_left_first_item" v-for="(item, index) in catalogList" :key="index">
                    <div class="catalog_first_item" @click="handleSelectFirstCatalog(item.id)">
                      <span class="catalog_dot"></span>
                      <p class="catalog_first_title">{{item.name}}</p>
                      <i class="icon icon-delete delete_icon"></i>
                    </div>
                    <div class="bai_catalog_left_second_item" v-for="(itemS, indexS) in item.child" :key="indexS">
                      <i class=" icon icon-caidan"></i>
                      <p class="catalog_second_title">{{itemS.name}}</p>
                      <i class="icon icon-delete" :class="'delete_icon'"></i>
                    </div>
                  </div>
                </div>
                <div class="bai_catalog_right">
                  <div class="bai_catalog_right_content">
                    <div class="bai_catalog_right_first_title">
                      <i class="icon icon-neirong"></i>
                      <span>一级目录标题</span>
                    </div>
                    <el-input v-model="firstCatalogValue" size="mini" class="bai_catalog_input" placeholder="请添加一级目录">
                      <el-button @click="handleAddFirstCatalog" slot="append" icon="el-icon-circle-plus"></el-button>
                    </el-input>
                    <div v-if="secondCatalogVisible" class="bai_catalog_right_first_title" style="margin-top: 20px">
                      <i class="icon icon-neirong"></i>
                      <span>二级目录标题</span>
                    </div>
                    <el-input  v-if="secondCatalogVisible" v-model="secondCatalogValue" size="mini" class="bai_catalog_input" placeholder="请添加一级目录">
                      <el-button @click="handleAddSecondCatalog" slot="append" icon="el-icon-circle-plus"></el-button>
                    </el-input>
                  </div>
                </div>
              </div>
            </el-tab-pane>
            <el-tab-pane label="编辑百科" name="3">
              <div class="uploading_encyclopedia_step uploading_encyclopedia_step_3">STEP.3 编辑百科</div>
              <div class="uploading_compile_encyclopedia">
                <div class="catalogue_list">
                  <ul class="first_level">
                    <li class="list_item" v-for="(handline,index) in firstLevel" :key="index">
                      <span class="first_level_txt" :class="{active:activeIndex===index}"
                            @click.stop="firstClick(index,$event)">{{handline.name}}</span>
                      <ul class="second_level">
                        <li class="second_level_txt" :class="{active:activeIndex2===(index+'-'+index2)}"
                            v-for="(tmp,index2) in handline.next" :key="index2"
                            @click="secondClick(index,index2,$event)">
                          {{tmp.name}}
                        </li>
                      </ul>
                    </li>
                  </ul>
                </div>
                <div class="compile_encyclopedia_detail">
                  <div class="compile_encyclopedia_content" v-if="firstLevel.length>0">
                    <div class="main_head">
                      <i class="icon_rectangle"></i>
                      <span class="main_txt">{{currentValue}}</span>
                    </div>
                    <quill-editor
                      class="encyclopedia_editor"
                      v-model="content"
                      ref="myQuillEditor"
                      :options="editorOption"
                      @blur="onEditorBlur($event)" @focus="onEditorFocus($event)"
                      @change="onEditorChange($event)">
                    </quill-editor>
                  </div>
                  <uploading-main-file @uploadingEncy='uploadingEncyClick'></uploading-main-file>
                  <div class="uploading_main_item uploading_main_part">
                    <div class="main_head">
                      <i class="icon icon_part" style="width:22px;height:20px;margin-right:11px;"></i>
                      <span class="main_txt">参考文献</span>
                    </div>
                    <div class="main_part_detail">
                      <el-input
                        placeholder="添加文献名字"
                        v-model="partValue"
                        clearable
                        @keyup.enter.native="addPart">
                      </el-input>
                      <i class="el-icon-circle-plus" @click="addPart"></i>
                      <ul class="figure_list">
                        <li class="list_item" v-for="(part,index) in partList" :key="index">
                          <i class="el-icon-delete" @click="removePart(index)"></i>
                          <div class="part_info" :class="{active}">
                            <span class="part_info_name">{{part.name}}</span>
                            <el-input
                              placeholder="输入连接(选填)"
                              clearable
                              style="width:initial"
                              @focus="onFocus"
                              @blur="onBlur"
                              @input="getPartLink($event,index)"
                            ></el-input>
                          </div>
                        </li>
                      </ul>
                    </div>
                  </div>
                </div>
              </div>
            </el-tab-pane>
          </el-tabs>
        </nav>
        <div class="mod_uploading_confirm" v-if="activeName<3">
          <a href="javascript:;" class="uploading_confirm_cancel" @click="goBack">取消</a>
          <a href="javascript:;" class="uploading_confirm_release active" @click="handleNextStep">下一步</a>
        </div>
        <div class="uploading_submit" v-if="activeName==='3'">
          <a href="javascript:;" class="submit_btn" :class="{active:activeName<3}" @click="submit">
            <i class="icon icon_release"></i>
            发布百科
          </a>
        </div>
      </div>
    </section>
    <aside>
      <floating-div></floating-div>
    </aside>
    <!--<protocol-div ref="protocol"></protocol-div>-->
  </div>
</template>

<script>

  import FloatingDiv from '@/components/floating'
  import ProtocolDiv from '@/views/upload/protocol'
  import UploadingMainTitle from '@/views/upload/uploadingMainTitle'
  import UploadingMainContent from '@/views/upload/uploadingMainContent'
  import UploadingMainTypeDetail from '@/views/upload/uploadingMainTypeDetail'
  import UploadingMainFile from '@/views/upload/uploadingMainFile'


  var toolbarOptions = [
    ['bold', 'italic', 'underline', 'strike'],
    ['blockquote', 'code-block'],
    [{'header': 1}, {'header': 2}],
    [{'list': 'ordered'}, {'list': 'bullet'}],
    [{'script': 'sub'}, {'script': 'super'}],
    [{'indent': '-1'}, {'indent': '+1'}],
    [{'direction': 'rtl'}],
    [{'size': ['small', false, 'large', 'huge']}],
    [{'header': [1, 2, 3, 4, 5, 6, false]}],
    [{'color': []}, {'background': []}],
    [{'font': []}],
    [{'align': []}],
    ['clear']
  ];

  export default {
    name: "uploadingEncyclopedia",
    data() {
      return {
        infoData: {}, //百科详情
        contentData: '',  //富文本内容
        encData: {},//个人中心修改百科传过来的数据
        title: '标题',
        dynamicTags: [],  //装关键字的容器
        inputValue: '',
        activeName: '1',
        firstValue: '',
        firstLevel: [
          // {name:'汽车',next:['越野车']},
          // {name:'摩托车',next:['越野车']}
        ],
        secondValue: '',
        secondIndex: 0,
        currentValue: '',
        activeIndex: 0,
        activeIndex2: "0-0",

        content: null,
        editorOption: {
          modules: {
            toolbar: toolbarOptions
          }
        },
        partValue: '',
        partList: [],//零件数组
        active: false,
        titleDate: null,    //标题数据
        richFont: null,      //富文本数据
        categoryDate: null,       //类别数据
        cdnImg: null,         //第一面上传图片返回path
        encyclopedia_id: null,   //一级上传成功返回encyclopedia_id百科ID
        EncyFile: [], //附件数组
        fileList3: [],
        // edit by zxd
        baiKeId: '', // 百科id
        baiKeData: { // 百科数据
          category_id: '', // 分类id
          title: '', // 百科标题
          serial_number: null, // 上传唯一编号
          content: '', // 百科简介
          label: [] , // 标签
          integrity: null, // 完善度
        },
        baiKeType: [], // 百科类别
        secondType: [], // 二级百科列表
        currentTypeFirstId: '', // 当前选中的一级类型id
        currentTypeSecondId: '', // 当前选中的一级类型id
        imageFileList: [], // 绑定的图片列表
        imageReallyFileList: [], // 真实存储的图片列表
        imageBeforeFileList: [], // 上传之后，删除之前的图片列表
        dialogImageUrl: '', // 图片预览地址
        dialogVisible: false, // 是否显示图片预览
        dragOver: false, // 图片上传之前的描述
        dragDone: false, // 图片拖拉描述
        stepValue: '1', // 进度步骤
        catalogList: [], // 目录列表
        firstCatalogValue: '', // 一级输入框的值
        secondCatalogValue: '', // 二级输入框的值
        firstCatalogId: '', // 一级目录id
        secondCatalogId: '', // 二级目录id
        secondCatalogVisible: false, // 二级输入框显示
      }
    },
    components: {
      FloatingDiv,
      ProtocolDiv,
      UploadingMainTitle,
      UploadingMainContent,
      UploadingMainTypeDetail,
      UploadingMainFile,
    },
    created() {
      this.getBaiKeType();
      this.baiKeData.serial_number = this.Tools.GetNumber();
    },
    mounted() {
      this.getData();
      // this.$refs.protocol.handleTimer()
    },
    methods: {
      // region
      handleRemove(file, fileList) {
        console.log(file, fileList);
        if (fileList.length <= 0) {
          this.dragOver = false;
        }
      },
      uploadingEncyClick(msg) {

        this.EncyFile.push(msg)
        console.log(this.EncyFile)
      },
      handleSuccess() {
        this.$message.success('上传成功!')
      },
      handleError() {
        this.$message.error('上传失败!')
      },
      handleExceed() {
        this.$message.warning(`当前限制选择 1 个文件，本次选择了 ${files.length} 个文件，共选择了 ${files.length + fileList.length} 个文件`)
      },
      handlePictureCardPreview(file) {
        this.dialogImageUrl = file.url;
        this.dialogVisible = true;
      },
      beforeAvatarUpload(file) {
        const isJPG = file.type === 'image/jpeg';
        const isPNG = file.type === 'image/png';
        const isLt2M = file.size / 1024 / 1024 < 1;

        if (!isJPG && !isPNG) {
          this.$message.error('上传头像图片只能是 JPG/PNG 格式!');
        } else {
          var FontDate = new FormData()
          FontDate.append('token', window.localStorage.token)
          FontDate.append('image_path', file)
          FontDate.append('serial_number', Number(new Date()))
          var FileImg = file
          this.$ajax.post(this.request.axiosPort + this.request.axiosApi + 'encyclopedias/uploadimage', FontDate)
            .then((res) => {
              console.log(res)
              this.cdnImg = res.data.path
              console.log(this.cdnImg)
            })
        }
        if (!isLt2M) {
          this.$message.error('上传头像图片大小不能超过 5MB!');
        }
        return isJPG || isPNG && isLt2M;
      },
      /**************************************添加关键词********************************************/

      goBack() {
        this.$router.go(-1)
      },
      tabNext() {
        if (this.$route.query.data) {
          console.log('我是修改百科')
          console.log(this.infoData)
          // this.activeName= parseInt(this.activeName)+1;
          // console.log(this.activeName)
          // this.$ajax.post(this.request.axiosPort + this.request.axiosApi + 'my/encyclopedias/edit',{
          // token:window.localStorage.token,
          // encyclopedia_id:this.infoData.encyclopedia_id,
          // catagory_id:this.infoData.catagory_id,
          // cover:this.dialogImageUrl,
          // content:this.richFont,
          // label:this.dynamicTags,
          // })
          // .then((res) => {
          //     console.log(res)
          // })
          if (parseInt(this.activeName) < 3) {
            this.activeName = "" + (parseInt(this.activeName) + 1);
            if (parseInt(this.activeName) <= 2) {
              this.$ajax.post(this.request.axiosPort + this.request.axiosApi + 'my/encyclopedias/edit', {
                token: window.localStorage.token,
                encyclopedia_id: this.infoData.encyclopedia_id,
                catagory_id: this.infoData.catagory_id,
                cover: this.dialogImageUrl,
                content: this.richFont,
                label: this.dynamicTags,
              })
                .then((res) => {
                  console.log(res)

                })
            } else if (parseInt(this.activeName) == 3) {
              console.log(this.firstLevel)
            }
          }


        } else {
          if (parseInt(this.activeName) < 3) {
            this.activeName = "" + (parseInt(this.activeName) + 1);
            if (parseInt(this.activeName) <= 2) {
              var pack = new FormData()
              var cont = this.dynamicTags
              this.$ajax.post(this.request.axiosPort + this.request.axiosApi + 'encyclopedias/upload', {
                title: this.titleDate,
                label: this.dynamicTags,
                content: this.richFont,
                category_id: this.categoryDate,
                token: window.localStorage.token,
                cover: this.cdnImg
              })
                .then((res) => {
                  if (res.data.code != 200) {
                    this.activeName = 1
                    this.$message.error(res.data.msg);
                  } else {
                    this.$message.success('上传成功!')
                    this.encyclopedia_id = res.data.encyclopedia_id
                  }
                })
            } else if (parseInt(this.activeName) == 3) {
              console.log(this.firstLevel)

            }
          }
        }
      },
      submit() {
        if (this.activeName >= 3) {
          this.$ajax.post(this.request.axiosPort + this.request.axiosApi + 'encyclopedias/addcatalog', {
            token: window.localStorage.token,
            encyclopedia_id: this.encyclopedia_id,
            catelog: this.firstLevel,
            source: null,
            attachment: this.EncyFile
          })
            .then((res) => {
              if (res.data.code != 200) {
                console.log(this.partList)
                this.$message.error(res.data.msg)
              } else {
                console.log(this.partList)
                this.$message.success(res.data.msg)
                this.$router.go(-1)
              }
            })

        }
      },
      removeFirst(index) {
        this.firstLevel.splice(index, 1);
        this.secondIndex = this.firstLevel.length - 1;
        this.currentValue = this.firstLevel[index - 1].name;
        console.log(this.secondIndex);
      },
      addFirst() {
        //添加一级目录
        const newFirst = {name: this.firstValue, next: [], content: ''};
        if (this.firstLevel.length < 3) {
          this.firstLevel.push(newFirst);
          this.secondIndex = this.firstLevel.length - 1;
          this.currentValue = this.firstValue;
          this.activeIndex = this.secondIndex;
          this.activeIndex2 = this.secondIndex + "-" + 0;
          this.firstValue = '';
        } else {
          this.$message.warning('只能上传三条一级目录');
        }
      },
      firstClick(index, event) {
        //选择一级目录
        this.secondIndex = index;
        this.activeIndex = index;
        this.activeIndex2 = index + "-" + "null";
        this.currentValue = this.firstLevel[index].name;
        this.content = this.firstLevel[index].content
      },
      addSecond() {
        //添加二级目录
        if (this.firstLevel.length > 0) {
          if (this.firstLevel[this.secondIndex].next.length < 3) {
            this.firstLevel[this.secondIndex].next.push({name: this.secondValue, content: ''});
            this.currentValue = this.firstLevel[this.secondIndex].name + " · " + this.secondValue;
            this.activeIndex2 = this.secondIndex + "-" + (this.firstLevel[this.secondIndex].next.length - 1);
            this.secondValue = '';
          } else {
            this.$message.warning('只能添加三条二级目录')
          }
        } else {
          this.$message.warning('请先添加一级目录！')
        }
      },
      removeSecond(index, index2) {
        //删除二级
        this.firstLevel[index].next.splice(index2, 1);
        console.log(this.firstLevel[index].next.length);
        if (this.firstLevel[index].next.length > 0) {
          this.currentValue = this.firstLevel[index].name + " · " + this.firstLevel[index].next[index2 - 1]
        } else {
          this.currentValue = this.firstLevel[index].name
        }
      },
      secondClick(index, index2, event) {
        //选择二级
        this.activeIndex = index;
        this.activeIndex2 = index + "-" + index2;
        this.currentValue = this.firstLevel[index].name + " · " + this.firstLevel[index].next[index2].name;
        this.content = this.firstLevel[index].next[index2].content
      },
      /***********************************文档编辑器**********************************/
      onEditorBlur() {//失去焦点事件
      },
      onEditorFocus() {//获得焦点事件
      },
      onEditorChange() {//内容改变事件
        let IndexList = this.activeIndex2.split('-');
        if (IndexList[1] !== "null") {
          this.firstLevel[IndexList[0]].next[IndexList[1]].content = this.content;
          console.log(this.firstLevel)
        } else {
          console.log("1")
          this.firstLevel[IndexList[0]].content = this.content
        }
      },
      /**********************************参考文献************************************/
      addPart() {
        if (this.partValue) {
          // this.partName=this.partValue;
          this.partList.push({name: this.partValue, link: ''});
          this.partValue = '';
        } else {
          this.$message({
            message: '请输入零件/软件名称',
            type: 'warning'
          });
        }
      },
      removePart(index) {
        this.partList.splice(index, 1);
      },
      onFocus() {
        this.active = true;
      },
      onBlur() {
        this.active = false;
      },
      getPartLink(e, i) {//获取零件链接
        this.partList[i].link = e;
      },
      handleChange(file, fileList) {
        if (fileList.length > 0) {
          this.dragOver = true;
          this.dragDone = true;
        } else {
          this.dragOver = false;
          this.dragDone = false;
        }
      },
      onDragover() {
        this.dragOver = true;
      },
      dragLeave() {
        this.dragOver = false;
      },
      //接口事件开始
      EncyclopediaTitle(msg) {
        //创建第一面提交数据包并进行双向数据绑定
        this.titleDate = msg
        console.log(this.titleDate)
      },
      EncyclopediaQuertp(msg) {
        //富文本数据
        this.richFont = msg
        console.log(this.richFont)
      },
      EncyclopediaTypeValue(msg) {
        this.categoryDate = msg
        console.log(this.categoryDate)
      },
      getData() {
        if (this.$route.query.data) {
          // 取到路由带过来的参数
          let routerQuery = this.$route.query.data
          // 将数据放在当前组件的数据内
          this.encData = routerQuery;
          this.dialogImageUrl = this.request.picUrl + routerQuery.cover;  //图片地址
          console.log(this.dialogImageUrl)
          this.fileList3 = [{name: '111', url: this.dialogImageUrl}]
          this.dynamicTags = routerQuery.label_name;                    //关键词
          //获取百科ID
          var id = routerQuery.encyclopedia_id;
          this.$ajax.post(this.request.axiosPort + this.request.axiosApi + 'encyclopedias/info', {
            token: window.localStorage.token,
            encyclopedia_id: id,
          })
            .then((res) => {
              console.log(res)
              this.infoData = res.data.data;
              // console.log(res.data.data.content)
              var start = res.data.data.content.indexOf('<p><strong style="font-size: 18px;">'),
                stop = res.data.data.content.indexOf('</strong></p>');
              this.contentData = res.data.data.content.substring(start + 36, stop);
              console.log(this.contentData)
            })
        }
      },
      // endregion

      /**********************created()时的方法***************/
      //region
      /******
       * 获取百科类型
       */
      getBaiKeType() {
        const param = {
          type: 1,
          level: 2
        };
        this.HttpClient.post('/category/list', param)
          .then(res =>{
            if(res.data.code === 200) {
              this.baiKeType = res.data.data;
            }
          })
      },
      // endregion

      /**********************上传图片************************/
      // region
      /****
       * 图片预览
       * @param file
       */
      handleImagePreview(file) {
        this.dialogImageUrl = file.url;
        this.dialogVisible = true;
      },
      /****
       *
       * @param file
       * @param fileList
       */
      handleImageRemove(file, fileList) {
        console.log(file, fileList);
        if(fileList.length<=0){
          this.dragOver=false;
        }
      },
      /****
       * 上传图片之前
       * @param file
       */
      async beforeImageUpload(file) {
        const isLt5M = file.size / 1024 / 1024 < 5;
        const fileType = file.name.split('.')[1];
        if (fileType !== 'png' && fileType !== 'jpg' && fileType !== 'jpeg') {
          this.$message.error('上传头像图片只能是 JPG/PNG 格式!');
          return false;
        }
        if (!isLt5M) {
          this.$message.error('上传头像图片大小不能超过 5MB!');
          return false;
        }
        const param = {
          image_path: file,
          serial_number: this.baiKeData.serial_number
        };
        await this.HttpClient.form('/encyclopedias/uploadimage', param)
          .then(res =>{
            if(res.data.code === 200) {
              this.imageReallyFileList.push(res.data.path);
            }else {
              this.$message.error(res.data.msg);
            }
          })
      },
      /****
       * 删除图片之前
       * @param file
       * @param fileList
       */
      async beforeImageRemove(file, fileList) {
        let urls;
        if(this.baiKeId) {

        }else {
          const index = this.imageBeforeFileList.map(item => item.name).indexOf(file.name);
          console.log(index)
          urls = this.imageReallyFileList[index];
          await this.HttpClient.post('/services/destroyFile', {url: urls})
            .then(res =>{
              if(res.data.code === 200) {
                this.imageReallyFileList.splice(index, 1);
              }else {
                this.$message.error('删除失败');
              }
            })
        }
      },
      /****
       * 图片改变事件
       * @param file
       * @param fileList
       */
      handleImageChange(file, fileList) {
        if(fileList.length>0){
          this.dragOver=true;
          this.dragDone=true;
        }else{
          this.dragOver=false;
          this.dragDone=false;
        }
      },
      /*****
       * 图片上传成功
       * @param response
       * @param file
       * @param fileList
       */
      handleImageSuccess(response, file, fileList) {
        this.imageBeforeFileList = fileList;
      },
      /****
       * 图片上传失败
       */
      handleImageError() {
        this.$message.error('上传失败');
      },
      /****
       * 文件超出个数限制时的钩子
       * @param file
       * @param fileList
       */
      handleImageExceed(file, fileList) {
        this.$message.warning(`当前限制选择 1 个文件，本次选择了 ${fileList.length} 个文件，供选择了 ${this.imageFileList.length +  fileList.length} 个`);
      },
      // endregion

      /************************新增标签******************************/
      // region

      // 删除标签
      handleClose(tag) {
        this.dynamicTags.splice(this.dynamicTags.indexOf(tag), 1);
      },
      /*****
       * 添加单个标签
       */
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
        this.baiKeData.label = this.dynamicTags;
      },

      // endregion

      /************************类型选择******************************/
      // region
      /****
       * 选择一级类型
       * @param id
       */
      handleSelectType(id) {
        this.currentTypeFirstId = id;
        this.baiKeData.category_id = id;
        const options = this.baiKeType.find(function (obj) {
          return obj.menu_id === id;
        });
        this.secondType = options.child;
      },
      /****
       * 选择二级类型
       * @param id
       */
      handleSelectSecondType(id) {
        this.currentTypeSecondId = id;
        this.baiKeData.category_id = id;
      },
      // endregion

      /*************************点击下一步***************************/
      // region
      /****
       * 点击下一步
       */
      handleNextStep() {
        if(parseInt(this.stepValue) === 1) {
          console.log(this.baiKeData);
          this.baiKeData.agreement_status = 1;
          if(this.baiKeData.label.length>0) {
            this.baiKeData.integrity = this.baiKeData.label.length * 15;
          }
          this.HttpClient.post('/encyclopedias/upload',this.baiKeData)
            .then(res =>{
              if(res.data.code === 200) {
                this.stepValue = '2';
              }
            })
        }
      },
      // endregion

      /**************************目录管理*****************************/
      /****
       * 添加一级目录
       */
      handleAddFirstCatalog() {
        if(this.firstCatalogValue) {
          this.catalogList.push({
            id: this.Tools.GetNumber(),
            name: this.firstCatalogValue
          });
          console.log(this.catalogList)
        }else {
          this.$message.warning('一级目录值不能为空')
        }
        if(this.catalogList.length > 0) {
          this.secondCatalogVisible = true;
        }
      },
      /*****
       * 添加二级目录
       */
      handleAddSecondCatalog() {
        if(this.firstCatalogId) {
          if(this.secondCatalogValue) {
            /*const options = this.catalogList.find(function (obj) {
              return obj.id === id
            });*/
            let index;
            this.catalogList.map((item, indexS) =>{
              if(item.id === this.firstCatalogId) {
                index = indexS;
              }
            });
            this.catalogList[index]['child'].push({
              id: this.Tools.GetNumber(),
              name: this.secondCatalogValue
            });
          }else {
            this.$message.warning('二级目录值不能为空')
          }
        }else {
          this.$message.warning('请选择一级目录列表')
        }
      },
      /****
       * 选择第一级的目录列表
       * @param id
       */
      handleSelectFirstCatalog(id) {
        this.firstCatalogId = id;
      }
    }
  }
</script>

<style src="@/assets/css/uploading.css"></style>
<style src="@/assets/css/uploadService.css"></style>
<style scoped lang="less">
  .main_box {
    background: #f2f2f2;
  }
  .mod_uploading {
    position: relative;
    padding-bottom: 0;
    box-shadow: none;
    border: none;
  }
  .el-icon-caret-right {
    position: absolute;
    top: -12px;
    left: -10px;
    color: #f0f;
    font-size: 62px;
  }
  .uploading_encyclopedia_nav {
    margin-bottom: 17px;
  }
  .uploading_main_title {
    .bai_tag_list {
      display: flex;
      align-items: center;
    }
  }
  .bai_type {
    .bai_type_contents {
      display: flex;
      .bai_type_contents_left {
        flex: 1;
      }
      .bai_type_contents_right {
        width: 200px;
        border: 1px solid #f2f2f2;
        min-height: 400px;
        margin-left: 10px;
        .bai_type_gai_title {
          display: flex;
          height: 30px;
          line-height: 30px;
          background: #dcdcdc;
          i {
            margin-left: 5px;
          }
          p {
            line-height: 33px;
          }
        }
        .bai_type_gai_remark {
          margin: 10px 10px;
        }
      }
    }
    .bai_type_title{
      display: flex;
      height: 40px;
      line-height: 40px;
      i {
        color: #15BAFE;
        font-size: 20px;
      }
      p {
        font-size: 16px;
        font-weight: 600;
        line-height: 44px;
      }
    }
    .bai_type_content {
      display: flex;
      flex-wrap: wrap;
      .bai_type_item {
        cursor: pointer;
        height: 120px;
        width: 120px;
        border: 1px solid #f2f2f2;
        text-align: center;
        margin-right: 20px;
        margin-top: 20px;
        i {
          font-size: 34px;
          margin-left: -7px;
          margin-top: 15px;
        }
        p{
          margin-top: 30px;
        }
      }
      .bai_type_item:hover {
        box-shadow: 0 0 7px rgba(0,0,0,0.1);
        color: #15BAFE;
      }
      .bai_type_item_active {
        box-shadow: 0 0 7px rgba(0,0,0,0.1);
        color: #15BAFE;
      }
      .bai_type_item:nth-last-child(1) {
        margin-right: 0;
      }
    }
    .bai_type_second {
      display: flex;
      width: 300px;
      border: 1px solid #f2f2f2;
      font-size: 13px;
      color: #808080;
      margin-top: 20px;
      .bai_type_second_left {
        width: 50%;
      }
      .bai_type_second_item_active {
        color: #15BAFE;
      }
      .bai_type_second_item {
        text-align: center;
        margin-top: 10px;
        margin-bottom: 5px;
        cursor: pointer;
        p:hover {
          color: #15BAFE;
        }
      }
      .bai_type_second_right {
        width: 49%;
        border-left: 1px solid #f2f2f2;
      }
    }
  }
  .bai_catalog {
    display: flex;
    width: 100%;
    .bai_catalog_left {
      width: 30%;
      min-height: 800px;
      border-right: 1px solid #f2f2f2;
      .bai_catalog_left_first_item {
        margin-right: 20px;
        .catalog_first_item {
          display: flex;
          align-items: center;
          .catalog_dot {
            width: 10px;
            height: 10px;
            border-radius: 50%;
            background: black;
          }
          .catalog_first_title {
            flex: 1;
            color: #15BAFE;
            font-size: 16px;
            font-weight: 600;
            margin-left: 10px;
          }
          .delete_icon {
            font-size: 14px;
            color: #7d7d7d;
            cursor: pointer;
          }
          .delete_icon:hover {
            color: #15BAFE;
          }
        }
        .bai_catalog_left_second_item {
          margin-top: 10px;
          margin-left: 20px;
          display: flex;
          align-items: center;
          margin-right: 20px;
          .catalog_second_dot {

          }
          .catalog_second_title {
            flex: 1;
            margin-left: 10px;
          }
          .delete_icon {
            font-size: 14px;
            color: #7d7d7d;
            cursor: pointer;
          }
          .delete_icon:hover {
            color: #15BAFE;
          }
        }
      }
    }
    .bai_catalog_right {
      width: 69%;
      .bai_catalog_right_content {
        margin: 0 20px;
        .bai_catalog_right_first_title {
          display: flex;
          align-items: center;
          i {
            color: #15BAFE;
            font-size: 16px;
          }
          span {
            font-size: 16px;
            font-weight: 600;
            color: #404040;
            margin-left: 10px;
          }
        }
        .bai_catalog_input {
          margin-top: 10px;
        }
      }
    }
  }
  </style>
