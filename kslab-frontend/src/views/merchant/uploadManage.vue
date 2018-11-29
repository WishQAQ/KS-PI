<template>
    <div class="upload_manage">
        <commercial-info-header></commercial-info-header>
        <section>
            <div class="upload_manage_tabs">
                <el-tabs v-model="activeName2" type="card" @tab-click="handleClick">
                <el-tab-pane label="我的视频" name="video">
                    <div class="userUpload_box">
                        <div class="userUpload_title">
                            <div>视频</div>
                            <div>浏览次数</div>
                            <div>状态</div>
                            <div>操作</div>
                        </div>

                        <div class="userUpload_box_list" v-for="(video,index) in videoList" :key="index">
                            <div class="userUpload_img">
                                <a href="#">
                                    <img src="/static/img/car.jpg" alt="">
                                    <span class="video_duration">3:22</span>
                                    <span class="teach_tag" v-if="video.is_course">
                                        <i class="icon_tag"></i>
                                    </span>
                                </a>
                            </div>
                            <div class="userUpload_text">
                                <h4><a href="javascript:;" @click="toDetails(video.video_id)">{{video.title}}</a></h4>
                                <div class="user_tags">
                                  <keyWordDiv :keyword="video.label_name?video.label_name.split(','):[]"></keyWordDiv>

                                </div>
                                <p>{{formatDate(video.created_at)}}前</p>
                            </div>

                            <div class="userUpload_box_nmb">{{video.view_num}}次</div>

                            <div class="userUpload_status">
                                <div class="userUpload_status_blue" @click="statusClick('upload',video.status,'',video.video_id)" v-if="video.status===1">
                                    <p></p>
                                    <span>已通过</span>
                                </div>
                                <div class="userUpload_status_yellow" @click="statusClick('upload',video.status,'',video.video_id)" v-else-if="video.status===2">
                                    <p></p>
                                    <span>待审核</span>
                                </div>
                                <div class="userUpload_status_red" @click="statusClick('upload',video.status,'',video.video_id)" v-else-if="video.status===3">
                                    <p></p>
                                    <span>未通过</span>
                                </div>

                            </div>

                            <div class="userUpload_operating">
                              <div class="userUpload_operating_modify" @click="toUpdate(video.video_id)"><i class="icon icon-bi"></i></div>
                              <div class="userUpload_operating_delete" @click="deleteModal(video.video_id)"><i class="icon"></i></div>
                            </div>

                        </div>

                        <div class="userUpload_bottom">
                            <el-pagination
                                    layout="prev, pager, next"
                                    :page-count="pageNum"
                                    @current-change="currentChange">
                            </el-pagination>
                        </div>
                    </div>
                </el-tab-pane>

                <el-tab-pane label="我的百科" name="Encyclopedia">

                    <div class="userUpload_box userEncyclopedia">
                        <div class="userUpload_title">
                            <div>百科</div>
                            <div>点赞量</div>
                            <div>状态</div>
                            <div>操作</div>
                        </div>
                        <div class="userUpload_box_list" v-for="(e,index) in encyclopediaList" :key="index">
                            <div class="userUpload_img"><img :src="request.picUrl+e.cover" alt=""></div>
                            <div class="userUpload_text">
                                <h4><span></span><a herf="javascript:;" @click="toDetails(e.encyclopedia_id)">{{e.title}}</a></h4>
                                <div class="user_tags">
                                  <keyWordDiv :keyword="e.label_name?e.label_name.split(','):[]"></keyWordDiv>
                                </div>
                                <p>{{formatDate(e.created_at)}}之前</p>
                            </div>

                            <div class="userUpload_box_nmb">{{e.like_num}}次</div>

                            <div class="userUpload_status">
                                <div class="userUpload_status_blue" @click="statusClick('upload',e.status,'',e.encyclopedia_id)" v-if="e.status===1">
                                    <p></p>
                                    <span>已通过</span>
                                </div>
                                <div class="userUpload_status_yellow" @click="statusClick('upload',e.status,'',e.encyclopedia_id)" v-else-if="e.status===2">
                                    <p></p>
                                    <span>待审核</span>
                                </div>
                                <div class="userUpload_status_red" @click="statusClick('upload',e.status,'',e.encyclopedia_id)" v-else-if="e.status===3">
                                    <p></p>
                                    <span>未通过</span>
                                </div>
                                <div class="userUpload_status_green" @click="statusClick('upload',e.status,'',e.encyclopedia_id)" v-else-if="e.status===4">
                                    <p></p>
                                    <span>被修改</span>
                                </div>

                            </div>

                            <div class="userUpload_operating">
                              <div class="userUpload_operating_modify" @click="toUpdate(e.encyclopedia_id)"><i class="icon icon-bi"></i></div>
                              <div class="userUpload_operating_delete" @click="deleteModal(e.encyclopedia_id)"><i class="icon"></i></div>
                            </div>

                        </div>

                        <div class="userUpload_bottom">
                            <el-pagination
                                    layout="prev, pager, next"
                                    :page-count="pageNum"
                                    @current-change="currentChange">
                            </el-pagination>
                        </div>
                    </div>

                </el-tab-pane>

                <el-tab-pane label="我的问题" name="problem">

                    <div class="userUpload_box userProblem">
                        <div class="userUpload_title">
                            <div>问题</div>
                            <div>回答数</div>
                            <div>状态</div>
                            <div>操作</div>
                        </div>
                        <div class="userUpload_box_list" v-for="(q,i) in questionList" :key="i">
                            <div class="userUpload_text">
                                <h4><p>{{q.name}}</p><a href="javascript:;" @click="toDetails(q.question_id)">{{q.title}}</a></h4>
                                <p class="userUpload_text_txt" v-html="q.content"></p>
                                <div class="userUpload_text_bottom">
                                    <div class="user_tags">
                                      <keyWordDiv :keyword="q.label_name.split(',')"></keyWordDiv>
                                    </div>
                                    <p>{{formatDate(q.created_at)}}之前</p>
                                </div>

                            </div>

                            <div class="userUpload_box_nmb">{{q.answers_count}}次</div>

                            <div class="userUpload_status">
                                <div class="userUpload_status_blue" @click="statusClick('upload',q.status,'',q.question_id)" v-if="q.status===1">
                                    <p></p>
                                    <span>已通过</span>
                                </div>
                                <div class="userUpload_status_yellow" @click="statusClick('upload',q.status,'',q.question_id)" v-else-if="q.status===2">
                                    <p></p>
                                    <span>待审核</span>
                                </div>
                                <div class="userUpload_status_red" @click="statusClick('upload',q.status,'',q.question_id)" v-else-if="q.status===3">
                                    <p></p>
                                    <span>未通过</span>
                                </div>

                            </div>

                            <div class="userUpload_operating">
                              <div class="userUpload_operating_modify" @click="toUpdate(q.question_id)"><i class="icon icon-bi"></i></div>
                              <div class="userUpload_operating_delete" @click="deleteModal(q.question_id)"><i class="icon"></i></div>
                            </div>

                        </div>

                        <div class="userUpload_bottom">
                            <el-pagination
                                    layout="prev, pager, next"
                                    :page-count="pageNum">
                            </el-pagination>
                        </div>
                    </div>

                </el-tab-pane>

                <el-tab-pane label="我的回答" name="reply">

                    <div class="userUpload_box userReply">
                        <div class="userUpload_title">
                            <div>回答</div>
                            <div>点赞量</div>
                            <div>状态</div>
                            <div>操作</div>
                        </div>
                        <div class="userUpload_box_list" v-for="(a,i) in answerList" :key="i">
                            <div class="userUpload_text">
                                <h4><p>排放</p><a href="javascript:;" @click="toDetails(a.source_id)">{{a.title}}</a></h4>
                                <p class="userUpload_text_txt">{{a.answer_content}}</p>
                                <div class="userUpload_text_bottom">
                                    <div class="user_tags">
                                      <keyWordDiv :keyword="['汽车','摩托车','无人机']"></keyWordDiv>
                                    </div>
                                    <p>{{formatDate(a.created_at)}}之前</p>
                                </div>

                            </div>

                            <div class="userUpload_box_nmb">{{a.like_num}}次</div>

                            <div class="userUpload_status">
                                <div class="userUpload_status_blue" @click="statusClick('upload',a.status,'',a.answer_id)" v-if="a.status===1">
                                    <p></p>
                                    <span>已通过</span>
                                </div>
                                <div class="userUpload_status_yellow" @click="statusClick('upload',a.status,'',a.answer_id)" v-else-if="a.status===2">
                                    <p></p>
                                    <span>待审核</span>
                                </div>
                                <div class="userUpload_status_red" @click="statusClick('upload',a.status,'',a.answer_id)" v-else-if="a.status===3">
                                    <p></p>
                                    <span>未通过</span>
                                </div>

                            </div>

                            <div class="userUpload_operating">
                              <div class="userUpload_operating_modify" @click="toUpdateAnswer(a.answer_id,a.answer_content)"><i class="icon icon-bi"></i></div>
                              <div class="userUpload_operating_delete" @click="deleteModal(a.answer_id)"><i class="icon"></i></div>
                            </div>

                        </div>

                        <div class="userUpload_bottom">
                            <el-pagination
                                    layout="prev, pager, next"
                                    :page-count="pageNum"
                                    @current-change="currentChange">
                            </el-pagination>
                        </div>

                        <!--修改回答弹框-->
                        <Reply-model :answer="answerReply" ref="replyModel"></Reply-model>

                    </div>

                </el-tab-pane>

                <el-tab-pane label="我的文章" name="article">

                    <div class="userUpload_box userArticle">
                        <div class="userUpload_title">
                            <div>文章</div>
                            <div>浏览次数</div>
                            <div>状态</div>
                            <div>操作</div>
                        </div>

                        <div class="userUpload_box_list" v-for="(a,index) in articleList" :key="index">
                            <div class="userUpload_img"><img :src="request.picUrl+a.image_path" alt=""></div>
                            <div class="userUpload_text">
                                <h4><a href="javascript:;" @click="toDetails(a.article_id)">{{a.title}}</a></h4>
                                <div class="userUpload_article_text">
                                    {{a.profile}}
                                </div>
                                <div class="user_tags">
                                  <keyWordDiv :keyword="a.label_name.split(',')"></keyWordDiv>
                                </div>
                                <p>{{formatDate(a.created_at)}}之前</p>
                            </div>

                            <div class="userUpload_box_nmb">{{a.view_num}}次</div>

                            <div class="userUpload_status">
                                <div class="userUpload_status_blue" @click="statusClick('upload',a.status,'',a.article_id)" v-if="a.status===1">
                                    <p></p>
                                    <span>已通过</span>
                                </div>
                                <div class="userUpload_status_yellow" @click="statusClick('upload',a.status,'',a.article_id)" v-else-if="a.status===2">
                                    <p></p>
                                    <span>待审核</span>
                                </div>
                                <div class="userUpload_status_red" @click="statusClick('upload',a.status,'',a.article_id)" v-else-if="a.status===3">
                                    <p></p>
                                    <span>未通过</span>
                                </div>

                            </div>

                            <div class="userUpload_operating">
                              <div class="userUpload_operating_modify" @click="toUpdate(a.article_id)"><i class="icon icon-bi"></i></div>
                              <div class="userUpload_operating_delete" @click="deleteModal(a.article_id)"><i class="icon"></i></div>
                            </div>

                        </div>

                        <div class="userUpload_bottom">
                            <el-pagination
                                    layout="prev, pager, next"
                                    :page-count="pageNum">
                            </el-pagination>
                        </div>
                    </div>

                </el-tab-pane>
            </el-tabs>
            </div>
            <info-prompt ref="prompt"></info-prompt>
            <delete-modal ref="delete" @confirm="confirmDelete"></delete-modal>
        </section>
        <aside>
            <floating-div></floating-div>
        </aside>
    </div>
</template>

<script>

    import FloatingDiv from '@/components/floating'
    import DeleteModal from '@/components/deleteModal'
    import CommercialInfoHeader from '@/components/commercialInfoHeader'
    import InfoPrompt from '@/views/merchant/infoPrompt'

    import keyWordDiv from '@/components/keywordInstall'
    import FormatDate from '@/utils/GetDateUtils'

    import ReplyModel from '@/components/replyMode'

    export default {
        name: "uplaodManage",
        data(){
            return {
                isActive:true,
                activeName2:'video',
                isTeach:true,
                videoList:[],//视频列表
                encyclopediaList:[],//百科列表
                questionList:[],//问题列表
                answerList:[],//回答列表
                articleList:[],//文章列表
                deleteId:'',//删除对象id
                pageSize:8,//每页显示条数
                currentPage:1,//当前页
                pageNum:0,//总页数
                answerReply:{answer_id:'',content:''},//修改回答参数
            }
        },
        components:{
            FloatingDiv,
            DeleteModal,
            CommercialInfoHeader,
            InfoPrompt,
            keyWordDiv,
            ReplyModel
        },
        methods:{
            handleClick(tab, event) {

            },

            //跳转详情页
            toDetails(id){
                console.log(1);
                let name=this.activeName2;
                if(name==='video'){
                    this.$router.push({
                        path:'/home/videoDetail',
                        query:{
                            video:id
                        }
                    })
                }else if(name==='Encyclopedia'){
                    this.$router.push({
                        path:'/home/BaikeDetail',
                        query:{
                            uid:id
                        }
                    })
                }else if(name==='article'){
                    this.$router.push({
                        path:'/home/articleDetails',
                        query:{
                            name:id
                        }
                    })
                }else{
                    this.$router.push({
                        path:'/home/problemDetails',
                        query: {
                            id: id
                        }
                    })
                }
            },

            //状态点击弹框
            statusClick(type,status,reason,id){
                if(status==='被修改'){
                    this.$router.push({
                        path:'/home/baikeDetail',
                        encyclopedia_id:id
                    })
                }else{
                    this.$refs.prompt.showModal=true;
                    this.$refs.prompt.getTips(type,status,reason)
                }
            },

            //修改
            toUpdate(id){
                let activeName=this.activeName2,
                    path='',
                    query={};
                if(activeName==='video'){
                    path='/home/uploadingVideo';
                    query={videoData:id,status:1,};
                }else if(activeName==='Encyclopedia'){
                    path='/home/uploadingModifyEncyclopedia';
                    query={info:{encyclopedia_id:id}};
                    this.encyclopediaList.forEach(item=>{
                        if(item.encyclopedia_id===id){
                            query.info.cover=item.cover;
                            query.info.label_name=item.label_name.split(',');
                            query.info.title=item.title;
                        }
                    });
                }else if(activeName==='problem'){
                    path='/home/uploadingModifyQuestion';
                    let info={};
                    this.questionList.forEach(item=>{
                        if(item.question_id===id){
                            info=item
                        }
                    });
                    query={info:info}
                }else if(activeName==='article'){
                    path='/home/uploadingArticle';
                    query={articleid:id,status:1}
                }
                this.$router.push({
                    path:path,
                    query:query
                })
            },

            //修改回答
            toUpdateAnswer(id,content){
                console.log(this.$refs.replyModel);
                this.$refs.replyModel.replyMode=true
                console.log(this.$refs.replyModel.replyMode);
                this.answerReply.answer_id=id;
                this.answerReply.content=content;
            },

            /*删除操作*/
            deleteModal(id){
                this.$refs.delete.modelDelete=true;
                this.deleteId=id
            },
            confirmDelete(isSingle){
                if(isSingle){
                    let activeName=this.activeName2,
                        http='',
                        id={};
                    if(activeName==='video'){
                        http='/my/video/delete';
                        id={video_id:this.deleteId}
                    }else if(activeName==='Encyclopedia'){
                        http='/my/encyclopedias/delete';
                        id={encyclopedia_id:this.deleteId}
                    }else if(activeName==='problem'){
                        http='/my/question/delete';
                        id={question_id:this.deleteId}
                    }else if(activeName==='reply'){
                        http='/my/answer/delete';
                        id={answer_id:this.deleteId}
                    }else{
                        http='/my/article/delete';
                        id={article_id:this.deleteId}
                    }
                    this.HttpClient.post(http,id)
                        .then(res=>{
                            console.log(res);
                            if(res.data.code===200){
                                this.$message.success(res.data.msg);
                                setTimeout(()=>{
                                    console.log('已延迟1000s');
                                    this.getList()
                                },1000)
                            }else{
                                this.$message.error('删除失败!')
                            }
                        })
                }else{
                        // 删除请求
                        // axios({
                        //     url: '/xxxxxxx/delete/' + selectedItem.id,
                        //     method: 'get',
                        //     dataType: 'json'
                        // })
                }
            },

            //分页当前页改变
            currentChange(p){
                this.currentPage=p;
                this.getList()
            },

            //获取列表数据
            getList(){
                let activeName=this.activeName2,
                    http='';
                if(activeName==='video'){
                    http='/my/video/list'
                }else if(activeName==='Encyclopedia'){
                    http='/my/encyclopedias/list'
                }else if(activeName==='problem'){
                    http='/my/question/list'
                }else if(activeName==='reply'){
                    http='/my/answer/list'
                }else{
                    http='/my/article/list'
                }
                this.HttpClient.post(http,{page_size:this.pageSize,page:this.currentPage})
                    .then(res=>{
                        console.log(res);
                        let {code,data} = res.data;
                        if(code===200){
                            if(activeName==='video'){
                                this.videoList=data.data;
                            }else if(activeName==='Encyclopedia'){
                                this.encyclopediaList=data.data;
                            }else if(activeName==='problem'){
                                this.questionList=data.data;
                            }else if(activeName==='reply'){
                                this.answerList=data.data;
                            }else{
                                this.articleList=data.data;
                            }
                            this.pageNum=Math.ceil(data.total/this.pageSize)
                        }
                    })
            },

            //获取时间方法
            formatDate(date){
                return FormatDate.GetDate(date)
            }
        },
        created(){
            this.getList()
        },
        watch:{
            activeName2(){
                this.currentPage=1;
                this.getList()
            }
        }
    }
</script>

<style scoped src="../../assets/css/userUploadCenter.css"></style>
<style>
  .upload_manage .keyword_up li{
    margin-top: 0 !important;
  }
    .upload_manage{
        background:#f2f2f2;
    }
    .upload_manage_tabs{
        max-width:1200px;
        min-width: 960px;
        margin:0 auto;
    }
    .upload_manage_tabs .el-tabs__nav-wrap{
        background:#f2f2f2;
    }
    .upload_manage_tabs .el-tabs--card>.el-tabs__header .el-tabs__item.is-active{
        background:#fff;
    }
    .upload_manage_tabs .el-tabs--card>.el-tabs__header{
        margin-bottom:0;
        box-shadow:-1px 0 0 0 rgba(173, 151, 117, 0.16);
    }
    .upload_manage_tabs .el-tabs--card>.el-tabs__header .el-tabs__nav{

    }
    .upload_manage_tabs .el-tabs__content{
        box-shadow: 0 2px 5px 0 rgba(34, 24, 21, 0.16);
    }
    .upload_manage_tabs .el-tabs__header{
        margin-bottom: 0 !important;
    }
    .upload_manage_tabs .el-tabs--card>.el-tabs__header .el-tabs__item.is-active{
        background-color: #fff;
        color: #222 !important;
        font-size: 14px;
    }
    .upload_manage_tabs .el-tabs--card>.el-tabs__header .el-tabs__item{
        font-size: 14px;
        color: #9f9f9f;
    }
</style>
