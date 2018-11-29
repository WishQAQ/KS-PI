<template>
  <div class="userIndex appBackground maxwidth">
    <!--个人页面头部-->
    <userInfoHeader-div></userInfoHeader-div>

    <div class="home width_1200">
      <div class="home_box">
        <div class="home_box_title">
            <p><span></span>个人概况</p>
            <span>Personal profiles</span>
        </div>


        <!--电量-->
        <div class="userIndex_box_border">
          <div class="userIndex_box">
            <div class="userIndex_box_name">
              <div class="userIndex_box_name_left">
                <img src="/static/img/icon/electricity.png" alt="">
              </div>
              <div class="userIndex_box_name_right">
                <p>电量</p>
                <span>Electric</span>
              </div>
            </div>
            <div class="userIndex_box_data">
              <div class="userIndex_electric">
                <div class="userIndex_electric_title">
                  <span class="public">当前电量：{{homeData.electric}}mAh</span>
                  <span  class="public">今日增长：{{homeData.electric_increase}}mAh</span>
                </div>
                <div class="userIndex_electric_center">
                  <p :style="{width:widthValue+'%'}"></p>
                </div>
                <div class="userIndex_electric_bottom">
                  <span>0</span>
                  <span>100</span>
                </div>
              </div>

            </div>
          </div>
        </div>
        <br />


        <!--关注-->
        <div class="userIndex_box_border">
          <div class="userIndex_box">
            <div class="userIndex_box_name">
              <div class="userIndex_box_name_left">
                <img src="/static/img/icon/userIndex_attenion.png" alt="">
              </div>
              <div class="userIndex_box_name_right">
                <p>关注</p>
                <span>Attention</span>
              </div>
            </div>
            <div class="userIndex_box_data">
              <div class="userIndex_box_data_box">
                <div class="data_box_text">
                  <p class="public">关注者</p>
                  <span>{{homeData.follow}}</span>
                </div>
                <div class="data_box_nbm">
                  <p><span><img src="/static/img/icon/userIndex_up.png" alt=""></span>{{homeData.focus_increase}}</p>
                </div>
              </div>

              <div class="userIndex_box_data_box">
                <div class="data_box_text">
                  <p class="public">关注了</p>
                  <span>{{homeData.focus}}</span>
                </div>
                <div class="data_box_nbm">
                  <p><span><img src="/static/img/icon/userIndex_down.png" alt=""></span>36</p>
                </div>
              </div>
            </div>
          </div>
        </div>

        <br />
        <!--问答-->
        <div class="userIndex_box_border">
          <div class="userIndex_box">
            <div class="userIndex_box_name">
              <div class="userIndex_box_name_left">
                <img src="/static/img/icon/userIndex_qa.png" alt="">
              </div>
              <div class="userIndex_box_name_right">
                <p>问答</p>
                <span>Q & A</span>
              </div>
            </div>
            <div class="userIndex_box_data">
              <div class="userIndex_box_data_box">
                <div class="data_box_text">
                  <p class="public">回答数</p>
                  <span>{{homeData.answers}}</span>
                </div>
                <div class="data_box_nbm">
                  <p><span><img src="/static/img/icon/userIndex_up.png" alt=""></span>2</p>
                </div>
              </div>

              <div class="userIndex_box_data_box">
                <div class="data_box_text">
                  <p class="public">提问数</p>
                  <span>{{homeData.question}}</span>
                </div>
                <div class="data_box_nbm">
                  <p><span><img src="/static/img/icon/userIndex_up.png" alt=""></span>8</p>
                </div>
              </div>
            </div>
          </div>
        </div>
        <!--文章-->
        <div class="userIndex_box_border">
          <div class="userIndex_box">
            <div class="userIndex_box_name">
              <div class="userIndex_box_name_left">
                <img src="/static/img/icon/userIndex_artice.png" alt="">
              </div>
              <div class="userIndex_box_name_right">
                <p>文章</p>
                <span>Article</span>
              </div>
            </div>
            <div class="userIndex_box_data">
              <div class="userIndex_box_data_box">
                <div class="data_box_text">
                  <p class="public">文章总数</p>
                  <span>{{homeData.article_total}}</span>
                </div>
                <div class="data_box_nbm">
                  <p><span><img src="/static/img/icon/userIndex_up.png" alt=""></span>13</p>
                </div>
              </div>

              <div class="userIndex_box_data_box">
                <div class="data_box_text">
                  <p class="public">浏览</p>
                  <span>{{homeData.article_view}}</span>
                </div>
                <div class="data_box_nbm">
                  <p><span><img src="/static/img/icon/userIndex_up.png" alt=""></span>{{homeData.article_view_increase}}</p>
                </div>
              </div>

              <div class="userIndex_box_data_box">
                <div class="data_box_text">
                  <p class="public">转发</p>
                  <span>{{homeData.article_link}}</span>
                </div>
                <div class="data_box_nbm">
                  <p><span><img src="/static/img/icon/userIndex_up.png" alt=""></span>{{homeData.article_link_increase}}</p>
                </div>
              </div>

              <div class="userIndex_box_data_box">
                <div class="data_box_text">
                  <p class="public">点赞</p>
                  <span>{{homeData.article_like}}</span>
                </div>
                <div class="data_box_nbm">
                  <p><span><img src="/static/img/icon/userIndex_up.png" alt=""></span>{{homeData.article_like_increase}}</p>
                </div>
              </div>

              <div class="userIndex_box_data_box">
                <div class="data_box_text">
                  <p class="public">评论</p>
                  <span>{{homeData.article_comment}}</span>
                </div>
                <div class="data_box_nbm">
                  <p><span><img src="/static/img/icon/userIndex_up.png" alt=""></span>{{homeData.article_comment_increase}}</p>
                </div>
              </div>

            </div>
          </div>
        </div>

        <br />
        <!--视频-->
        <div class="userIndex_box_border">
          <div class="userIndex_box">
            <div class="userIndex_box_name">
              <div class="userIndex_box_name_left">
                <img src="/static/img/icon/userIndex_video.png" alt="">
              </div>
              <div class="userIndex_box_name_right">
                <p>视频</p>
                <span>Video</span>
              </div>
            </div>
            <div class="userIndex_box_data">
              <div class="userIndex_box_data_box">
                <div class="data_box_text">
                  <p class="">视频总数</p>
                  <span>{{homeData.video_total}}</span>
                </div>
                <div class="data_box_nbm">
                  <p><span><img src="/static/img/icon/userIndex_up.png" alt=""></span>13</p>
                </div>
              </div>

              <div class="userIndex_box_data_box">
                <div class="data_box_text">
                  <p class="public">浏览</p>
                  <span>{{homeData.video_view}}</span>
                </div>
                <div class="data_box_nbm">
                  <p><span><img src="/static/img/icon/userIndex_up.png" alt=""></span>{{homeData.video_view_increase}}</p>
                </div>
              </div>

              <div class="userIndex_box_data_box">
                <div class="data_box_text">
                  <p class="public">转发</p>
                  <span>{{homeData.video_link}}</span>
                </div>
                <div class="data_box_nbm">
                  <p><span><img src="/static/img/icon/userIndex_up.png" alt=""></span>{{homeData.video_link_increase}}</p>
                </div>
              </div>

              <div class="userIndex_box_data_box">
                <div class="data_box_text">
                  <p class="public">点赞</p>
                  <span>{{homeData.video_like}}</span>
                </div>
                <div class="data_box_nbm">
                  <p><span><img src="/static/img/icon/userIndex_up.png" alt=""></span>{{homeData.video_like_increase}}</p>
                </div>
              </div>

              <div class="userIndex_box_data_box">
                <div class="data_box_text">
                  <p class="public">评论</p>
                  <span>{{homeData.video_comment}}</span>
                </div>
                <div class="data_box_nbm">
                  <p><span><img src="/static/img/icon/userIndex_up.png" alt=""></span>{{homeData.video_comment_increase}}</p>
                </div>
              </div>

            </div>
          </div>
        </div>

        <br />
        <!--收入-->
        <div class="userIndex_box_border">
          <div class="userIndex_box">
            <div class="userIndex_box_name">
              <div class="userIndex_box_name_left">
                <img src="/static/img/icon/userIndex_revenue.png" alt="">
              </div>
              <div class="userIndex_box_name_right">
                <p>收入</p>
                <span>Revenue</span>
              </div>
            </div>
            <div class="userIndex_box_data">
              <div class="userIndex_box_data_box">
                <div class="data_box_text">
                  <p class="public">总收入</p>
                  <span>&yen;{{homeData.income_total}}</span>
                </div>
                <div class="data_box_nbm">
                  <p><span><img src="/static/img/icon/userIndex_up.png" alt=""></span>{{homeData.income_total_increase}}</p>
                </div>
              </div>

            </div>
          </div>
        </div>

        <!--信用-->
        <div class="userIndex_box_border">
          <div class="userIndex_box">
            <div class="userIndex_box_name">
              <div class="userIndex_box_name_left">
                <img src="/static/img/icon/userIndex_credit.png" alt="">
              </div>
              <div class="userIndex_box_name_right">
                <p>信用</p>
                <span>Credit</span>
              </div>
            </div>
            <div class="userIndex_box_data">
              <div class="userIndex_box_data_box">
                <div class="data_box_text">
                  <p class="public">信用良好</p>
                  <span>
                    <el-rate
                    v-model="value5"
                    disabled
                    :colors="['#99A9BF', '#F7BA2A', '#15bafe']"
                    score-template="{value}">
                  </el-rate>
                  </span>
                </div>
              </div>

            </div>
          </div>
        </div>

      </div>
    </div>

<!-- 
  ****
  猜你喜欢
  ****
 -->


    <div class="like width_1200" id="tab1">
      <div class="home_box_title">
        <p><span></span>猜你喜欢</p>
        <span>Your favorite</span>
      </div>
      <el-tabs v-model="activeName" @tab-click="handleClick" class="like_title">

        <el-tab-pane label="活动" name="activity">
          <div class="like_activity clearfix">

            <div class="like_activity_box" v-for="(item,index) in activityData" :key="index"> 
              <div class="like_activity_img">
                <img :src="item.pics" alt="" @click="actinfoRouter(index)">
                <p><span><img src="/static/img/icon/userIndex_videoTime.png" alt=""></span>{{item.active_date}}</p>
              </div>

              <div class="like_activity_center">
                <div class="like_activity_center_top">
                  <p @click="actinfoRouter(index)">{{item.title}}</p>
                  <div class="like_tags">
                    <span v-for="(names,index) in item.label" :key="index">{{names.name}}</span>
                  </div>
                </div>

              </div>

              <div class="like_activity_bottom">
                <div class="like_activity_star">
                  <el-rate
                    v-model="item.score"
                    disabled
                    :colors="['#99A9BF', '#F7BA2A', '#15bafe']"
                    score-template="{value}">
                  </el-rate>
                  <div class="like_activity_money">
                    <span>&yen;</span>{{item.price}}
                  </div>
                </div>
              </div>

              <div class="like_activity_view">
                <div class="like_activity_view_left">{{item.enrollment}} 人已报名</div>

                <div class="like_activity_view_right"><span><img src="/static/img/icon/watch.png" alt=""></span>{{item.view_num}}</div>
              </div>

            </div>

          </div>


        </el-tab-pane>
        <el-tab-pane label="服务" name="second">

          <div class="like_box">

            <serviceCarData v-for="(item,index) in serviceData" :key="index" :data="item"></serviceCarData>

            
          </div>



        </el-tab-pane>
      </el-tabs>
      <!--瀑布流刷新图标-->
      <!-- <div class="box1">

        
        <div class="load"></div>
      </div> -->


      <Unsubscribe></Unsubscribe>


    </div>

    <!--侧边悬浮框-->
    <floating-div></floating-div>

  </div>
</template>

<script>
  import FloatingDiv from "@/components/floating"
  import userInfoHeaderDiv from "@/components/userInfoHeader"
  import ServiceCarData from "@/components/serviceCarData"
  import Unsubscribe from  "@/components/unsubscribe"

  // javascript
  import '../../assets/js/userInfo.js'

  export default {
    data() {
      return {
        value5: 4.5,
        activeName: 'activity',
        homeData:{},
        widthValue:0,
        activityData:[],
        serviceData:[],
      }
    },
    mounted(){

      this.$ajax.post(this.request.axiosPort+this.request.axiosApi+'web/user/personal',{
          token:window.localStorage.getItem('token'),
      })
      .then((res) => {
          console.log(res.data.data)
          this.homeData = res.data.data
      })
      //进度条长度
      this.widthValue = this.homeData.electric_increase/this.homeData.electric*100;
      // 猜你喜欢(活动)
      this.$ajax.post(this.request.axiosPort+this.request.axiosApi+'web/user/guessYouLike',{
          token:window.localStorage.getItem('token'),
          type:3,
          size:6
      })
      .then((res) => {
          console.log(res)
          this.activityData = res.data.data.data;
          for(var i = 0; i < this.activityData.length;i++){  //图片处理
              this.activityData[i].pics = this.request.picUrl+JSON.parse(this.activityData[i].pics)[0];
              this.activityData[i].active_date = this.handleTime(this.activityData[i].active_date);//处理时间
          }
      })
      // 猜你喜欢(服务)
      this.$ajax.post(this.request.axiosPort+this.request.axiosApi+'web/user/guessYouLike',{
          token:window.localStorage.getItem('token'),
          type:2,
          size:6
      })
      .then((res) => {
          console.log(res)
          this.serviceData = res.data.data.data;
          for(var i = 0; i < this.serviceData.length;i++){  //图片处理
              this.serviceData[i].images = this.request.picUrl+JSON.parse(this.serviceData[i].images)[0].path;
          }
      })
    },
    methods: {
      //跳转活动详情页
      actinfoRouter(index){
        this.$router.push({
          path:'/home/activity-detail',
          query:{
            id:this.activityData[index].active_id,
            status:1
          }
        })
      },
      //处理时间
      handleTime(time){
        console.log(time)
        var date = new Date(time);
        var Time = date.getFullYear()+'-'+(date.getMonth() + 1)+'-'+date.getDate();
        console.log(Time)
        return Time
      },
      handleClick(tab, event) {
        console.log(tab, event);
      }

    },
    components:{
      FloatingDiv,
      userInfoHeaderDiv,
      ServiceCarData,
      Unsubscribe,
    }
  }
</script>

<style src="../../assets/css/userIndex.css"></style>
<style>
  .like_box{
    display: flex;
    justify-content: space-between;
    align-items: center;
    flex-wrap: wrap;
  }
  /* .maxwidth{
    max-width: 1400px;
    min-width: 960px;
  } */
</style>
