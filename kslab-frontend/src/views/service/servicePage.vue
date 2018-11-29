<template>
    <div class="Cont_cadiv">
      <activity-header @getHeaderParam="getHeaderParam"></activity-header>
      <div class="service_box_page_width">
        <!--服务title-->
         <div class="service_box_div">
            <div class="service_title_box_font">
               <img src="/static/img/icon/logo_hd4.gif" alt="">
               <span>服务 </span>
               <img src="/static/img/icon/service_font.png" alt="">
            </div>
            <div class="service_title_click">
              <div class="radios" :style="radioValue===1?{border:'1px solid #15bafe'}:{}" @click="handleRadio(1)">
                <p class="radio_s">咨询商家</p>
                <i class="icon icon-check-square-fill icon_gou" :style="radioValue===1?{display:'block'}:{display:'none'}"></i>
              </div>
              <div class="radios" :style="radioValue===2?{border:'1px solid #15bafe'}:{}" @click="handleRadio(2)">
                <p class="radio_s">固定价格</p>
                <i class="icon icon-check-square-fill icon_gou" :style="radioValue===2?{display:'block'}:{display:'none'}"></i>
              </div>
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
        <div class="mescroll_content" v-if="dataVisible">
         <!-- <mescroll-vue ref="mescroll" :down="mescrollDown" :up="mescrollUp" @init="mescrollInit">
          <div slot="empty" style="text-align:center">无任何数据</div>-->
          <div class="service_content">
            <div class="s_left">
              <div v-for="(item,index) in serviceData" :key="index">
                <div class="s_left_item" v-if="index%3===0"  @click="currentScreenWidth>1183?handleJumpToDetails(item.service_id):null">
                  <video ref="vio"
                         :id="'video'+index"
                         @timeupdate="updateTime"
                         @mouseenter="handleMouseEnter(index)"
                         @mousemove="handleMouseOver(index)"
                         @mouseleave="handleMouseOut(index)"
                         v-if="handleBoolean(item.video)"
                         muted
                         :poster="handleVideoSrc(item.video)+'?vframe/jpg/offset/2'"
                         class="video_s">
                    <source :src="handleVideoSrc(item.video)" />
                  </video>
                  <div class="vio_content" v-if="handleBoolean(item.video)">
                    <div v-if="currentVideoIndex ===index" class="video_progress_box">
                      <div class="video_progress" :style='"width:"+currentTime*(currentScreenWidth>1183?maxVideoWidth/5:minVideoWidth/5)+"px"'></div>
                    </div>
                  </div>
                  <img v-else class="image_s" :src="handleImg(item.images?JSON.parse(item.images)[0].path:'')">
                  <div class="item_bottom_service" @click="currentScreenWidth<=1183?handleJumpToDetails(item.service_id):null">
                    <p class="s_title">{{item.title}}</p>
                    <p class="s_remark">{{item.description}}</p>
                    <div class="rates">
                      <el-rate
                        v-bind:value="item.score/2"
                        disabled
                        :show-text="true"
                        :colors="['#15bafe','#15bafe','#15bafe']"
                        text-color="#15bafe"
                        :texts="[item.score,item.score,item.score,item.score,item.score]"
                        score-template="{value}">
                      </el-rate>
                      <p class="rmb">¥<span class="rmb_num">{{item.price}}</span></p>
                    </div>
                    <div class="dotted_line"></div>

                    <div class="s_bottom">
                      <div class="s_bottom_left">
                        <!--<img class="read_img" src="/static/img/icon/read.png">-->
                        <i class="icon icon-ziyuan37 icon_eye"></i>
                        <span class="visit_num">{{(item.view_num/1000).toFixed(2)}}K</span>
                      </div>
                      <p class="address">{{item.province_name}}</p>
                    </div>
                  </div>
                </div>
                <div class="key_word" v-if="index%3===0">
                  <p @click="handleJumpToKeyWords(item1)" v-for="(item1,index1) in (item.tagsname?item.tagsname.split(','):[])" :key="index1" class="key_words">{{item1}}</p>
                </div>
              </div>
            </div>
            <div class="s_center">
              <div v-for="(item,index) in serviceData" :key="index">
                <div class="s_left_item" v-if="index%3===1"  @click="currentScreenWidth>1183?handleJumpToDetails(item.service_id):null">
                  <video ref="vio"
                         :id="'video'+index"
                         @timeupdate="updateTime"
                         @mouseenter="handleMouseEnter(index)"
                         @mousemove="handleMouseOver(index)"
                         @mouseleave="handleMouseOut(index)"
                         v-if="handleBoolean(item.video)"
                         class="video_s"
                         muted
                         :poster="handleVideoSrc(item.video)+'?vframe/jpg/offset/2'"
                         :src="handleVideoSrc(item.video)"></video>
                  <div class="vio_content" v-if="handleBoolean(item.video)">
                    <div v-if="currentVideoIndex ===index" class="video_progress_box">
                      <div class="video_progress" :style='"width:"+currentTime*(currentScreenWidth>1183?maxVideoWidth/5:minVideoWidth/5)+"px"'></div>
                    </div>
                  </div>
                  <img v-else class="image_s" :src="handleImg(item.images&&JSON.parse(item.images)?JSON.parse(item.images)[0].path:'')">
                  <div>
                    <div class="item_bottom_service" @click="currentScreenWidth<=1183?handleJumpToDetails(item.service_id):null">
                      <p class="s_title">{{item.title}}</p>
                      <p class="s_remark">{{item.description}}</p>
                      <div class="rates">
                        <el-rate
                          v-bind:value="item.score/2"
                          disabled
                          :show-text="true"
                          :colors="['#15bafe','#15bafe','#15bafe']"
                          text-color="#15bafe"
                          :texts="[item.score,item.score,item.score,item.score,item.score]"
                          score-template="{value}">
                        </el-rate>
                        <p class="rmb">¥<span class="rmb_num">{{item.price}}</span></p>
                      </div>
                      <div class="dotted_line"></div>

                      <div class="s_bottom">
                        <div class="s_bottom_left">
                          <!--<img class="read_img" src="/static/img/icon/read.png">-->
                          <i class="icon icon-ziyuan37 icon_eye"></i>
                          <span class="visit_num">{{(item.view_num/1000).toFixed(2)}}K</span>
                        </div>
                        <p class="address">{{item.province_name}}</p>
                      </div>
                    </div>
                  </div>
                </div>
                <div class="key_word" v-if="index%3===1">
                  <p @click="handleJumpToKeyWords(item1)" v-for="(item1,index1) in (item.tagsname?item.tagsname.split(','):[])" :key="index1" class="key_words">{{item1}}</p>
                </div>
              </div>

            </div>
            <div class="s_right">
              <div  v-for="(item,index) in serviceData" :key="index">
                <div class="s_left_item" v-if="index%3===2" @click="currentScreenWidth>1183?handleJumpToDetails(item.service_id):null">
                  <video ref="vio"
                         :id="'video'+index"
                         @timeupdate="updateTime"
                         @mouseenter="handleMouseEnter(index)"
                         @mousemove="handleMouseOver(index)"
                         @mouseleave="handleMouseOut(index)"
                         v-if="handleBoolean(item.video)"
                         class="video_s"
                         muted
                         :poster="handleVideoSrc(item.video)+'?vframe/jpg/offset/2'"
                         :src="handleVideoSrc(item.video)"></video>
                  <div class="vio_content" v-if="handleBoolean(item.video)">
                    <div v-if="currentVideoIndex ===index" class="video_progress_box">
                      <div class="video_progress" :style='"width:"+currentTime*(currentScreenWidth>1183?maxVideoWidth/5:minVideoWidth/5)+"px"'></div>
                    </div>
                  </div>
                  <img v-else class="image_s" :src="handleImg(item.images&&JSON.parse(item.images)?JSON.parse(item.images)[0].path:'')">
                  <div>
                    <div class="item_bottom_service" @click="currentScreenWidth<=1183?handleJumpToDetails(item.service_id):null">
                      <p class="s_title">{{item.title}}</p>
                      <p class="s_remark">{{item.description}}</p>
                      <div class="rates">
                        <el-rate
                          v-bind:value="item.score/2"
                          disabled
                          :show-text="true"
                          :colors="['#15bafe','#15bafe','#15bafe']"
                          text-color="#15bafe"
                          :texts="[item.score,item.score,item.score,item.score,item.score]"
                          score-template="{value}">
                        </el-rate>
                        <p class="rmb">¥<span class="rmb_num">{{item.price}}</span></p>
                      </div>
                      <div class="dotted_line"></div>

                      <div class="s_bottom">
                        <div class="s_bottom_left">
                          <!--<img class="read_img" src="/static/img/icon/read.png">-->
                          <i class="icon icon-ziyuan37 icon_eye"></i>
                          <span class="visit_num">{{(item.view_num/1000).toFixed(2)}}K</span>
                        </div>
                        <p class="address">{{item.province_name}}</p>
                      </div>
                    </div>
                  </div>
                </div>
                <div class="key_word" v-if="index%3===2">
                  <p @click="handleJumpToKeyWords(item1)" v-for="(item1,index1) in (item.tagsname?item.tagsname.split(','):[])" :key="index1" class="key_words">{{item1}}</p>
                </div>
              </div>

            </div>
          </div>
          <!--</mescroll-vue>-->
        </div>
        <el-pagination
          v-if="dataVisible"
          style="text-align: center"
          background
          layout="prev, pager, next"
          @change="handlePage"
          :total="total">
        </el-pagination>
        <div class="no_service_find" v-if="!dataVisible">
          <div class="">
            <img src="/static/img/u4815.png" alt="">
          </div>
          <div class="">
            <p>抱歉！没有找到更多符合条件的相关信息</p>
            <p>您可以尝试更换相关条件</p>
          </div>
        </div>
      </div>
    </div>
</template>

<script>
import ServiceIndex from '@/components/serviceIndexInput'
import ServiceCar from '@/components/serviceCarData'
import ActivityHeader from '@/components/activityHeader'
/*import Scroll from '@/components/Scroll'*/
import MescrollVue from 'mescroll.js/mescroll.vue'
import {HttpClient} from "../../utils/HttpUtils";
import * as cfg from "../../../config/app";
const itemData = [];
for(let l=0;l<12;l++){
  itemData.push({
    id: l,
    img_url: '/static/img/baike_car.png',
    title: '云里雾里看成都-观致5带你嗨云里雾里看成都-观致5带你嗨云里雾里看成都-观致5带你嗨',
    description: '马立可（Meineke）认为汽车清洗分为普洗和精洗，普洗一般就是车外表清洗，车内吸尘、仪表仪盘简单擦拭。所谓汽车精洗，就是清洗的更为细致，整个一个流程从车主接待、外观清洗、内饰细致保洁保养、发动机外表清洗、轮毂保养、车尾箱保洁、目送客人离开。服务更为规范，从工人的动作手。',
    value: 3.4,
    price: 375,
    key_word:['新能源汽车','新能源汽车','新能源汽车'],
    visited_num: 5900,
    address: '重庆'
  })
}
//console.log(itemData)
export default {
    data(){
      return{
        rate:3.7,
        itemData:itemData,
        radioValue:null,
        sort:true,
        selectType:'',
        currentTime: 0,
        index: 13,
        currentVideoIndex: null,
        serviceData: [],
        currentScreenWidth: document.body.clientWidth,
        selectOption:[{
          value: 1,
          label: '评分'
        },{
          value: 2,
          label: '综合'
        },{
          value: 3,
          label: '上传时间'
        },{
          value: 4,
          label: '价格'
        }],
        mescroll: null,
        mescrollUp: {
          callback: this.upCallback
        },
        mescrollDown: {
          use: false,
          auto: false
        },
        provinceid: null,
        categoryid: null,
        search: null,
        order: null,
        price: null,
        pagsize: 15,
        page: 1,
        minVideoWidth: 290,
        maxVideoWidth: 368,
        total: null,
        dataVisible: false
      }
    },
    components:{
      ServiceIndex,
      ServiceCar,
      ActivityHeader,
      /*Scroll,*/
      MescrollVue
    },
    created() {
      const param = {
        page: this.page,
        pagsize: this.pagsize
      };
      this.getServiceList(param);
    },
    mounted() {
      const _this = this;
      window.onresize = function temp() {
        _this.currentScreenWidth = $(window).width();
        //console.log(_this.currentScreenWidth)
        this.currentScreenWidth = _this.currentScreenWidth;
      };
    },
    methods:{
      /***
       * 获取从header传过来的数据
       */
      getHeaderParam(param) {
        this.serviceData = [];
        console.log(param)
        this.provinceid = param.districtId?param.districtId:param.cityId;
        this.categoryid = param.serviceType;
        this.search = param.searchWord;
        const params = {
          provinceid: param.districtId?param.districtId:param.cityId,
          categoryid: param.serviceType,
          search: this.search,
          orderby: this.sort ? 'asc' : 'desc',
          price: this.price,
          order: this.order,
          page: 1,
          pagsize: this.pagsize
        };
        this.getServiceList(params);
      },
      handleRadio(id) {
        this.serviceData = [];
        this.radioValue = id;
        let price;
        if(id === 1){
          price = 0
        }else {
          price = null
        }
        this.price = price;
        const param = {
          orderby: this.sort ? 'asc' : 'desc',
          price: price,
          provinceid: this.provinceid,
          categoryid: this.categoryid,
          order: this.order,
          search: this.search,
          page: this.page,
          pagsize: this.pagsize
        };
        this.getServiceList(param);
      },
      //上拉加载
      /*mescrollInit (mescroll) {
        this.mescroll = mescroll
      },
      upCallback(page,mescroll) {
        //console.log(45554);
        const param = {
          orderby: this.sort ? 'asc' : 'desc',
          price: this.price,
          provinceid: this.provinceid,
          categoryid: this.categoryid,
          order: this.order,
          search: this.search,
          page: this.page + 1,
          pagsize: this.pagsize
        };
        console.log(2222)

        this.getServiceList(param,mescroll);
        console.log(1111)
        /!*this.serviceData = this.serviceData.concat(this.serviceData)
        // 数据渲染成功后,隐藏下拉刷新的状态
        this.$nextTick(() => {
          mescroll.endSuccess(this.serviceData.length)
        })*!/
      },*/
      /***
       * 获取服务业数据
       */
      getServiceList(param,mescroll) {
        console.log(param)
        HttpClient.post('/services/homeIndex',param).then(res =>{
          //console.log(res)
          if(res.data.code === 200) {
            this.page = param.page
            //this.serviceData = res.data.data;
            this.serviceData = res.data.data;
            this.total = res.data.count;
            this.dataVisible = true;
            // 数据渲染成功后,隐藏下拉刷新的状态
            /*this.$nextTick(() => {
              mescroll.endSuccess(this.serviceData.length)
            })*/
            console.log(3333)
          }else{
            //this.$message.error(res.data.msg);
            this.serviceData = [];
            this.orderby = 'desc';
            this.price = null;
            this.provinceid = null;
            this.categoryid = null;
            this.order = null;
            this.dataVisible = false;
          }
        })
      },
      /***
       * 跳转到服务详情页
       */
      handleJumpToDetails(id) {
        this.$router.push({
          path: '/home/service-detail',
          query: {
            id: id
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
      /***
       * 截取视屏5秒
       */
      handleVideoSrc(data) {
        const url = JSON.parse(data)[0].path;
        let index =url.indexOf('.');
        //console.log(index)
        let start = url.substring(0,index);
        let end = url.substring(index,url.length);
        //console.log(start,end,cfg.imageUrl+start+'_1_5'+end)
        return cfg.imageUrl+start+'_1_5'+end
      },
      /***
       * 判断是否有video
       * @param data
       */
      handleBoolean(data) {
        if(data!==null) {
          return JSON.parse(data).length > 0;
        }
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
        //console.log(this.currentTime)
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
       * 选择类型 1:评分 2：综合 3时间 4价格 排序，默认为时间
       * @param value
       */
      handleSelect(value) {
        this.serviceData = [];
        console.log(value)
        this.order = value;
        const param = {
          orderby: this.sort ? 'asc' : 'desc',
          price: this.price,
          provinceid: this.provinceid,
          categoryid: this.categoryid,
          order: value,
          search: this.search,
          page: this.page,
          pagsize: this.pagsize
        };
        this.getServiceList(param);
      },
      /****
       * 排序
       */
      handleSort() {
        this.serviceData = [];
        this.sort = !this.sort;
        const param = {
          orderby: this.sort ? 'asc' : 'desc',
          price: this.price,
          provinceid: this.provinceid,
          categoryid: this.categoryid,
          order: this.order,
          search: this.search,
          page: this.page,
          pagsize: this.pagsize
        };
        this.getServiceList(param);
      },
      /***
       * 翻页
       * @param value
       */
      handlePage(value) {
        this.page = value;
        const param = {
          orderby: this.sort ? 'asc' : 'desc',
          price: this.price,
          provinceid: this.provinceid,
          categoryid: this.categoryid,
          order: this.order,
          search: this.search,
          page: this.page,
          pagsize: this.pagsize
        };
        this.getServiceList(param)
      },
      /***
       * 跳转关键字
       * @param value
       */
      handleJumpToKeyWords(value) {
        this.$router.push({
          path: '/home/searchIndex',
          query: {
            keyword: value
          }
        })
      }
    }
}

</script>

<style scoped src="../../assets/css/servicePage.css"></style>
<style lang="less">
  .no_service_find>div>p{
    font-size:18px;
  }
  .no_service_find{
    display: flex;
    width: 100%;
    height: 500px;
    align-items: center;
    justify-content: center;
    color: #cccccc;
  }
  .item_bottom_service{
    cursor: pointer;
  }
.align_center{
  text-align: center;
  margin-top: 15px;
}
.service_uk_header>li:hover{
  color:#15befe;
  border:1px solid #15befe;
  cursor: pointer;
}
.service_color_sfont>span:nth-child(1){
  margin-right: 15px;
}
.service_color_sfont>span>span{
  margin-left: 3px;
  position: relative;
  top:-2px;
}
.service_color_sfont{
  color:#cccccc;
  margin-top: 17px;
}
.service_uk_header>li{
  color:#cccccc;
  border:1px solid #cccccc;
  padding: 2px 8px 2px 8px;
  border-radius: 3px;
  margin-right: 10px;
}
.service_uk_header{
  display: flex;
  margin-top: 12px;
}
.service_bottom_title{
  display: flex;
  justify-content: space-between;
}
.service_momy_font{
  font-size: 30px;
  color:#15befe;
}
.service_title_discv>div>.el-rate{
  position: relative;
  top:15px;
}
.service_title_discv>div>.el-rate>.el-rate__item>.el-rate__icon{
  font-size: 24px;
}
.service_title_discv{
  width: 100%;
  display: flex;
  justify-content: space-between;
  border-bottom: 1px solid #e5e5e5;
  padding-bottom: 5px;
}
.service_title_font{
  color:#666666;
  font-size: 14px;
  margin-top: 5px;
}
.service_title_name{
  font-size:21px;
  font-weight: 600;
  margin-top: 10px;
}
.service_odiv_font{
  width: 330px;
  margin: 0 auto;
}
.addbox>.service_img_car_div:nth-child(odd){
  width: 100%;
  height: 240px;
  overflow: hidden;
}
.addbox>.service_img_car_div:nth-child(even){
  width: 100%;
  height: 400px;
  overflow: hidden;
}
.addbox1{
  display: none;
}
.service_body_ul_odd>.addbox:nth-child(odd){
  height: 410px;
  margin-bottom: 15px;
}
.service_body_ul_odd>.addbox:nth-child(even){
  height: 560px;
  margin-bottom: 15px;
}
.service_body_ul_odd>.addbox:nth-child(even) .service_img_car_div{
  height: 390px;
}
.service_body_ul_odd>.addbox{
  border:1px solid #000;
  width: 95%;
  display: inline-block;
  cursor: pointer;
}
.service_body_ul_odd{
  width: 100%;
  column-count: 3;
  -webkit-column-count: 3;
  -moz-column-count: 3;
  column-gap: 20px;
  margin-top: 16px;
}
.service_title_click{
  font-size:14px;
  color:#999999;
}
.service_title_click>p{
  width: 115px;
  text-align:center;
  padding-top: 9px;
  cursor: pointer;
}
.service_title_box_font>img:nth-child(3){
  position: relative;
  top:3px;
}
.service_title_box_font{
  padding-left: 15px;
}
.service_title_box_font>img:nth-child(1){
  width: 20px;
  margin-right: 10px;
  position: relative;
  top:3px;
}
.service_title_click{
  display: flex;
  align-items: center;
  position: relative;
  bottom: -4px;
  .radios{
    display: flex;
    border: 1px solid #f2f2f2;
    position: relative;
    width: 88px;
    height: 26px;
    border-radius: 4px;
    margin-right: 10px;
    .icon_gou{
      color: #15bafe;
      position: relative;
      left: 11px;
      font-size: 14px;
      top: 7px;
    }
    .radio_s{
      padding-left: 15px;
      font-size: 12px;
      line-height: 24px;
    }
  }
 /* .radio_s{
    padding: 5px 15px;
    border-radius: 3px;
    border: 1px solid #f2f2f2;
  }
  .radio_ss{
    padding: 5px 15px;
    border-radius: 3px;
    border: 1px solid #15bafe;
  }*/
}
.service_title_box_font>span{
  font-size: 26px;
  font-weight: 800;
}
.service_box_page_width{
  /*width: 1200px;*/
  margin: 0 auto 30px auto;
  padding-bottom: 2px;
}
.service_box_div{
  display: flex;
  justify-content: space-between;
  border-bottom:1px solid #bbbbbb;
  padding-bottom: 5px;
}
.sort{
  cursor: pointer;
  margin: 0 10px;
}
.type{
  width: 100px;
}
  @media screen and (max-width:1200px){
    .service_box_div{
      display: flex;
      justify-content: space-between;
      border-bottom:1px solid #bbbbbb;
      padding-bottom: 5px;
      margin-left: 10px;
      margin-right: 10px;
      margin-bottom: 10px;
    }
    .service_content{
      display: flex;
      justify-content: space-between;
      margin: 0 10px !important;
      .s_left{
        width: 292px;
        margin-right: 25px;
        position: relative;
        .s_left_item{
          width: 100%;
          border: 1px solid #f2f2f2;
          margin-bottom: 20px;
          .vio_content{
            height: 5px;
            .video_progress_box{
              position:relative;
              bottom: 9px;
              width: 100%;
              height:5px;
              background:#999;
              .video_progress{
                height:5px;
                background:#15bafe;
              }
            }
          }

          .image_s{
            height: 278px;
            width: 100%;
          }
          .video_s{
            height: 278px;
            width: 100%;
            object-fit: fill;
          }
          .s_title{
            font-size: 14px;
            color: #404040;
            margin: 0 10px;
            width: 92%;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
          }
          .s_remark{
            font-size: 12px;
            color: #808080;
            margin-left: 10px;
            margin-right: 10px;
          }
          .rates{
            display: flex;
            justify-content: space-between;
            margin-right: 10px;
            align-items: center;
            margin-left: 10px;
            .rmb{
              color: #15bafe;
              font-size: 16px;
              font-weight: 400;
            }
            .rmb_num{
              font-size: 24px;
              font-weight: 600;
              margin-left: 5px;
            }
          }
          .dotted_line{
            border-bottom: 1px dotted #f2f2f2;
            margin: 0 10px;
          }

          .s_bottom{
            margin-top: 40px;
            display: flex;
            align-items: center;
            margin-left: 10px;
            margin-bottom: 10px;
            justify-content: space-between;
            .s_bottom_left{
              display: flex;
              align-items: center;
            }
            .read_img{
              width: 16px;
              height: 10px;
            }
            .icon_eye{
              font-size: 12px;
              color: #808080;
            }
            .visit_num{
              margin-left: 10px;
              color: #808080;
              font-size: 13px;
            }
            .address{
              color: #808080;
              margin-right: 10px;
            }
          }
        }
        .key_word{
          display: flex;
          margin-top: 10px;
          position: absolute;
          bottom: 78px;
          z-index: 22;
          .key_words{
            text-decoration: underline;
            margin-left: 10px;
            cursor: pointer;
            font-size: 12px;
          }
          .key_words:hover{
            text-decoration: underline;
            margin-left: 10px;
            cursor: pointer;
            color: #15bafe;
            font-size: 12px;
          }
        }
      }
      .s_center{
        width: 292px;
        margin-right: 25px;
        position: relative;
        .s_left_item{
          width: 100%;
          border: 1px solid #f2f2f2;
          margin-bottom: 20px;
          .vio_content{
            height: 5px;
            .video_progress_box{
              position:relative;
              bottom: 9px;
              width: 100%;
              height:5px;
              background:#999;
              .video_progress{
                height:5px;
                background:#15bafe;
              }
            }
          }
          .image_s{
            height: 278px;
            width: 100%;
          }
          .video_s{
            height: 278px;
            width: 100%;
            object-fit: fill;
          }
          .s_title{
            font-size: 14px;
            color: #404040;
            margin: 10px;
            width: 92%;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
          }
          .s_remark{
            font-size: 12px;
            color: #808080;
            margin-left: 10px;
            margin-right: 10px;
          }
          .rates{
            display: flex;
            justify-content: space-between;
            margin-right: 10px;
            align-items: center;
            margin-left: 10px;
            .rmb{
              color: #15bafe;
              font-size: 16px;
              font-weight: 400;
            }
            .rmb_num{
              font-size: 24px;
              font-weight: 600;
              margin-left: 5px;
            }
          }
          .dotted_line{
            border-bottom: 1px dotted #f2f2f2;
            margin: 0 10px;
          }

          .s_bottom{
            margin-top: 40px;
            display: flex;
            align-items: center;
            margin-left: 10px;
            margin-bottom: 10px;
            justify-content: space-between;
            .s_bottom_left{
              display: flex;
              align-items: center;
            }
            .read_img{
              width: 16px;
              height: 10px;
            }
            .icon_eye{
              font-size: 12px;
              color: #808080;
            }
            .visit_num{
              margin-left: 10px;
              color: #808080;
              font-size: 13px;
            }
            .address{
              color: #808080;
              margin-right: 10px;
            }
          }
          .key_word{
            display: flex;
            margin-top: 10px;
            position: absolute;
            bottom: 78px;
            z-index: 22;
            .key_words{
              text-decoration: underline;
              margin-left: 10px;
              cursor: pointer;
              font-size: 12px;
            }
            .key_words:hover{
              text-decoration: underline;
              margin-left: 10px;
              cursor: pointer;
              color: #15bafe;
              font-size: 12px;
            }
          }
        }

      }
      .s_right{
        width: 292px;
        position: relative;
        .s_left_item{
          width: 100%;
          border: 1px solid #f2f2f2;
          margin-bottom: 20px;
          .vio_content{
            height: 5px;
            .video_progress_box{
              position:relative;
              bottom: 9px;
              width: 100%;
              height:5px;
              background:#999;
              .video_progress{
                height:5px;
                background:#15bafe;
              }
            }
          }
          .image_s{
            height: 278px;
            width: 100%;
          }
          .video_s{
            height: 278px;
            width: 100%;
            object-fit: fill;
          }
          .s_title{
            font-size: 14px;
            color: #404040;
            margin: 10px;
            width: 92%;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
          }
          .s_remark{
            font-size: 12px;
            color: #808080;
            margin-left: 10px;
            margin-right: 10px;
          }
          .rates{
            display: flex;
            justify-content: space-between;
            margin-right: 10px;
            align-items: center;
            margin-left: 10px;
            .rmb{
              color: #15bafe;
              font-size: 16px;
              font-weight: 400;
            }
            .rmb_num{
              font-size: 24px;
              font-weight: 600;
              margin-left: 5px;
            }
          }
          .dotted_line{
            border-bottom: 1px dotted #f2f2f2;
            margin: 0 10px;
          }

          .s_bottom{
            display: flex;
            align-items: center;
            margin-left: 10px;
            margin-bottom: 10px;
            justify-content: space-between;
            margin-top: 40px;
            .s_bottom_left{
              display: flex;
              align-items: center;
            }
            .read_img{
              width: 16px;
              height: 10px;
            }
            .icon_eye{
              font-size: 12px;
              color: #808080;
            }
            .visit_num{
              margin-left: 10px;
              color: #808080;
              font-size: 13px;
            }
            .address{
              color: #808080;
              margin-right: 10px;
            }
          }
        }
        .key_word{
          display: flex;
          margin-top: 10px;
          position: absolute;
          bottom: 78px;
          z-index: 22;
          .key_words{
            text-decoration: underline;
            margin-left: 10px;
            cursor: pointer;
            font-size: 12px;
          }
          .key_words:hover{
            text-decoration: underline;
            margin-left: 10px;
            cursor: pointer;
            color: #15bafe;
            font-size: 12px;
          }
        }
      }
    }
    .mescroll_content{
      //height: calc(100vh - 408px);
      /*height: calc(100vh);*/
    }
  }
  @media screen and (min-width:1200px){
    .mescroll_content{
      /*height: calc(100vh - 300px);*/
    }
    .service_box_div{
      display: flex;
      justify-content: space-between;
      border-bottom:1px solid #bbbbbb;
      padding-bottom: 5px;
      width: 1200px;
      margin: 0 auto;
    }
    .service_content{
      display: flex;
      margin: 20px auto;
      width: 1200px;
      justify-content: space-between;
      position: relative;
      left: 3px;
      .s_left{
        width: 370px;
        margin-right: 25px;
        position: relative;
        .key_word{
          position: relative;
          bottom: 65px !important;
          cursor: pointer;
        }
        .key_words:hover{
          text-decoration: underline;
          color: #15bafe;
          font-size: 12px;
          bottom: 65px !important;
          cursor: pointer;
        }
        .s_left_item{
          width: 100%;
          border: 1px solid #f2f2f2;
          margin-bottom: 20px;
          .vio_content{
            height: 5px;
            .video_progress_box{
              position:relative;
              bottom: 9px;
              width: 100%;
              height:5px;
              background:#999;
              .video_progress{
                height:5px;
                background:#15bafe;
              }
            }
          }
          .image_s{
            height: 278px;
            width: 100%;
          }
          .video_s{
            height: 278px;
            width: 100%;
            object-fit: fill;
          }
          .s_title{
            font-size: 14px;
            color: #404040;
            margin: 10px;
            width: 92%;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
          }
          .s_remark{
            font-size: 12px;
            color: #808080;
            margin-left: 10px;
            margin-right: 10px;
          }
          .rates{
            display: flex;
            justify-content: space-between;
            margin-right: 10px;
            align-items: center;
            margin-left: 10px;
            .rmb{
              color: #15bafe;
              font-size: 16px;
              font-weight: 400;
            }
            .rmb_num{
              font-size: 24px;
              font-weight: 600;
              margin-left: 5px;
            }
          }
          .dotted_line{
            border-bottom: 1px dotted #f2f2f2;
            margin: 0 10px;
          }

          .s_bottom{
            display: flex;
            margin-top: 10px;
            align-items: center;
            margin-left: 10px;
            margin-bottom: 10px;
            justify-content: space-between;
            position: relative;
            top: 10px;
            height: 30px;
            .s_bottom_left{
              display: flex;
              align-items: center;
            }
            .read_img{
              width: 16px;
              height: 10px;
            }
            .icon_eye{
              font-size: 12px;
              color: #808080;
            }
            .visit_num{
              margin-left: 10px;
              color: #808080;
              font-size: 13px;
            }
            .address{
              color: #808080;
              margin-right: 10px;
            }
          }
        }
        .key_word{
          display: flex;
          margin-top: 10px;
          position: absolute;
          bottom: 78px;
          z-index: 22;
          .key_words{
            text-decoration: underline;
            margin-left: 10px;
            cursor: pointer;
            font-size: 12px;
          }
          .key_words:hover{
            text-decoration: underline;
            margin-left: 10px;
            cursor: pointer;
            color: #15bafe;
            font-size: 12px;
          }
        }
      }
      .s_center{
        width: 370px;
        margin-right: 25px;
        position: relative;
        .key_word{
          position: relative;
          bottom: 65px !important;
          margin-left: 10px;
          cursor: pointer;
        }
        .key_words:hover{
          text-decoration: underline;
          color: #15bafe;
          font-size: 12px;
          bottom: 65px !important;
          cursor: pointer;
        }
        .s_left_item{
          width: 100%;
          border: 1px solid #f2f2f2;
          margin-bottom: 20px;
          .vio_content{
            height: 5px;
            .video_progress_box{
              position:relative;
              bottom: 9px;
              width: 100%;
              height:5px;
              background:#999;
              .video_progress{
                height:5px;
                background:#15bafe;
              }
            }
          }
          .image_s{
            height: 278px;
            width: 100%;
          }
          .video_s{
            height: 278px;
            width: 100%;
            object-fit: fill;
          }
          .s_title{
            font-size: 14px;
            color: #404040;
            margin: 10px;
            width: 92%;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
          }
          .s_remark{
            font-size: 12px;
            color: #808080;
            margin-left: 10px;
            margin-right: 10px;
          }
          .rates{
            display: flex;
            justify-content: space-between;
            margin-right: 10px;
            align-items: center;
            margin-left: 10px;
            .rmb{
              color: #15bafe;
              font-size: 16px;
              font-weight: 400;
            }
            .rmb_num{
              font-size: 24px;
              font-weight: 600;
              margin-left: 5px;
            }
          }
          .dotted_line{
            border-bottom: 1px dotted #f2f2f2;
            margin: 0 10px;
          }
          .key_word{
            display: flex;
            margin-top: 10px;
            position: absolute;
            bottom: 78px;
            z-index: 22;
            .key_words{
              text-decoration: underline;
              margin-left: 10px;
              cursor: pointer;
              font-size: 12px;
            }
            .key_words:hover{
              text-decoration: underline;
              margin-left: 10px;
              cursor: pointer;
              color: #15bafe;
              font-size: 12px;
            }
          }
          .s_bottom{
            display: flex;
            align-items: center;
            margin-left: 10px;
            margin-top: 10px;
            margin-bottom: 10px;
            justify-content: space-between;
            position: relative;
            top: 10px;
            height: 30px;
            .s_bottom_left{
              display: flex;
              align-items: center;
            }
            .read_img{
              width: 16px;
              height: 10px;
            }
            .icon_eye{
              font-size: 12px;
              color: #808080;
            }
            .visit_num{
              margin-left: 10px;
              color: #808080;
              font-size: 13px;
            }
            .address{
              color: #808080;
              margin-right: 10px;
            }
          }
        }
      }
      .s_right{
        width: 370px;
        position: relative;
        .key_word{
          position: relative;
          bottom: 65px !important;
          margin-left: 10px;
          cursor: pointer;
        }
        .key_words:hover{
          text-decoration: underline;
          color: #15bafe;
          font-size: 12px;
          bottom: 65px !important;
          cursor: pointer;
        }
        .s_left_item{
          width: 100%;
          border: 1px solid #f2f2f2;
          margin-bottom: 20px;
          .vio_content{
            height: 5px;
            .video_progress_box{
              position:relative;
              bottom: 9px;
              width: 100%;
              height:5px;
              background:#999;
              .video_progress{
                height:5px;
                background:#15bafe;
              }
            }
          }
          .image_s{
            height: 278px;
            width: 100%;
          }
          .video_s{
            height: 278px;
            width: 100%;
            object-fit: fill;
          }
          .s_title{
            font-size: 14px;
            color: #404040;
            margin: 10px;
            width: 92%;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
          }
          .s_remark{
            font-size: 12px;
            color: #808080;
            margin-left: 10px;
            margin-right: 10px;
          }
          .rates{
            display: flex;
            justify-content: space-between;
            margin-right: 10px;
            align-items: center;
            margin-left: 10px;
            .rmb{
              color: #15bafe;
              font-size: 16px;
              font-weight: 400;
            }
            .rmb_num{
              font-size: 24px;
              font-weight: 600;
              margin-left: 5px;
            }
          }
          .dotted_line{
            border-bottom: 1px dotted #f2f2f2;
            margin: 0 10px;
          }
          .key_word{
            display: flex;
            margin-top: 10px;
            position: absolute;
            bottom: 78px;
            z-index: 22;
            .key_words{
              text-decoration: underline;
              margin-left: 10px;
              cursor: pointer;
              font-size: 12px;
            }
            .key_words:hover{
              text-decoration: underline;
              margin-left: 10px;
              cursor: pointer;
              color: #15bafe;
              font-size: 12px;
            }
          }
          .s_bottom{
            display: flex;
            align-items: center;
            margin-left: 10px;
            margin-top: 10px;
            margin-bottom: 10px;
            justify-content: space-between;
            position: relative;
            top: 10px;
            height: 30px;
            .s_bottom_left{
              display: flex;
              align-items: center;
            }
            .read_img{
              width: 16px;
              height: 10px;
            }
            .icon_eye{
              font-size: 12px;
              color: #808080;
            }
            .visit_num{
              margin-left: 10px;
              color: #808080;
              font-size: 13px;
            }
            .address{
              color: #808080;
              margin-right: 10px;
            }
          }
        }
      }
    }
  }
</style>
