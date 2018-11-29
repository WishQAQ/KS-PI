<template>
  <div class="appBackground">
    <CommercialHead></CommercialHead>


    <div class="merchantViewReviews">
      <div class="header_btm">
        <div class="header_back" @click="handleBack"><i class="el-icon-arrow-left"></i></div>
        <div class="header_title">{{title}}</div>
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
              <p class="content">{{scope.row.content.length>90?scope.row.content.slice(0,91):scope.row.content}}
              <i class="icon icon-down" @click="dialogCenter = true" v-if="scope.row.content.length>90"></i>
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
                  <swiper-slide v-for="(itemx, indexx) in scope.row.attachment" :key="indexx"><img :src="handleImg(itemx.path)+'?imageView2/1/w/534'" alt=""></swiper-slide>
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
          <!--分页器-->
          <div class="salesVolume_table_main_btm" v-if="totalPage">
              <el-pagination
                      layout="prev, pager, next"
                      :page-count="totalPage"
                      @current-change="ProductPageChange">
              </el-pagination>
          </div>

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
            // 名称
            title:this.$route.query.title,
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
          currentPage: 1,
          size: 10,
          totalPage: 0,
          commentData: []
        }
      },
      created() {
        this.id = this.$route.query.id;
        let type=this.$route.query.type;
        if(type==='service'){
            const param = {
                page: this.currentPage,
                size: this.size,
                source_id: this.id,
                token: window.localStorage.getItem('token')
            };
            this.getCommentData(param);
        }else if(type==='activity'){
            this.HttpClient.get('/actives/comments',
                {
                    active_id:this.id,
                    page:this.currentPage,
                    size:this.size
                }).then(res=>{
                console.log(res);
                let {code,data,total} = res.data;
                if(code===200){
                    this.commentData=data;
                    this.totalPage=Math.ceil(total/this.size);
                    let pic=[];
                    this.commentData.map(item=>{
                        item.attachment.map(item=>{
                            pic.push({path:item})
                        });
                        item.attachment=pic
                    })
                }
            })
        }else if(type==='product'){
            this.HttpClient.get('/products/comments',{product_id:this.id,page:this.currentPage})
                .then(res=>{
                    console.log(res);
                    let {code,data,page_num} = res.data;
                    if(code===200){
                        this.commentData=data;
                        this.totalPage=page_num;
                        let pic=[];
                        this.commentData.map(item=>{
                            item.attachment.map(item=>{
                               pic.push({path:item})
                            });
                            item.attachment=pic
                        })
                    }
                })
        }
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
          this.HttpClient.post('/services/getAnswer', param).then(res =>{
            console.log(res.data);
            if(res.data.code === 200) {
              this.commentData = res.data.data.data;
              this.totalPage=Math.ceil(res.data.data.total/this.size);
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
        },

        ProductPageChange(p){
            this.currentPage=p;
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

    .salesVolume_table_main_btm {
        text-align: center;
        margin: 20px 0;
    }

  }
</style>
