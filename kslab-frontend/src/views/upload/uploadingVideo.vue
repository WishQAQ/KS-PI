<template>
    <div class="body uploading_background">
        <section>
           <!-- {{dataAtomStatus}}
           {{dataAtomUirl}} -->
            <video id="video" controls :src="this.dataAtomUirl.video_url" v-show="false"></video>
            <uploading-head></uploading-head>
            <div class="mod_uploading mod_uploading_video_box">
                <div class="mod_uploading_main">
                    <div class="mod_uploading_video">
                        <div class="upload_video" v-if="this.$route.query.status == 1?true:false">
                          <img class="upload_img_video" src="/static/img/videoImguploading.png" alt="">
                          <video class="video_url_div" :src="request.picUrl+this.videoUserData"></video>
                        </div>
                        <el-upload
                                v-else
                                class="upload_video"
                                drag
                                :show-file-list="false"
                                action="http://test.kslab.com/api/article/null"
                                :limit="1"
                                :on-progress="uploadVideoProcess"
                                :on-error="uploadVideoError"
                                :on-success="uploadVideoSuccess"
                                :before-upload="beforeUploadVideo">
                            <i class="el-icon-upload" v-if="!videoFlag && !uploadFailed && !uploadSucceed"></i>
                            <div class="el-upload__text" v-if="!videoFlag && !uploadFailed && !uploadSucceed">将视频拖到此处，或<em>点击上传</em></div>
                            <el-progress v-if="videoFlag == true" type="circle" :percentage="videoUploadPercent" style="margin-top:40px;"></el-progress>
                            <div class="upload_video_status">
                                <div class="upload_video_error" v-if="uploadFailed">
                                    <i class="el-icon-error" style="color:red;font-size:67px"></i>
                                    <p class="video_error_txt">上传失败！</p>
                                    <p class="video_error_msg">请重试!</p>
                                </div>
                                <div class="upload_video_success" v-if="uploadSucceed">
                                    <i class="el-icon-success" style="color:green;font-size:67px"></i>
                                    <p class="video_success_msg">上传成功!</p>
                                </div>
                            </div>
                        </el-upload>
                        <el-upload
                                class="encyclopedia_cover_box"
                                action="http://test.kslab.com/api/article/null"
                                list-type="picture-card"
                                drag
                                :limit="1"
                                :multiple="true"
                                :file-list="urlBig"
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
                                <p class="encyclopedia_cover_suggest" v-show="!dragOver">JPG/PNG,5M以内</p>
                                <div class="el-upload__txt" v-show="dragOver && !dragDone">松开图片以上传</div>
                            </div>
                        </el-upload>
                        <el-dialog :visible.sync="dialogVisible">
                            <img width="100%" :src="dialogImageUrl" alt="">
                        </el-dialog>
                    </div>
                    <div class="uploading_video_title">
                        <uploading-main-title :mainTxt="title" :titleVakue="dataAtomStatus.title" @ArticletitleName="ArticletitleName"></uploading-main-title>
                    </div>
                    <uploading-main-Content @ArticleMainContent="ArticleMainContent" :description="dataAtomStatus.description"></uploading-main-Content>
                    <div class="uploading_main_item uploading_main_tag">
                        <div class="main_head">
                            <i class="icon icon_file"></i>
                            <span class="main_txt">关键词</span>
                        </div>
                        <div class="main_tag_add">
                            <div class="main_tag_add_box" :class="{active: dynamicTags.length>0}">
                                <el-input
                                        class="input-new-tag"
                                        v-model="inputValue"
                                        ref="saveTagInput"
                                        size="small"
                                        @keyup.enter.native="handleInputConfirm"
                                >
                                </el-input>
                                <div class="main_tag_list">
                                    <i class="el-icon-circle-plus" :class="{active:dynamicTags.length>0}" @click="handleInputConfirm"></i>
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
                    <div class="uploading_main_item uploading_main_radio">
                        <div class="main_head">
                            <i class="icon icon_radio" style="width:22px;margin-right:11px;"></i>
                            <span class="main_txt">是否为教程</span>
                            <span class="main_txt_describe">(选填)</span>
                        </div>
                        <div class="main_radio_box">
                            <span class="main_radio_txt" :class="{active:course}" @click="radioSelect">教程视频<i class="el-icon-success"></i></span>
                        </div>
                    </div>
                    <uploading-main-part @MainpartAcont="MainpartAcont" :source="dataAtomStatus.source"></uploading-main-part>
                    <uploading-main-file id="uploading_main_file" :attachments="this.dataAtomUirl.attachment" @uploadMinFile="uploadMinFile" :compile="dataAtomStatus.attachment"></uploading-main-file>
                </div>
                <main-item-tips ref="mainItemTips"></main-item-tips>
                <mod-uploading-confirm v-if="this.$route.query.status == 1?false:true" :parameterAcont="dataAtomUirl"></mod-uploading-confirm>
                <mod-uploading-confirm v-else :parameterAcont="dataAtomStatus"></mod-uploading-confirm>
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
    import UploadingMainTitle from '@/views/upload/uploadingMainTitle'
    import UploadingMainContent from '@/views/upload/uploadingMainContent'
    import UploadingMainTag from '@/views/upload/uploadingMainTag'
    import UploadingMainPart from '@/views/upload/uploadingMainPart'
    import ModUploadingConfirm from '@/views/upload/modUploadingConfirm'
    import UploadingMainFile from '@/views/upload/uploadingMainFile'
    import MainItemTips from '@/views/upload/mainItemTips'
    import moment from 'moment'
    var UploadingHead = {
        template:"<div class='mod_uploading_head'><div class='uploading_head_txt'>上传视频</div></div>",
        data(){
            return {}
        },
    };
    export default {
        name: "uploadingVideo",
        data(){
            return {
                videoFlag:false,
                videoUploadPercent:0,
                uploadFailed:false,
                uploadSucceed:false,
                title:"标题",
                partValue:'',
                partList:[],
                partName:'',
                dynamicTags:[],
                inputValue:'',
                dragOver:false,
                dragDone:false,
                dialogVisible:false,
                dialogImageUrl:'',
                typeList:[ //类别列表
                    {type:'汽车',img:'icon-qiche'},
                    {type:'摩托车',img:'icon-motuoche'},
                    {type:'无人机',img:'icon-wurenji--'},
                    {type:'智能设备',img:'icon-zhinengshebei'}
                ],
                checkedValue:'',//大类已选值
                checkedIndex:null,//大类已选值下标
                course:false, //是否为教程
                dataAtomUirl:{
                  token:window.localStorage.token,
                  category_id:null,
                  title:null,
                  description:null,
                  video_url:Number(new Date())+1,
                  cover:Number(new Date())+2,
                  video_length:null,
                  label:null,
                  is_course:null,
                  source:null,
                  attachment:null,
                  http:this.request.axiosPort+this.request.axiosApi+'videos/upload'
                }, //数据打包
                dataAtomStatus:{
                  description:null,     //描述
                  title:null,           //title 数据
                  source:null,          //来源编辑数据包
                  video_id:null,        //来源id
                  datacourse:null,       //判断是否为教学
                  label:null,      //标签
                  catagory_id:null,    //类别id
                  token:window.localStorage.token,
                  attachment:null,
                  cover:'',
                  http:this.request.axiosPort+this.request.axiosApi+'my/video/edit'
                },
                videoUserData:null,    //编辑视频链接
                urlBig:[]
            }
        },
        components:{
            FloatingDiv,
            ProtocolDiv,
            UploadingHead,
            UploadingMainTitle,
            UploadingMainContent,
            UploadingMainTag,
            UploadingMainPart,
            ModUploadingConfirm,
            UploadingMainFile,
            MainItemTips
        },
        methods:{
            /***********************************视频上传***************************/
            beforeUploadVideo(file) {
                // if(this.$refs.protocol.isAgree){
                    // const isLt10M = file.size / 1024 / 1024  < 10;
                    console.log(file)
                    if (['video/mp4', 'video/ogg', 'video/flv','video/avi','video/wmv','video/rmvb'].indexOf(file.type) == -1) {
                        this.$message.error('请上传正确的视频格式');
                        return false;
                    }else{
                      var FormDataVideo = new FormData()
                      console.log(Number(new Date()))
                      FormDataVideo.append('video',file)
                      FormDataVideo.append('serial_number',this.dataAtomUirl.video_url)
                      FormDataVideo.append('token',window.localStorage.token)
                      this.$ajax.post(this.request.axiosPort+this.request.axiosApi+'videos/upload/video',FormDataVideo)
                      .then((res) => {
                        console.log(res)
                        if(res.data.code != 200){
                          this.$message.error(res.data.msg);
                        }else{
                          // this.dataAtomUirl.video_url = res.data.path
                          this.$message({
                            message: res.data.msg,
                            type: 'success'
                          });
                          setTimeout(function(){
                            console.log(document.getElementById('video').duration)
                          },2000)
                        }
                      })
                    }
                // }else{
                //     this.$refs.protocol.readProtocol=true;
                //     return false;
                // }
                // if (!isLt10M) {
                //     this.$message.error('上传视频大小不能超过10MB哦!');
                //     return false;
                // }
            },
            uploadVideoProcess(event, file, fileList){
                this.videoFlag = true;
                this.uploadSucceed = false;
                this.uploadFailed = false;
                this.videoUploadPercent = parseInt(file.percentage.toFixed(0));
            },
            uploadVideoError(err,file,fileLisr){
                console.log(err);
                console.log(file);
                this.$message.error('上传失败！')
                this.uploadFailed=true;
                this.videoFlag=false;
            },
            uploadVideoSuccess(response,file,fileList){
                this.$message.success('上传成功！')
                this.uploadSucceed=true;
                this.videoFlag=false;
            },
            /************************封面上传***********************/
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

                if (!isJPG && !isPNG) {
                    this.$message.error('上传头像图片只能是 JPG/PNG 格式!');
                }else if (!isLt2M) {
                    this.$message.error('上传头像图片大小不能超过 5MB!');
                }
                else{
                  var FormImgPath = new FormData()
                  FormImgPath.append('image_path',file)
                  FormImgPath.append('token',window.localStorage.token)
                  FormImgPath.append('serial_number',this.dataAtomUirl.cover)
                  this.$ajax.post(this.request.axiosPort+this.request.axiosApi+'videos/upload/image',FormImgPath)
                  .then((res) => {
                    // this.dataAtomUirl.cover = res.data.path
                  })
                }
                return isJPG || isPNG && isLt2M;
            },
            onDragover(){
                this.dragOver=true;
            },
            dragLeave(){
                this.dragOver=false;
            },
            /***********************添加零件************************/
            addPart(){
                if(this.partValue){
                    this.partName=this.partValue;
                    this.partList.push(this.partValue);
                }else{
                    this.$message({
                        message: '请输入零件/软件名称',
                        type: 'warning'
                    });
                }
            },
            removePart(index){
                this.partList.splice(index,1);
            },
            /*************************添加关键词**********************/
            handleClose(tag) {
                this.dynamicTags.splice(this.dynamicTags.indexOf(tag), 1);
            },
            handleInputConfirm() {
                let inputValue = this.inputValue;
                if (inputValue) {
                    if(this.dynamicTags.length<3){
                        this.dynamicTags.push(inputValue);
                        this.dataAtomUirl.label = this.dynamicTags
                        this.dataAtomStatus.label = this.dynamicTags
                    }else{
                        this.$message({
                            message: '最多添加三个关键词',
                            type: 'warning'
                        });
                    }
                }else{
                    this.$message({
                        message:'请添加关键词内容',
                        type:'warning'
                    })
                }
                this.inputValue = '';
            },
            /***类别事件***/
            checkedType(type,index){//大类点击事件
                console.log()
                this.checkedValue=type;
                this.checkedIndex=index;
                this.dataAtomUirl.category_id = this.typeList[index].type  //类别ID
                this.dataAtomStatus.category_id = this.typeList[index].type
            },
            /*教程*/
            radioSelect(){
                this.course=!this.course
                if(this.course == true)
                {
                  this.course = 1
                }else{
                  this.course = 0
                }
                this.dataAtomUirl.is_course = this.course  //教学
                this.dataAtomStatus.is_course = this.course
            },
            //标题
            ArticletitleName(msg){
              this.dataAtomUirl.title = msg
              this.dataAtomStatus.title = msg
            },
            //内容
            ArticleMainContent(msg){
              this.dataAtomUirl.description = msg
              this.dataAtomStatus.description = msg
            },
            //来源
            MainpartAcont(msg){
              this.dataAtomUirl.source = msg
              this.dataAtomStatus.source
              console.log(this.dataAtomUirl.source)
            },
            formtData(){
              return moment().formit('YYYYMMDDHHmmssS')
            },
            uploadMinFile(msg){
              this.dataAtomUirl.attachment = msg
            },
            commentFileVideo(){
              if(this.$route.query.status == 1){
                console.log("我进入了此判断")
                  console.log(this.$route.query.videoData);
                  this.HttpClient.post('/my/video/info',{
                  video_id:this.$route.query.videoData
                })
                .then((res) => {
                  var data = res.data.data
                  console.log(data)
                  console.log(data.label_name)
                  this.dataAtomStatus.title = data.title  //标题
                  this.dataAtomStatus.description = data.description
                  for(var i = 0 ; i<data.label.length;i++){
                    this.dynamicTags[i] = data.label[i].name
                  }
                  this.dataAtomStatus.label = this.dynamicTags
                  this.checkedIndex = data.category_id;
                  this.dataAtomStatus.source = data.source
                  this.dataAtomStatus.catagory_id = this.checkedIndex
                  this.videoUserData = data.video_url
                  this.course = data.is_course
                  this.datacourse = this.course
                  this.dataAtomStatus.video_id = this.$route.query.videoData
                  this.urlBig = [{'url':this.request.picUrl + data.cover}]
                  this.dataAtomStatus.attachment = data.attachment
                })
              }else{
                this.batDataComt = ""
              }
            }
        },
        mounted(){
            // this.$refs.mainItemTips.fixedEnd("uploading_main_file");
            // this.$refs.protocol.handleTimer();
        },
        created(){
          this.commentFileVideo()
        },
        watch:{
          $route(to,from){
            this.dataAtomStatus = this.dataAtomUirl
            this.course = false
            this.urlBig = []
          }
        }
    }
</script>

<style src="@/assets/css/uploading.css"></style>
<style src="@/assets/css/uploadService.css"></style>
<style scoped>
    .upload_img_video{
      width: 100% !important;
    }
    .body{
        /*position:relative;*/
        background:#f4f4f4!important;
    }
    .mod_uploading{
        background:#fff;
    }
    .mod_uploading_head{
        background:#f4f4f4;
    }
    .uploading_main_part .el-icon-circle-plus{
        position:relative;
        top:4px;
        left:-45px;
    }
    .mod_uploading_video_box .main_tag_add_box{
        position:relative;
        width:800px;
    }
    .mod_uploading_video_box .main_tag_list{
        display:inline-block;
        position:absolute;
        top:4px;
        right:0;
        height:24px;
        line-height:24px;
    }
    .mod_uploading_video_box .main_tag_list .el-icon-circle-plus{
        color:#d2d2d2;
        font-size:20px;
        padding:0 10px;
        vertical-align:middle;
    }
    .mod_uploading_video_box .main_tag_list .el-icon-circle-plus.active{
        margin-right:10px;
        border-right:1px solid #dcdcdc;
    }
    .mod_uploading .mod_uploading_main .main_type_list{
        margin-bottom:0!important;
    }
    .mod_uploading .mod_uploading_video .upload_video{
      overflow: hidden;
      position: relative;
    }
    .upload_img_video{
      position: absolute;
      top:-47px;
    }
    .video_url_div{
      width: 100%;
      height: 100%;
    }
</style>
