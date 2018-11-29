<template>

  <div class="videoSearch">
    <div class="videoSearch_left">
      <div class="search_title">
        <p><i class="icon icon-lianjie"></i>搜索视频标题</p>
        <el-input>
          <el-button slot="append" icon="el-icon-search"></el-button>
        </el-input>
      </div>

      <div class="search_tutorial">
        <p><i class="icon icon-changjingtuijianpitchon"></i>教程</p>
        <el-switch
          v-model="tutorial"
          active-color="#13ce66"
          inactive-color="#ff4949">
        </el-switch>
      </div>

      <div class="videoType">
        <p><i class="icon icon-shipin"></i>视频类型</p>
        <el-radio-group v-model="videoType">
          <el-radio-button label="汽车"></el-radio-button>
          <el-radio-button label="摩托车"></el-radio-button>
          <el-radio-button label="无人机"></el-radio-button>
          <el-radio-button label="智能设备"></el-radio-button>
        </el-radio-group>
      </div>

      <div class="filter">
        <p class="filter_title"><i class="icon icon-caidan"></i>过滤</p>

        <div class="filter_list">
          <p>上传日期</p>
          <el-radio-group v-model="uploadTime">
            <el-radio-button label="今天"></el-radio-button>
            <el-radio-button label="本周"></el-radio-button>
            <el-radio-button label="本月"></el-radio-button>
            <el-radio-button label="本年"></el-radio-button>
          </el-radio-group>
        </div>

        <div class="filter_list">
          <p>长度</p>
          <el-radio-group v-model="videoTime">
            <el-radio-button label="小于10分钟"></el-radio-button>
            <el-radio-button label="大于10分钟"></el-radio-button>
          </el-radio-group>
        </div>

        <div class="filter_list">
          <p>排列</p>
          <el-radio-group v-model="videoRange">
            <el-radio-button label="上传时间"></el-radio-button>
            <el-radio-button label="观看次数"></el-radio-button>
            <el-radio-button label="影响力"></el-radio-button>
          </el-radio-group>
        </div>

      </div>

    </div>

    <div class="videoSearch_main">
      <el-breadcrumb separator-class="el-icon-arrow-right">
        <el-breadcrumb-item :to="{ path: '/home/videoIndex' }">视频首页</el-breadcrumb-item>
        <el-breadcrumb-item>视频搜索页</el-breadcrumb-item>
      </el-breadcrumb>

      <div class="videoSearch_content">
        <!--视频列表-->
        <div class="videoSearch_content_list">
          <!--图片-->
          <div class="video_img"><img src="/static/img/car.jpg" alt=""><span>10:20</span></div>
          <!--信息-->
          <div class="video_text">
            <!--标题-->
            <h4>澳州连发13起草莓藏针事件多人中招 官方：切碎再吃</h4>
            <!--ID关键词-->
            <div class="video_text_box">
              <p class="video_text_user">
                <span>大颗颗</span>·
                <span>231次观看</span>·
                <span>1天前</span>
              </p>
              <p class="tags">
                关键词：
                <keyWordInstall :keyword="['11','22','33']"></keyWordInstall>
              </p>
            </div>
            <!--简介-->
            <p class="video_text_main">大乘汽车品牌正式发布，同时亮相的还有旗下三款新车——紧凑型SUV车型G60S、中型SUV车型G70S以及小型纯电动车型E20。</p>
          </div>
        </div>
      </div>
    </div>
  </div>

</template>

<script>
  import keyWordInstall from '@/components/keywordInstall'

export default {
  data(){
    return{
      tutorial:false,  //教程开关
      videoType:'',  //视频类型

      uploadTime:'', //上传日期
      videoTime:'',  //视频长度
      videoRange:'',  //视频排列
    }
  },
  components:{
    keyWordInstall,
  },
}
</script>

<style lang="less">
  .videoSearch{
    max-width: 1200px;
    min-width: 980px;
    margin: 0 auto;
    display: flex;
    align-items: flex-start;

    /*筛选条件*/
    .videoSearch_left{
      background: #f2f2f2;
      width: 250px;
      padding: 30px 15px;

      /*搜索标题*/
      .search_title{
        margin-bottom: 20px;
        p{
          font-size: 16px;
          color: #222;
          margin-bottom: 10px;
          padding-left: 15px;
          .icon{
            margin-right: 10px;
            color: #bebebe;
            font-size: 24px;
          }
        }
        .el-input{
          .el-input__inner{
            height: 30px;
            line-height: 30px;
            border-color: #bebebe;
          }
        }
      }

      /*教程*/
      .search_tutorial{
        margin-bottom: 10px;
        p{
          font-size: 16px;
          color: #222;
          .icon{
            margin-right: 10px;
            color: #bebebe;
          }
        }
        padding: 10px 20px;
        border-top: 1px solid #e0e0e0;
        border-bottom: 1px solid #e0e0e0;
        display: flex;
        align-items: center;
        justify-content: space-between;
      }

      /*视频类型*/
      .videoType{
        padding: 10px 15px;
        border-radius: 10px;
        background: #fff;
        margin-bottom: 10px;
        p{
          margin-bottom: 10px;
          font-size: 16px;
          color: #222;
          padding-left: 5px;
          .icon{
            color: #bebebe;
            margin-right: 10px;
            font-size: 20px;
          }
        }
        .el-radio-button{
          width: 100%;
          margin: 5px 0;
          border: 1px solid #bebebe;
          .el-radio-button__inner{
            width: 100%;
            border-radius: unset;
            border: none;
          }
        }

      }

      /*过滤*/
      .filter{
        padding: 10px 15px;
        border-radius: 10px;
        background: #fff;
        .filter_title{
          font-size: 16px;
          color: #222;
          margin-bottom: 15px;
          padding-left: 5px;
          display: flex;
          align-items: center;
          .icon{
            margin-right: 10px;
            color: #bebebe;
            font-size: 20px;
          }
        }

        .filter_list{
          margin: 10px 0;
          p{
            font-size: 16px;
            color: #222;
            padding-bottom: 5px;
            border-bottom: 1px solid #bebebe;
            margin: 0 5px 10px 5px;
          }
          .el-radio-button{
            width: 100%;
            margin: 5px 0;
            border: 1px solid #bebebe;
            .el-radio-button__inner{
              width: 100%;
              border-radius: unset;
              border: none;
            }
          }
        }
      }
    }


    /*筛选结果*/
    .videoSearch_main{
      flex: 1;
      padding: 25px 0 50px 50px;

      /*面包屑*/
      .el-breadcrumb{
        padding-bottom: 10px;
        margin-bottom: 30px;
        border-bottom: 1px solid #bebebe;
      }

      /*主体内容*/
      .videoSearch_content{
        /*列表*/

        .videoSearch_content_list:hover{
          .video_text{
            background: #f2f2f2;
          }
        }
        .videoSearch_content_list{
          display: flex;
          align-items: center;
          height: 155px;
          transition: all .3s;
          margin: 25px 0;
          cursor: pointer;

          /*图片*/
          .video_img{
            height: 100%;
            width: 255px;
            display: flex;
            justify-content: center;
            align-items: center;
            overflow: hidden;
            position: relative;
            img{
              height: 100%;
            }
            span{
              position: absolute;
              display: inline-block;
              padding: 2px 10px;
              color: #fff;
              font-size: 12px;
              background: rgba(0,0,0,.5);
              bottom: 10px;
              right: 10px;
            }
          }

          /*说明*/
          .video_text{
            flex: 1;
            height: 100%;
            padding: 15px 20px;
            transition: all .3s;

            /*标题*/
            h4{
              font-size: 18px;
              color: #222;
              margin-bottom: 15px;
            }

            /*用户信息*/
            .video_text_box{
              display: flex;
              align-items: center;
              justify-content: space-between;
              margin-bottom: 10px;

              .video_text_user{
                font-size: 14px;
                color: #999;
              }

              .tags{
                display: flex;
                align-items: center;
                font-size: 14px;
                color: #999;
                li{
                  margin-top: 0;
                }
              }
            }

            /*简介*/
            .video_text_main{
              font-size: 14px;
              color: #999;
            }
          }
        }


      }
    }
  }
</style>
