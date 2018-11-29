<template>
    <div class="body uploading_background">
        <section>
            {{dataArticleAtom}}<br />
            {{parameter}}
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
                                    :file-list="urlBig"
                                    :limit="1"
                                    :multiple="true"
                                    :on-preview="handlePictureCardPreview"
                                    :on-remove="handleRemove"
                                    :before-upload="beforeAvatarUpload"
                                    :on-change="handleChange"
                                    :on-success="handleSuccess"
                                    :on-error="handleError"
                                    :on-exceed="handleExceed">
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
                        <uploading-main-title  :mainTxt="title" @ArticletitleName="titleBody" :titleVakue="dataArticleAtom.title"></uploading-main-title>
                        <div class="uploading_main_item uploading_main_synopsis">
                            <div class="main_head">
                                <i class="icon icon_synopsis"></i>
                                <span class="main_txt">简介</span>
                            </div>
                            <el-input
                                    @change="changeInput"
                                    type="textarea"
                                    :rows="2"
                                    maxlength="50"
                                    placeholder="简介限定50字以内"
                                    v-model="parameter.textarea">
                            </el-input>
                        </div>
                    </div>
                    <uploading-main-content @ArticleMainContent="MainContent" :description="dataArticleAtom.content"></uploading-main-content>
                    <uploading-main-tag @MainTagLength="MainTaglength" :labeList="dataArticleAtom.label"></uploading-main-tag>
                    <div class="uploading_main_item uploading_main_type">
                        <div class="main_head">
                            <i class="icon icon_type"></i>
                            <span class="main_txt">类别</span>
                        </div>
                        <div class="main_type_list">
                            <ul class="figure_list">
                                <li class="list_item" :class="{active:index===checkedIndex}" v-for="(tmp,index) in typeList" :key="index" @click.stop="checkedType(tmp.type,index)">
                                    <div class="type_list_content">
                                        <div class="type_content_img_box"><i class="icon" :class="tmp.img"></i></div>
                                        <div class="type_content_txt">
                                            <p class="content_txt_title">{{tmp.type}}</p>
                                        </div>
                                    </div>
                                </li>
                            </ul>
                        </div>
                    </div>
                    <uploading-main-part @MainpartAcont="uploadPart" :Source="dataArticleAtom.source"></uploading-main-part>
                    <uploading-main-file :compile="dataArticleAtom.attachment" id="uploading-main-file" @uploadMinFile="MinFilecd"></uploading-main-file>
                </div>
                <main-item-tips ref="mainItemTips"></main-item-tips>
                <mod-uploading-confirm v-if="this.$route.query.status == 1?false:true" :parameterAcont="parameter"></mod-uploading-confirm>
                <mod-uploading-confirm v-else :parameterAcont="dataArticleAtom"></mod-uploading-confirm>
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


    var toolbarOptions = [
        ['bold','italic','underline','strike'],
        ['blockquote','code-block'],
        [{'header':1},{'header':2}],
        [{'list':'ordered'},{'list':'bullet'}],
        [{'script':'sub'},{'script':'super'}],
        [{'indent':'-1'},{'indent':'+1'}],
        [{'direction':'rtl'}],
        [{'size':['small',false,'large','huge']}],
        [{'header':[1,2,3,4,5,6,false]}],
        [{'color':[]},{'background':[]}],
        [{'font':[]}],
        [{'align':[]}],
        ['clear']
    ];

    export default {
        name: "uploadingArticle",
        data(){
            return {
                title:'标题',
                titleValue:'',
                content:null,
                dragOver:false,
                dragDone:false,
                dialogVisible:false,
                dialogImageUrl:'',
                editorOption:{
                    modules:{
                        toolbar:toolbarOptions
                    }
                },
                parameter:{
                  titleContent:'',  //标题,
                  MainContentBody:'', // 富文本内容
                  MainTagCont:'',   //标签数组
                  MaintypeCont:'',  //汽车类型
                  uploadPartCont:'',  //添加零件/软件名字
                  textarea:'',
                  fileimg:Number(new Date())+1,     //图片编号
                  MinFilemsg:null
                },
                typeList:[ //类别列表
                    {type:'汽车',img:'icon-qiche'},
                    {type:'摩托车',img:'icon-motuoche'},
                    {type:'无人机',img:'icon-wurenji--'},
                    {type:'智能设备',img:'icon-zhinengshebei'}
                ],
                checkedValue:'',//大类已选值
                checkedIndex:null, //大类已选值下标
                dataArticleAtom:{
                  category_id:null,               //文章类别id
                  title:null,           //标题
                  token:window.localStorage.token,        //用户登陆token
                  article_id:this.$route.query.articleid,   //文章id
                  profile:null,                  //文章简介
                  image_path:null,               //文章图片编码
                  content:null,                  //文章描述
                  label:[],                     //文章标签
                  attachment:[],                   //附件编码
                  source:null,                   //来源
                  http:this.request.axiosPort+this.request.axiosApi+'my/article/edit'
                },
                coding:Number(new Date()),                        //专属编码
                urlBig:[]
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
        methods:{
            /***********************************文档编辑器**********************************/
            onEditorBlur(){//失去焦点事件
            },
            onEditorFocus(){//获得焦点事件
            },
            onEditorChange(){
              console.log(this.MainContentBody)
            },
            titleBody(msg){
              this.parameter.titleContent = msg
              this.dataArticleAtom.title = msg
            },
            MainContent(msg){
              this.parameter.MainContentBody = msg
              this.dataArticleAtom.content = msg
            },
            MainTaglength(msg){
              this.parameter.MainTagCont = msg
            },
            uploadPart(msg){
              this.parameter.uploadPartCont = msg
            },
            MinFilecd(msg){
              console.log(this.parameter.MinFilemsg = msg)
            },
            /************************封面图********************************/
            handleRemove(file, fileList) {
                console.log(file, fileList);
                if(fileList.length<=0){
                    this.dragOver=false;
                }
            },
            handleSuccess(){
                this.$message.success('上传成功!')
            },
            handleError(){
                this.$message.error('上传失败!')
            },
            handleExceed(){
                this.$message.warning(`当前限制选择 1 个文件，本次选择了 ${files.length} 个文件，共选择了 ${files.length + fileList.length} 个文件`)
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
            handlePictureCardPreview(file) {
                this.dialogImageUrl = file.url;
                this.dialogVisible = true;
            },
            beforeAvatarUpload(file) {
                const isJPG = file.type === 'image/jpeg';
                const isPNG = file.type === 'image/png';
                const isLt2M = file.size / 1024 / 1024 < 5;

                console.log(file)


                if (!isJPG && !isPNG) {
                    this.$message.error('上传头像图片只能是 JPG/PNG 格式!');

                }
                else{
                  var FromData = new FormData()
                  //文章上传图片接口
                  FromData.append('token',window.localStorage.token)
                  FromData.append('image_path',file)
                  FromData.append('serial_number',this.parameter.fileimg)
                  this.$ajax.post(this.request.axiosPort+this.request.axiosApi+'article/uploadimage',FromData)
                  .then((res) => {
                    console.log(res)
                    this.dataArticleAtom.image_path = this.parameter.fileimg
                  })
                }
                if (!isLt2M) {
                    this.$message.error('上传头像图片大小不能超过 5MB!');
                }
                return isJPG || isPNG && isLt2M;
            },
            onDragover(){
                this.dragOver=true;
            },
            dragLeave(){
                this.dragOver=false;
            },
            /***类别事件***/
            checkedType(type,index){//大类点击事件
                this.checkedValue=type;
                this.checkedIndex=index;
                this.parameter.MaintypeCont = this.checkedIndex
                this.dataArticleAtom.catagory_id = this.checkedIndex
            },
            changeInput(){
              this.dataArticleAtom.profile = this.parameter.textarea
            }
        },
        mounted(){
            // this.$refs.mainItemTips.fixedEnd('uploading-main-file');
            // this.$refs.protocol.handleTimer();
        },
        created(){
          if(this.$route.query.status == 1){
            this.HttpClient.post('/my/article/info',{
              article_id:this.$route.query.articleid
            })
            .then((res) => {
              console.log(res)
              var dataArticle = res.data.data
              this.dataArticleAtom.title = dataArticle.title
              this.parameter.textarea = dataArticle.profile
              this.dataArticleAtom.profile = this.parameter.textarea
              this.dataArticleAtom.content = dataArticle.content
              this.dataArticleAtom.label = dataArticle.label
              this.checkedIndex = dataArticle.category_id - 1
              this.dataArticleAtom.source = dataArticle.source
              this.dataArticleAtom.category_id = dataArticle.category_id
              this.urlBig = [{'url':this.request.picUrl + dataArticle.image_path}]
              this.dataArticleAtom.attachment = dataArticle.attachment
              console.log(this.dialogImageUrl)
            })
          }else{

          }
        },
        watch:{
          $route(to,from){
            console.log("路由发生跳转")
            this.dialogImageUrl = null
            this.course = false
            this.urlBig = []
          }
        }
    }
</script>

<style src="@/assets/css/uploading.css"></style>
<style src="@/assets/css/uploadService.css"></style>
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
