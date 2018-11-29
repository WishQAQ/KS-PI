<template>
    <div class="width_1200 index_car">
        <div class="car_titile_header">
            <div>
              <i></i>
                <span>汽&nbsp;&nbsp;车</span>
                <span class="brainpower_title_font">CAR</span>
            </div>
        </div>
        <el-tabs v-model="activeName" @mouseenter.native="handleClick" >
            <!--汽车问题数据-->
            <el-tab-pane name="first">
              <p slot="label" class="car_title_btm">
                <span>问坛</span>
                <router-link to="/home/problemIndex"><i class="icon icon-ziyuan45"></i></router-link>
              </p>
              <div class="car_pro_section_body pro">
                  <ul>
                      <li v-for="(questionsList ,index) in questions" :key="index">

                         <p class="car_pro_font"  @click="RouterIndexAnwser(index)"><i class="icon icon-huaban10"></i>{{questionsList.title}}</p>

                          <key-wrod :keyword="['精品教程','精品教程1']"></key-wrod>
                         <div class="car_pro_Dz">
                            <div class="">
                                <ul class="car_disFlx" @click="RouterIndexAnwser(index)">
                                   <li>
                                     <i class="icon icon-ziyuan39"></i>
                                     <span>{{questionsList.like_num}}</span>
                                   </li>
                                   <li>
                                     <i class="icon icon-ziyuan36"></i>
                                     <span>{{questionsList.comment_num}}</span>
                                   </li>
                                   <li>
                                     <i class="icon icon-ziyuan37"></i>
                                     <span>{{questionsList.view_num}}</span>
                                   </li>
                                </ul>
                            </div>
                            <div class="">
                                <span>{{questionsList.created_at}}</span>
                            </div>
                         </div>

                        <span class="index_questions_line"></span>

                      </li>
                  </ul>
              </div>
            </el-tab-pane>
            <!--汽车百科数据-->
            <el-tab-pane name="second">
              <p slot="label" class="car_title_btm">
                <span>百科</span>
                <router-link to="/home/baikeindex"><i class="icon icon-ziyuan45"></i></router-link>
              </p>
              <div class="car_baike_section_body baike">
                  <ul>
                      <li v-for="(encyclopediasList ,index) in encyclopedias" :key="index" @click="encyclopediasIndexon(index)">
                          <div class="car_odiv_img">
                             <img src="/static/img/indexCarTwo.jpg" alt="">
                          </div>
                          <div class="car_odiv_font">
                              <p><i class="icon icon-huaban10"></i>{{encyclopediasList.title}}</p>
                              <p class="class_height_p" v-html="encyclopediasList.content">
                              </p>
                              <div class="car_look_video">
                                  <span>{{encyclopediasList.view_num}} 次浏览 · {{encyclopediasList.like_num}} 次点赞 · {{encyclopediasList.created_at}}</span>
                              </div>
                            <span class="index_encyclopedia_line"></span>
                          </div>

                      </li>
                  </ul>
              </div>
            </el-tab-pane>
            <!--汽车文章数据-->
            <el-tab-pane name="third">
              <p slot="label" class="car_title_btm">
                <span>文章</span>
                <router-link to="/home/articlePage"><i class="icon icon-ziyuan45"></i></router-link>
              </p>
              <div class="car_Art_section_body Article">
                  <ul>
                    <li v-for="(articlesList ,index) in articles" :key="index">
                      <div class="class_car_img"  @click="articleIndexon(index)">
                        <img src="/static/img/indexCarTree.jpg" alt="">
                      </div>
                      <div class="class_car_font">
                        <p class="class_car_title"  @click="articleIndexon(index)">{{articlesList.title}}</p>
                        <p class="class_car_box"  @click="articleIndexon(index)">{{articlesList.profile}}</p>
                        <key-wrod :keyword="articlesList.label_name"></key-wrod>
                        <p class="class_car_footer">
                          <MerchantModalDiv :name="articlesList.uid"></MerchantModalDiv> · {{articlesList.view_num}} 次浏览 · {{articlesList.created_at}}
                        </p>
                      </div>
                      <span class="index_article_border"></span>
                      <span class="index_article_borderBottom"></span>
                    </li>
                  </ul>
              </div>
            </el-tab-pane>
            <!--汽车视频数据-->
            <el-tab-pane name="fourth">
              <p slot="label" class="car_title_btm">
                <span>逛一逛</span>
                <router-link to="/home/videoIndex"><i class="icon icon-ziyuan45"></i></router-link>
              </p>
              <div class="car_section_body video">
                  <ul>
                     <li @click="VideoIndexClick(index)" v-for="(videoList ,index) in videos" :key="index">
                       <div class="car_section_img">
                         <video :id="'video'+index" v-show="index == videoPlay"  :src="request.picUrl+videoList.video_url" preload @mouseenter="playVideoComt(index)" @mouseleave="stopVideoComt(index)"></video>
                          <img :key="index" v-show="index == videoPlay?false:true"  :src="request.picUrl+videoList.cover" alt="" @mouseenter="playVideo(index)">
                          <p class="car_section_p">
                            <span>{{videoList.title}}</span>
                            <span>59:00</span>
                          </p>
                       </div>
                       <key-wrod :keyword="videoList.label_name"></key-wrod>
                       <!-- <p class="car_Font_color top_font"><MerchantModalDiv :name="videoList.uid"></MerchantModalDiv> · {{articlesList.view_num}} 次浏览 · {{articlesList.created_at}}</p> -->
                       <p class="car_Font_color">{{videoList.view_num}}次浏览 · {{videoList.created_at}}</p>
                     </li>
                  </ul>
              </div>
            </el-tab-pane>
        </el-tabs>
    </div>
</template>

<script>
import KeyWrod from '@/components/keywordInstall'
// 用户信息框
import UserModalDiv from '@/components/userModal'
// 商户信息框
import MerchantModalDiv from '@/components/merchantModal'


export default {
    data(){
      return{
        activeName:"fourth",
        isActive:true,
        contsa:false,
        hasstatus:null,
        articles:null,    //文章列表
        encyclopedias:null,   //百科列表
        videos:null,     //视频列表
        questions:null,  //问题列表
        videoPlay:null  //初始化视频播放
      }
    },
    methods:{
      RouterIndexAnwser(index){
        this.$router.push({
          path:'/home/problemDetails',
          query:{
            id:this.questions[index].question_id
          }
        })
      },
      stopVideoComt(index){
        const vide = document.getElementById('video'+index)
        vide.pause()
        this.videoPlay = 0 - 1
      },
      //视频移入事件
      playVideoComt(index){
        const vide = document.getElementById('video'+index)
        vide.play()
      },
      //封面移入事件
      playVideo(index){
        console.log(index)
        this.videoPlay = index
      },
      handleClick(tab, event,index) {
        //   console.log(event.srcElement)
        tab.index = index
      },
      VideoIndexClick(index){
        this.$router.push({
          path:'/home/videoDetail',
          query:{
            video:this.videos[index].video_id
          }
        })
      },
      articleIndexon(index){
        this.$router.push({
          path:'/home/articleDetails',
          query:{
            name:this.articles[index].article_id
          }
        })
      },
      encyclopediasIndexon(index){
        this.$router.push({
          path:'/home/BaikeDetail',
          query:{
            uid:this.encyclopedias[index].encyclopedia_id
          }
        })
      }
    },
    created(){
        /*this.$ajax.post(this.request.axiosPort+this.request.axiosApi+'index/carlist',{


        })*/
        this.HttpClient.post('/index/carlist')
        .then((res) => {

          this.articles = res.data.articles
          this.encyclopedias = res.data.encyclopedias
          this.videos = res.data.videos
          this.questions = res.data.questions
          // console.log(this.articles)
          //关键字,时间转换方法
          var Vuethis = this
          function FunctionDate(type){
            console.log(type)
            for(var i=0;i<type.length;i++){
              type[i].label_name = Vuethis.filtration(type[i].label_name)
              type[i].created_at = Vuethis.DateTime(Vuethis.finalDate(type[i]))
            }
          }

          //文章
          FunctionDate(this.articles)
          //视频
          FunctionDate(this.videos)
          //百科
          FunctionDate(this.encyclopedias)
          //问题
          FunctionDate(this.questions)
        })
    },
    components:{
      KeyWrod,
      UserModalDiv,
      MerchantModalDiv
    }
}
</script>

<style scoped src="../../assets/css/car.css"></style>
<style lang="css">
.car_pro_section_body{
  cursor: pointer;
}
.car_disFlx{
  cursor: pointer;
}
.kslab  {
  background-color: red;
}
.Body_img_index>.width_1200>.el-tabs{
  margin-top: -35px;
}
.Body_img_index>.width_1200>.el-tabs>.el-tabs__header{
  margin: 0;
}
.Body_img_index>.width_1200>.el-tabs>.el-tabs__header>.el-tabs__nav-wrap>.el-tabs__nav-scroll>.el-tabs__nav{
  float: right;
}
.Body_img_index>.width_1200>.el-tabs>.el-tabs__header>.el-tabs__nav-wrap>.el-tabs__nav-scroll>.el-tabs__nav>#tab-first,#tab-second,#tab-third,#tab-fourth{
  background-size: 20px;
  background-position: right  0px center;
  background-repeat: no-repeat;
}

/*.Body_img_index>.width_1200>.el-tabs>.el-tabs__header>.el-tabs__nav-wrap>.el-tabs__nav-scroll>.el-tabs__nav>.is-active{*/
  /*background: url(/static/img/icon/bansc.png);*/
/*}*/
/* .Body_img_index>.width_1200>.el-tabs>.el-tabs__header>.el-tabs__nav-wrap>.el-tabs__nav-scroll>.el-tabs__nav>:hover{
  background-image: url(/static/img/icon/bansc.png)
} */
.index_car .car_title_btm{
  display: flex;
  justify-content: center;
  align-items: center;
  overflow: hidden;
  position: relative;
  width: 100%;
  height: 100%;
  flex-wrap: wrap;
  flex: 1;
}
/*.index_car .car_title_btm:hover span{*/
  /*transform: translate3d(-40px,0,0);*/
/*}*/
.index_car .car_title_btm span{
  display: block;
  height: 100%;
  margin-right: 5px;
}
.index_car .is-active a{
  transform: translate3d(0,0,0) !important;
  transition: all .4s;
}
.index_car .car_title_btm a{
  transform: translate3d(0,-40px,0);
  transition: all .4s;
  height: 100%;
}
/*变化css960*/

@media screen and (min-width: 960px) and (max-width: 1334px) {
  .car_section_body>ul>li{
    width: 18% !important;
    margin-right: 30px !important;
  }
  .car_section_img{
    height: 130px !important;
  }
  .car_section_body>ul>li>p{
    width: auto !important;
  }
  .car_Art_section_body>ul>li{
    width: 25% !important;
  }
  .car_odiv_font>p:nth-child(2){
    font-size: 12px !important;
  }
  .car_look_video{
    margin-top: 0 !important;
  }
  .car_odiv_font>p:nth-child(1){
    font-size: 18px !important;
  }
  .car_section_img{
    height: 130px !important;
  }
}
@media screen and (max-width:959px) {
  .car_section_img{
    height: 130px !important;
  }
  .car_section_body>ul>li{
    width: 18% !important;
    margin-right: 30px !important;
  }
  .car_section_img{
    height: 130px !important;
  }
  .car_section_body>ul>li>p{
    width: auto !important;
  }
  .car_Art_section_body>ul>li{
    width: 25% !important;
  }
  .car_odiv_font>p:nth-child(2){
    font-size: 12px !important;
  }
  .car_baike_section_body>ul>li{
    width: 39.5% !important;
    height: 140px !important;
  }
  .car_look_video{
    margin-top: 0 !important;
  }
  .car_odiv_font>p:nth-child(1){
    font-size: 18px !important;
  }
}

</style>
