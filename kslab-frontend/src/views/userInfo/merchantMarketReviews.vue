<template>
  <div class="appBackground">
    <CommercialHead></CommercialHead>


    <div class="merchantViewReviews">
      <div class="header_btm">
        <div class="header_back" @click="handleBack"><i class="el-icon-arrow-left"></i></div>
        <div class="header_title">球形分离器</div>
      </div>
      <div class="header_content">
        <el-table
          :data="commentData"
          style="width: 100%"
          :default-sort = "{prop: 'date', order: 'descending'}">

          <el-table-column
            prop="user"
            width="180"
            align="center"
            label="用户">
            <template slot-scope="scope">
              <div class="userContend">
                <div class="user_avatar"><img :src="handleImg(scope.row.avatar)" alt=""></div>
                <p>{{scope.row.name}}</p>
              </div>
            </template>
          </el-table-column>

          <el-table-column
            prop="content"
            align="center"
            label="评价内容">
            <template slot-scope="scope">
              <p class="content">{{scope.row.content}}
              <i class="icon icon-down" @click="dialogCenter = true"></i>
              </p>

              <el-dialog
                title="用户评价"
                :visible.sync="dialogCenter"
                width="30%">
                <p class="dialogCenter">{{scope.row.content}}</p>
              </el-dialog>

            </template>
          </el-table-column>

          <el-table-column
            prop="images"
            align="center"
            label="图片"
            :formatter="formatter">
            <template slot-scope="scope">
              <div class="images_box" @click="dialogVisible = true">
                <div v-for="(items, indexs) in scope.row.attachment" :key="indexs" class="images"><img :src="handleImg(items.path)" alt=""></div>
              </div>

              <el-dialog
                title="评论图片"
                :visible.sync="dialogVisible"
                width="30%">
                <swiper :options="swiperOption">
                  <swiper-slide><img v-for="(itemx, indexx) in scope.row.attachment" :key="indexx" :src="handleImg(itemx.path)" alt=""></swiper-slide>
                  <div class="swiper-button-prev" slot="button-prev"></div>
                  <div class="swiper-button-next" slot="button-next"></div>
                </swiper>

              </el-dialog>


            </template>
          </el-table-column>
          <el-table-column
            prop="rate"
            width="100"
            align="center"
            label="评分"
            sortable>
            <template slot-scope="scope">
              <div class="rate">
                <el-rate
                  v-bind:value="scope.row.score/2"
                  disabled>
                </el-rate>
              </div>
            </template>
          </el-table-column>
          <el-table-column
            prop="created_at"
            label="发布时间"
            align="center"
            width="100"
            sortable>
          </el-table-column>
        </el-table>

      </div>

    </div>
  </div>
</template>

<script>
  import CommercialHead from '@/components/commercialInfoHeader'
  import * as cfg from "../../../config/app";

    export default {
        name: "merchantViewReviews",

      components:{
        CommercialHead
      },
      data() {
        return {
          viewReviews: [{
            time: '2018-10-31'
          },{
            time: '2018-10-31'
          }],
          dialogCenter: false,  //详细评论框
          viewReviewsRate: 3, //评分
          dialogVisible: false,  //查看图片框
          // 轮播分页器
          swiperOption: {
            navigation: {
              nextEl: '.swiper-button-next',
              prevEl: '.swiper-button-prev'
            }
          },
          id: '',
          page: 1,
          size: 10,
          total: null,
          commentData: []
        }
      },
      created() {
        this.id = this.$route.query.id;
        const param = {
          page: this.page,
          size: this.size,
          source_id: this.id,
          token: window.localStorage.getItem('token')
        };
        this.getCommentData(param);
      },
      methods: {
        formatter(row, column) {
          return row.address;
        },
        /***
         * 获取评论列表
         * @param param
         */
        getCommentData(param) {
          this.HttpClient.post('/goods/getAnswer', param).then(res =>{
            console.log(res.data)
            if(res.data.code === 200) {
              this.commentData = res.data.data.data;
              this.total = res.data.data.total;
            }
          })
        },
        /**
         * 图片格式
         * @param url
         * @returns {string}
         */
        handleImg(url) {
          return cfg.imageUrl+url;
        },
        /**
         * 返回上一页
         */
        handleBack() {
          this.$router.go(-1)
        }
      }

    }
</script>

<style lang="less">
  .merchantViewReviews{
    max-width: 1200px;
    min-width: 960px;
    margin: 0 auto;
    background-color: #fff;

    /*顶部按钮*/
    .header_btm{
      display: flex;
      align-items: center;
      height: 50px;
      background-color: #f2f2f2;

      /*返回*/
      .header_back{
        height: 100%;
        width: 45px;
        background-color: #ededed;
        color: #999;
        font-size: 20px;
        display: flex;
        justify-content: center;
        align-items: center;
      }
      /*评价标题*/
      .header_title{
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100%;
        padding: 0 30px;
        background-color: #15befe;
        color: #fff;
        font-size: 16px;
      }
    }


    /*用户名单元格*/
    .userContend{
      display: flex;
      align-items: center;
      padding: 10px 0;

      /*用户头像*/
      .user_avatar{
        width: 60px;
        height: 60px;
        border: 4px solid #fff;
        border-radius: 50%;
        overflow: hidden;
        box-shadow: 3px 3px 10px rgba(34,24,21,0.34);
        margin-right: 10px;
        img{
          width: 100%;
          height: 100%;
        }
      }
    }


    /*用户评价*/
    .content{
      font-size: 12px;
      color: #666;
      text-align: left;
      max-height: 70px;
      overflow: hidden;
      position: relative;

      .icon{
        position: absolute;
        right: 0;
        bottom: 0;
        width: 13px;
        height: 13px;
        border-radius: 2px;
        background-color: #dedede;
        color: #999;
        display: flex;
        justify-content: center;
        align-items: center;
        font-size: 12px;
        cursor: pointer;
      }
    }

    /*用户评价弹出框*/
    .dialogCenter{
      text-align: left;
    }

    /*用户评价图片*/
    .images_box{
      display: flex;
      align-items: center;
      cursor: pointer;

      .images{
        width: 70px;
        height: 70px;
        display: flex;
        justify-content: center;
        align-items: center;
        img{
          width: 100%;
          height: 100%;
        }
      }
      .images:not(:last-child){
        margin-right: 10px;
      }
    }

    /*用户评分*/
    .rate{
      .el-rate__icon{
        margin-right: 0;
        font-size: 14px;
      }
    }


  }
</style>
