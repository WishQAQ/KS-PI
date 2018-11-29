<template>
    <div class="video_index">
      <div class="video_index_top">
        <div class="video_index_banner">
          <div class="video_index_title">
            <p>热门视频</p>
            <span></span>
          </div>
          <div class="video_banner_swiper">
            <swiper :options="swiperOption">
              <swiper-slide v-for="(videoList ,index) in videoData" :key="index">
                <img class="clickImgHover" :src="request.picUrl+videoList.cover" @click="bannerImgBack(index)">
                <div class="video_swiper_bottom">
                  <div class="video_swiper_logo"><img src="/static/img/icon/userIndex_credit.png" alt=""></div>
                  <div class="videp_swiper_text">
                    <p>{{videoList.title}}</p>
                    <span v-html="videoList.description"></span>
                  </div>
                </div>
              </swiper-slide>
              <div class="swiper-button-prev el-icon-arrow-left" slot="button-prev"></div>
              <div class="swiper-button-next el-icon-arrow-right" slot="button-next"></div>
              <div class="swiper-pagination" slot="pagination"></div>
            </swiper>
          </div>
        </div>

        <div class="video_banner_list">
          <div class="video_index_title">
            <p>关注视频</p>
            <span></span>
          </div>

          <div class="video_banner_list_box">
            <el-collapse v-model="activeName" accordion>
              <el-collapse-item :name="index" v-for="(followList ,index) in followVideoData" :key="index">
                <template slot="title">
                  <div class="video_banner_avatar"><img :src="request.picUrl + followList.avatar" alt=""></div>
                  <div class="video_banner_text">
                    <p>{{followList.title}}</p>
                    <span v-html="followList.description"></span>
                  </div>
                </template>
                <img class="cuporImg" :src="request.picUrl+followList.cover" alt="" @click="imgRouterClick(index)">
              </el-collapse-item>
            </el-collapse>
          </div>
        </div>
      </div>


      <div class="video_bottom">
        <div class="video_bottom_title">
          <div class="video_title_left">
            <i class="icon icon-ziyuan42"></i>
            <p>猜你喜欢</p>
            <span>Guess what you like</span>
          </div>

          <div class="video_title_right">
            <input type="text" placeholder="请输入搜索内容" v-model="searchVideo">
            <button class="btnclick" @click="videoSearch"><i class="icon icon-huaban2"></i></button>
          </div>

        </div>

        <!--<div class="video_bottom_main">
          <div :class="{video_bottom_list:true, 'video_list_teaching':likeList.is_course == 1?true:false}" v-for="(likeList ,index) in likeVideoData" :key="index">
            <div class="video_list_img" @click="likeClickVide(index)">
              <img :src="request.picUrl+likeList.cover" alt="">

              <div class="video_img_time">
                <p>{{likeList.title}}</p>
                <span>7:34</span>
              </div>

              <div class="video_img_teaching"></div>
            </div>
            <div class="video_list_tags">
              关键词:
              <keyWordInstall :keyword="likeList.label_name"></keyWordInstall>
            </div>
            <div class="video_list_userName"><user-modal></user-modal>{{likeList.nickname}}</div>
            <div class="video_list_time">
              <p>{{likeList.view_num}}次观看</p>
              <span>·</span>
              <p>{{likeList.created_at}}</p>
            </div>
          </div>
        </div>-->

      </div>
      <div class="video_bottom" v-for="(item ,index) in videoClassDataArray" :key="index" @mouseenter="RouteIndexVideo(index)">
        <div class="video_index_title" v-if="index !== 0">
          <p>{{item.name}}</p>
          <span></span>
        </div>

        <div class="video_bottom_main">
          <div :class="{video_bottom_list:true, 'video_list_teaching':listItem.is_course}" v-for="(listItem ,index) in item.data" :key="index">
            <div class="video_list_img" @click="RouteIndexDalis(index)">
              <img :src="request.picUrl+listItem.cover" alt="">

              <div class="video_img_time">
                <p>{{listItem.title}}</p>
                <span>7:34</span>
              </div>

              <div class="video_img_teaching"></div>
            </div>
            <div class="video_list_tags">
              关键词:
              <keyWordInstall :keyword="listItem.label_name"></keyWordInstall>
            </div>
            <div class="video_list_userName"><user-modal></user-modal>{{listItem.nickname}}</div>
            <div class="video_list_time">
              <p>{{listItem.view_num}}次观看</p>
              <span>·</span>
              <p>{{handleDate(listItem.created_at)}}</p>
            </div>
          </div>
        </div>

      </div>
    </div>
</template>

<script>
  import UserModal from '@/components/userModal'
  import keyWordInstall from '@/components/keywordInstall'
  import FormatDate from "../../utils/GetDateUtils";

    export default {
      name: "videoIndex",
      data() {
        return {
          // 轮播图
          swiperOption: {
            pagination: {
              el: '.swiper-pagination',
              clickable :true,
            },
            navigation: {
              nextEl: '.swiper-button-next',
              prevEl: '.swiper-button-prev'
            }
          },

          // 手风琴
          activeName: '1',
          videoData:null,   //热门视频
          likeVideoData:null,  //猜你喜欢
          followVideoData:null,  //关注视频
          searchVideo:null,     //视频搜索
          videoClassisyArray:[],     //视频模块新列表数据
          videoClassDataArray:[],     //视频模块新内容数据
          indexlist:null              //视频模块点击下标
        }
      },
      components:{
        keyWordInstall,
        UserModal
      },
      methods:{
        handleDate(date) {
          return FormatDate.GetDate(date);
        },
        //视频模块列表
        videoClassisy(){
          this.HttpClient.post('/videos/module/list',{})
          .then((res) => {
            var name = new Array()
            for(var i = 0;i<res.data.data.length;i++){

              this.videoClassisyArray.push({
                name:res.data.data[i].name,
                data:[],
                id:res.data.data[i].id
              })
              name.push({
                name:this.videoClassisyArray[i].name
              })
              var id = this.videoClassisyArray[i].id

              let postData = this.videoClassisyArray[i]


              this.HttpClient.post('/videos/module',{
                id:this.videoClassisyArray[i].id
              })
              .then((res) => {
                var data = res.data.data
                this.videoClassDataArray.push({
                  name:null,
                  data:data,
                  id:id
                })

                for(var a=0;a<name.length;a++){
                  this.videoClassDataArray[a].name = name[a].name
                }
                console.log(this.videoClassDataArray)
              })
            }
            // console.log(this.videoClassisyArray)
          })

        },
        //热门视频点击跳转
        bannerImgBack(index){
          this.$router.push({
            path:'/home/videoDetail',
            query:{
              video:this.videoData[index].video_id
            }
          })
        },
        imgRouterClick(index){
          this.$router.push({
            path:'/home/videoDetail',
            query:{
              video:this.followVideoData[index].video_id
            }
          })
          console.log(index)
        },
        circulation(data){
          for(var i=0;i<data.length;i++){
            data[i].created_at = this.DateTime(this.finalDate(data[i]))
          }
        },
        //热门视频
        createdVideoHot(){
          this.HttpClient.post('/videos/hot',{})
          .then((res) => {
            this.videoData = res.data.data.data
            // console.log(this.videoData)
          })
        },
        //猜你喜欢
        createdVideoLike(){
          this.HttpClient.post('/videos/like',{})
          .then((res) => {
            this.likeVideoData = res.data.data
            this.circulation(this.likeVideoData)
            // console.log(this.likeVideoData)
          })
        },
        //关注视频
        createdVideoFollow(){
          this.HttpClient.post('/videos/follow',{})
          .then((res) => {
            this.followVideoData = res.data.data.data
            console.log(this.followVideoData)
          })
        },
        //视频搜索
        videoSearch(){
          this.HttpClient.post('/videos/search',{
            keywords:this.searchVideo
          })
          .then((res) => {
            this.likeVideoData = res.data.data
            this.circulation(this.likeVideoData)
            // console.log(this.likeVideoData)
          })
        },
        //猜你喜欢跳转详情
        likeClickVide(index){
          this.$router.push({
            path:'/home/videoDetail',
            query:{
              video:this.likeVideoData[index].video_id
            }
          })
        },
        RouteIndexVideo(index){
          this.indexlist = index

        },
        RouteIndexDalis(index){
          this.$router.push({
            path:'/home/videoDetail',
            query:{
              video:this.videoClassDataArray[this.indexlist].data[index].video_id
            }
          })
        }
      },
      created(){
        this.videoClassisy()
        this.createdVideoHot()
        this.createdVideoLike()
        this.createdVideoFollow()
      }
    }
</script>

<style lang="less">
  .clickImgHover{
    cursor: pointer;
  }
  .cuporImg{
    cursor: pointer;
  }
  .btnclick{
    cursor: pointer;
  }
  .video_index{
    padding: 30px 0;
  }
  //title
  .video_index_title{
    margin-bottom: 10px;
    p{
      font-size: 16px;
      color: #000;
    }
    span{
      background: linear-gradient(to right, #157efe, #fff);
      width: 100px;
      height: 4px;
      display: block;
    }
  }
  .video_index{
    max-width: 1200px;
    min-width: 960px;
    margin: 0 auto;
    //banner及手风琴
    .video_index_top{
      position: relative;
      display: flex;
      justify-content: space-between;
      margin-bottom: 40px;

      //轮播图
      .video_index_banner{
        width: 790px;

        .video_banner_swiper{
          /*分页器*/
          .swiper-container-horizontal > .swiper-pagination-bullets{
            bottom: 5% !important;
            left: 85% !important;
            width: auto !important;
            .swiper-pagination-bullet-active{
              background: #fff;
            }
            span{
              border-radius: 0 !important;
              background: #fff;
            }
          }

          /*切换按钮*/
          .swiper-button-next,
          .swiper-button-prev{
            background: none;
            font-size: 40px;
            color: #fff;
            opacity: 0;
            transition: all .3s;
          }
        }

        .swiper-slide{
          height: 440px;
          display: flex;
          justify-content: center;
          align-items: center;
          background-color: #000;
          overflow: hidden;
        }
        .swiper-slide>img{
          width: 100%;
        }
        /*swiper底部文字*/
        .video_swiper_bottom{
          position: absolute;
          bottom: 0;
          left: 0;
          width: 100%;
          display: flex;
          align-items: center;
          padding: 15px 25px;
          background: rgba(0,0,0,.8);

          /*用户logo*/
          .video_swiper_logo{
            width: 40px;
            height: 40px;
            display: flex;
            justify-content: center;
            align-items: center;
            overflow: hidden;
            margin-right: 20px;

            img{
              width: 100%;
            }
          }
          .videp_swiper_text{
            flex: 1;
            height: 50px;
            overflow: hidden;
            >p{
              color: #fff;
              font-size: 18px;
            }
            span{
              font-size: 14px;
              color: #999;
              width: 460px;
              display: block;
              overflow: hidden;
              text-overflow:ellipsis;
              white-space: nowrap;

              p{
                font-size: 14px;
                color: #999;
                width: 460px;
                display: block;
                overflow: hidden;
                text-overflow:ellipsis;
              }
            }
          }
        }
      }

      /*切换按钮*/
      .video_index_banner:hover{
        .swiper-button-next,
        .swiper-button-prev{
         opacity: 1;
        }
        .swiper-button-disabled{
          opacity: .5 !important;
        }
      }


      /*手风琴*/
      .video_banner_list{
        width: 386px;
      }
      /*滚动条样式*/
      .video_banner_list_box::-webkit-scrollbar{
        width: 6px;
        height: 16px;
      }
      .video_banner_list_box::-webkit-scrollbar-track{
        background-color: #dadada;
      }
      .video_banner_list_box::-webkit-scrollbar-thumb{
        background-color: #15bafe;
      }

      .video_banner_list_box{
        height: 440px;
        overflow: auto;

        .el-collapse-item{
          position: relative;
          width: 380px;

          .el-collapse-item__header.is-active{
            background-color: #222 !important;
            .video_banner_text{
              span{
                display:inline-block;
                width: 100%;
                color: #fff;
                overflow: hidden;
                text-overflow:ellipsis;
                white-space: nowrap;
                p{
                  display:inline-block;
                  width: 100%;
                  color: #fff;
                  overflow: hidden;
                  text-overflow:ellipsis;
                  white-space: nowrap;
                }

              }
            }
          }
          .el-collapse-item__arrow.is-active{
            color: #fff;
          }

          .el-collapse-item__header{
            display: flex;
            align-items: center;
            background-color: #f2f2f2 !important;
            height: 75px !important;
            line-height: normal !important;
            padding: 0 20px;
            position: relative;
            z-index: 1;

            .el-collapse-item__arrow{
              line-height: normal !important;
              position: absolute;
              right: 5%;
            }
            /*头像*/
            .video_banner_avatar{
              width: 50px;
              height: 50px;
              border-radius: 50%;
              display: flex;
              justify-content: center;
              align-items: center;
              overflow: hidden;
              margin-right: 10px;

              img{
                width: 100%;
              }
            }

            .video_banner_text{
              width: 70%;
              p{
                font-size: 14px;
                color: #999;
              }
              span{
                font-size: 16px;
                color: #222;
                display: block;
                height: 40px;
                overflow: hidden;
                p{
                  font-size: 16px;
                  color: #222;
                  overflow: hidden;
                  text-overflow:ellipsis;
                  white-space: nowrap;
                }
              }
            }

          }

          .el-collapse-item__wrap{
            height: 210px;

            .el-collapse-item__content{
              display: flex;
              justify-content: center;
              align-items: center;
              width: 380px;
              height: 100%;
              background-color: #222;
              padding-bottom: 0 !important;
              img{
                width: 100%;
              }
            }
          }

        }
      }
    }

    /*猜你喜欢*/
    .video_bottom{
      margin-bottom: 30px;

      /*猜你喜欢标题*/
      .video_bottom_title{
        display: flex;
        justify-content: space-between;
        align-items: center;
        border-bottom: 1px solid #dcdcdc;
        padding-bottom: 10px;
        margin-bottom: 10px;

        .video_title_left{
          display: flex;
          align-items: center;
          text-transform: uppercase;

          .icon{
            color: #15bafe;
            font-size: 20px;
            margin-right: 10px;
          }
          p{
            font-size: 18px;
            color: #000;
            margin-right: 10px;
          }
          span{
            font-size: 18px;
            font-weight: bold;
            color: #d3d3d3;
            font-style: italic;
          }
        }

        /*搜索框*/
        .video_title_right{
          display: flex;
          justify-content: center;
          align-items: center;

          input{
            height: 25px;
            border-top-left-radius: 10px;
            border-bottom-left-radius: 10px;
            border: none;
            background-color: #f2f2f2;
            padding: 0 10px;
          }
          input::placeholder{
            font-size: 14px;
            color: #999;
          }
          button{
            height: 25px;
            border-top-right-radius: 10px;
            border-bottom-right-radius: 10px;
            border: none;
            background: linear-gradient(to right, #41a1fd , #4ac8fd);
            font-size: 20px;
            color: #fff;
            padding: 0 10px;
          }

        }

      }

      /*列表盒子*/
      .video_bottom_main{
        display: flex;
        align-items: center;
        flex-wrap: wrap;


        /*教学视频*/
        .video_list_teaching{
          /*教学标签*/
          .video_img_teaching{
            background: url("/static/img/icon/logo_3.png") no-repeat;
            background-size: contain;
            width: 40px;
            height: 35px;
            position: absolute;
            top: 0;
            right: 5%;
          }
        }


        /*列表主体*/
        .video_bottom_list{
          width: 230px;
          margin-right: 8px;
          margin-bottom: 10px;
          cursor: pointer;

          .video_list_img{
            height: 130px;
            display: flex;
            justify-content: center;
            align-items: center;
            overflow: hidden;
            position: relative;
            background-color: #000;
            margin-bottom: 10px;

            img{
              height: 100%;
            }

            /*视频名称/时间*/
            .video_img_time{
              position: absolute;
              left: 0;
              bottom: 0;
              width: 100%;
              height: 30px;
              background: rgba(0,0,0,.5);
              color: #fff;
              display: flex;
              justify-content: space-between;
              align-items: center;
              padding: 0 5px;

              p{
                font-size: 14px;
                width: 120px;
                overflow: hidden;
                text-overflow: ellipsis;
                white-space: nowrap;
              }
              span{
                font-size: 12px;
              }
            }
          }
          .video_list_tags{
            display: flex;
            align-items: center;
            color: #999;
            font-size: 12px;

            div{
              margin-left: 10px;

              li{
                margin-top: 0 !important;
              }
            }
          }

          .video_list_userName{
            display: block;
            font-size: 12px;
            color: #999;
          }

          .video_list_time{
            display: flex;
            align-items: center;
            font-size: 12px;
            color: #999;

            span{
              display: inline-block;
              margin: 0 5px;
            }
          }
        }
      }
    }
  }
  @media screen and (max-width: 1200px) and (min-width: 300px){
    .video_index{
      padding: 30px 20px !important;
    }
    /*轮播*/
    .video_index_banner {
      width: 65% !important;
      .swiper-slide{
        height: 344px !important;

        /*轮播字体*/
        .videp_swiper_text{
          p{
            font-size: 14px !important;
          }
          span{
            font-size: 12px !important;
          }
        }
      }
    }
    /*手风琴*/
    .video_banner_list{
      width: 305px !important;
    }
    .video_banner_list_box{
      height: 344px !important;
      .el-collapse-item{
        width: 298px !important;

        /*手风琴字体*/
        .video_banner_text{
          p,span{font-size: 12px !important;}
        }
        .el-collapse-item__wrap{
          height: 115px !important;
          .el-collapse-item__content{
            width: 298px !important;
          }
        }
      }
    }

    .video_index .video_bottom .video_bottom_main .video_bottom_list{
      width: 22.3% !important;
    }
    .video_index .video_bottom .video_bottom_main .video_bottom_list:not(:nth-child(4n)){
      margin-right: 29px;
    }

  }
</style>
