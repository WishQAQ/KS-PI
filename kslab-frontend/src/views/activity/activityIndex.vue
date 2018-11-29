<template>
  <div class="activityIndex">
    <ActivityHeaderA @getHeaderParam="getHeaderParam"></ActivityHeaderA>


    <div class="activityIndex_main">
      <div class="activity_title">
        <div class="activity_title_left">
          <img src="/static/img/icon/logo_hd4.gif" alt="">
          <p>热门活动<span><i></i>activity</span></p>
        </div>
        <div class="activity_title_right">
          <i class="sort" @click="handleSort" :class="sort?'icon icon-ziyuan29': 'icon icon-ziyuan30'"></i>
          <el-select @change="handleSelect" class="type" size="mini" v-model="selectType" placeholder="类型">
            <el-option
              v-for="item in selectOption"
              :key="item.value"
              :label="item.label"
              :value="item.value">
            </el-option>
          </el-select>
        </div>
      </div>

      <div class="activity_main_banner" v-if="hotDataVisible">

        <el-carousel height="400px" arrow="always" :autoplay="false">

          <el-carousel-item v-for="(item, index) in popularData" :key="index">
            <div class="activity_main_banner_box">
              <div class="banner_box_img">
                <video
                  :id="'video'+index"
                  @timeupdate="updateTime"
                  @mouseenter="handleMouseEnter(index)"
                  @mousemove="handleMouseOver(index)"
                  @mouseleave="handleMouseOut(index)"
                  muted
                  v-if="item.video"
                  class="carousel_video"
                  :poster="handleVideoSrc(item.video)+'?vframe/jpg/offset/2'"
                  :src="handleVideoSrc(item.video)"
                >
                </video>
                <img v-else :src="handleImg(item.pic)" alt="">
              </div>

              <div class="banner_box_time">{{item.created_at?handleDateTime(item.created_at):''}}</div>

              <div>
                <div class="banner_box_text" @click="handleJumpToDetail(item.active_id)">

                  <div class="banner_box_text_time">发布时间：{{item.created_at?handleDate(item.created_at):''}}</div>
                  <div class="banner_box_text_title">{{item.title}}</div>
                  <div class="banner_box_text_center">
                    {{item.description}}
                  </div>
                  <div class="banner_box_text_bottom">
                    <div class="banner_box_text_bottom_money">
                      <el-rate
                        v-bind:value="item.score/2"
                        disabled
                        :show-text="true"
                        :colors="['#15bafe','#15bafe','#15bafe']"
                        text-color="#15bafe"
                        :texts="[item.score,item.score,item.score,item.score,item.score]"
                        score-template="{value}">
                      </el-rate>
                      <p><span>&yen;</span>{{item.price}}</p>
                    </div>


                  </div>
                </div>
                <div class="banner_box_text_bottom_tags">
                  <keywordInstall :keyword="item.tags"></keywordInstall>

                  <p>
                    <span><img src="/static/img/icon/usersta.png" alt="">{{item.enrollment}}</span>
                    <span><img src="/static/img/icon/aiye.png"/>{{item.view_num}}</span>
                  </p>
                </div>
              </div>


            </div>
          </el-carousel-item>
        </el-carousel>

      </div>

      <div class="activity_main_box" v-if="dataVisible">
        <actvity-div :SearchData="max" :activityData="activityData.length>0?activityData:popularData"></actvity-div>
      </div>
      <div class="no_activity_find" v-if="!hotDataVisible && !dataVisible">
        <div class="">
          <img src="/static/img/u4815.png" alt="">
        </div>
        <div class="">
          <p>抱歉！没有找到更多符合条件的相关信息</p>
          <p>您可以尝试更换相关条件</p>
        </div>
      </div>
    </div>
    <el-pagination
      background
      v-if="dataVisible"
      class="activity_pagination"
      layout="prev, pager, next"
      @current-change="handlePage"
      :page-size="page_size"
      :total="total">
    </el-pagination>
    <div id="allmap"></div>
  </div>
</template>

<script>
  import FloatingDiv from '@/components/floating'
  import ActivityHeaderA from '@/components/activityHeaderA'
  import ActvityDiv from '@/views/activity/actvityDataLi'
  import keywordInstall from '@/components/keywordInstall'
  import moment from 'moment'
  import * as cfg from "../../../config/app";


  export default {
    name: "activityIndex",
    components: {
      FloatingDiv,
      ActivityHeaderA,
      ActvityDiv,
      keywordInstall
    },
    data(){
      return{
        value5:4,
        max:"",
        sort: true,
        selectType: null,
        selectOption:[{
          value: 1,
          label: '评分'
        },{
          value: 2,
          label: '价格'
        },{
          value: 3,
          label: '上传时间'
        },{
          value: 4,
          label: '报名人数'
        }],
        activityData: [],
        page: 1,
        page_size: 15,
        district: null,
        category_id: null,
        active_date_type: null,
        keywords: '',
        order_by: null,
        total: null,
        popularData: [],
        dataVisible: false,
        hotDataVisible: false,
      };
    },
    async mounted() {

      const locationData = this.$store.state.getCurrentLocation.myLocation.province;
      console.log(locationData)
      const address = localStorage.getItem('address');
      if(address) {
        this.getCityIdByName(address);
      }else if(locationData !== '' || locationData !== null) {
        this.getCityIdByName(locationData);
      }else {
        const param = {
          page: this.page,
          page_size: this.page_size,
          sort: this.sort? 1 : 2,
        };
        this.getActivityList(param);
      }

      console.log(112)
      /*console.log(transCity)
      const param = {
        page: this.page,
        page_size: this.page_size,
        sort: this.sort? 1 : 2
      };
      this.getActivityList(param);*/


    },
    methods: {
      getCityIdByName(name) {
        this.HttpClient.get('/getCityLinkageId',{name: name}).then(res =>{
          console.log(res.data)
          if(res.data.code === 200) {

            const param = {
              page: this.page,
              page_size: this.page_size,
              sort: this.sort? 1 : 2,
              district: res.data.data.id
            };
            this.getActivityList(param);
          }else{
            const param = {
              page: this.page,
              page_size: this.page_size,
              sort: this.sort? 1 : 2,
            };
            this.getActivityList(param);
          }
        })
      },
      getHeaderParam(param) {
        this.district = param.cityId ? param.cityId : param.districtId;
        this.category_id = param.serviceType;
        this.active_date_type = param.radioTime;
        this.keywords = param.searchWord;
        const params = {
          district: this.district,
          category_id: this.category_id,
          active_date_type: this.active_date_type,
          keywords: this.keywords,
          order_by: this.order_by,
          sort: this.sort? 1 : 2,
          page: this.page,
          page_size: this.page_size
        };
        this.getActivityList(params);

      },
      handleSort() {
        this.sort = !this.sort;
        const params = {
          district: this.district,
          category_id: this.category_id,
          active_date_type: this.active_date_type,
          keywords: this.keywords,
          order_by: this.order_by,
          sort: this.sort? 1 : 2,
          page: this.page,
          page_size: this.page_size
        };
        this.getActivityList(params);
      },
      /***
       * 选择类型 1:评分 2：综合 3时间 4价格 排序，默认为时间
       * @param value
       */
      handleSelect(value) {
        console.log(value);
        this.order_by = value;
        const params = {
          district: this.district,
          category_id: this.category_id,
          active_date_type: this.active_date_type,
          keywords: this.keywords,
          order_by: this.order_by,
          sort: this.sort? 1 : 2,
          page: this.page,
          page_size: this.page_size
        };
        this.getActivityList(params);
      },
      /***
       * 获取活动主页列表
       * @param param
       */
      getActivityList(param) {
        this.HttpClient.get('/actives/list', param).then(res =>{
          console.log(res)
          if(res.data.code === 200) {
            this.activityData = res.data.data;
            if(this.activityData && this.activityData.length>0) {
              this.dataVisible = true;
            }
            this.total = res.data.total;
            this.popularData = res.data.popular;
            if(this.popularData && this.popularData.length>0) {
              this.hotDataVisible = true;
            }
          }else{
            //this.$message.error(res.data.msg)
            this.dataVisible = false;
            this.hotDataVisible = false;
          }
        })
      },
      /***
       * 截取视屏长度 5秒
       * @param data
       * @returns {string}
       */
      handleVideoSrc(data) {
        const start = data.split('.')[0];
        const end = data.split('.')[1];
        /*console.log(start,end)*/
        //console.log(start,end,cfg.imageUrl+start+'_1_5'+end)
        return cfg.imageUrl+start+'_1_5'+'.'+end
      },
      /**
       * 图片格式
       * @param url
       * @returns {string}
       */
      handleImg(url) {
        return cfg.imageUrl+url;
      },
      /***
       * 格式化时间获取月和日
       * @param str
       * @returns {string}
       */
      handleDateTime(str) {
        /*console.log(str)*/
        return moment(str).format('MM.DD');
      },
      /***
       * 格式化时间YYYY-MM-DD
       * @param str
       * @returns {string}
       */
      handleDate(str) {
        return moment(str).format('YYYY-MM-DD');
      },
      /***
       * 鼠标移入事件
       * @param index
       */
      handleMouseOver(index) {
        const vdo = document.getElementById("video"+index);
        this.currentVideoIndex = index;
        vdo.play();
      },
      /***
       * 鼠标移除事件
       * @param index
       */
      handleMouseOut(index) {
        /*console.log(11111111,index)*/
        const vdo = document.getElementById("video"+index);
        vdo.pause();
      },
      updateTime(e){//播放进度
        if(e.target.currentTime>=5){
          e.target.currentTime=0;
          e.target.pause();
          this.videoIndex=null;
          this.hotIndex=null;
        }
        this.currentTime=e.target.currentTime;
      },
      /***
       * 鼠标点击事件
       * @param index
       */
      handleMouseEnter(index) {
        const vdo = document.getElementById("video"+index);
        this.currentVideoIndex = index;
        vdo.play();
      },
      /***
       * 翻页
       * @param value
       */
      handlePage(value) {
        /*console.log(value)*/
        this.page_size = value;
        const params = {
          district: this.district,
          category_id: this.category_id,
          active_date_type: this.active_date_type,
          keywords: this.keywords,
          order_by: this.order_by,
          sort: this.sort? 1 : 2,
          page: this.page,
          page_size: this.page_size
        };
        this.getActivityList(params);
      },
      /***
       * 跳转到详情页面
       * @param id
       */
      handleJumpToDetail(id) {
        this.$router.push({
          path: '/home/activity-detail',
          query: {
            id: id
          }
        })
      }
    }
  }

</script>

<style scoped src="../../assets/css/activityIndex.css"></style>

<style>
  .no_activity_find>div>p{
    font-size:18px;
  }
  .no_activity_find{
    display: flex;
    width: 100%;
    height: 500px;
    align-items: center;
    justify-content: center;
    color: #cccccc;
  }
  .activity_pagination{
    text-align: center;
    margin-bottom: 10px;
  }
  /*tags*/
  .banner_box_text_bottom_tags li{
    margin-top: 0 !important;
  }

  /*按钮*/
  .activityIndex_main .el-carousel__arrow{
    top: 10% !important;
  }
  .activityIndex_main .el-carousel__arrow--left{
    left: 91% !important;
  }


  .activityIndex_main .el-carousel__arrow i{
    color: #15bafe;
  }
  .activityIndex_main .el-carousel__arrow:hover{
    background-color: #15bafe !important;
  }
  .activityIndex_main .el-carousel__arrow:hover i{
    color: #fff;
  }


  .activityIndex_main .el-carousel__indicators{
    display: none;
  }



  /*组件动画*/
  .activity_main_box .actviDataLi_box>li:nth-child(4n+0){
    margin-right: 0 !important;
  }

  .sort{
    cursor: pointer;
    margin: 0 10px;
    color: #808080;
  }
  .type{
    width: 100px;
  }
</style>

