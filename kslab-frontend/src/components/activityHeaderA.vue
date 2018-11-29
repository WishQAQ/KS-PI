<template>
  <div class="activityIndex">
    <div class="activityIndex_box">
      <div class="activity_title">

        <transition name="bounce">
          <div class="activity_title_box" v-if="show" :class="{activityList:activityListShow}">

            <!--地区-->
            <div class="activity_title_box_area activity_title_div">
              <div class="activity_title_left">
                <img src="/static/img/icon/activity_area.png" alt="">地   区：
              </div>

              <div class="activity_city">
                <div class="activity_city_select">
                  <p>选择城市：</p>
                  <div class="activity_city_select_btn">
                    <button @click="cityShowBtn">{{currentCityName}}</button>
                    <div class="city_box" v-if="cityShow">
                      <el-tabs v-model="activeName" @tab-click="handleClick">
                        <el-tab-pane label="热门城市" name="cityHot">
                          <ul>
                            <li @click="districtShowBtn(item.city, item.name)" v-for="(item, index) in hotCities" :key="index">{{item.name}}</li>
                          </ul>
                        </el-tab-pane>
                        <el-tab-pane label="ABCDEFG" name="ABCDEFG">
                          <div class="districtNmb"
                          v-for="(item, index) in ['A','B','C','D','E','F','G']" :key="index">
                            <p v-if="allCities.ABCDEFG&&allCities.ABCDEFG[item]&&allCities.ABCDEFG[item].length>0">{{item}}</p>
                            <ul v-if="allCities.ABCDEFG&&allCities.ABCDEFG[item]&&allCities.ABCDEFG[item].length>0">
                              <li @click="districtShowBtn(items.id, items.name)" v-for="(items, indexs) in allCities.ABCDEFG[item]" :key="indexs">{{items.name}}</li>
                            </ul>
                          </div>
                        </el-tab-pane>
                        <el-tab-pane label="HIJKL" name="HIJKL">
                          <div class="districtNmb"
                               v-for="(item, index) in ['H','I','J','K','L']" :key="index">
                            <p v-if="allCities.HIJKL&&allCities.HIJKL[item]&&allCities.HIJKL[item].length>0">{{item}}</p>
                            <ul v-if="allCities.HIJKL&&allCities.HIJKL[item]&&allCities.HIJKL[item].length>0">
                              <li @click="districtShowBtn(items.id, items.name)" v-for="(items, indexs) in allCities.HIJKL[item]" :key="indexs">{{items.name}}</li>
                            </ul>
                          </div>
                        </el-tab-pane>
                        <el-tab-pane label="MNOPQRST" name="MNOPQRST">
                          <div class="districtNmb"
                               v-for="(item, index) in ['M','N','O','P','Q','R','S','T']" :key="index">
                            <p v-if="allCities.MNOPQRST&&allCities.MNOPQRST[item]&&allCities.MNOPQRST[item].length>0">{{item}}</p>
                            <ul v-if="allCities.MNOPQRST&&allCities.MNOPQRST[item]&&allCities.MNOPQRST[item].length>0">
                              <li @click="districtShowBtn(items.id, items.name)" v-for="(items, indexs) in allCities.MNOPQRST[item]" :key="indexs">{{items.name}}</li>
                            </ul>
                          </div>
                        </el-tab-pane>
                        <el-tab-pane label="WXYZ" name="WXYZ">
                          <div class="districtNmb"
                               v-for="(item, index) in ['W','X','Y','Z']" :key="index">
                            <p v-if="allCities.WXYZ&&allCities.WXYZ[item]&&allCities.WXYZ[item].length>0">{{item}}</p>
                            <ul v-if="allCities.WXYZ&&allCities.WXYZ[item]&&allCities.WXYZ[item].length>0">
                              <li @click="districtShowBtn(items.id, items.name)" v-for="(items, indexs) in allCities.WXYZ[item]" :key="indexs">{{items.name}}</li>
                            </ul>
                          </div>
                        </el-tab-pane>
                      </el-tabs>
                    </div>
                  </div>
                </div>
                <div class="activity_city_district" v-if="districtShow">
                  <p>选择区县：</p>
                  <ul>
                    <li :class="item.id===districtIndexId?'district_items':'district_item'"
                        @click="districtActiveBtm(item.id)"
                        v-for="(item,index) in district" :key="index">{{item.name}}</li>
                  </ul>
                </div>
              </div>
            </div>

            <!--类别-->
            <div class="service_category">
              <div class="service_category_top">
                <div class="service_category_left">
                  <img src="/static/img/icon/activity_category.png" alt="">
                  <p>类 别：</p>
                </div>
                <div class="service_category_right">
                  <div v-for="(item,index) in serviceBigType" :key="index" :style="index===0?{marginLeft:'-10px'}:{}" :class="item.id===typeIndex?'type_right_items':'type_right_item'" @click="handleBigType(item,index)">{{item.name}}</div>
                </div>
              </div>
              <div class="service_category_bottom">
                <p v-for="(item, index) in serviceSmallType" :key="index" :class="item.id===smallTypeIndex?'type_service_items':'type_service_item'" @click="handleSmallType(item,index)">{{item.name}}</p>
              </div>
            </div>

            <!--时效-->
            <div class="activity_title_box_search activity_title_div">
              <div class="activity_title_left">
                <img src="/static/img/icon/data.png" alt="">时 效：
              </div>

              <div class="activity_title_right activity_title_right_search">
                <el-radio-group v-model="radioTime" @change="handleRadioTime">
                  <el-radio :label="1">限时</el-radio>
                  <el-radio :label="2">长期</el-radio>
                </el-radio-group>
              </div>

            </div>

            <!--搜索-->
            <div class="activity_title_box_search activity_title_div">
              <div class="activity_title_left">
                <img src="/static/img/icon/data.png" alt="">搜   索：
              </div>

              <div class="activity_title_right activity_title_right_search">
                <el-input
                  placeholder="请输入名称、关键字搜索"
                  size="mini"
                  style="width: 200px"
                  :v-model="searchWord">
                  <i @click="handleSearch" slot="prefix" class="el-input__icon el-icon-search"></i>
                </el-input>
              </div>

            </div>

          </div>
        </transition>
        <div class="activity_title_box_bottom" @click="activityShow" >
          <div class="activity_title_box_line"></div>
          <div class="activity_title_box_btm" :class="{btmActive:active}" @click="active = ! active"> </div>
        </div>
      </div>

    </div>

  </div>
</template>

<script>

  export default {
    name: "activityHeader",
    components: {
    },
    props: ['transCity'],
    data(){
      return{
        show: false,
        radio: '1',
        btmActive: false,
        active:"",
        cityActive: false,
        hotCities: [],
        activeName: 'cityHot', //城市tab选项卡
        allCities: {},
        district: [],
        cityShow:false,  //默认隐藏城市选择框
        districtShow:false,  //默认隐藏区县选择框
        districtActive:false, //区县选择
        currentCityName: '选择城市',
        cityId: null,
        districtId: null,
        serviceType: null,
        serviceBigType:[],
        serviceSmallType: [],
        typeIndex: null,
        smallTypeIndex: null,
        searchWord: '',
        districtIndexId: null,
        radioTime: null, //时效 1限时 2永久

        activityListShow:false,
      }
    },
    mounted() {
      this.getProvince();
      this.getServiceType();
    },
    watch: {
      transCity: {
        handler(newVal, oldVal) {
          console.log(newVal, oldVal)
        }
      }
    },
    methods: {
      activityShow(){
        if(this.show == false){
          this.show = true
          this.activityListShow = true
        }else {
          this.show = false
          this.activityListShow = false
        }

      },

      handleClick(tab, event) {
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
        console.log(1111)
        this.districtShow=true;
        this.cityShow=false;
        this.currentCityName = cityName;
        this.cityId = cityId;
        this.getDistrict(cityId);
        const param = {
          cityId: this.cityId,
          districtId: this.districtId,
          serviceType: this.serviceType,
          radioTime: this.radioTime,
          searchWord: this.searchWord
        };
        this.$emit('getHeaderParam',param);
      },
      // 选择区县Active
      districtActiveBtm(districtId){
        this.districtActive=true;
        this.districtId = districtId;
        this.districtIndexId = districtId;
        const param = {
          cityId: this.cityId,
          districtId: this.districtId,
          serviceType: this.serviceType,
          radioTime: this.radioTime,
          searchWord: this.searchWord
        };
        this.$emit('getHeaderParam',param);
      },
      /***
       * 获取省市名称
       */
      getProvince() {
        this.HttpClient.get('/actives/getAllActivesArea').then(res => {
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
        this.HttpClient.get('/actives/getCityDistricts',{pid: cityId}).then(res =>{
          console.log(res);
          if(res.data.code === 200){
            this.district = res.data.data;
          }
        })
      },
      /***
       * 获取服务类型
       */
      getServiceType() {
        this.HttpClient.get('/actives/homeCategory').then(res =>{
          console.log(res.data.data);
          if(res.data.code === 200) {
            this.serviceBigType = res.data.data;
          }
        })
      },
      /****
       * 选择大的服务类型
       * @param item
       * @param index
       */
      handleBigType(item,index) {
        this.typeIndex = item.id;
        this.serviceSmallType = item.child;
        this.serviceType = item.id;
        const param = {
          cityId: this.cityId,
          districtId: this.districtId,
          serviceType: this.serviceType,
          radioTime: this.radioTime,
          searchWord: this.searchWord
        };
        this.$emit('getHeaderParam',param);
      },
      /***
       * 选择小的服务类型
       * @param item
       * @param index
       */
      handleSmallType(item,index) {
        this.smallTypeIndex = item.id;
        this.serviceType = item.id;
        const param = {
          cityId: this.cityId,
          districtId: this.districtId,
          serviceType: this.serviceType,
          active_date_type: this.active_date_type,
          searchWord: this.searchWord
        };
        this.$emit('getHeaderParam',param);

      },
      /***
       * 条件搜索
       */
      handleSearch(){
        const param = {
          cityId: this.cityId,
          districtId: this.districtId,
          serviceType: this.serviceType,
          active_date_type: this.active_date_type,
          searchWord: this.searchWord
        };
        this.$emit('getHeaderParam',param);
      },
      handleRadioTime(value) {
        console.log(value)
        this.radioSex = value;
        const param = {
          cityId: this.cityId,
          districtId: this.districtId,
          serviceType: this.serviceType,
          radioTime: this.radioTime,
          searchWord: this.searchWord
        };
        this.$emit('getHeaderParam',param);
      }
    }
  }

</script>


<style scoped lang="less">

  .activity_title_box{
    >div{
      opacity: 0;
      bottom: -50px;
      position: relative;
    }
  }
  .activity_title_box.activityList{
    >div:nth-child(1){
      animation: activityListTop 1s forwards;
    }
    >div:nth-child(2){
      animation: activityListTop 1.3s forwards;
    }
    >div:nth-child(3){
      animation: activityListTop 1.6s forwards;
    }
    >div:nth-child(4){
      animation: activityListTop 1.9s forwards;
    }
    >div:nth-child(5){
      animation: activityListTop 2.2s forwards;
    }
  }
  @keyframes activityListTop {
    0%{
      opacity: 0;
      bottom: -50px;
    }
    30%{
      opacity: 0;
      bottom: -50px;
    }
    100%{
      opacity: 1;
      bottom: 0;
    }
  }


  .service_category{
    .service_category_top{
      display: flex;
      .service_category_left{
        display: flex;
        width: 120px;
        font-size: 18px;
        color: #666;
        p{
          margin-left: 20px;
        }
        img{
          width: 17px;
          height: 17px;
          margin-top: 6px;
        }
      }
      .service_category_right{
        display: flex;
        flex-wrap: wrap;
        font-size: 16px;
        color: #666;
        .type_right_item{
          padding: 2px 15px;
          margin-right: 10px;
          cursor: pointer;
        }
        .type_right_items{
          cursor: pointer;
          padding: 2px 15px;
          background: #15bafe;
          color: white;
          border-radius: 5px;
          margin-right: 10px;
        }
      }
    }
    .service_category_bottom{
      display: flex;
      flex-wrap: wrap;
      margin-left: 110px;
      .type_service_item{
        padding: 2px 10px;
        margin-right: 10px;
        cursor: pointer;
        margin-top: 10px;
      }
      .type_service_items{
        cursor: pointer;
        padding: 2px 10px;
        background: #15bafe;
        color: white;
        border-radius: 5px;
        margin-right: 10px;
        margin-top: 10px;
      }
    }
  }

  /*选择城市*/
  .activity_city{
    flex: 1;

    /*选择城市*/
    .activity_city_select{
      display: flex;
      align-items: center;
      p{
        margin-right: 10px;
      }

      /*选择城市按钮*/
      .activity_city_select_btn{
        position: relative;
        border: 1px solid #dedede;
        background-color: #fff;
        border-radius: 4px;
        padding: 2px 3px;
        button{
          border: none;
          background-color: transparent;
          width: 100%;
          height: 100%;
        }

        /*城市框*/
        .city_box{
          position: absolute;
          left: 0;
          top: 30px;
          background-color: #fff;
          min-width: 200px;
          padding: 0 15px 10px 15px;
          box-shadow: 1px 1px 5px 2px rgba(34,24,21,.16);
          z-index: 2;

          ul{
            display: flex;
            flex-wrap: wrap;
            li{
              margin: 0 5px;
              cursor: pointer;
            }
            li:hover{
              color: #15bafe;
            }
          }

          .districtNmb{
            display: flex;
            margin-bottom: 5px;
            ul{}
          }

        }
      }

    }
  }

  /*区县框*/
  .activity_city_district{

    display: flex;
    p{
      margin-right: 10px;
    }
    ul{
      display: flex;
      flex-wrap: wrap;
      align-items: center;
      flex: 1;

      li{
        margin: 0 5px;
        cursor: pointer;
      }
      .district_item{
        color: #808080;
      }
      .district_items{
        color: #15bafe;
      }
    }
  }

  .activityIndex_box{
    position: relative;
    overflow: hidden;
  }

  .activity_title{
    position: relative;
    z-index: 1;
    margin-bottom: 30px;
    background-color: #fbfbfb;
  }

  .activity_title_box{
    height: 300px;
    position: relative;
    max-width: 1200px;
    min-width: 960px;
    margin: 0 auto;
  }

  @media screen and (max-width: 1240px) {
    .activity_title_box{
      padding: 0 40px;
    }
  }

  .activity_title_box_line{
    position: absolute;
    width: 100%;
    bottom: -5px;
    height: 5px;
    background-color: #15bafe;
  }

  .activity_title_box_btm{
    width: 40px;
    height: 40px;
    border-radius: 50%;
    background: url("/static/img/icon/activity_title_box_btm.png") no-repeat center center;
    position: absolute;
    bottom: -22px;
    left: 50%;
    margin-left: -15px;
    cursor: pointer;
    z-index: 1;
    transform: rotate(180deg);
    transition: all .5s;
  }

  .btmActive{
    transform: rotate(0deg);
    transition: all .5s;
  }

  /*收起*/
  .bounce-leave-active{
    animation: myfirst .3s reverse ease-out;
  }

  /*展开*/
  .bounce-enter-active{
    animation: myfirst .5s ease-out;
  }

  @keyframes myfirst{
    0%{
      margin-top: -300px;
    }
    100%{
      margin-top: 0;
    }
  }




  .activity_title_left,
  .activity_title_div{
    display: flex;
  }

  .type_right{
    display: flex;
  }

  .activity_title_div{
    margin-bottom: 20px;
    margin-top: 10px;
  }
  .activity_title_left{
    width: 120px;
    font-size: 18px;
    color: #666;
  }
  .activity_title_left img{
    width: 18px;
    height: 18px;
    margin-right: 20px;
    position: relative;
    top: 3px;
  }


  .activity_title_right{
    display: flex;
    align-items: center;
    flex-wrap: wrap;
    width: 900px;
  }


  /*地区*/
  .activity_title_right_area span{
    display: inline-block;
    width: 60px;
    text-align: center;
    margin: 0 10px 10px 10px;
    cursor: pointer;
    font-size: 14px;
    color: #666;
  }
  .activity_title_right_area span:hover{
    color: #15bafe;
  }



  /*时效*/
  .activity_title_right_aging{

  }

  /*搜索*/
  .activity_title_right_search{
    display: flex;
    align-items: center;
  }
  .activity_title_right_search span{
    display: flex;
    align-items: center;
    width: 12px;
    height: 12px;
    position: relative;
    left: 10px;
  }
  .activity_title_right_search input{
    border: none;
    border-bottom: 1px solid #aaa;
    background-color: transparent;
  }
</style>
<style scoped src="../assets/css/Naughty.css"></style>
<style  src="../assets/css/city.css"></style>
