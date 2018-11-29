<template>
    <div class="uploading_background">
        <section id="editor">
            <uploading-head></uploading-head>
            <div class="mod_uploading">
                <div class="mod_uploading_main">
                    <uploading-main-title :mainTxt="title" :titleValue="questionData.title" @ArticletitleName="getTitle"></uploading-main-title>
                    <uploading-main-content :description="questionData.content" @Quescthon="getContent" @getNum="getContentNum"></uploading-main-content>
                    <uploading-main-tag :labeList="questionData.tags" @MainTagLength="getTags"></uploading-main-tag>
                    <uploading-main-file :info="{serial_number:serial_number,source:'question'}" @uploadMinFile="getFile"></uploading-main-file>
                    <uploading-main-type-detail @ActiveTypeValue="getTypeId"></uploading-main-type-detail>
                </div>
                <!--<mod-uploading-confirm></mod-uploading-confirm>-->
                <div class="mod_uploading_confirm">
                    <a href="javascript:;" class="uploading_confirm_cancel" :class="{active:!isActive}" @mouseenter="activeBtn($event)">取消</a>
                    <a href="javascript:;" @click="submit" class="uploading_confirm_release" :class="{active:isActive}" @mouseenter="activeBtn($event)">
                        <i class="icon icon_release"></i>
                        发布
                    </a>
                </div>
                <main-item-tips ref="mainItemTips"></main-item-tips>
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
    import ModUploadingConfirm from '@/views/upload/modUploadingConfirm'
    import MainItemTips from '@/views/upload/mainItemTips'
    import UploadingMainTitle from '@/views/upload/uploadingMainTitle'
    import UploadingMainContent from '@/views/upload/uploadingMainContent'
    import UploadingMainFile from '@/views/upload/uploadingMainFile'
    import UploadingMainTag from '@/views/upload/uploadingMainTag'
    import UploadingMainTypeDetail from '@/views/upload/uploadingMainTypeDetail'

    var UploadingHead = {
        template:"<div class='mod_uploading_head'><div class='uploading_head_txt'>提出问题</div></div>",
        data(){
            return {}
        },
    };

    export default {
        name: "uploadingQuestion",
        data(){
            return {
                title:"题目",
                isActive:true,
                questionData:{
                    category_id:'',//类别id
                    content:'',//内容
                    title:'',//标题
                    tags:[],//标签
                    attachment:'',//批次号
                },//提问参数
                contentNum:0,//内容字数
                serial_number:'',//批次号
            }
        },
        components:{
            UploadingHead,
            FloatingDiv,
            ProtocolDiv,
            ModUploadingConfirm,
            MainItemTips,
            UploadingMainTitle,
            UploadingMainContent,
            UploadingMainFile,
            UploadingMainTag,
            UploadingMainTypeDetail
        },
        methods:{
            //获取标题
            getTitle(title){
                this.questionData.title=title;
            },
            //获取内容
            getContent(content){
                this.questionData.content=content;
            },
            //获取内容字数
            getContentNum(count){
                this.contentNum=count;
            },
            //获取标签
            getTags(tag){
                this.questionData.tags=tag;
            },
            //获取类别id
            getTypeId(type){
                this.questionData.category_id=type.stairtwo
            },
            //获取附件上传数据
            getFile(p){
                if(p===1){
                    this.questionData.attachment=this.serial_number
                }
            },
            //按钮样式变化
            activeBtn(event){
                if(!$(event.currentTarget).is(".active")){
                    this.isActive = !this.isActive;
                }
            },
            //上传
            submit(){
                console.log(this.questionData);
                this.HttpClient.post('/questions/create',this.questionData)
                    .then(res=>{
                        console.log(res);
                        if(res.data.code===200){
                            this.$router.go(-1)
                        }
                    })
            }
        },
        created(){
            this.serial_number=this.Tools.GetNumber();
        },
        mounted(){
            this.$refs.mainItemTips.fixedEnd("main_type_list_describe");
            // this.$refs.protocol.handleTimer();
        }
    }
</script>

<style src="@/assets/css/uploading.css"></style>
<style src="@/assets/css/uploadService.css"></style>
<style scoped>

</style>