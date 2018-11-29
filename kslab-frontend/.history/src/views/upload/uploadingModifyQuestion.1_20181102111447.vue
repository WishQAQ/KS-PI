<template>
    <div class="uploading_background">
        编辑问题
        <section id="editor">
            <uploading-head></uploading-head>
            <div class="mod_uploading">
                <div class="mod_uploading_main">
                    <!-- 标题 -->
                    <div class="uploading_main_item uploading_main_title">
                        <div class="main_head">
                            <i class="icon icon_title"></i>
                            <span class="main_txt">问题标题</span>
                        </div>
                        <input type="text" class="main_title_input" placeholder="标题限定25字以内" v-model="articleTitleName" maxlength="25" >
                        <div class="mod_uploading_date">
                        </div>
                    </div>
                    <!-- 富文本编辑器 -->
                    <uploading-main-content @Quescthon="EncyclopediaQuertp" :neirData="contentData" @getNum="getNum"></uploading-main-content>
                    <!-- <uploading-main-tag></uploading-main-tag> -->
                    <!-- 标签 -->
                    <div class="uploading_main_item uploading_main_tag">
                        <div class="main_head">
                            <i class="icon icon_tag"></i>
                            <span class="main_txt">标签</span>
                            <span class="main_txt_describe">(至少1个标签,最多3个，每个2~5个字)</span>
                        </div>
                        <div class="main_tag_add">
                            <div class="main_tag_add_box" :class="{active: dynamicTags.length>0}">
                                <el-input class="input-new-tag" v-model="inputValue" ref="saveTagInput" maxlength="5" size="small"  
                                @keyup.enter.native="handleInputConfirm">
                                </el-input>
                                <div class="main_tag_list">
                                    <i class="el-icon-circle-plus" :class="{active:dynamicTags.length>0}" @click="handleInputConfirm"></i>
                                    <el-tag :key="tag" v-for="tag in dynamicTags" closable  size="small"
                                        style="margin-right:5px;"  :disable-transitions="false"  @close="handleClose(tag)">
                                        {{tag}}
                                    </el-tag>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- <uploading-main-file></uploading-main-file> -->
                    <uploadingEncycMainFile id="uploading_main_file" :attachments="this.dataAtomUirl.attachment" v-on:getFile="getFile" :bkID="bkID"></uploadingEncycMainFile>
                    <uploading-main-type-detail></uploading-main-type-detail>
                    <div class="btn">
                        <el-button>取消</el-button>
                        <el-button type="primary" @click="Submmodify">确认修改</el-button>
                    </div>
                </div>
                <mod-uploading-confirm></mod-uploading-confirm>
                <main-item-tips ref="mainItemTips"></main-item-tips>
            </div>
        </section>
        <aside>
            <floating-div></floating-div>
        </aside>
        <protocol-div ref="protocol"></protocol-div>
    </div>
</template>

<script>

    import FloatingDiv from '@/components/floating'
    import ProtocolDiv from '@/views/upload/protocol'
    import ModUploadingConfirm from '@/views/upload/modUploadingConfirm'
    import MainItemTips from '@/views/upload/mainItemTips'
    // import UploadingMainTitle from '@/views/upload/uploadingMainTitle'
    import UploadingMainContent from '@/views/upload/uploadingMainContent'
    // import UploadingMainFile from '@/views/upload/uploadingMainFile'
    import uploadingEncycMainFile from '@/views/upload/uploadingEncycMainFile'
    // import UploadingMainTag from '@/views/upload/uploadingMainTag'
    import UploadingMainTypeDetail from '@/views/upload/uploadingMainTypeDetail'

    var UploadingHead = {
        template:"<div class='mod_uploading_head'><div class='uploading_head_txt'>提出问题</div></div>",
        data(){
            return {}
        },
    };

    export default {
        name: "uploadingModifyQuestion",
        data(){
            return {
                bkID:null,
                word_num:null,//字数
                question_id:null,//当前修改的问题ID
                articleTitleName:'',           //问题标题数据
                contentData:'',                //富文本编辑器数据
                dynamicTags: [],               //问题标签数据
                inputValue: '',
                localUrl: window.location.pathname,
                pathName: '/home/uploadingService',
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
                  attachment:Number(new Date())+3,
                  http:this.request.axiosPort+this.request.axiosApi+'videos/upload'
                }, //数据打包
            }
        },
        components:{
            UploadingHead,
            FloatingDiv,
            ProtocolDiv,
            ModUploadingConfirm,
            MainItemTips,
            // UploadingMainTitle,
            UploadingMainContent,
            // UploadingMainFile,
            uploadingEncycMainFile,
            // UploadingMainTag,
            UploadingMainTypeDetail
        },
        created(){
        },
        mounted(){
            this.getData();
            // this.$refs.mainItemTips.fixedEnd("main_type_list_describe");
            this.$refs.protocol.handleTimer();
        },
        methods:{
            //得到编辑器组件传过来的字数
            getNum(val){
                this.word_num = val;
                console.log("字数"+val)
            },
            //提交修改
            Submmodify(){
                console.log(this.richFont)
                this.$ajax.post(this.request.axiosPort + this.request.axiosApi + 'my/question/edit',{
                    token:window.localStorage.token,
                    question_id:this.question_id,
                    content:this.richFont,
                    label:this.dynamicTags,
                    word_num:this.word_num,
                    attachment:this.question_id
                })
                .then((res) => {
                   console.log(res)
                   if(res.data.code != 200){ 
                      this.$message.error(res.data.msg)  
                    }else{
                      this.$message.success(res.data.msg)
                      this.$router.go(-1)
                    }
                })
            },
            getData(){               
                // 取到路由带过来的参数 
                let routerQuery = this.$route.query.info
                console.log(routerQuery)
                //数据赋值
                this.articleTitleName = routerQuery.title; 
                this.contentData = routerQuery.content;
                this.dynamicTags = routerQuery.label_name;
                this.question_id = routerQuery.question_id;
                this.bkID = this.question_id;
                console.log(this.contentData)
                    
            },
            //编辑器组件传过来的富文本数据
            EncyclopediaQuertp(msg){
                this.richFont = msg
                console.log(this.richFont)
            },
            handleClose(tag) {
                this.dynamicTags.splice(this.dynamicTags.indexOf(tag), 1);
                console.log(this.dynamicTags);
                if (this.localUrl === this.pathName) {
                    const serviceData = {
                        tags: this.dynamicTags
                    };
                    this.$store.dispatch('getServiceUploadData', serviceData).then(res => {
                        //console.log(this.$store.state.serviceUpload.serviceUploadData)
                    });
                }
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
                if (this.localUrl === this.pathName) {
                    const serviceData = {
                        tags: this.dynamicTags
                    };
                    this.$store.dispatch('getServiceUploadData', serviceData).then(res => {
                        //console.log(this.$store.state.serviceUpload.serviceUploadData)
                    });
                }
            },
            //获取子组件向父组件传的附件
            getFile(file){
                console.log(file);
                this.fileData = file;
            }
        }    
    }
</script>

<style src="@/assets/css/uploading.css"></style>
<style src="@/assets/css/uploadService.css"></style>
<style >
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
<style scoped>
.btn {
    text-align: right;
    margin-right: 400px;
}
</style>
