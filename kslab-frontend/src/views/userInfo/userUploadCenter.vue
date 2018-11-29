<template>
    <div class="appBackground">
      <!--个人页面头部123-->
      <userInfoHeader-div></userInfoHeader-div>

      <div class="userUpload width_1200">

        <el-tabs v-model="activeName2" type="card" @tab-click="handleClick">
          <el-tab-pane label="我的视频" name="video">
            <div class="userUpload_box">
              <div class="userUpload_title">
                <div>视频</div>
                <div>点赞量</div>
                <div>状态</div>
                <div>操作</div>
              </div>

              <div class="userUpload_box_list" v-for="(item,index) in videoList" :key="index" >
                <div class="userUpload_img"><img :src="item.cover" alt=""></div>
                <div class="userUpload_text" @click="routerVideoDails(index)">
                  <h4>{{item.title}}</h4>
                  <div class="user_tags">
                    <!-- <span class="appTagsHollow"  ></span> -->
                    <keywordInstallDiv :keyword="item.label_name"></keywordInstallDiv>
                  </div>
                  <p>{{item.created_at}}</p>
                </div>

                <div class="userUpload_box_nmb">{{item.view_num}}次</div>

                <div class="userUpload_status">
                  <div class="userUpload_status_blue" v-if="item.status == 1">
                    <p></p>
                    <span>已通过</span>
                  </div>
                  <div class="userUpload_status_yellow" v-else-if="item.status == 2">
                    <p></p>
                    <span>待审核</span>
                  </div>
                  <div class="userUpload_status_red" v-else-if="item.status == 3">
                    <p></p>
                    <span>未通过</span>
                  </div>
                </div>

                <div class="userUpload_operating">
                  <div class="userUpload_operating_modify" v-if="item.status != 2" @click="jumpVidPage(item.video_id)"><i class="icon icon-bi"></i></div>
                  <div class="userUpload_operating_delete" @click="videoDelet(index)"><i class="icon"></i></div>

                </div>

              </div>

              <div class="userUpload_bottom">
                <el-pagination
                  layout="prev, pager, next"
                  @current-change="handleCurrentChangeVideo"
                  :total="totalVideo">
                </el-pagination>
              </div>
            </div>

          </el-tab-pane>

          <el-tab-pane label="我的百科" name="Encyclopedia">

            <div class="userUpload_box userEncyclopedia" v-if="1 == indexLength">
              <div class="userUpload_title">
                <div>百科</div>
                <div>点赞量</div>
                <div>状态</div>
                <div>操作</div>
              </div>

              <div class="userUpload_box_list" v-for="(encyclopediaList ,index) in encyclopediaDate" :key="index">
                <div class="userUpload_img"><img src="/static/img/car_title.png" alt=""></div>
                <div class="userUpload_text">
                  <h4 @click="onclickEncyclopedia(index)"><span></span>{{encyclopediaList.title}}</h4>
                  <div class="user_tags">
                    <keywordInstallDiv :keyword="encyclopediaList.label_name"></keywordInstallDiv>
                  </div>
                  <p>{{encyclopediaList.created_at}}</p>
                </div>

                <div class="userUpload_box_nmb">{{encyclopediaList.like_num}}次</div>

                <div class="userUpload_status">
                  <div class="userUpload_status_blue" v-if="encyclopediaList.status == 1">
                    <p></p>
                    <span>已通过</span>
                  </div>
                  <div class="userUpload_status_yellow" v-else-if="encyclopediaList.status == 2">
                    <p></p>
                    <span>待审核</span>
                  </div>
                  <div class="userUpload_status_red" v-else-if="encyclopediaList.status == 3">
                    <p></p>
                    <span>未通过</span>
                  </div>
                  <div class="userUpload_status_green" v-else-if="encyclopediaList.status == 4">
                    <p></p>
                    <span>被修改</span>
                  </div>

                </div>

                <div class="userUpload_operating">
                  <div class="userUpload_operating_modify" v-if="encyclopediaList.status == 2" @click="jumpEncPage(index)"><i class="icon icon-bi"></i></div>
                  <div class="userUpload_operating_delete" @click="encyDelet(index)"><i class="icon"></i></div>

                </div>

              </div>

              <div class="userUpload_bottom">
                <el-pagination
                  layout="prev, pager, next"
                  @current-change="handleCurrentChangeEncyc"
                  :total="totalEncyc">
                </el-pagination>
              </div>
            </div>

          </el-tab-pane>

          <el-tab-pane label="我的问题" name="problem">

            <div class="userUpload_box userProblem" v-if="2 == indexLength">
              <div class="userUpload_title">
                <div>问题</div>
                <div>点赞量</div>
                <div>状态</div>
                <div>操作</div>
              </div>
              <div class="userUpload_box_list" v-for="(item,index) in questionList" :key="index">
                <div class="userUpload_text" @click="routerQuestionDalis(index)">
                  <h4><span></span>{{item.title}}</h4>
                  <p class="userUpload_text_txt" v-html="'答：'+item.content"></p>
                  <div class="userUpload_text_bottom">
                    <div class="user_tags">
                      <keywordInstallDiv :keyword="item.label_name"></keywordInstallDiv>
                    </div>
                    <p>{{item.created_at}}</p>
                  </div>

                </div>

                <div class="userUpload_box_nmb">{{item.view_num}}次</div>

                <div class="userUpload_status">
                  <div class="userUpload_status_blue" v-if="item.status == 1">
                    <p></p>
                    <span>已通过</span>
                  </div>
                  <div class="userUpload_status_yellow" v-else-if="item.status == 2">
                    <p></p>
                    <span>待审核</span>
                  </div>
                  <div class="userUpload_status_red" v-else-if="item.status == 3">
                    <p></p>
                    <span>未通过</span>
                  </div>
                </div>

                <div class="userUpload_operating">
                  <div class="userUpload_operating_modify" v-if="item.status !== 2" @click="jumpQusPage(index)"><i class="icon icon-bi"></i></div>
                  <div class="userUpload_operating_delete" @click="qusDelet(index)"><i class="icon"></i></div>

                </div>

              </div>

              <div class="userUpload_bottom">
                <el-pagination
                  layout="prev, pager, next"
                  @current-change="handleCurrentChangeProb"
                  :total="totalProb">
                </el-pagination>
              </div>
            </div>

          </el-tab-pane>

          <el-tab-pane label="我的回答" name="reply">

            <div class="userUpload_box userReply" v-if="3 == indexLength">
              <div class="userUpload_title">
                <div>回答</div>
                <div>点赞量</div>
                <div>状态</div>
                <div>操作</div>
              </div>
              <div class="userUpload_box_list" v-for="(item,index) in answerList" :key="index">
                <div class="userUpload_text">
                  <h4><span></span>{{item.title}}</h4>
                  <p class="userUpload_text_txt" v-html="'答：'+item.answer_content"></p>
                  <div class="userUpload_text_bottom">
                    <!-- <div class="user_tags">
                      <span class="appTagsHollow" >新能源</span>
                    </div> -->
                    <p>{{item.created_at}}</p>
                  </div>

                </div>

                <div class="userUpload_box_nmb">{{item.like_num}}次</div>

                 <div class="userUpload_status">
                  <div class="userUpload_status_blue" v-if="item.status == 1">
                    <p></p>
                    <span>已通过</span>
                  </div>
                  <div class="userUpload_status_yellow" v-else-if="item.status == 2">
                    <p></p>
                    <span>待审核</span>
                  </div>
                  <div class="userUpload_status_red" v-else-if="item.status == 3">
                    <p></p>
                    <span>未通过</span>
                  </div>
                </div>

                <div class="userUpload_operating">
                  <div class="userUpload_operating_modify" v-if="item.status !== 2" @click="jumpAnsPage(index)"><i class="icon icon-bi"></i></div>
                  <div class="userUpload_operating_delete" @click="ansDelet(index)"><i class="icon"></i></div>

                </div>

              </div>

              <div class="userUpload_bottom">
                <el-pagination
                  layout="prev, pager, next"
                  @current-change="handleCurrentChangeReply"
                  :total="totalReply">
                </el-pagination>
              </div>


            </div>

          </el-tab-pane>
          <!-- 我的文章 -->
          <el-tab-pane label="我的文章" name="article">

            <div class="userUpload_box userArticle" v-if="4 == indexLength">
              <div class="userUpload_title">
                <div>文章</div>
                <div>点赞量</div>
                <div>状态</div>
                <div>操作</div>
              </div>

              <div  class="userUpload_box_list" v-for="(item,index) in articleList" :key="index">
                <div class="userUpload_img"><img :src="item.image_path" alt=""></div>
                <div class="userUpload_text" @click="JumpArticle(index)">
                  <h4>{{item.title}}</h4>
                  <keywordInstallDiv :keyword="item.label_name"></keywordInstallDiv>
                  <p>{{item.created_at}}</p>
                </div>

                <div class="userUpload_box_nmb">{{item.like_num}}次</div>

                <div class="userUpload_status">
                  <div class="userUpload_status_blue" v-if="item.status == 1">
                    <p></p>
                    <span>已通过</span>
                  </div>
                  <div class="userUpload_status_yellow" v-else-if="item.status == 2">
                    <p></p>
                    <span>待审核</span>
                  </div>
                  <div class="userUpload_status_red" v-else-if="item.status == 3">
                    <p></p>
                    <span>未通过</span>
                  </div>

                </div>

                <div class="userUpload_operating">
                  <div class="userUpload_operating_modify" v-if="item.status !== 2" @click="jumpArtlePage(item.article_id)"><i class="icon icon-bi"></i></div>
                  <div class="userUpload_operating_delete" @click="artDelet(index)"><i class="icon"></i></div>

                </div>

              </div>

              <div class="userUpload_bottom">
                <el-pagination
                  @current-change="handleCurrentChangeArtic"
                  layout="prev, pager, next"
                  :total="totalArtic">
                </el-pagination>
              </div>
            </div>

          </el-tab-pane>
        </el-tabs>

        <!--删除框-->
        <deleteModal v-if="deleteModal"></deleteModal>
        <!--修改回答框-->
        <replyMode-div ref="replyMode" :answer="answerDataAtom"></replyMode-div>

      </div>



      <!--侧边悬浮框-->
      <floating-div></floating-div>
    </div>
</template>

<script>
  import FloatingDiv from "@/components/floating"
  import userInfoHeaderDiv from "@/components/userInfoHeader"
   import keywordInstallDiv from "@/components/keywordInstall"

  // 删除确认框
  import deleteModal from "../../components/deleteModal"
  // 修改回答框
  import replyModeDiv from '@/components/replyMode'


  export default {
    data(){
      return{
        totalVideo:null,
        totalEncyc:null,
        totalProb:null,
        totalReply:null,
        totalArtic:null,
        size:8,
        page:1,
        currentPage_video:null,
        currentPage_encyc:null,
        currentPage_prob:null,
        currentPage_answer:null,
        currentPage_artic:null,
        questionList:[],
        videoList:[],
        activeName2: 'video',
        deleteModal: null,
        indexLength:null,     //点击加载判断条件
        encyclopediaDate:null,  //我的百科数据容器
        articleDate:null,        //我的文章数据容器
        videoCompile:null   ,      //编辑视频数据包
        objList:[],
        obj_index:null,//存储index,提供给删除弹框。
        articleList:[],
        answerList:[],
        dialogVisible:false,
        // currentPage:0, //当前页面
        answerDataAtom:null,   //我的回答数据
        answerDataStaus:false
      }
    },
    mounted(){
      // this.simplyToRelativeTime();
      console.log(window.localStorage.token)
      //获取视频列表
      const param = {
        page_size:this.size,
        page:this.page
      }
      this.getVideoList(param);
    },
    methods: {
      //获取视频列表
      getVideoList(param){
        this.HttpClient.post('/my/video/list',param).then((res) => {
          console.log(res)
          this.videoList = res.data.data.data;
          this.totalVideo = res.data.data.total;
          for(var i = 0; i < this.videoList.length;i++){
              this.videoList[i].cover = this.request.picUrl+this.videoList[i].cover;
              this.videoList[i].label_name = this.filtration(this.videoList[i].label_name);
              this.videoList[i].created_at = this.simplyToRelativeTime(this.videoList[i].created_at);
          }
        })
      },
      //获取百科列表
      getEncycList(param){
        this.HttpClient.post('/my/encyclopedias/list',param).then((res) => {
          console.log(res)
            this.encyclopediaDate = res.data.data.data;
            this.totalEncyc = res.data.data.total;
            var abbreviationEnc = this.encyclopediaDate
            for(var i = 0; i < abbreviationEnc.length;i++){
              abbreviationEnc[i].label_name = this.filtration(this.encyclopediaDate[i].label_name);
              abbreviationEnc[i].created_at = this.simplyToRelativeTime(this.encyclopediaDate[i].created_at);
              // abbreviationEnc[i].created_at = this.DateTime(this.finalDate(this.encyclopediaDate[i].created_at));
            }
        })
      },
      //获取问题列表
      getProbList(param){
        this.HttpClient.post('/my/question/list',param).then((res) => {
          console.log(res)
              this.questionList = res.data.data.data;
              this.totalProb = res.data.data.total;
              for(var i = 0; i < this.questionList.length;i++){
                  this.questionList[i].cover = this.request.picUrl+this.questionList[i].cover;
                  this.questionList[i].label_name = this.filtration(this.questionList[i].label_name);
                  this.questionList[i].created_at = this.simplyToRelativeTime(this.questionList[i].created_at);
              }
        })
      },
      //获取回答列表
      getAnswerList(param){
        this.HttpClient.post('/my/answer/list',param).then((res) => {
          console.log(res)
            this.answerList = res.data.data.data;
            this.totalReply = res.data.data.total;
            for(var i = 0; i < this.answerList.length;i++){
                this.answerList[i].created_at = this.simplyToRelativeTime(this.answerList[i].created_at);
            }
        })
      },
      //获取文章列表
      getArticList(param){
        this.HttpClient.post('/my/article/list',param).then((res) => {
          console.log(res)
            this.articleList = res.data.data.data;
            this.totalArtic = res.data.data.total;
            for(var i = 0; i < this.articleList.length;i++){
                this.articleList[i].image_path = this.request.picUrl+this.articleList[i].image_path;
                this.articleList[i].label_name = this.filtration(this.articleList[i].label_name);
                this.articleList[i].created_at = this.simplyToRelativeTime(this.articleList[i].created_at);
            }
        })
      },
      //删除我的回答
      ansDelet(index){
        this.$ajax.post(this.request.axiosPort+this.request.axiosApi+"my/answer/delete",{
            token:window.localStorage.token,
            answer_id:this.answerList[index].answer_id
          })
          .then((res) => {
            console.log(res)
            this.answerList.splice(index,1);
          })
      },
      routerQuestionDalis(index){
        this.$router.push({
          path:'/home/problemDetails',
          query:{
            id:this.questionList[index].question_id
          }
        })
      },
      //视频详情页跳转
      routerVideoDails(index){
        this.$router.push({
          path:'/home/videoDetail',
          query:{
            video:this.videoList[index].video_id
          }
        })
      },
      //时间转换为多久之前，
      simplyToRelativeTime(time) {
          // var cuttime = new Date('2018-10-24 14:47:14')
          var cuttime = new Date(time)
          let lasttime = Math.round(cuttime.getTime() / 1000); //将时间转化为秒
          // console.log(lasttime)
          console.log("触发了")
      　　let currentUnixTime = Math.round((new Date()).getTime() / 1000);       // 当前时间的秒数
      　　let deltaSecond = currentUnixTime - parseInt(lasttime, 10);            // 当前时间与要转换的时间差（ s ）
      　　let result;
      　　if (deltaSecond < 60) {
      　　　　result = deltaSecond + '秒前';
      　　} else if (deltaSecond < 3600) {
      　　　　result = Math.floor(deltaSecond / 60) + '分钟之前';
      　　} else if (deltaSecond < 86400) {
      　　　　result = Math.floor(deltaSecond / 3600) + '小时之前';
      　　} else if(deltaSecond < 2592000){
      　　　　result = Math.floor(deltaSecond / 86400) + '天之前';
      　　}else{
             result = Math.floor(deltaSecond /2592000 ) + '个月之前';
      }
          return result;
          console.log('结果：'+result)
      },
      //tab切换
      handleClick(tab, event) {
        this.indexLength = tab.index
        if(tab.index == 0){
          console.log("0")
        }
        else if(tab.index == 1){
          console.log("1")
          const param = {
            page_size:this.size,
            page:this.page
          }
          this.getEncycList(param);
        }
        else if(tab.index == 2){ 
          console.log("2")
          //获取我的问题列表
          let param ={
            page_size:this.size,
            page:this.page
          }
          this.getProbList(param)
        }
        else if(tab.index == 3){
          console.log("3")
          //获取我的回答
          let param ={
            page_size:this.size,
            page:this.page
          }
          this.getAnswerList(param);
        }
        else if(tab.index == 4){
          console.log("4")
          let param ={
            page_size:this.size,
            page:this.page
          }
          this.getArticList(param);
        }
      },
      //点击修改视频跳转页面
      jumpVidPage(id){
        this.$router.push({
          path:'/home/uploadVideo',
          query:{
            id: id,
            status: 1
          }
        })
      },
      //点击删除视频
      videoDelet(index){
        this.$ajax.post(this.request.axiosPort+this.request.axiosApi+"my/video/delete",{
            token:window.localStorage.token,
            video_id:this.videoList[index].video_id
          })
          .then((res) => {
            console.log(res)
            this.videoList.splice(index,1);
          })
      },
      //百科点击修改跳转到新建百科页面进行修改。
      jumpEncPage(index){
        console.log('跳转修改百科页面')
        this.$router.push({
          path:'/home/uploadingModifyEncyclopedia',
          query:{
            info:this.encyclopediaDate[index]
          }
        })
      },
      //点击删除百科
      encyDelet(index){
        console.log(window.localStorage.token)
        this.$ajax.post(this.request.axiosPort+this.request.axiosApi+"my/encyclopedias/delete",{
            token:window.localStorage.token,
            encyclopedia_id:this.encyclopediaDate[index].encyclopedia_id
          })
          .then((res) => {
            console.log(res)
            this.encyclopediaDate.splice(index,1);
          })
      },
      //点击编辑问题
      jumpQusPage(index){
        this.$router.push({
          path:'/home/uploadingModifyQuestion',
          query:{
            info:this.questionList[index]
          }
        })
      },
      //点击删除问题
      qusDelet(index){
        this.$ajax.post(this.request.axiosPort+this.request.axiosApi+"my/question/delete",{
            token:window.localStorage.token,
            question_id:this.questionList[index].question_id
          })
          .then((res) => {
            console.log(res)
            this.questionList.splice(index,1);
          })
      },

      // 编辑回答
      jumpAnsPage(index){

        this.$refs.replyMode.replyMode = true

        if(this.answerDataStaus == false){
          this.answerDataStaus = true
          this.HttpClient.post('/my/answer/info',{
            answer_id:this.answerList[index].answer_id
          })
          .then((res) => {
            console.log("数据进来了")
            this.answerDataAtom = res.data.data
          })
        }else{
          this.answerDataStaus = false
        }

        if(this.replyMode == false){
          this.replyMode = true
        }
      },



      //编辑文章
      jumpArtlePage(id){
        this.$router.push({
          path:'/home/uploadArticle',
          query:{
            id: id, // this.articleList[index].article_id,
            status: 1
          }
        })
      },
      //删除文章
      artDelet(index){
        this.$ajax.post(this.request.axiosPort+this.request.axiosApi+"my/article/delete",{
            token:window.localStorage.token,
            article_id:this.articleList[index].article_id
          })
          .then((res) => {
            console.log(res)
            this.articleList.splice(index,1);
          })
      },
      encyclopediaClick(){
        console.log("1")
      },
      JumpArticle(index){
        var name =this.articleList[index].article_id
        this.$router.push({
          path:'/home/articleDetails',
          query:{
            name:name
          }
        })
      },
      onclickEncyclopedia(index){
        this.$router.push({
          path:'/home/baikeDetail',
          query:{
            uid:this.encyclopediaDate[index].encyclopedia_id
          }
        })
      },
      //视频分页
      handleCurrentChangeVideo(value){
        console.log(value)
        this.currentPage_video = parseInt(value);
        let param = {
          page_size:8,
          page:this.currentPage_video 
        }
        this.getVideoList(param);
      },
      //百科分页
      handleCurrentChangeEncyc(value){
        console.log(value)
        this.currentPage_encyc = parseInt(value);
        let param = {
          page_size:8,
          page:this.currentPage_encyc 
        }
        this.getEncycList(param);
      },
      //问题分页
      handleCurrentChangeProb(value){
        console.log(value)
        this.currentPage_prob = parseInt(value);
        let param = {
          page_size:8,
          page:this.currentPage_prob 
        }
        this.getProbList(param);
      },
       //回答分页
      handleCurrentChangeReply(value){
        console.log(value)
        this.currentPage_answer = parseInt(value);
        let param = {
          page_size:8,
          page:this.currentPage_answer 
        }
        this.getAnswerList(param);
      },
       //文章分页
      handleCurrentChangeArtic(value){
        console.log(value)
        this.currentPage_artic = parseInt(value);
        let param = {
          page_size:8,
          page:this.currentPage_artic 
        }
        this.getArticList(param);
      },
      
    },
    components:{
      FloatingDiv,
      userInfoHeaderDiv,
      deleteModal,          // 删除
      keywordInstallDiv,

      replyModeDiv
    },
    computed:{
      filteringAttribute : function(){
        if(this.articleDate == null){
          //点击加载数据为null,不点击则不做加载
        }else{
          var forDataArticle = this.articleDate
          var cont = this.finalDate(forDataArticle)
          // console.log(this.DateTime(cont))
        }
        return console.log(this.DateTime(cont))
      }
    }
  }
</script>

<style scoped src="../../assets/css/userUploadCenter.css"></style>
<style>
  .userUpload .el-tabs__header{
    margin-bottom: 0 !important;
  }
  .userUpload .el-tabs--card>.el-tabs__header .el-tabs__item.is-active{
    background-color: #fff;
    color: #222 !important;
    font-size: 14px;
  }
  .userUpload .el-tabs--card>.el-tabs__header .el-tabs__item{
    font-size: 14px;
    color: #9f9f9f;
  }
</style>
