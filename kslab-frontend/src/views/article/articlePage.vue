7<template lang="html">
    <div class="">

      <div class="article_index">
        <!--&lt;!&ndash;左侧边框&ndash;&gt;-->
        <!--<div class="left_float_box">-->
          <!--<div class="left_float_box_title">-->
            <!--<span></span>文章-->
          <!--</div>-->


        <!--轮播-->
        <div class="articleSwiper">
          <swiper :options="swiperOption">
            <swiper-slide v-for="(item ,index) in articleBanner" :key="index">

              <div class="articleSwiper_box" @click="RouterIndexArtic(index)">

                <div class="articleSwiper_img"><img :src="request.picUrl + item.banner_url" alt=""></div>

                <div class="articleSwiper_text">
                  <span>{{item.self_define_text_1}}</span><br />
                  <span>{{item.self_define_text_2}}</span><br />
                  <span>{{item.self_define_text_3}}</span>
                </div>


                <div class="articleSwiper_bottom">

                  <div class="articleSwiper_user">
                    <div class="articleSwiper_avatar"><img :src="request.picUrl  + item.avatar" alt=""></div>
                    <div class="articleSwiper_userName">{{item.nickname}}</div>
                  </div>

                  <div class="articleSwiper_title">
                    {{item.title}}
                  </div>

                </div>

                <div class="articleSwiper_background"></div>
              </div>

            </swiper-slide>
            <div class="swiper-pagination"  slot="pagination"></div>
          </swiper>
        </div>

        <!--<div class="article_carousel">-->
          <!--<el-carousel trigger="click" height="450px">-->
            <!--<el-carousel-item v-for="(articleBanner ,index) in article_banner" :key="index">-->
              <!--<div><img :src="bannerImgurl" alt=""></div>-->
            <!--</el-carousel-item>-->
          <!--</el-carousel>-->
        <!--</div>-->

        <div class="article_box_title">
          <div class="article_box_title_left">
            <div class="article_left_titleName">
              <span></span>
              文章
            </div>
            <div class="article_left_button">
              <button @click="checkedButtom"   v-for="(articleTypeIndex ,index) in articleType" :key="index" checked='0' :id="index">{{articleTypeIndex.name}}·</button>
            </div>
          </div>

          <div class="article_box_title_right">
            <i class="icon icon-ziyuan30"></i>

            <div class="article_title_select">
              <el-select v-model="value" placeholder="默认排序">
                <el-option
                  v-for="item in options"
                  :key="item.value"
                  :label="item.label"
                  :value="item.value">
                </el-option>
              </el-select>
            </div>
          </div>
        </div>

        <div class="article_box">
          <div @click="articleRouter(index)" class="article_box_list" v-for="(articleDataIndex ,index) in articleData" :key="index">
            <div class="article_box_list_img"><img :src="'http://cdn.kushualab.com/'+articleDataIndex.image_path" alt=""></div>

            <div class="article_box_list_title">{{articleDataIndex.title}}</div>

            <div class="article_box_list_text" v-html="articleDataIndex.profile"></div>

            <div class="article_box_list_bottom">
              <div class="article_box_list_bottom_icon">
                <p class="el-icon-view">{{articleDataIndex.view_num}}</p>
                <p><span><img src="/static/img/icon/yy.gif" alt=""></span>{{articleDataIndex.comment_num}}</p>
              </div>
              <div class="article_box_list_bottom_userName">
                <p>{{articleDataIndex.nickname}}</p>
                <p>{{articleDataIndex.created_at}}</p>
              </div>

            </div>

          </div>
        </div>
      </div>

      <FloatingDiv></FloatingDiv>
    </div>
</template>

<script>
import FloatingDiv from '@/components/floating'

import 'swiper/dist/css/swiper.css'    //swiper轮播
import { swiper, swiperSlide } from 'vue-awesome-swiper'


export default {
name: 'carrousel',
  data() {
    return {
      // 标题排序
      options: [{
        value: '选项1',
        label: '上传时间'
      }, {
        value: '选项2',
        label: '点赞次数'
      }, {
        value: '选项3',
        label: '讨论次数'
      }],
      value: '',

      length:'sdsd',
      articleType:[
        {
          name:"汽车"
        },
        {
          name:"摩托车"
        },
        {
          name:"无人机"
        },
        {
          name:"ITO"
        }
      ],
      articleData:'',      //文章主页数据
      article_banner:'',  //文章bannerLength
      bannerImg:'',        //文章Banner默认网址

      swiperOption: {
        pagination: {
          el: '.swiper-pagination',
        },
        observer:true,
        observeParents:true,
        autoplay: {
         delay: 7000,      //自动播放
         stopOnLastSlide: false,
         disableOnInteraction: true,
        },
      },
      articleBanner:null    //banner图数据
    }
  },
  created(){
    this.HttpClient.post('/article/banner',{})
    .then((res) => {
      this.articleBanner = res.data.data
      console.log(res.data.data)
    })
  },
  components: {
    FloatingDiv,
    swiper,
    swiperSlide,
  },
  computed: {
     bannerImgurl : function(){
       //当前url图片地址
       var IndexLength = this.article_banner.length - 1
       // console.log(IndexLength)
       return this.bannerImg + this.article_banner[IndexLength].banner_url
     }
  },
  methods:{
    RouterIndexArtic(index){
      console.log("12")
      this.$router.push({
        path:'/home/articleDetails',
        query:{
          name:this.articleBanner[index].source_id
        }
      })
    },
    checkedButtom(index){
      console.log(index.target.id)
      this.HttpClient.post('/article/list',{
        category_id:index.target.id
      })
      .then((res) => {
        this.articleData = res.data.data.data
        // console.log(this.articleData.image_path)
        console.log(this.articleData)
      })
      .catch(err=>{
        console.log(err)
      })
    },
    articleRouter(index){
      var routerIndex = Number(index)
      this.$router.push({
        path:'/home/articleDetails',
        query:{
          name:this.articleData[routerIndex].article_id
        }
      })
    }
  },
  beforeCreate(to, from, next){
    //根据左侧category_id 选择默认的中间内容
     this.HttpClient.post('/article/list',{
       category_id:0
     })
     .then((res) => {
       this.articleData = res.data.data.data
       console.log(this.articleData)
       var Vuethis = this
       function FunctionDate(type){
         console.log(type)
         for(var i=0;i<type.length;i++){
           type[i].label_name = Vuethis.filtration(type[i].label_name)
           type[i].created_at = Vuethis.DateTime(Vuethis.finalDate(type[i]))
         }
       }
       FunctionDate(this.articleData)
     })

    //获取banner图
    this.HttpClient.post('/article/banner',{})
    .then((res) => {
      this.article_banner = res.data.data  //banner length
      this.bannerImg = res.data.url
      // console.log(this.article_banner)
    })
  }
}
</script>



<style scoped src="../../assets/css/articlePage.css"></style>

<style>

  /*分页器*/
  .article_box_list_img>img{
    width: 100%;
  }
  .articleSwiper .swiper-pagination{
    text-align: right !important;
    padding-right: 20px;
  }
  .articleSwiper .swiper-pagination-bullet{
    background: #f2f2f2 !important;
    opacity: 1 !important;
  }
  .articleSwiper .swiper-pagination-bullet-active{
    background: #15bafe !important;
  }

  /*标题排序样式*/

  .article_box_title_right .el-input__inner{
    border: none;
  }
  .article_box_title_right .el-input__inner::placeholder{
    color: #333;
  }

@media screen and (max-width:1210px) {
  .articleSwiper{
    width: 100%;
    margin: 0 auto;
  }
  .article_box_title{
    width: 100%;
    margin: 0 auto;
    padding: 10px 30px !important;
  }
  .article_box{
    max-width: 1200px !important;
    min-width: 960px;
    margin: 0 auto !important;
    padding: 0 30px;
  }
  .article_box_list{
    width: 23.5% !important;
  }
  .article_box_list:not(:nth-child(4n)){
    margin-right: 2% !important;
  }
  .article_box_list_title{
    height: 25px !important;
  }
  .article_box_list_text{
    height: 45px !important;
  }
}
</style>
