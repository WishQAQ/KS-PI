<template lang="html">
  <div class="searchIndex">
    <el-tabs v-model="activeName" @tab-click="handleClick">
      <el-tab-pane label="视频" name="video" >
        <span slot="label"><i class="icon icon-huaban7"></i> 视频</span>
        <div class="searchIndex_video_list" v-loading="loading" >

          <div v-if="searchKeyword" class="searchIndex_video_box" v-for="(item ,index) in searchKeyword" :key="index">
            <div class="searchIndex_video_img" @click="RouterIndexVideo(index)">
              <span v-if="item.is_course"><img src="/static/img/icon/logo_3.png" alt=""></span>
              <img :src="request.picUrl + item.cover" alt="">
              <p>7:13</p>
            </div>

            <div class="searchIndex_video_text">
              <h2 @click="RouterIndexVideo(index)">{{item.title}}</h2>
              <p v-html="item.description" @click="RouterIndexVideo(index)"></p>
              <div class="searchIndex_video_status">
                <keywordInstall :keyword="item.label"></keywordInstall>
                <div class="searchIndex_userName">
                  <p><i class="icon icon-ziyuan31"></i>{{item.nickname}}</p>
                  <span>·</span>
                  <p>{{item.view_num}}次观看</p>
                  <span>·</span>
                  <p>{{handleDate(item.created_at)}}</p>
                </div>
              </div>

            </div>
          </div>
          <div class="no_Found">
            <div class="">
              <img src="/static/img/u4815.png" alt="">
            </div>
            <div class="">
              <p>抱歉！没有找到更多符合条件的相关信息</p>
              <p>您可以尝试更换关键词</p>
            </div>
          </div>
        </div>
      </el-tab-pane>
      <el-tab-pane label="文章" name="article">
        <span slot="label"><i class="icon icon-huaban8"></i> 文章</span>
        <div class="searchIndex_article_list" v-loading="loading">

          <div v-if="searchKeyword" class="searchIndex_article_box" v-for="(item ,index) in searchKeyword" :key="index">
            <div class="searchIndex_article_img" @click="RouterIndexActivt(index)">
              <img src="/static/img/baike_car.png" alt="">
            </div>
            <div class="searchIndex_article_text">
              <div class="searchIndex_article_top">
                <h2 @click="RouterIndexActivt(index)">{{item.title}}</h2>
                <div class="searchIndex_userName">
                  <p>{{item.nickname}}</p>
                  <span>·</span>
                  <p>{{item.view_num}} 次观看</p>
                  <span>·</span>
                  <p>2小时前</p>
                </div>
              </div>

              <div class="searchIndex_article_bottom">
                <p v-html="item.content"></p>
                <keywordInstall :keyword="item.label"></keywordInstall>
              </div>

            </div>
          </div>
          <div class="no_Found">
            <div class="">
              <img src="/static/img/u4815.png" alt="">
            </div>
            <div class="">
              <p>抱歉！没有找到更多符合条件的相关信息</p>
              <p>您可以尝试更换关键词</p>
            </div>
          </div>
        </div>
      </el-tab-pane>
      <el-tab-pane label="百科" name="encyclopedia">
        <span slot="label"><i class="icon icon-huaban9"></i> 百科</span>
        <div class="searchIndex_encyclopedia_list" v-loading="loading">

          <div v-if="searchKeyword" class="searchIndex_article_box" v-for="(item ,index) in searchKeyword" :key="index">
            <div class="searchIndex_article_img" @click="RouterBaike(index)">
              <img src="/static/img/baike_car.png" alt="">
            </div>
            <div class="searchIndex_article_text">
              <div class="searchIndex_article_top" @click="RouterBaike(index)">
                <h2><span></span>{{item.title}}</h2>
                <div class="searchIndex_userName">
                  <p>{{item.nickname}}</p>
                  <span>·</span>
                  <p>{{item.view_num}} 次观看</p>
                  <span>·</span>
                  <p>2小时前</p>
                </div>
              </div>

              <div class="searchIndex_article_bottom">
                <p v-html="item.content" @click="RouterBaike(index)"></p>
                <keywordInstall :keyword="item.label"></keywordInstall>
              </div>

            </div>
          </div>
          <div class="no_Found">
            <div class="">
              <img src="/static/img/u4815.png" alt="">
            </div>
            <div class="">
              <p>抱歉！没有找到更多符合条件的相关信息</p>
              <p>您可以尝试更换关键词</p>
            </div>
          </div>
        </div>
      </el-tab-pane>
      <el-tab-pane label="问题" name="problem">
        <span slot="label"><i class="icon icon-wenti"></i> 问题</span>
        <div class="searchIndex_problem_list" v-loading="loading">

          <div v-if="searchKeyword" class="searchIndex_problem_box" v-for="(item ,index) in searchKeyword" :key="index">

            <div class="searchIndex_problem_left">
              <p><i style="font-size: 16px" class="icon icon-ziyuan39"></i>5721</p>
              <p><i style="font-size: 14px" class="icon icon-ziyuan36"></i>249</p>
              <p><i class="icon icon-ziyuan37"></i>4891</p>
            </div>

            <div class="searchIndex_problem_right">
              <div class="searchIndex_problem_top">
                <h2>2019宝马S1000RR升级 将采用MotoGP技术？</h2>
                <p>大颗颗</p>
              </div>
              <p>随着时间的推移，超级摩托车的世界越来越先进。在杜卡迪高调的推出了旗下的超跑Panigale V4后，作为摩界头部超跑的宝马感受</p>
              <div class="searchIndex_problem_bottom">
                <keywordInstall :keyword="['新能源','精品教程','汽车']"></keywordInstall>

                <div class="searchIndex_userName">
                  <p>老机友之李超说车</p>
                  <span>·</span>
                  <p>25万 次观看</p>
                  <span>·</span>
                  <p>2小时前</p>
                </div>
              </div>

            </div>

          </div>
          <div class="no_Found">
            <div class="">
              <img src="/static/img/u4815.png" alt="">
            </div>
            <div class="">
              <p>抱歉！没有找到更多符合条件的相关信息</p>
              <p>您可以尝试更换关键词</p>
            </div>
          </div>
        </div>
      </el-tab-pane>
      <el-tab-pane label="商城" name="mall">
        <span slot="label"><i class="icon icon-shangcheng"></i> 商城</span>
        <div class="searchIndex_mall_list" v-loading="loading">

          <div v-if="searchKeyword" class="searchIndex_mall_box" v-for="(item ,index) in searchKeyword" :key="index">
            <div class="searchIndex_mall_img">
              <img src="/static/img/carss.gif" alt="">
            </div>

            <div class="searchIndex_mall_text">
              <div class="searchIndex_mall_money">
                <p><span>&yen;</span>576</p>
                <p>568人付款</p>
              </div>
              <div class="searchIndex_mall_main">星辉车模型 布加迪遥控车USB充电动男孩儿童玩具汽车···</div>
              <div class="searchIndex_mall_userName">
                <p><span>鹏盈专营店</span></p>
                <el-rate
                  v-model="mallValue"
                  :colors="['#15bafe','#15bafe','#15bafe']"
                  disabled
                >
                </el-rate>
              </div>
            </div>

          </div>
          <div class="no_Found">
            <div class="">
              <img src="/static/img/u4815.png" alt="">
            </div>
            <div class="">
              <p>抱歉！没有找到更多符合条件的相关信息</p>
              <p>您可以尝试更换关键词</p>
            </div>
          </div>
        </div>
      </el-tab-pane>
      <el-tab-pane label="淘货" name="bargain">
        <span slot="label"><i class="icon icon-taohuo1"></i> 淘货</span>
        <div class="searchIndex_bargain_list" v-loading="loading">
          <div v-if="searchKeyword" class="searchIndex_bargain_box item_1" v-for="(item ,index) in searchKeyword" :key="index">
            <div class="searchIndex_bargain_user">
              <div class="searchIndex_bargain_avatar">
                <img src="/static/img/avatar/user.png" alt="">
              </div>
              <div class="searchIndex_bargain_userName">
                <p>大颗颗</p>
                <el-rate
                  v-model="mallValue"
                  :colors="['#15bafe','#15bafe','#15bafe']"
                  disabled
                >
                </el-rate>
              </div>

            </div>

            <div class="searchIndex_bargain_img">
              <img src="/static/img/car10.png" alt="">
            </div>

            <div class="searchIndex_bargain_money">
              <p>&yen;1800</p>
              <p>重庆</p>
            </div>

            <div class="searchIndex_bargain_text">
              <h2>98新佳能700D+18-55 STM套件</h2>
              <p>轻微划痕，东西一分钱一分货不要拿垃圾来比较Note2成色9成手机无拆无修屏幕无划痕贴了防爆膜</p>
            </div>

            <div class="searchIndex_bargain_tags">
              <keywordInstall :keyword="['汽车','摩托车','无人机']"></keywordInstall>
            </div>

            <div class="searchIndex_bargain_time">1分钟前</div>
          </div>
          <div class="no_Found">
            <div class="">
              <img src="/static/img/u4815.png" alt="">
            </div>
            <div class="">
              <p>抱歉！没有找到更多符合条件的相关信息</p>
              <p>您可以尝试更换关键词</p>
            </div>
          </div>
        </div>
      </el-tab-pane>
    </el-tabs>
  </div>
</template>

<script>
// import '@/assets/js/searchIndex.js'
import FormatDate from "../../utils/GetDateUtils";
import keywordInstall from '@/components/keywordInstall'

export default {
  data(){
    return{
      activeName: 'video',

      mallValue:4,  //商城产品评分
      searchKeyword:null,     //关键字搜索数据
      loading:true,
      dataLength:null
    }
  },
  components:{
    keywordInstall,
  },
  beforeRouterEnter(to, from, next){
    console.log(to)

    next();
  },
  methods: {
    RouterBaike(index){
      this.$router.push({
        path:"/home/BaikeDetail",
        query:{
          uid:this.searchKeyword[index].encyclopedia_id
        }
      })
    },
    dataSeachIndex(Num){
      /*
      关键词搜索方法
      */
      if(this.$route.query.keyword){
        this.HttpClient.post('/keywords/search',{
          keywords:this.$route.query.keyword,
          type:Num
        })
        .then((res) => {
          console.log(res)
          this.searchKeyword = res.data.data
          this.loading = false
          console.log(this.searchKeyword)
        })
      }else{
        this.HttpClient.post('/tag/search',{
          tag:this.$route.query.label,
          type:Num
        })
        .then((res) => {
          this.searchKeyword = res.data.data
          this.loading = false
          console.log(this.searchKeyword)
        })
      }
    },
    handleDate(date) {
      return FormatDate.GetDate(date);
    },
    handleClick(tab, event) {
      if(tab.index == 0){
        this.loading = true
        this.dataSeachIndex(3)
      }else if(tab.index == 1){
        this.loading = true
        this.dataSeachIndex(1)
      }else if(tab.index == 2){
        this.loading = true
        this.dataSeachIndex(2)
      }else if(tab.index == 3){
        this.loading = true
        this.dataSeachIndex(4)
      }else if(tab.index == 4){
        this.loading = true
        this.dataSeachIndex(6)
      }else if(tab.index == 5){
        this.loading = true
        this.dataSeachIndex(5)
      }
    },
    RouterIndexVideo(index){
      this.$router.push({
        path:'/home/videoDetail',
        query:{
          video:this.searchKeyword[index].video_id
        }
      })
    },
    RouterIndexActivt(index){
      this.$router.push({
        path:'/home/articleDetails',
        query:{
          name:this.searchKeyword[index].article_id
        }
      })
    }
  },
  created(){
    console.log(this.$store.state.sreachId)
    this.HttpClient.post('/keywords/search',{
      keywords:this.$route.query.keyword,
      type:3
    })
    .then((res) => {
      this.dataLength = res.data.data.length
      this.searchKeyword = res.data.data
      this.loading = false
      console.log(this.searchKeyword)
    })
  },
}
</script>
<style lang="less">
  .no_Found>div>p{
    font-size:18px;
  }
  .no_Found{
      display: flex;
      width: 100%;
      height: 500px;
      align-items: center;
      justify-content: center;
  }
  @media screen and (max-width: 1280px) {
    .searchIndex{
      padding: 30px 40px !important;
    }
  }
  .searchIndex{
    max-width: 1200px;
    min-width: 960px;
    margin: 0 auto;
    padding: 30px 0;

    .el-tabs__content{
      overflow: unset;
    }
    .el-tabs__item{
      .icon{
        color: #15bafe;
      }
    }
    /*视频*/
    .searchIndex_video_list{
      .searchIndex_video_box:not(:last-child){
        margin-bottom: 15px;
        border-bottom: 1px solid #dedede;
        padding-bottom: 15px;
      }
      /*视频列表盒子*/
      .searchIndex_video_box{
        display: flex;
        align-items: center;
        cursor: pointer;

        /*视频封面*/
        .searchIndex_video_img{
          position: relative;
          width: 260px;
          height: 148px;
          display: flex;
          justify-content: center;
          align-items: center;
          overflow: hidden;
          background-color: #000;
          margin-right: 30px;
          span{
            width: 40px;
            height: 40px;
            position: absolute;
            top: 0;
            right: 15px;
          }
          p{
            font-size: 12px;
            color: #fff;
            padding: 0 5px;
            background: rgba(0,0,0,.8);
            position: absolute;
            left: 15px;
            bottom: 10px;
          }
          img{
            width: 100%;
          }

        }

        /*视频详情*/
        .searchIndex_video_text{
          flex: 1;

          /*标题*/
          h2{
            font-size: 16px;
          }
          h2:hover{
            color: #15bafe;
          }
          h2:focus{
            color: #325fc3;
          }

          /*内容*/
          >p{
            height: 60px;
            margin: 15px 0;
            font-size: 14px;
            color: #999;
            overflow: hidden;
          }


          /*视频状态*/
          .searchIndex_video_status{
            display: flex;
            justify-content: space-between;
            align-items: center;

            li{
              margin-top: 0 !important;
            }
          }
        }
      }
    }

    /*文章/百科*/
    .searchIndex_article_list,
    .searchIndex_encyclopedia_list{


      .searchIndex_article_box:not(:last-child){
        margin-bottom: 15px;
        border-bottom: 1px solid #dedede;
        padding-bottom: 15px;
      }
      .searchIndex_article_box{
        display: flex;
        align-items: center;
        cursor: pointer;
        .searchIndex_article_img{
          width: 160px;
          height: 120px;
          display: flex;
          justify-content: center;
          align-items: center;
          background-color: #000;
          overflow: hidden;
          margin-right: 30px;

          img{
            width: 100%;
          }
        }

        .searchIndex_article_text{
          flex: 1;

          .searchIndex_article_top{
            display: flex;
            justify-content: space-between;
            align-items: center;

            h2{
              font-size: 16px;
              display: flex;
              align-items: center;

              span{
                width: 7px;
                height: 20px;
                background-color: #15bafe;
                display: block;
                margin-right: 10px;
              }
            }
            h2:hover{
              color: #15bafe;
            }
            h2:focus{
              color: #325fc3;
            }
          }

          .searchIndex_article_bottom{
            display: flex;
            justify-content: space-between;
            align-items: flex-end;
            margin-top: 20px;

            p{
              height: 40px;
              overflow: hidden;
              max-width: 600px;
              color: #999;
            }
          }
        }
      }
    }

    /*问题*/
    .searchIndex_problem_list{
      .searchIndex_problem_box:hover{
        background-color: #f2f2f2;
        .searchIndex_problem_left{
          border-left: 6px solid #15bafe;
        }
      }
      .searchIndex_problem_box:not(:last-child){
        border-bottom: 1px solid #dedede;
      }
      .searchIndex_problem_box{
        display: flex;
        align-items: center;
        padding: 20px 20px 20px 0;

        .searchIndex_problem_left{
          margin-right: 50px;
          border-left: 6px solid transparent;
          padding-left: 20px;
          transition: all .3s;

          p{
            font-size: 12px;
            color: #a1a1a1;
            padding: 5px 0;
            .icon{
              font-size: 12px;
              width: 20px;
              color: #15bafe;
              margin-right: 10px;
            }
          }

          p:not(:last-child){
            border-bottom: 1px solid #dedede;
          }

        }

        .searchIndex_problem_right{
          flex: 1;

          .searchIndex_problem_top{
            display: flex;
            align-items: flex-end;
            justify-content: space-between;

            h2{
              font-size: 16px;
            }
            h2:hover{
              color: #15bafe;
            }
            h2:focus{
              color: #325fc3;
            }
            p{
              font-size: 14px;
              color: #999;
            }
          }

          >p{
            font-size: 14px;
            color: #999;
            height: 40px;
            margin: 10px 0;
          }

          .searchIndex_problem_bottom{
            display: flex;
            align-items: center;
            justify-content: space-between;

            li{
              margin-top: 0;
            }
          }
        }
      }
    }

    /*商城*/
    .searchIndex_mall_list{
      display: flex;
      align-items: center;
      flex: 5;
      flex-wrap: wrap;

      .searchIndex_mall_box:hover{
        box-shadow: 0px 2px 5px 0px
        rgba(34, 24, 21, 0.16);
      }
      .searchIndex_mall_box{
        flex: 1;
        max-width: 230px;
        padding: 15px;
        transition: all .3s;

        .searchIndex_mall_img{
          width: 200px;
          height: 200px;
          display: flex;
          justify-content: center;
          align-items: center;
          overflow: hidden;
          img{
            width: 100%;
          }
        }

        .searchIndex_mall_text{
          .searchIndex_mall_money{
            display: flex;
            justify-content: space-between;
            align-items: center;

            >p:nth-child(1){
              font-size: 16px;
              color: #15bafe;
              span{
                font-size: 12px;
                font-weight: normal;
              }
            }

            >p:last-child{
              font-size: 12px;
              color: #999;
            }
          }

          .searchIndex_mall_main{
            height: 40px;
            overflow: hidden;
            font-size: 14px;
            margin-bottom: 5px;
          }
          .searchIndex_mall_nmb{
            margin-bottom: 5px;
            font-size: 12px;
            color: #999;
          }
          .searchIndex_mall_userName{
            display: flex;
            justify-content: space-between;
            align-items: center;
            >p{
              display: flex;
              align-items: center;
              .icon{
                margin-right: 5px;
              }
              span{
                text-decoration: underline;
                font-size: 12px;
                color: #999;
              }
            }

            .el-rate{
              height: auto;
              i{
                font-size: 14px;
                margin-right: 0;
              }
            }
          }
        }
      }
    }

    /*淘货*/
    .searchIndex_bargain_list{
      display: flex;
      align-items: center;
      flex-wrap: wrap;
      flex: 5;

      .searchIndex_bargain_box:hover{
        box-shadow: 0px 2px 5px 0px
        rgba(34, 24, 21, 0.16);
      }

      .searchIndex_bargain_box{
        max-width: 230px;
        flex: 1;
        border-top: 5px solid;
        padding: 10px;
        margin: 0 5px;
        transition: all .3s;

        .searchIndex_bargain_user{
          display: flex;
          align-items: center;
          margin-bottom: 10px;

          /*头像*/
          .searchIndex_bargain_avatar{
            display: flex;
            justify-content: center;
            align-items: center;
            background-color: #000;
            overflow: hidden;
            width: 35px;
            height: 35px;
            border: 1px solid #15bafe;
            border-radius: 5px;
            margin-right: 10px;
            img{
              width: 100%;
            }
          }

          /*用户名*/
          .searchIndex_bargain_userName{
            p{
              font-size: 14px;
              color: #333;
            }

            /*评分*/
            .el-rate{
              height: auto;
              i{
                font-size: 14px;
                margin-right: 2px;
              }
            }
          }
        }

        .searchIndex_bargain_img{
          height: 160px;
          display: flex;
          justify-content: center;
          align-items: center;
          background-color: #f2f2f2;

          img{
            width: 100%;
          }
        }

        .searchIndex_bargain_money{
          display: flex;
          justify-content: space-between;
          align-items: flex-end;
          border-bottom: 1px solid #dedede;
          margin-top: 10px;
          padding-bottom: 5px;
          margin-bottom: 5px;

          >p:nth-child(1){
            font-size: 18px;
            color: #15bafe;
          }
          >p:last-child{
            font-size: 12px;
            color: #999;
          }
        }

        .searchIndex_bargain_text{
          h2{
            font-size: 14px;
            color: #333;
            width: 95%;
            overflow: hidden;
            text-overflow:ellipsis;
            white-space: nowrap;
          }
          p{
            font-size: 12px;
            color: #999;
            height: 55px;
            overflow: hidden;
          }
        }

        .searchIndex_bargain_tags{
          li{
            margin-top: 5px;
            margin-bottom: 5px;
          }
        }

        .searchIndex_bargain_time{
          font-size: 12px;
          color: #999;
        }
      }

      .item_1{
        border-color: #15bafe;
      }
      .item_2{
        border-color: #C536E4;
        .searchIndex_bargain_money {
          > p:nth-child(1) {
            color: #C536E4;
          }
        }
      }
      .item_3{
        border-color: #FF9900;
        .searchIndex_bargain_money {
          > p:nth-child(1) {
            color: #FF9900;
          }
        }
      }
      .item_4{
        border-color: #00CC00;
        .searchIndex_bargain_money {
          > p:nth-child(1) {
            color: #00CC00;
          }
        }
      }
      .item_5{
        border-color: #15bafe;
        .searchIndex_bargain_money {
          > p:nth-child(1) {
            color: #FF9900;
          }
        }
      }
      .item_6{
        border-color: #15bafe;
        .searchIndex_bargain_money {
          > p:nth-child(1) {
            color: #FF9900;
          }
        }
      }
    }


    /*用户信息*/
    .searchIndex_userName{
      display: flex;
      align-items: center;

      p{
        display: flex;
        align-items: center;
        color: #999;
        font-size: 12px;

        .icon{
          color: #15bafe;
          margin-right: 3px;
        }
      }
      span{
        margin: 0 5px;
      }
    }
  }
</style>
<!--<style scoped src="../../assets/css/searchIndex.css"></style>-->
