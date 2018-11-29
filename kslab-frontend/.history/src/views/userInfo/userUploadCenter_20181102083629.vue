<template>
    <div class="appBackground">
      <!--个人页面头部-->
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

              <div class="userUpload_box_list" v-for="(item,index) in videoList" :key="index">
                <div class="userUpload_img"><img :src="item.cover" alt=""></div>
                <div class="userUpload_text">
                  <h4>{{item.title}}</h4>
                  <div class="user_tags">
                    <span class="appTagsHollow" v-for="(labname,index) in item.label_name" :key="index">{{labname}}</span>
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
                  <div class="userUpload_operating_modify" v-if="item.status != 2" @click="jumpVidPage(index)"></div>
                  <div class="userUpload_operating_delete" @click="videoDelet(index)"></div>

                </div>

              </div>

              <!-- <div class="userUpload_box_list">
                <div class="userUpload_img"><img src="/static/img/car.jpg" alt=""></div>
                <div class="userUpload_text">
                  <h4>美国工程师参观中国汽车脸色一下就变了</h4>
                  <div class="user_tags">
                    <span class="appTagsHollow">新能源</span>
                    <span class="appTagsHollow">精品教程</span>
                    <span class="appTagsHollow">汽车</span>
                  </div>
                  <p>2小时之前</p>
                </div>

                <div class="userUpload_box_nmb">623532次</div>

                <div class="userUpload_status">
                  <div class="userUpload_status_red">
                    <p></p>
                    <span>未通过</span>
                  </div>

                </div>

                <div class="userUpload_operating">
                  <div class="userUpload_operating_modify"></div>
                  <div class="userUpload_operating_delete" @click="deleteModal =! deleteModal"></div>

                </div>

              </div>

              <div class="userUpload_box_list">
                <div class="userUpload_img"><img src="/static/img/car.jpg" alt=""></div>
                <div class="userUpload_text">
                  <h4>美国工程师参观中国汽车脸色一下就变了</h4>
                  <div class="user_tags">
                    <span class="appTagsHollow">新能源</span>
                    <span class="appTagsHollow">精品教程</span>
                    <span class="appTagsHollow">汽车</span>
                  </div>
                  <p>2小时之前</p>
                </div>

                <div class="userUpload_box_nmb">623532次</div>

                <div class="userUpload_status">
                  <div class="userUpload_status_yellow">
                    <p></p>
                    <span>待审核</span>
                  </div>

                </div>

                <div class="userUpload_operating">
                  <div class="userUpload_operating_modify"></div>
                  <div class="userUpload_operating_delete" @click="deleteModal =! deleteModal"></div>

                </div>

              </div> -->
              <div class="userUpload_bottom">
                <el-pagination
                  layout="prev, pager, next"
                  :total="50">
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
                    <span class="appTagsHollow" v-for="(labname,index) in encyclopediaList.label_name" :key="index">{{labname}}</span>
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
                  <div class="userUpload_operating_modify" v-if="encyclopediaList.status == 2" @click="jumpEncPage(index)"></div>
                  <div class="userUpload_operating_delete" @click="encyDelet(index)"></div>

                </div>

              </div>

              <div class="userUpload_bottom">
                <el-pagination
                  layout="prev, pager, next"
                  :total="50">
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
                <div class="userUpload_text">
                  <h4><span></span>{{item.title}}</h4>
                  <p class="userUpload_text_txt">{{item.content}}</p>
                  <div class="userUpload_text_bottom">
                    <div class="user_tags">
                      <span class="appTagsHollow" v-for="(labname,index) in item.label_name" :key="index">{{labname}}</span>
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
                  <div class="userUpload_operating_modify" v-if="item.status == 2" @click="jumpQusPage(index)"></div>
                  <div class="userUpload_operating_delete" @click="qusDelet(index)"></div>

                </div>

              </div>

              <!-- <div class="userUpload_box_list">
                <div class="userUpload_text">
                  <h4><span></span>白光干涉仪的应用</h4>
                  <p class="userUpload_text_txt">引擎 有人把引擎称为发动机，其实，发动机是一整套动力输出设备，包括变速齿轮、
                    引擎和传动轴等等可见引擎是只是整个发动机的一个部分，但是却是整个发动机的核心部分，
                    因此把引擎称为发动机也不为过因此把引擎称为发动机也不为过。</p>
                  <div class="userUpload_text_bottom">
                    <div class="user_tags">
                      <span class="appTagsHollow">新能源</span>
                      <span class="appTagsHollow">精品教程</span>
                      <span class="appTagsHollow">汽车</span>
                    </div>
                    <p>2小时之前</p>
                  </div>

                </div>

                <div class="userUpload_box_nmb">623532次</div>

                <div class="userUpload_status">
                  <div class="userUpload_status_red">
                    <p></p>
                    <span>未通过</span>
                  </div>

                </div>

                <div class="userUpload_operating">
                  <div class="userUpload_operating_modify"></div>
                  <div class="userUpload_operating_delete"></div>

                </div>

              </div>

              <div class="userUpload_box_list">
                <div class="userUpload_text">
                  <h4><span></span>白光干涉仪的应用</h4>
                  <p class="userUpload_text_txt">引擎 有人把引擎称为发动机，其实，发动机是一整套动力输出设备，包括变速齿轮、
                    引擎和传动轴等等可见引擎是只是整个发动机的一个部分，但是却是整个发动机的核心部分，
                    因此把引擎称为发动机也不为过因此把引擎称为发动机也不为过。</p>
                  <div class="userUpload_text_bottom">
                    <div class="user_tags">
                      <span class="appTagsHollow">新能源</span>
                      <span class="appTagsHollow">精品教程</span>
                      <span class="appTagsHollow">汽车</span>
                    </div>
                    <p>2小时之前</p>
                  </div>

                </div>

                <div class="userUpload_box_nmb">623532次</div>

                <div class="userUpload_status">
                  <div class="userUpload_status_yellow">
                    <p></p>
                    <span>待审核</span>
                  </div>

                </div>

                <div class="userUpload_operating">
                  <div class="userUpload_operating_modify"></div>
                  <div class="userUpload_operating_delete"></div>

                </div>

              </div> -->

              <div class="userUpload_bottom">
                <el-pagination
                  layout="prev, pager, next"
                  :total="50">
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
              <div class="userUpload_box_list">
                <div class="userUpload_text">
                  <h4><span></span>白光干涉仪的应用</h4>
                  <p class="userUpload_text_txt">引擎 有人把引擎称为发动机，其实，发动机是一整套动力输出设备，包括变速齿轮、
                    引擎和传动轴等等可见引擎是只是整个发动机的一个部分，但是却是整个发动机的核心部分，
                    因此把引擎称为发动机也不为过因此把引擎称为发动机也不为过。</p>
                  <div class="userUpload_text_bottom">
                    <div class="user_tags">
                      <span class="appTagsHollow">新能源</span>
                      <span class="appTagsHollow">精品教程</span>
                      <span class="appTagsHollow">汽车</span>
                    </div>
                    <p>2小时之前</p>
                  </div>

                </div>

                <div class="userUpload_box_nmb">623532次</div>

                <div class="userUpload_status">
                  <div class="userUpload_status_blue">
                    <p></p>
                    <span>已通过</span>
                  </div>

                </div>

                <div class="userUpload_operating">
                  <div class="userUpload_operating_modify"></div>
                  <div class="userUpload_operating_delete" @click="dialogVisible = true"></div>

                </div>

              </div>

              <div class="userUpload_box_list">
                <div class="userUpload_text">
                  <h4><span></span>白光干涉仪的应用</h4>
                  <p class="userUpload_text_txt">引擎 有人把引擎称为发动机，其实，发动机是一整套动力输出设备，包括变速齿轮、
                    引擎和传动轴等等可见引擎是只是整个发动机的一个部分，但是却是整个发动机的核心部分，
                    因此把引擎称为发动机也不为过因此把引擎称为发动机也不为过。</p>
                  <div class="userUpload_text_bottom">
                    <div class="user_tags">
                      <span class="appTagsHollow">新能源</span>
                      <span class="appTagsHollow">精品教程</span>
                      <span class="appTagsHollow">汽车</span>
                    </div>
                    <p>2小时之前</p>
                  </div>

                </div>

                <div class="userUpload_box_nmb">623532次</div>

                <div class="userUpload_status">
                  <div class="userUpload_status_red">
                    <p></p>
                    <span>未通过</span>
                  </div>

                </div>

                <div class="userUpload_operating">
                  <div class="userUpload_operating_modify"></div>
                  <div class="userUpload_operating_delete"></div>

                </div>

              </div>

              <div class="userUpload_box_list">
                <div class="userUpload_text">
                  <h4><span></span>白光干涉仪的应用</h4>
                  <p class="userUpload_text_txt">引擎 有人把引擎称为发动机，其实，发动机是一整套动力输出设备，包括变速齿轮、
                    引擎和传动轴等等可见引擎是只是整个发动机的一个部分，但是却是整个发动机的核心部分，
                    因此把引擎称为发动机也不为过因此把引擎称为发动机也不为过。</p>
                  <div class="userUpload_text_bottom">
                    <div class="user_tags">
                      <span class="appTagsHollow">新能源</span>
                      <span class="appTagsHollow">精品教程</span>
                      <span class="appTagsHollow">汽车</span>
                    </div>
                    <p>2小时之前</p>
                  </div>

                </div>

                <div class="userUpload_box_nmb">623532次</div>

                <div class="userUpload_status">
                  <div class="userUpload_status_yellow">
                    <p></p>
                    <span>待审核</span>
                  </div>

                </div>

                <div class="userUpload_operating">
                  <div class="userUpload_operating_modify"></div>
                  <div class="userUpload_operating_delete"></div>
                </div>
              </div>

              <div class="userUpload_bottom">
                <el-pagination
                  layout="prev, pager, next"
                  :total="50">
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

              <div @click="JumpArticle(index)" class="userUpload_box_list" v-for="(item,index) in articleList" :key="index">
                <div class="userUpload_img"><img :src="item.image_path" alt=""></div>
                <div class="userUpload_text">
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
                  <div class="userUpload_operating_modify" v-if="item.status !== 2" @click="jumpArtlePage(index)"></div>
                  <div class="userUpload_operating_delete" @click="artDelet(index)"></div>

                </div>

              </div>

              <div class="userUpload_bottom">
                <el-pagination
                  @current-change="handleCurrentChange"
                  :current-page="currentPage"
                  layout="prev, pager, next"
                  :total="50">
                </el-pagination>
              </div>
            </div>

          </el-tab-pane>
        </el-tabs>
        <deleteModal v-if="deleteModal"></deleteModal>
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

  export default {
    data(){
      return{
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
        currentPage:0, //当前页面
      }
    },
    mounted(){
      // this.simplyToRelativeTime();
      console.log(window.localStorage.token)
      //获取视频列表
      this.$ajax.post(this.request.axiosPort+this.request.axiosApi+'my/video/list',{
          token:window.localStorage.token,
          page_size:8,
          page:1

      })
      .then((res) => {
          console.log(res)
          this.videoList = res.data.data.data;
          for(var i = 0; i < this.videoList.length;i++){
              this.videoList[i].cover = this.request.picUrl+this.videoList[i].cover;
              this.videoList[i].label_name = this.filtration(this.videoList[i].label_name);
              this.videoList[i].created_at = this.simplyToRelativeTime(this.videoList[i].created_at);
          }
      })
      //获取我的问题列表
      this.$ajax.post(this.request.axiosPort+this.request.axiosApi+'my/question/list',{
          token:window.localStorage.token,
      })
      .then((res) => {
          // console.log(res)
          this.questionList = res.data.data;
          for(var i = 0; i < this.questionList.length;i++){
              this.questionList[i].cover = this.request.picUrl+this.questionList[i].cover;
              this.questionList[i].label_name = this.filtration(this.questionList[i].label_name);
              this.questionList[i].created_at = this.simplyToRelativeTime(this.questionList[i].created_at);
          }
      })
    },
    methods: {
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

      handleClick(tab, event) {
        this.indexLength = tab.index
        if(tab.index == 0){
          console.log("0")
        }
        else if(tab.index == 1){
          console.log("1")
          this.$ajax.post(this.request.axiosPort+this.request.axiosApi+"my/encyclopedias/list",{
            token:window.localStorage.token
          })
          //拿到数据循环方法获取数组类型关键词
          .then((res) => {
            // console.log(res)
            this.encyclopediaDate = res.data.data
            var abbreviationEnc = this.encyclopediaDate
            for(var i = 0; i < abbreviationEnc.length;i++){
              abbreviationEnc[i].label_name = this.filtration(this.encyclopediaDate[i].label_name);
              abbreviationEnc[i].created_at = this.simplyToRelativeTime(this.encyclopediaDate[i].created_at);
              // abbreviationEnc[i].created_at = this.DateTime(this.finalDate(this.encyclopediaDate[i].created_at));
            }
          })
        }
        else if(tab.index == 2){
          console.log("2")
        }
        else if(tab.index == 3){
          console.log("3")
        }
        else if(tab.index == 4){
          console.log("4")
          this.$ajax.post(this.request.axiosPort+this.request.axiosApi+"my/article/list",{
            token:window.localStorage.token,
            page_size:8,
            page:1
          })
          .then((res) => {
              console.log(res)
              this.articleList = res.data.data.data;
              for(var i = 0; i < this.articleList.length;i++){
                  this.articleList[i].image_path = this.request.picUrl+this.articleList[i].image_path;
                  this.articleList[i].label_name = this.filtration(this.articleList[i].label_name);
                  this.articleList[i].created_at = this.simplyToRelativeTime(this.articleList[i].created_at);
              }
          })
        }
      },
      //点击修改视频跳转页面
      jumpVidPage(index){
        var obj = this.videoList[index]
        this.$router.push({
          path:'/home/uploadingVideo',
          query:{
            videoData:this.videoList[index].video_id,
            status:1
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
          path:'/home/uploadingEncyclopedia',
          query:{
            data:this.encyclopediaDate[index]
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
          path:'/home/uploadingEncyclopedia',
          query:{
            data:this.encyclopediaDate[index]
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
      //编辑文章
      jumpArtlePage(index){
        this.$router.push({
          path:'/home/uploadingArticle',
          query:{
            articleid:this.articleList[index].article_id,
            status:1
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
        console.log(this.articleList[index].article_id)
        this.$router.push({
          path:'/home/articleDetails',
          query:{
            name:this.articleDate[index].article_id
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
      handleCurrentChange(){},
    },
    components:{
      FloatingDiv,
      userInfoHeaderDiv,
      deleteModal,          // 删除
      keywordInstallDiv
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
