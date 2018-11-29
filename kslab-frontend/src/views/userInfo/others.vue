<template>
  <div class="others appBackground" v-if="othersUserDate">

    <div class="others_box width_1200">

      <div class="others_header">
        <!--资料背景图-->
        <div class="others_banner"><img src="/static/img/others_banner.jpg" alt=""></div>
        <!--他人资料信息-->
        <div class="others_header_text">
          <!--头像/信息-->
          <div class="others_info">
            <div class="others_avatar"><img :src="request.picUrl + othersUserDate.avatar" alt=""></div>
            <div class="others_info_text">
              <p>{{othersUserDate.user_nikname}}</p>
              <span>{{othersUserDate.signature}}</span>
              <div class="others_info_btn">
                <button>+关注他</button>
                <button>发私信</button>
              </div>
            </div>
          </div>
          <!--粉丝数-->
          <div class="others_fans">
            <i class="icon icon-ziyuan40"></i>
            <div class="others_fans_nbm">
              <p>TA的粉丝</p>
              <span>{{othersUserDate.fans}}</span>
            </div>
          </div>
        </div>
      </div>


      <!--主体内容框-->
      <div class="others_main">
        <div class="others_tab">
          <el-tabs v-model="activeName" @tab-click="handleClick">

            <el-tab-pane label="视频" name="video">
              <div class="others_main_title">
                <span></span>
                <p>TA的视频</p>
              </div>
              <div class="others_video" v-if="videoDate">

                <div class="others_video_list" @click="RouterIndexVideos(index)" v-for="(videoDateList ,index) in videoDate" :key="index" v-if="videoDate">
                  <!--视频信息-->
                  <div class="others_video_img">
                    <img :src="request.picUrl+videoDateList.cover" alt="">
                    <div class="others_video_name">
                      <p>{{videoDateList.title}}</p>
                      <span>7:34</span>
                    </div>
                  </div>
                  <!--信息-->
                  <div class="others_video_tags">
                    <key-word :keyword="videoDateList.label_name"></key-word>
                  </div>
                  <div class="others_video_time"><p>{{videoDateList.view_num}}次观看</p><span>·</span><p>{{videoDateList.created_at}}</p></div>
                </div>

                <!-- <div class="others_video_list">
                  <div class="others_video_img">
                    <img src="/static/img/jrxc.png" alt="">
                    <div class="others_video_name">
                      <p>老司机教你开车</p>
                      <span>7:34</span>
                    </div>
                  </div>
                  <div class="others_video_tags">
                    <span>新能源</span>
                    <span>汽车</span>
                    <span>跑车</span>
                  </div>
                  <div class="others_video_userName">小颗颗</div>
                  <div class="others_video_time"><p>23万次观看</p><span>·</span><p>3天前</p></div>
                </div> -->

              </div>

              <div class="others_bottom">
                <el-pagination
                  layout="prev, pager, next"
                  @current-change="handleCurrentChange"
                  :total="50">
                </el-pagination>
              </div>

            </el-tab-pane>

            <el-tab-pane label="百科" name="encyclopedia">

              <div class="others_main_title">
                <span></span>
                <p>TA的百科</p>
              </div>

              <div class= "others_encyclopedia">

                <div class="others_encyclopedia_list" v-if="baikeDate" v-for="(baikeDateList ,index) in baikeDate" :key="index" @click="baikeIndexClick(index)">

                  <div class="others_encyclopedia_img"><img src="/static/img/lunt.png" alt=""></div>

                  <div class="others_encyclopedia_text">
                    <h2>{{baikeDateList.title}}</h2>
                    <p>{{baikeDateList.content}}</p>
                    <div class="others_encyclopedia_nbm">
                      <p>{{baikeDateList.view_num}} 次浏览</p>
                      <span>·</span>
                      <p>{{baikeDateList.like_num}} 次点赞</p>
                      <span>·</span>
                      <p>{{baikeDateList.created_at}}</p>
                    </div>
                  </div>
                </div>

              </div>

              <div class="others_bottom">
                <el-pagination
                  layout="prev, pager, next"
                  :total="50">
                </el-pagination>
              </div>

            </el-tab-pane>

            <el-tab-pane label="文章" name="article">

              <div class="others_main_title">
                <span></span>
                <p>TA的文章</p>
              </div>

              <div class="others_article">

                <div @click="articleIndexClick(index)" class="others_article_list" v-if="articleDate" v-for="(articleDateList ,index) in articleDate" :key="index">
                  <div class="others_article_img"><img src="/static/img/newCarImg.png" alt=""></div>

                  <div class="others_article_text">
                    <h2>{{articleDateList.title}}</h2>
                    <div class="others_article_tags">
                      <p><i class="icon icon-ziyuan37"></i>{{articleDateList.view_num}}</p>
                      <p><i class="icon icon-ziyuan39"></i>{{articleDateList.like_num}}</p>
                      <p>{{articleDateList.created_at}}</p>
                    </div>
                  </div>
                </div>

              </div>

              <div class="others_bottom">
                <el-pagination
                  layout="prev, pager, next"
                  :total="50">
                </el-pagination>
              </div>

            </el-tab-pane>

            <el-tab-pane label="问题" name="question">

              <div class="others_main_title">
                <span></span>
                <p>TA的问题</p>
              </div>

              <div class="others_question">

                <div class="others_question_list" v-if="issueDate" v-for="(issueDateList ,index) in issueDate" :key="index">
                  <h2>{{issueDateList.title}}</h2>

                  <div class="others_question_tags">
                    <p class="appTagsHollow">特殊问题</p>
                    <p class="appTagsHollow">精品教程</p>
                    <p class="appTagsHollow">教程</p>
                  </div>

                  <div class="others_question_bottom">
                    <div class="others_question_nbm">
                      <p><i class="icon icon-ziyuan39"></i>{{issueDateList.like_num}}</p>
                      <p><i class="icon icon-pinglun"></i>{{issueDateList.comment_num}}</p>
                      <p><i class="icon icon-ziyuan37"></i>{{issueDateList.view_num}}</p>
                    </div>
                    <div class="others_question_time">{{issueDateList.created_at}}</div>
                  </div>


                </div>

              </div>

              <div class="others_bottom">
                <el-pagination
                  layout="prev, pager, next"
                  :total="50">
                </el-pagination>
              </div>

            </el-tab-pane>

            <el-tab-pane label="回答" name="reply">

              <div class="others_main_title">
                <span></span>
                <p>TA的问答</p>
              </div>

              <div class="others_reply">

                <div class="others_question_list" v-for="(answerDateList ,index) in answerDate" :key="index" @click="answerDateIndexClick(index)">
                  <h2 v-html="answerDateList.content"></h2>

                  <div class="others_reply_text" v-if="answerDateList.ac_name">题目：{{answerDateList.ac_name}}</div>
                  <div class="others_reply_text" v-else-if="answerDateList.ar_name">题目：{{answerDateList.ar_name}}</div>
                  <div class="others_reply_text" v-else-if="answerDateList.e_name">题目：{{answerDateList.e_name}}</div>
                  <div class="others_reply_text" v-else-if="answerDateList.q_name">题目：{{answerDateList.q_name}}</div>

                  <div class="others_question_bottom">
                    <div class="others_question_nbm">
                      <p><i class="icon icon-ziyuan39"></i>{{answerDateList.like_num}}</p>
                      <p><i class="icon icon-pinglun"></i>{{answerDateList.comment_num}}</p>
                      <p><i class="icon icon-ziyuan37"></i>89</p>
                    </div>
                    <div class="others_question_time">5 分钟之前</div>
                  </div>


                </div>

              </div>

              <div class="others_bottom">
                <el-pagination
                  layout="prev, pager, next"
                  :total="50">
                </el-pagination>
              </div>

            </el-tab-pane>

          </el-tabs>

        </div>
      </div>
    </div>

    <floating-Div></floating-Div>
  </div>
</template>

<script>
  import floatingDiv from '@/components/floating'
  import KeyWord from '@/components/keywordInstall'

    export default {
      name: "others",
      components: {
        floatingDiv,
        KeyWord
      },
      data() {
        return {
          total:5,
          activeName: 'video',
          othersUserDate:null,  //他人用户数据
          videoDate:null,        //他人用户视频数据
          baikeDate:null,        //他人用户百科数据
          articleDate:null,      //他人用户文章数据
          issueDate:null,         //他人用户问题数据
          answerDate:null,        //他人用户回答数据
          sumDate:null
        };
      },
      methods: {
        FunctionAjax(param,Nuber){
          this.$ajax.post(this.request.axiosPort+this.request.axiosApi+param,{
            uid:this.$route.query.others,
            type:1,
            page:1
          })
          .then((res) => {
            console.log('空间十分南海开发')
            console.log(res)
            if(Nuber == 3){
              this.issueDate = res.data.data
            }else{
              this.videoDate = res.data.data;
              this.baikeDate = res.data.data;
              this.articleDate = res.data.data;
              this.answerDate = res.data.data;
            }
          })
        },
        RouterLinkUser(to,name,id){
          this.$router.push({
            path:to,
            query:{
              name:id
            }
          })
        },
        handleClick(tab, event) {
          if(tab.index == 1)
          {
            this.FunctionAjax('other/encyclopedias')
          }
          else if(tab.index == 2){
            this.FunctionAjax('other/article')
          }
          else if(tab.index == 3){
            this.FunctionAjax('other/questions',3)
          }
          else if(tab.index == 4){
            this.FunctionAjax('other/answers')
          }
          else if(tab.index == 0){
            this.FunctionAjax('other/videos')
          }
        },
        baikeIndexClick(index){
          this.$router.push({
            path:'/home/BaikeDetail',
            query:{
              uid:this.baikeDate[index].encyclopedia_id
            }
          })
        },
        articleIndexClick(index){
          this.$router.push({
            path:'/home/articleDetails',
            query:{
              name:this.articleDate[index].article_id
            }
          })
        },
        answerDateIndexClick(index){
          console.log(this.answerDate[index].type)
          if(this.answerDate[index].type == 1){
            this.RouterLinkUser('/home/articleDetails',name,this.answerDate[index].source_id)
          }
          else if(this.answerDate[index].type == 2){

          }
          else if(this.answerDate[index].type == 3){

          }
          else if(this.answerDate[index].type == 4){

          }
          else if(this.answerDate[index].type == 5){

          }
        },
        RouterIndexVideos(index){
          console.log(this.videoDate[index].created_id)
          this.$router.push({
            path:'/home/videoDetail',
            query:{
              video:this.videoDate[index].video_id
            }
          })
        },
        //视频分页
        handleCurrentChange(value){
          console.log(value)
        },
      },
      created(){
        //获取视频
        this.$ajax.post(this.request.axiosPort+this.request.axiosApi+'other/videos',{
          uid:this.$route.query.others,
          type:1,
          page:1
        })
        .then((res) => {
          this.videoDate = res.data.data;
          console.log(this.videoDate)
        })

        //头部数据
        this.$ajax.post(this.request.axiosPort+this.request.axiosApi+'other/user/info',{
          uid:this.$route.query.others
        })
        .then((res) => {
          this.othersUserDate = res.data.data
        })

       //视频页数据
       this.$ajax.post(this.request.axiosPort+this.request.axiosApi+'other/videos',{
         uid:this.$route.query.others
       })
       .then((res) => {
         this.videoDate = res.data.data
       })
     },
     watch:{
       '$route' (to, from) {

       },
     }
    }
</script>

<style src="../../assets/css/others.css"></style>
<style media="screen">
  .others_video{
    height: 520px;
    overflow: hidden;
  }
  .others_article{
    height: 520px;
    overflow: hidden;
  }
  .others_reply{
    height: 520px;
    overflow: hidden;
  }
  @media screen and (min-width: 960px) and (max-width: 1200px) {
    .others_article{
      flex:2;
    }
    .others_article_list{
      flex:1;
    }
    .others_article_text{
      border:0;
    }
    .others_article_text{
      width: 250px !important;
    }
    .others_question_list:nth-child(1), .others_question_list:nth-child(3), .others_question_list:nth-child(5), .others_question_list:nth-child(7){
      border:0;
      width: 450px;
      overflow: hidden;
    }
    .others_reply {
      height: 520px;
      overflow: hidden;
      display: flex;
      justify-content: space-between;
      flex-wrap: wrap;
      flex: 2;
   }
   .others_reply .others_question_list{
     width: 450px;
     overflow: hidden;
   }
   .others_video_list{
     margin-bottom: 40px !important;
   }
  }
  @media screen and (max-width:970px) {
    .others_article{
      flex:2;
    }
    .others_article_list{
      flex:1;
    }
    .others_article_text{
      border:0;
    }
    .others_article_text{
      width: 250px !important;
    }
    .others_question_list:nth-child(1), .others_question_list:nth-child(3), .others_question_list:nth-child(5), .others_question_list:nth-child(7){
      border:0;
      width: 450px;
      overflow: hidden;
    }
    .others_reply {
      height: 520px;
      overflow: hidden;
      display: flex;
      justify-content: space-between;
      flex-wrap: wrap;
      flex: 2;
   }
   .others_reply .others_question_list{
     width: 450px;
     overflow: hidden;
   }
   .others_video_list{
     margin-bottom: 40px !important;
   }
  }
</style>
