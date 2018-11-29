<template>
    <div class="">
      <div class="market_type" v-if="currentScreenWidth>1620">
        <ul>
          <li @click="handleSelectMachine(item.menu_id,item.color)" :style="currentTypeId===item.menu_id?{background:item.color,borderRight:'5px solid '+item.color,color:'#ffffff'}:{background:'#ffffff',borderRight:'5px solid '+item.color}" v-for="(item, index) in category" :key="index">
            <span>{{item.name}}</span>
          </li>
          <li @click="handleSelectMachine(10000)" :style="currentTypeId===10000?{background:'#f2f2f2',borderRight:'5px solid #f2f2f2',color:'#ffffff'}:{background:'#ffffff',borderRight:'5px solid #f2f2f2'}"><span>全部</span></li>
        </ul>
      </div>
      <section class="Tao_section_body">
        <div class="tao_title_Cont">
          <div class="tao_title_left">
            <div class="title_Price CssXz_m">
              <el-select v-model="value6" placeholder="请选择" @change="handleSelectMachine">
                <el-option
                  v-for="item in category"
                  :key="item.menu_id"
                  :label="item.name"
                  :value="item.menu_id">
                  <span style="float: left" :style="{background: item.color}" class="all_color"></span>
                  <span style="float: left">{{ item.name }}</span>
                </el-option>
                <el-option
                  :key="10000"
                  label="全部"
                  value="全部">
                  <span style="float: left;background: #f2f2f2" class="all_color"></span>
                  <span style="float: left">全部</span>
                </el-option>
              </el-select>
            </div>
            <div class="title_Price title_Location" @click="cityVisible = !cityVisible">
              <img class="Magtin_left" src="/static/img/icon/T_dw.png" alt="">
              <!--定位名称-->
              <span class="Location_name">{{currentCityName}}</span>
              <img class="bottom_logo" src="/static/img/icon/T_bottom.png" alt="">
            </div>
            <div class="tao_cities" :style="cityVisible ? {}:{display:'none'}">
              <el-tabs v-model="activeName" @tab-click="handleClick">
                <el-tab-pane label="全部" name="cityAll">
                  <ul>
                    <li :class="0===currentCityId?'active_color':'normal_color'" @click="districtShowBtn(0, '全部')">全部</li>
                  </ul>
                </el-tab-pane>
                <el-tab-pane label="热门城市" name="cityHot">
                  <ul>
                    <li :class="item.city===currentCityId?'active_color':'normal_color'" @click="districtShowBtn(item.city, item.name)" v-for="(item, index) in hotCities" :key="index">{{item.name}}</li>
                  </ul>
                </el-tab-pane>
                <el-tab-pane label="ABCDEFG" name="ABCDEFG">
                  <div class="districtNmb"
                       v-for="(item, index) in ['A','B','C','D','E','F','G']" :key="index">
                    <p v-if="allCities.ABCDEFG&&allCities.ABCDEFG[item]&&allCities.ABCDEFG[item].length>0">{{item}}</p>
                    <ul v-if="allCities.ABCDEFG&&allCities.ABCDEFG[item]&&allCities.ABCDEFG[item].length>0">
                      <li :class="items.id===currentCityId?'active_color':'normal_color'" @click="districtShowBtn(items.id, items.name)" v-for="(items, indexs) in allCities.ABCDEFG[item]" :key="indexs">{{items.name}}</li>
                    </ul>
                  </div>
                </el-tab-pane>
                <el-tab-pane label="HIJKL" name="HIJKL">
                  <div class="districtNmb"
                       v-for="(item, index) in ['H','I','J','K','L']" :key="index">
                    <p v-if="allCities.HIJKL&&allCities.HIJKL[item]&&allCities.HIJKL[item].length>0">{{item}}</p>
                    <ul v-if="allCities.HIJKL&&allCities.HIJKL[item]&&allCities.HIJKL[item].length>0">
                      <li :class="items.id===currentCityId?'active_color':'normal_color'" @click="districtShowBtn(items.id, items.name)" v-for="(items, indexs) in allCities.HIJKL[item]" :key="indexs">{{items.name}}</li>
                    </ul>
                  </div>
                </el-tab-pane>
                <el-tab-pane label="MNOPQRST" name="MNOPQRST">
                  <div class="districtNmb"
                       v-for="(item, index) in ['M','N','O','P','Q','R','S','T']" :key="index">
                    <p v-if="allCities.MNOPQRST&&allCities.MNOPQRST[item]&&allCities.MNOPQRST[item].length>0">{{item}}</p>
                    <ul v-if="allCities.MNOPQRST&&allCities.MNOPQRST[item]&&allCities.MNOPQRST[item].length>0">
                      <li :class="items.id===currentCityId?'active_color':'normal_color'" @click="districtShowBtn(items.id, items.name)" v-for="(items, indexs) in allCities.MNOPQRST[item]" :key="indexs">{{items.name}}</li>
                    </ul>
                  </div>
                </el-tab-pane>
                <el-tab-pane label="WXYZ" name="WXYZ">
                  <div class="districtNmb"
                       v-for="(item, index) in ['W','X','Y','Z']" :key="index">
                    <p v-if="allCities.WXYZ&&allCities.WXYZ[item]&&allCities.WXYZ[item].length>0">{{item}}</p>
                    <ul v-if="allCities.WXYZ&&allCities.WXYZ[item]&&allCities.WXYZ[item].length>0">
                      <li :class="items.id===currentCityId?'active_color':'normal_color'" @click="districtShowBtn(items.id, items.name)" v-for="(items, indexs) in allCities.WXYZ[item]" :key="indexs">{{items.name}}</li>
                    </ul>
                  </div>
                </el-tab-pane>
              </el-tabs>
            </div>
            <div class="search">
              <el-input
                placeholder="请输入搜索标题"
                v-model="search">
                <i slot="prefix" @click="handleSearch" class="el-input__icon el-icon-search search_icon"></i>
              </el-input>
            </div>
            <div class="float"></div>
          </div>
          <div class="tao_title_right">
            <i class="icon_sort" @click="handleSelectSort" :class="sort?'icon icon-ziyuan29': 'icon icon-ziyuan30'"></i>
            <el-select class="order_select" @change="handleSelectOrder" v-model="order" placeholder="默认排序">
              <el-option
                v-for="item in orderOptions"
                :key="item.value"
                :label="item.label"
                :value="item.value">
              </el-option>
            </el-select>
          </div>
        </div>
        <div class="body_section">
          <ul>
            <li v-for="(item ,index) in marketData" class="tao_item" :key="index" :style="widthScreen<1400?index%4===3?{marginRight:'0',borderTop: '5px solid '+handleFindColorById(item.category_id)}:{borderTop: '5px solid '+handleFindColorById(item.category_id)}:index%5===4?{marginRight:'0',borderTop: '5px solid '+handleFindColorById(item.category_id)}:{borderTop: '5px solid '+handleFindColorById(item.category_id)}">
              <div class="tao_item_s" @click="currentScreenWidth>1183?handleJumpToDetail(item.asin,index):null">
                <div class="tao_cont" style="cursor: pointer" @click="currentScreenWidth<=1183?handleJumpToDetail(item.asin,index):null">
                  <div class="tao_logo" :style="{border: '2px solid '+handleFindColorById(item.category_id)}">
                    <img :src="handleImg(item.avatar)" alt="">
                  </div>
                  <div  class="tao_logo_right">
                    <p>{{item.nickname}}</p>
                    <el-rate
                      class="tao_rate"
                      v-bind:value="item.score/2"
                      disabled
                      :colors="[handleFindColorById(item.category_id),handleFindColorById(item.category_id),handleFindColorById(item.category_id)]">
                    </el-rate>
                  </div>
                  <div class="float"></div>
                </div>
                <div class="tao_img_title">
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
                  <img v-else src="/static/img/bacv_35.gif" alt="">
                  <div class="vio_content" v-if="handleBoolean(item.video)">
                    <div v-if="currentVideoIndex ===index" class="video_progress_box">
                      <div class="video_progress" :style='"width:"+currentTime*(currentScreenWidth>1183?51:42.4)+"px"'></div>
                    </div>
                  </div>

                </div>
                <div style="cursor: pointer" @click="currentScreenWidth<1183?handleJumpToDetail(item.asin,index):null">
                  <div class="price_title_local">
                     <span class="blue_font">￥{{item.price}}</span>
                    <span class="price_title_address">{{item.city}}</span>
                  </div>
                  <p class="name_market" :style="{color: handleFindColorById(item.category_id)}">{{item.title}}</p>
                  <p class="remark_market">
                    {{item.description}}
                  </p>
                  <!--<key-word :keyword="['摩托车','精品教学','精品教学']"></key-word>-->
                  <p class="tao_before_time">{{handleDate('2018-10-18 9:00:00')}}之前</p>
                </div>
              </div>
              <div class="tao_signature" :style="{color: handleFindColorById(item.category_id)}">
                <p class="signature_item" @click="handleJumpToKeyWords(items)"  v-for="(items ,index) in item.tagsname?item.tagsname.split(','):[]" :key="index">{{items}}</p>
              </div>
            </li>
          </ul>
          <div class="no_market_find" v-if="!dataVisible">
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
          v-if="dataVisible"
          background
          class="tao_pagination"
          layout="prev, pager, next"
          @current-change="handlePage"
          :page-size="pageSize"
          :total="total">
        </el-pagination>
      </section>
    </div>
</template>

<script>
import '@/assets/js/Naughty.js'
import KeyWord from '@/components/keywordInstall'
import FormatDate from "../../utils/GetDateUtils";
import * as cfg from "../../../config/app";
// import { inCity } from  '@/assets/js/cityTemplate.js'

export default {
    data(){
        return{
            currentColors: '',
            currentTypeId: 10000,
            currentCityName: '重庆',
            cityVisible: false,
            currentCityId: null,
            allCities: {},
            hotCities: [],
            activeName: 'cityAll', //城市tab选项卡
            value2:3,
            sort: true,
            order: null, //1:评分 2：价格 排序
            signature: ['摩托车','精品教学','精品教学'],
            rateColor: [['#15BAFE','#15BAFE','#15BAFE'],['#F55959','#F55959','#F55959'],['#22AC38','#22AC38','#22AC38']],
            orderOptions: [{
              value: 1,
              label: '评分'
            },{
              value: 2,
              label: '价格'
            }],
          category:[],
          value6: '',
          widthScreen: document.documentElement.clientWidth,
          page: 1,
          pageSize: 15,
          provinceid: null, // 城市ID
          orderby: null, // desc（倒序）或者asc（升序）
          categoryid: null, // 分类ID
          search: '', // 搜索标题
          total: null,
          marketData: [],
          colors: ['option_blue','option_grenn','option_orgin','option_forgive','option_red','option_conthui'],
          currentVideoIndex: null,
          currentTime: 0,
          currentScreenWidth: document.body.clientWidth,
          dataVisible: false, //控制未发现数据页面
        }
    },
    components:{
      KeyWord
    },
    mounted(){
      const _this = this;
      window.onresize = function temp() {
        _this.currentScreenWidth = $(window).width();
        //console.log(_this.currentScreenWidth)
        this.currentScreenWidth = _this.currentScreenWidth;
      };
      this.getProvince();
      const addressId = localStorage.getItem('addressId');
      const address = localStorage.getItem('address');
      let param;
      if(addressId && address) {
        this.provinceid = addressId;
        this.currentCityName = address;
        console.log(addressId,address)
        param = {
          page: this.page,
          provinceid: this.provinceid,
          passize: this.pageSize,
          order: this.order,
          orderby: this.sort ? 'desc' : 'asc',
          categoryid: this.categoryid,
          search: this.search
        };
      }else {
        this.currentCityName = '所有城市';
        param = {
          page: this.page,
          provinceid: this.provinceid,
          passize: this.pageSize,
          order: this.order,
          orderby: this.sort ? 'desc' : 'asc',
          categoryid: this.categoryid,
          search: this.search
        };
      }

      this.getMarketData(param);
      this.getCategories();
    },
    methods:{
      handleClick(tab, event) {
      },
      handleJumpToDetail(id,index){
        this.$router.push({
          path:'/home/market-detail',
          query: {
            id: id,
            label:this.marketData[index].tagsname
          }
        })
      },
      /***
       * 格式化时间
       * @param date
       * @returns {string|*}
       */
      handleDate(date) {
        return FormatDate.GetDate(date);
      },
      // 选择城市按钮
      cityShowBtn(){
        if(this.cityShow == false)  // 如果城市选择框为false时
        {
          this.cityShow = true; // 显示城市选择框
          this.districtShow=false;  // 隐藏区县选择框
          this.districtActive=false;  // 隐藏区县Active
        }else{
          this.cityShow = false; //否则隐藏城市选择框
        }
      },
      // 选择城市
      districtShowBtn(cityId, cityName){
        this.cityShow=false;
        console.log(cityId)
        this.currentCityId = cityId;
        this.currentCityName = cityName;
        this.cityVisible = false;
        this.provinceid = cityId===0?'':cityId;
        const param = {
          page: this.page,
          provinceid: this.provinceid,
          passize: this.pageSize,
          order: this.order,
          orderby: this.sort ? 'desc' : 'asc',
          categoryid: this.categoryid,
          search: this.search
        };
        this.getMarketData(param);
      },
      /***
       * 获取省市名称
       */
      getProvince() {
        this.HttpClient.get('/goods/homeCity').then(res => {
          console.log(res)
          if(res.data.code === 200) {
            this.hotCities = res.data.hotCities;
            this.allCities = res.data.allCities;
          }

        })
      },
      /***
       *
       * 获取区县
       * @param cityName
       */
      getDistrict(cityId) {
        this.HttpClient.post('/services/homePidDistrict',{pid:cityId}).then(res =>{
          console.log(res);
          if(res.data.code === 200){
            this.district = res.data.data;
          }
        })
      },
      /***
       * 获取淘货首页数据
       * @param param
       */
      getMarketData(param) {
        this.HttpClient.post('/goods/homeIndex', param).then(res =>{
          console.log(res.data)
          if(res.data.code === 200) {
            this.marketData = res.data.data;
            this.total = res.data.sum;
            this.dataVisible = true;
            if(res.data.data.length<1) {
              console.log(54454545)
              this.currentCityName = '所有城市';
              const param = {
                page: this.page,
                provinceid: null,
                passize: this.pageSize,
                order: this.order,
                orderby: this.sort ? 'desc' : 'asc',
                categoryid: this.categoryid,
                search: this.search
              };
              this.getMarketData(param);
            }
            console.log(this.total)
          }else{
            this.marketData = [];
            this.dataVisible = false;
            //this.$message.error(res.data.msg)
          }
        })
      },
      /***
       * 格式化图片
       * @param url
       * @returns {*}
       */
      handleImg(url) {
        return cfg.imageUrl+url;
      },
      /***
       * 截取视屏5秒
       */
      handleVideoSrc(data) {
        const url = data[0].path;
        let index =url.indexOf('.');
        //console.log(index)
        let start = url.substring(0,index);
        let end = url.substring(index,url.length);
        //console.log(start,end,cfg.imageUrl+start+'_1_5'+end)
        return cfg.imageUrl+start+'_1_5'+end
      },
      /***
       * 选择商品类型
       * @param value
       */
      handleSelectMachine(value,color) {
        console.log(value)
        this.currentColors = color;
        this.currentTypeId = value;
        this.categoryid = parseInt(value)===10000 || value === '全部'?'':value;
        const param = {
          page: this.page,
          provinceid: this.provinceid,
          passize: this.pageSize,
          order: this.order,
          orderby: this.sort ? 'desc' : 'asc',
          categoryid: this.categoryid,
          search: this.search
        };
        this.getMarketData(param);
      },
      /***
       * 获取淘货类型
       */
      getCategories() {
        this.HttpClient.get('/goods/homeCategory').then(res =>{
          console.log(res)
          if(res.data.code === 200) {
            this.category = res.data.data;
          }
        })
      },
      /**
       * 获取0-5之间的随机数
       * @param num
       * @returns {number}
       */
      getRandom(num) {
        return (Math.floor(Math.random()*num));
      },
      /***
       * 关键词搜索
       */
      handleSearch() {
        const param = {
          page: this.page,
          provinceid: this.provinceid,
          passize: this.pageSize,
          order: this.order,
          orderby: this.sort ? 'desc' : 'asc',
          categoryid: this.categoryid,
          search: this.search
        };
        this.getMarketData(param);
      },
      /***
       * 翻页
       * @param value
       */
      handlePage(value) {
        this.page = value;
        const param = {
          page: this.page,
          provinceid: this.provinceid,
          passize: this.pageSize,
          order: this.order,
          orderby: this.sort ? 'desc' : 'asc',
          categoryid: this.categoryid,
          search: this.search
        };
        this.getMarketData(param);
      },
      /***
       * 判断是否有video
       * @param data
       */
      handleBoolean(data) {
        if(data !== null) {
          return data.length > 0;
        }else{
          return false;
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
       * 根据类型id查找颜色
       * @param value
       * @returns {*}
       */
      handleFindColorById(value) {
        //console.log(Object.values(this.category))
        //console.log(value)
        const options = Object.values(this.category).find(function (obj) {
          return obj.menu_id === value
        });
        //console.log(options.color)
        return options.color;
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
      },
      /****
       * 排序
       */
      handleSelectSort() {
        this.sort = !this.sort;
        const param = {
          page: this.page,
          provinceid: this.provinceid,
          passize: this.pageSize,
          order: this.order,
          orderby: this.sort ? 'desc' : 'asc',
          categoryid: this.categoryid,
          search: this.search
        };
        this.getMarketData(param);
      },
      /***
       * 按评分和价格排序
       * @param value
       */
      handleSelectOrder(value) {
        this.order  = value;
        const param = {
          page: this.page,
          provinceid: this.provinceid,
          passize: this.pageSize,
          order: this.order,
          orderby: this.sort ? 'desc' : 'asc',
          categoryid: this.categoryid,
          search: this.search
        };
        this.getMarketData(param);
      }
    }
}

</script>

<style lang="less">
  .no_market_find>div>p{
    font-size:18px;
  }
  .no_market_find{
    display: flex;
    width: 100%;
    height: 500px;
    align-items: center;
    justify-content: center;
    color: #cccccc;
  }
  .tao_signature{
    display: flex;
    margin: 0 10px;
    position: relative;
    top: -20px;
    .signature_item{
      font-size: 13px;
      text-decoration: underline;
      margin-right: 10px;
      cursor: pointer;
    }
    .signature_item:hover{
      font-size: 13px;
      text-decoration: underline;
      color: #15bafe;
      margin-right: 10px;
      cursor: pointer;
    }
  }
  .all_color{
    width: 10px;
    height: 10px;
    display:block;
    border-radius: 50px;
    margin-top: 10px;
    margin-right: 10px;
  }
  .market_type{
    width: 80px;
    position: absolute;
    top: 156px;
    left: 20px;
    ul{
      li{
        width: 80px;
        height: 40px;
        line-height: 40px;
        cursor: pointer;
        text-align: center;
        background: white;
        font-size: 14px;
        font-weight: 600;
      }
    }
  }
  .active_color{
    color: #15bafe;
  }
  .normal_color{

  }
  @media screen and (max-width: 1400px) {
    .Tao_section_body {
      margin: 30px auto;
      .tao_title_Cont{
        display: flex;
        width: 930px;
        margin: 0 auto;
        justify-content: space-between;
        .tao_title_left{
          display: flex;
          position: relative;
          .search{
            margin-left: 10px;
            width: 250px;
            .search_icon{
              cursor: pointer;
            }
          }
        }
        .tao_title_right{
          display: flex;
          .icon_sort{
            line-height: 40px;
            margin-right: 10px;
          }
          .order_select{
            width: 100px;
            padding: 0;
          }
        }
      }
      .body_section{
        width: 930px;
        margin: 20px auto;
        ul{
          display: flex;
          flex-wrap: wrap;
          .tao_item{
            width: 227px;
            margin-right: 7px;
            border-top: 5px solid;
            margin-bottom: 12px;
            box-shadow: 1px 1px 6px rgba(0,0,0,0.1);
            .tao_item_s{
              padding-top: 5px;
              .tao_cont{
                display: flex;
                .tao_logo{
                  width: 27px;
                  height: 27px;
                  float: left;
                  margin-right: 10px;
                  border-radius: 5px;
                  margin-left: 8px;
                  img{
                    width: 100%;
                    height: 100%;
                  }
                }
              }
              .tao_logo_right{
                p{

                }
                .tao_rate{
                  margin-top: -4px;
                  .el-rate__icon{
                    font-size: 12px;
                    margin-right: 2px;
                  }
                }
              }
              .tao_img_title{
                width: 100%;
                height: 144px;
                margin-top: 10px;
                text-align: center;
                .vio_content{
                  height: 5px;
                  .video_progress_box{
                    position:relative;
                    bottom: 9px;
                    width: 210px;
                    height:5px;
                    background:#999;
                    margin: 0 auto;
                    .video_progress{
                      height:5px;
                      background:#15bafe;
                    }
                  }
                }
                img{
                  width: 210px;
                  height: 100%;
                  margin: 0 auto;
                }
                video{
                  width: 210px;
                  height: 100%;
                  object-fit: fill;
                  margin: 0 auto;
                }
              }
              .price_title_local{
                display: flex;
                justify-content: space-between;
                margin: 0 10px;
                border-bottom: 1px solid #f2f2f2;
                padding-bottom: 5px;
                padding-top: 3px;
                .blue_font{
                  font-size: 18px;
                }
                .price_title_address{
                  font-size: 12px;
                  color: #7d7d7d;
                  line-height: 23px;
                  align-self: flex-end;
                }
              }
              .name_market{
                font-size: 13px;
                margin-top: 5px;
                margin-left: 10px;
                color: #222222;
                text-overflow: ellipsis;
                overflow: hidden;
                white-space: nowrap;
              }
              .remark_market{
                margin: 10px;
                margin-bottom: 4px;
                height: 55px;
                color: #808080;
                overflow: hidden;
                text-overflow: ellipsis;
                display: -webkit-box;
                -webkit-line-clamp: 3;
                line-clamp: 3;
                -webkit-box-orient: vertical;
              }
              .tao_signature{
                display: flex;
                margin: 5px 10px;
                .signature_item{
                  font-size: 13px;
                  text-decoration: underline;
                  margin-right: 10px;
                  cursor: pointer;
                }
                .signature_item:hover{
                  font-size: 13px;
                  text-decoration: underline;
                  color: #15bafe;
                  margin-right: 10px;
                  cursor: pointer;
                }
              }
              .tao_before_time{
                font-size: 12px;
                color: #cccccc;
                margin-left: 10px;
                position: relative;
                top: 18px;
              }
            }
          }
          .item_1{
            border-top: 5px solid #15BAFE;
          }
          .item_2{
            border-top: 5px solid #F55959;
          }
          .item_3{
            border-top: 5px solid #22AC38;
          }
          .item_4{
            border-top: 5px solid #15BAFE;
          }
          .border_item_1{
            border: 2px solid #15BAFE;
          }
          .border_item_2{
            border: 2px solid #F55959;
          }
          .border_item_3{
            border: 2px solid #22AC38;
          }
          .border_item_4{
            border: 2px solid #15BAFE;
          }
          .color_1{
            color: #15BAFE;
          }
          .color_2{
            color: #F55959;
          }
          .color_3{
            color: #22AC38;
          }
        }
      }
      .tao_pagination{
        text-align: center;
      }
    }
    .tao_cities {
      padding: 0 10px;
      border: 1px solid #808080;
      min-height: 40px;
      position: absolute;
      top: 50px;
      z-index: 1000;
      left: 122px;
      background: white;
      .el-tabs__content{
        margin-top: -8px !important;
        padding-bottom: 10px !important;
      }
      .districtNmb{
        display: flex;
        flex-wrap: wrap;
        p{
          margin-right: 10px;
        }
        ul{
          display: flex;
          flex-wrap: wrap;
          li{
            margin-right: 10px;
            cursor: pointer;
          }
        }
      }
      ul{
        display: flex;
        flex-wrap: wrap;
        li{
          margin-right: 10px;
          cursor: pointer;
        }
      }
    }
  }

  @media screen and (min-width: 1400px){
    .tao_cities {
      padding: 0 10px;
      border: 1px solid #808080;
      min-height: 40px;
      position: absolute;
      top: 140px;
      z-index: 1000;
      left: 374px;
      background: white;
      .el-tabs__content{
        margin-top: -8px !important;
        padding-bottom: 10px !important;
      }
      .districtNmb{
        display: flex;
        flex-wrap: wrap;
        p{
          margin-right: 10px;
        }
        ul{
          display: flex;
          flex-wrap: wrap;
          li{
            margin-right: 10px;
            cursor: pointer;
          }
        }
      }
      ul{
        display: flex;
        flex-wrap: wrap;
        li{
          margin-right: 10px;
          cursor: pointer;
        }
      }
    }
  }
  @media screen and (min-width: 1200px) {
    .Tao_section_body{
      max-width: 1400px;
      margin:30px auto;
      min-width: 960px;
      .tao_title_Cont{
        display: flex;
        margin: 0 auto;
        justify-content: space-between;
        .tao_title_left{
          display: flex;
          .search{
            margin-left: 10px;
            width: 250px;
            .search_icon{
              cursor: pointer;
            }
          }
        }
        .tao_title_right{
          display: flex;
          .icon_sort{
            line-height: 40px;
            margin-right: 10px;
          }
          .order_select{
            width: 100px;
            input{
              padding: 0;
            }
          }
        }
      }
      .body_section{
        min-width: 1160px;
        margin: 20px auto;
        ul{
          display: flex;
          flex-wrap: wrap;
          .tao_item:hover{
            transform: scale(1.01);
          }
          .tao_item{
            transition: all .3s;
            width: 268px;
            margin-right: 12px;
            border-top: 5px solid;
            margin-bottom: 12px;
            box-shadow: 1px 1px 6px rgba(0,0,0,0.1);
            .tao_item_s{
              padding-top: 5px;
              .tao_cont{
                display: flex;
                align-items: center;
                .tao_logo{
                  width: 34px;
                  height: 34px;
                  margin-right: 10px;
                  border-radius: 5px;
                  margin-left: 8px;
                  overflow: hidden;
                  img{
                    width: 100%;
                    height: 100%;
                  }
                }
              }
              .tao_logo_right{
                p{
                  height: 25px;
                }
                .tao_rate{
                  margin-top: -4px;
                  height: auto;
                  .el-rate__icon{
                    font-size: 12px;
                    margin-right: 2px;
                  }
                }
              }
              .tao_img_title{
                width: 100%;
                height: 144px;
                margin-top: 10px;
                text-align: center;
                .vio_content{
                  height: 5px;
                  .video_progress_box{
                    position:relative;
                    bottom: 9px;
                    width: 250px;
                    height:5px;
                    background:#999;
                    margin: 0 auto;
                    .video_progress{
                      height:5px;
                      background:#15bafe;
                    }
                  }
                }
                img{
                  width: 250px;
                  height: 100%;
                  margin: 0 auto;
                }
                video{
                  width: 250px;
                  object-fit: fill;
                  height: 100%;
                  margin: 0 auto;
                }
              }
              .price_title_local{
                display: flex;
                justify-content: space-between;
                margin: 0 10px;
                border-bottom: 1px solid #f2f2f2;
                padding-bottom: 5px;
                padding-top: 3px;
                .blue_font{
                  font-size: 18px;
                }
                .price_title_address{
                  font-size: 12px;
                  color: #7d7d7d;
                  line-height: 23px;
                  align-self: flex-end;
                }
              }
              .name_market{
                font-size: 13px;
                margin-top: 5px;
                margin-left: 10px;
                color: #222222;
                text-overflow: ellipsis;
                overflow: hidden;
                white-space: nowrap;
              }
              .remark_market{
                height: 55px;
                margin: 10px;
                margin-bottom: 4px;
                color: #808080;
                overflow: hidden;
                text-overflow: ellipsis;
                display: -webkit-box;
                -webkit-line-clamp: 3;
                line-clamp: 3;
                -webkit-box-orient: vertical;
              }
              .tao_signature{
                display: flex;
                margin: 5px 10px;
                .signature_item{
                  font-size: 13px;
                  text-decoration: underline;
                  margin-right: 10px;
                  cursor: pointer;
                }
                .signature_item:hover{
                  font-size: 13px;
                  text-decoration: underline;
                  color: #15bafe;
                  margin-right: 10px;
                  cursor: pointer;
                }
              }
              .tao_before_time{
                font-size: 12px;
                color: #cccccc;
                margin-left: 10px;
                position: relative;
                top: 18px;
              }
            }
          }
          .item_1{
            border-top: 5px solid #15BAFE;
          }
          .item_2{
            border-top: 5px solid #F55959;
          }
          .item_3{
            border-top: 5px solid #22AC38;
          }
          .item_4{
            border-top: 5px solid #15BAFE;
          }
          .border_item_1{
            border: 2px solid #15BAFE;
          }
          .border_item_2{
            border: 2px solid #F55959;
          }
          .border_item_3{
            border: 2px solid #22AC38;
          }
          .border_item_4{
            border: 2px solid #15BAFE;
          }
          .color_1{
            color: #15BAFE;
          }
          .color_2{
            color: #F55959;
          }
          .color_3{
            color: #22AC38;
          }
        }
      }
      .tao_pagination{
        text-align: center;
      }
    }

  }
</style>
<style scoped src="../../assets/css/Naughty.css"></style>
<style  src="../../assets/css/city.css"></style>
