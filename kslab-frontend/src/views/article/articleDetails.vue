<template>

  <div class="article_details width_1200">

    <div class="article_details_text">

      <!--头部-->
      <div class="article_details_title">
        <div class="article_details_title_like">
          <Praise-Div :type="article_details_title" :index="0" :letType="1"></Praise-Div>
        </div>

        <div class="article_details_title_center">
          <h3>{{this.articleDataGather.title}}</h3>

          <div class="article_details_tags">
            <div @click="onValueClick(index)" class="keyword" v-for="(item ,index) in this.articleDataGather.label" :key="index">
                {{item.name}}
            </div>
            <!-- <span v-for="(FormSpan ,index) in arrayDetails" :key="index">
              {{FormSpan.name}}
            </span> -->
          </div>

          <div class="article_details_time">
            <div class="article_details_time_left">
              <span>{{handleDate(this.articleDataGather.created_at)}}</span>
              <span v-if="articleDataGather.source == null?false:true">{{this.articleDataGather.source[0].partName}}</span>
              <span v-else>暂无来源</span>
              <span>{{this.articleDataGather.view_num}} 次浏览</span>
              <span @click="shareModalShowTrue"><img src="/static/img/icon/share.png" alt=""></span>
              <span @click="reportModalClick()">
                <img src="/static/img/icon/report.png" alt="" @click="handleOpenReport">
                <ReportDialog @getReportVisible="getReportVisible" :reportVisible="reportVisible" :serviceId="article_id"></ReportDialog>
              </span>
            </div>

          </div>

        </div>


        <div class="article_details_right" @click="RouterOthers">
          <div class="article_details_right_userName">
            <p>{{this.articleDataGather.nickname}}</p>
            <span>{{this.articleDataGather.signature}}</span>
          </div>
          <div class="article_details_right_avatar"><img :src="request.picUrl + articleDataGather.avatar" alt=""></div>
        </div>


      </div>


      <!--文章内容-->
      <div class="article_details_content">
        <p v-html="this.articleDataGather.content"></p>
      </div>

      <div class="article_details_content_end">—— <span> THE END </span> ——</div>


    </div>


    <div class="article_details_comment">

      <div class="comment_avatar">

        <img v-if="userStatus" :src="request.picUrl + articleDataGather.avatar" alt="">
        <img v-else src="/static/img/avatar/avatar.jpg" alt="">
      </div>

      <div class="comment_box">
        <div class="comment_box_editor">
          <quill-editor
            v-model="content"
            ref="myQuillEditor"
            :options="editorOption"
            @blur="onEditorBlur($event)" @focus="onEditorFocus($event)"
            @change="onEditorChange($event)">
          </quill-editor>
        </div>


        <div class="comment_box_btm" >
          <login-warn ref="modelDelet"></login-warn>
          <button @click="commentFontButton">提交</button>
        </div>

      </div>

    </div>


    <div class="repeat_list">
      <div class="repeat_list_header">
        <p>{{this.articleReviews.length}}次评论</p>
        <div></div>
      </div>
      <div class="repeat_box" v-for="(article_Reviewsthis ,index) in articleReviews" :key="index">
        <div class="repeat_box_header">
          <div class="repeat_box_header_left" @click="userOthers(index)">
            <p class="repeat_box_header_avatar"><img :src="request.picUrl + article_Reviewsthis.avatar" alt=""></p>
            <p class="repeat_box_header_user">
              <span>{{article_Reviewsthis.nickname}}</span>
              <span>{{article_Reviewsthis.signature}}</span>
            </p>
          </div>
          <p>{{handleDate(article_Reviewsthis.created_at)}}</p>
        </div>

        <div class="repeat_main">
          <div class="repeat_main_left">
            <Praise-Div :type="repeat_main" :index="index" :letType="2"></Praise-Div>
          </div>

          <div class="repeat_main_right">
            <div class="repeat_main_right_text" v-html='article_Reviewsthis.content'>

            </div>

            <div class="repeat_main_right_bottom">
              <div @click="commentButton(index)">
                <el-button type="text" @click="outerVisible =! outerVisible">
                  <p class="repeat_main_right_bottom_p"><span><img src="/static/img/icon/message1.png" alt=""></span>{{article_Reviewsthis.comment_num}}条评论</p>
                </el-button>
              </div>

              <p @click="shareModalShowTrue"><img src="/static/img/icon/share.png" alt=""></p>
              <p>
                <span>
                  <img src="/static/img/icon/report.png" alt="" @click="RouterIndexId(index)">
                  <ReportDialog @getReportVisible="getReportVisible" :reportVisible="reportVisible" :serviceId="article_Reviewsthis.answer_id"></ReportDialog>
                </span>
              </p>
            </div>
          </div>
        </div>
      </div>
    </div>

    <commentModal ref="commentModal" v-if="outerVisible" :comments="commentLength" :httpclosure="httpClosure"></commentModal>

    <ReportDialog @getReportVisible="getReportVisible" :reportVisible="reportVisible" :serviceId="articleId"></ReportDialog>

    <ShareModalDiv ref="shareModal" :show="shareModalShow"></ShareModalDiv>
    <FloatingDiv></FloatingDiv>
  </div>

</template>

<script>
  import keywordInstall from '@/components/keywordInstall'
  import LoginWarn from '@/components/loginWarningModal'
  import ReportDialog from '@/components/ReportDialog'
  import FormatDate from "../../utils/GetDateUtils";
  import FloatingDiv from '@/components/floating'
  import PraiseDiv from '@/components/praise'
  import ShareModalDiv from '@/components/shareModal'

  import reportModal from '@/components/reportModal'
  import commentModal from '@/components/commentModal'

  export default {
    name: "articleDetails",
    components: {
      FloatingDiv,
      PraiseDiv,
      ShareModalDiv,
      reportModal,
      commentModal,
      ReportDialog,
      LoginWarn,
      keywordInstall
    },
    data(){
      return {
        reportVisible:false,
        reportModal: null,
        shareModalShow: false,
        content:null,
        repeat_main:[],
        editorOption:{
          modules:{
            toolbar:[
              ['bold', 'italic', 'underline', 'strike'],
              ['blockquote', 'code-block']
            ]
          }
        },
        routerName:'',
        articleDataGather:'',
        arrayDetails:'',
        article_details_title:[{
          praise:'',
          id:this.$route.query.name,
          state:0
        }],
        articleReviews:'',   //文章评论
        outerVisible:null,
        innerVisible: false,
        thiscc:1,
        isAutoTrue:false,
        isAuto:true,
        commentLength:'',  //回复评论参数
        commentFont:'',   //富文本编辑内容
        httpClosure:{
          //文章回复列表
          reply:this.request.axiosPort+this.request.axiosApi+'article/reply',
          //文章添加回复接口
          add:this.request.axiosPort+this.request.axiosApi+'article/addreply',
          //文章查看对话
          info:this.request.axiosPort+this.request.axiosApi+'article/replyinfo',
        },
        article_id:null,
        userStatus:null,    //用户头像状态判断
        articleId: '', //文章id
      }
    },
    methods:{
      RouterIndexId(){
        this.reportVisible = true
      },
      RouterOthers(){
        this.RouterLinkOther(this.articleDataGather.uid)
      },
      reportModalClick(){
        this.reportModal = !this.reportModal;
        this.reportVisible = true
      },
      // 打开举报框
      handleOpenReport() {
        this.reportVisible = true;
      },
      /***
       * 回调举报
       * @param value
       */
      getReportVisible(value) {
        this.reportVisible = value;
      },
      handleDate(date) {
        return FormatDate.GetDate(date);
      },
      onEditorBlur(){//失去焦点事件
      },
      onEditorFocus(){//获得焦点事件
      },
      onEditorChange(event){//内容改变事件
        this.commentFont = event.html
      },
      shareModalShowTrue(){
        if(!this.$refs.shareModal.modelDelete){
          this.$refs.shareModal.show();
        }
        // this.shareModalShow = true
      },
      RouterIndexName(){
        //文章user_id
        this.routerName = this.$route.query.name;

        //根据文章user_id进行post接受数据（内容）
        this.HttpClient.post('/article/info',{
          article_id:this.routerName
        })
        .then((res) => {
          console.log(res)
          this.articleDataGather = res.data.data
          this.arrayDetails = this.articleDataGather.label    //laber 标签
          this.article_details_title[0].praise = res.data.data.like_num  //点赞数
       })

        //根据文章user_id进行post接受数据（评论u）
        this.HttpClient.post('/article/comment',{
          article_id:this.routerName
        })
        .then((res) => {
          this.articleReviews = res.data.data     //文章评论
          console.log(this.articleReviews)
          for(var i=0;i<this.articleReviews.length;i++){
              // console.log(this.articleReviews[i])
            this.repeat_main.push({
              "praise":this.articleReviews[i].like_num,
              "state":0,
              "id":this.articleReviews[i].answer_id
            })
            console.log(this.repeat_main)
          }

        })
      },
      trueButtom(){
        this.isAutoTrue =! this.isAutoTrue
        this.isAuto =! this.isAuto
      },
      commentButton(index){
        this.commentLength = this.articleReviews[index].answer_id
        console.log(this.articleReviews[index])
      },
      commentFontButton(){
        this.RouterIndexName()
        this.content = ''
        /*
          判断当前富文本框是否为空
          头像判断
        */
        if(window.localStorage.token){

          if(this.commentFont == null || this.commentFont == ''){
            this.$message({
              message: '内容不能为空哦',
              type: 'warning'
            });
          }else{
            this.HttpClient.post('/article/addcomment',{
              article_id:this.articleId,
              content:this.commentFont
            })
            .then((res) => {
              console.log(res);
              if(res.data.code === 200) {
                this.commentFont = '';
                this.$message.success('提交评论成功');
              }else {
                this.$message.error(res.data.msg);
              }
            })
          }
        }else{
          this.$refs.modelDelet.modelDelet = true
        }
      },
      userOthers(index){
        this.$ajax.post(this.request.axiosPort+this.request.axiosApi+'other/type',{
          uid:this.articleReviews[index].uid
        })
        .then((res) => {
          console.log(res.data.type)
          this.RouterLinkOther(this.articleReviews[index].uid,res.data.type)
        })
      },
      onValueClick(index){
        //附带关键字搜索方法
        this.$router.push({
          path:'/home/searchIndex',
          query:{
            keyword:this.articleDataGather.label[index].name
          }
        });
        console.log(typeof this.keyword)
      }
    },
    created(){
      this.articleId = this.$route.query.name;
      /*
        头像判断
      */
      if(window.localStorage.token){
        this.userStatus = true
      }else{
        this.userStatus = false
      }

      this.RouterIndexName()
      this.article_id = this.$route.query.name
    },
    watch:{
      RouterIndexName:function(){

      }
    }
  }
</script>
<style lang="less">
  .keyword{
    cursor: pointer;
    color:#999999;
    margin-right: 10px;
    font-size: 14px;
    text-decoration:underline;
  }
  .article_details_right{
    cursor: pointer;
  }
  @media screen and (max-width: 1280px) {
    .article_details{
      padding: 0 30px;
    }
  }
</style>
<style scoped src="../../assets/css/articleDetails.css"></style>
