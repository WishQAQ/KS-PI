<template>
    <div class="serviceData">
      <!--面包屑-->
      <BreadCrumb class="bread" :breadData="breadData"></BreadCrumb>
      <!--主体内容-->
      <div class="serviceData_main">
        <!--标题-->
        <div class="title">
          <p>服务数据</p>
          <p>
            <i class="iconfont icon-shuaxin"></i>
            刷新
          </p>
        </div>

        <!--内容盒子-->
        <div class="serviceData_content">
          <!--表格-->
          <div class="service_table">
            <div class="table_title">
              <i class="iconfont icon-star"></i>服务总数 {{serviceTotal}}
            </div>
            <div class="table_box">
              <div class="table_box_list" v-for="item in serviceData" :key="item.id">
                <p>{{item.name}}</p>
                <p>{{item.number}}</p>
              </div>
            </div>
          </div>

          <div class="service_chart">
            <div class="conditions">
              <div class="date_item">
                <p class="date_label">开始</p>
                <el-date-picker
                  v-model="startTime"
                  class="date_picker_1"
                  type="date"
                  size="mini"
                  value-format="yyyy-MM-dd HH:mm:ss"
                  placeholder="选择日期"
                  @change="getServiceDataByDate">
                </el-date-picker>
              </div>
              <div class="date_item">
                <p class="date_label">截止</p>
                <el-date-picker
                  v-model="endTime"
                  class="date_picker_1"
                  type="date"
                  size="mini"
                  value-format="yyyy-MM-dd HH:mm:ss"
                  placeholder="选择日期"
                  @change="getServiceDataByDate"
                  :picker-options="pickerOptions">
                </el-date-picker>
              </div>
              <el-select size="mini" class="select_type" v-model="userType" placeholder="状态选择">
                <el-option
                  v-for="item in userOptions"
                  :key="item.value"
                  :label="item.label"
                  :value="item.value">
                </el-option>
              </el-select>
            </div>
            <div class="shape_content">
              <div class="shape_header">
                <div class="shape_header_left">
                  <p class="left_title">服务数量曲线图</p>
                  <div class="time_range">
                    <span>{{startTime.split(' ')[0]}}</span>
                    <span>---</span>
                    <span>{{endTime.split(' ')[0]}}</span>
                  </div>
                </div>
                <div class="shape_header_right">
                  <div class="right_items">
                    <div class="point color1"></div>
                    <p>汽车占{{carActivity.percent}}%</p>
                  </div>
                  <div class="right_items">
                    <div class="point color2"></div>
                    <p>摩托车占{{motorActivity.percent}}%</p>
                  </div>
                  <div class="right_items">
                    <div class="point color3"></div>
                    <p>无人机占{{planeActivity.percent}}%</p>
                  </div>
                  <div class="right_items">
                    <div class="point color4"></div>
                    <p>智能设备占{{intelligentActivity.percent}}%</p>
                  </div>
                </div>
              </div>
              <div id="myChart" :style="{width:'100%',height: '400px'}"></div>
            </div>


          </div>


          <div class="service_category">
            <div class="category_box">
              <div class="category_box_left">
                <i class="iconfont icon-qiche"></i>
                <div class="category_box_line">
                  <div class="category_line_main">
                    <p>汽车 <span>CAR</span></p>
                    <el-progress :percentage="carActivity.percent" :show-text="false"></el-progress>
                  </div>
                  <div class="category_line_nmb">
                      {{carActivity.percent}}%
                  </div>
                </div>
              </div>

              <div class="category_box_btm" @click="categoryContent = ! categoryContent">
                汽车详情<i class="iconfont icon-down-circle"></i>
              </div>
            </div>
            <el-collapse-transition>
              <div class="category_content" v-if="categoryContent">
                <div class="category_list">
                  <div class="category_list_text">
                    <p>改装</p>
                    <p>80%</p>
                  </div>
                  <el-progress :percentage="80" :show-text="false"></el-progress>
                </div>

                <div class="category_list">
                  <div class="category_list_text">
                    <p>改装</p>
                    <p>80%</p>
                  </div>
                  <el-progress :percentage="80" :show-text="false"></el-progress>
                </div>

                <div class="category_list">
                  <div class="category_list_text">
                    <p>改装</p>
                    <p>80%</p>
                  </div>
                  <el-progress :percentage="80" :show-text="false"></el-progress>
                </div>

                <div class="category_list">
                  <div class="category_list_text">
                    <p>改装</p>
                    <p>80%</p>
                  </div>
                  <el-progress :percentage="80" :show-text="false"></el-progress>
                </div>

                <div class="category_list">
                  <div class="category_list_text">
                    <p>改装</p>
                    <p>80%</p>
                  </div>
                  <el-progress :percentage="80" :show-text="false"></el-progress>
                </div>

              </div>
            </el-collapse-transition>

          </div>
          <div class="service_category">
            <div class="category_box">
                <div class="category_box_left">
                    <i class="iconfont icon-qiche"></i>
                    <div class="category_box_line">
                        <div class="category_line_main">
                            <p>摩托车 <span>CAR</span></p>
                            <el-progress :percentage="planeActivity.percent" :show-text="false"></el-progress>
                        </div>
                        <div class="category_line_nmb">
                            {{planeActivity.percent}}%
                        </div>
                    </div>
                </div>

                <div class="category_box_btm" @click="categoryContent = ! categoryContent">
                    摩托车详情<i class="iconfont icon-down-circle"></i>
                </div>
            </div>
            <el-collapse-transition>
                <div class="category_content" v-if="categoryContent">
                    <div class="category_list">
                        <div class="category_list_text">
                            <p>改装</p>
                            <p>80%</p>
                        </div>
                        <el-progress :percentage="80" :show-text="false"></el-progress>
                    </div>

                    <div class="category_list">
                        <div class="category_list_text">
                            <p>改装</p>
                            <p>80%</p>
                        </div>
                        <el-progress :percentage="80" :show-text="false"></el-progress>
                    </div>

                    <div class="category_list">
                        <div class="category_list_text">
                            <p>改装</p>
                            <p>80%</p>
                        </div>
                        <el-progress :percentage="80" :show-text="false"></el-progress>
                    </div>

                    <div class="category_list">
                        <div class="category_list_text">
                            <p>改装</p>
                            <p>80%</p>
                        </div>
                        <el-progress :percentage="80" :show-text="false"></el-progress>
                    </div>

                    <div class="category_list">
                        <div class="category_list_text">
                            <p>改装</p>
                            <p>80%</p>
                        </div>
                        <el-progress :percentage="80" :show-text="false"></el-progress>
                    </div>

                </div>
            </el-collapse-transition>

        </div>
          <div class="service_category">
            <div class="category_box">
                <div class="category_box_left">
                    <i class="iconfont icon-qiche"></i>
                    <div class="category_box_line">
                        <div class="category_line_main">
                            <p>无人机 <span>CAR</span></p>
                            <el-progress :percentage="planeActivity.percent" :show-text="false"></el-progress>
                        </div>
                        <div class="category_line_nmb">
                            {{planeActivity.percent}}%
                        </div>
                    </div>
                </div>

                <div class="category_box_btm" @click="categoryContent = ! categoryContent">
                    无人机详情<i class="iconfont icon-down-circle"></i>
                </div>
            </div>
            <el-collapse-transition>
                <div class="category_content" v-if="categoryContent">
                    <div class="category_list">
                        <div class="category_list_text">
                            <p>改装</p>
                            <p>80%</p>
                        </div>
                        <el-progress :percentage="80" :show-text="false"></el-progress>
                    </div>

                    <div class="category_list">
                        <div class="category_list_text">
                            <p>改装</p>
                            <p>80%</p>
                        </div>
                        <el-progress :percentage="80" :show-text="false"></el-progress>
                    </div>

                    <div class="category_list">
                        <div class="category_list_text">
                            <p>改装</p>
                            <p>80%</p>
                        </div>
                        <el-progress :percentage="80" :show-text="false"></el-progress>
                    </div>

                    <div class="category_list">
                        <div class="category_list_text">
                            <p>改装</p>
                            <p>80%</p>
                        </div>
                        <el-progress :percentage="80" :show-text="false"></el-progress>
                    </div>

                    <div class="category_list">
                        <div class="category_list_text">
                            <p>改装</p>
                            <p>80%</p>
                        </div>
                        <el-progress :percentage="80" :show-text="false"></el-progress>
                    </div>

                </div>
            </el-collapse-transition>

        </div>
          <div class="service_category">
            <div class="category_box">
                <div class="category_box_left">
                    <i class="iconfont icon-qiche"></i>
                    <div class="category_box_line">
                        <div class="category_line_main">
                            <p>智能设备 <span>CAR</span></p>
                            <el-progress :percentage="intelligentActivity.percent" :show-text="false"></el-progress>
                        </div>
                        <div class="category_line_nmb">
                            {{intelligentActivity.percent}}%
                        </div>
                    </div>
                </div>

                <div class="category_box_btm" @click="categoryContent = ! categoryContent">
                    智能设备详情<i class="iconfont icon-down-circle"></i>
                </div>
            </div>
            <el-collapse-transition>
                <div class="category_content" v-if="categoryContent">
                    <div class="category_list">
                        <div class="category_list_text">
                            <p>改装</p>
                            <p>80%</p>
                        </div>
                        <el-progress :percentage="80" :show-text="false"></el-progress>
                    </div>

                    <div class="category_list">
                        <div class="category_list_text">
                            <p>改装</p>
                            <p>80%</p>
                        </div>
                        <el-progress :percentage="80" :show-text="false"></el-progress>
                    </div>

                    <div class="category_list">
                        <div class="category_list_text">
                            <p>改装</p>
                            <p>80%</p>
                        </div>
                        <el-progress :percentage="80" :show-text="false"></el-progress>
                    </div>

                    <div class="category_list">
                        <div class="category_list_text">
                            <p>改装</p>
                            <p>80%</p>
                        </div>
                        <el-progress :percentage="80" :show-text="false"></el-progress>
                    </div>

                    <div class="category_list">
                        <div class="category_list_text">
                            <p>改装</p>
                            <p>80%</p>
                        </div>
                        <el-progress :percentage="80" :show-text="false"></el-progress>
                    </div>

                </div>
            </el-collapse-transition>

        </div>


        </div>
      </div>
    </div>
</template>

<script>
  import BreadCrumb from '@/components/public/BreadCrumb';
  import echarts from 'echarts'

  export default {
    name: "ServiceData",
    data(){
      return{

        //时间选择范围限制
        pickerOptions: {
            disabledDate: (time) => {
                console.log((time.getTime() - new Date(this.startTime).getTime()) / 1000 / 60 / 60 / 24);
                return ((time.getTime()-new Date(this.startTime).getTime())/1000/60/60/24)>31
            }
        },

        // 面包屑
        breadData: [
        {
          id: 1,
          name: '服务',
          urls: '/index/service/Service',
          icon: 'icon-home'
        }, {
          id: 2,
          name: '服务数据',
          urls: '/index/service/ServiceData',
          icon: 'icon-home'
        }
        ],
        userOptions: [
        {
          value: 1,
          label: '全部'
        },{
          value: 2,
          label: '未通过'
        }
        ],

        startTime: '',//开始时间段
        endTime: '',//结束时间段
        userType: '',

        categoryContent:false,
        serviceData:[],//服务数据
        serviceTotal:0,//服务总记录数
        serviceDataByDate:[],//某一时间段内服务数据
        carActivity:[],//汽车服务数据
        motorActivity:[],//摩托车服务数据
        planeActivity:[],//无人机服务数据
        intelligentActivity:[],//智能设备服务数据
        serviceTotalByDate:0,//某时间段内服务总记录数
      }
    },
    components:{
      BreadCrumb,
    },
    mounted() {
      this.drawLine();
    },

    methods: {
      //数据曲线绘制
      drawLine(){

          let days=(new Date(this.endTime).getTime()-new Date(this.startTime).getTime())/1000/60/60/24;
          let begin=new Date(this.startTime).getDate();
          let year=new Date(this.startTime).getFullYear();
          let month=new Date(this.startTime).getMonth()+1;
          let dates=[],
              monthDay=0;
          //获取起始时间月份天数
          switch(month) {
              case 1: monthDay = 31; break;
              case 2:
                  if(year%400 === 0 || (year%4 === 0 && year%100 !== 0)) { monthDay = 29; }//判断是否闰年
                  else { monthDay = 28; }
                  break;
              case 3: monthDay = 31; break;
              case 4: monthDay = 30; break;
              case 5: monthDay = 31; break;
              case 6: monthDay = 30; break;
              case 7: monthDay = 31; break;
              case 8: monthDay = 31; break;
              case 9: monthDay = 30; break;
              case 10: monthDay = 31; break;
              case 11: monthDay = 30; break;
              case 12: monthDay = 31; break;
          }
          for(let i=0;i<days;i++){
              if(begin+i>monthDay){
                  dates.push(begin+i-monthDay)
              }else{
                  dates.push(begin+i)
              }
          }
          let car=[],
              motorcycle=[],
              plane=[],
              intelligent=[];
          dates.map(date=> {
                  let carNum = 0;
                  let motorNum = 0;
                  let planeNum = 0;
                  let intelligentNum = 0;
                  this.carActivity.map(item => {
                      if (new Date(year + '-' + month + '-' + date).getTime() === new Date(item.created_at.split(' ')[0]).getTime() ||
                          new Date(year + '-' + (month + 1) + '-' + date).getTime() === new Date(item.created_at.split(' ')[0]).getTime()) {
                          console.log(1);
                          carNum += Number(item.services);
                      }
                  });
                  this.motorActivity.map(item => {
                      if (new Date(year + '-' + month + '-' + date).getTime() === new Date(item.created_at.split(' ')[0]).getTime() ||
                          new Date(year + '-' + (month + 1) + '-' + date).getTime() === new Date(item.created_at.split(' ')[0]).getTime()) {
                          motorNum += Number(item.services);
                      }
                  });
                  this.planeActivity.map(item => {
                      if (new Date(year + '-' + month + '-' + date).getTime() === new Date(item.created_at.split(' ')[0]).getTime() ||
                          new Date(year + '-' + (month + 1) + '-' + date).getTime() === new Date(item.created_at.split(' ')[0]).getTime()) {
                          planeNum += Number(item.services);
                      }
                  });
                  this.intelligentActivity.map(item => {
                      if (new Date(year + '-' + month + '-' + date).getTime() === new Date(item.created_at.split(' ')[0]).getTime() ||
                          new Date(year + '-' + (month + 1) + '-' + date).getTime() === new Date(item.created_at.split(' ')[0]).getTime()) {
                          intelligentNum += Number(item.services);
                      }
                  });
                  car.push(carNum);
                  motorcycle.push(motorNum);
                  plane.push(planeNum);
                  intelligent.push(intelligentNum);
          });
          //求和
          this.carActivity.total=eval(car.join('+'));
          this.motorActivity.total=eval(motorcycle.join('+'));
          this.planeActivity.total=eval(plane.join('+'));
          this.intelligentActivity.total=eval(intelligent.join('+'));
          this.serviceTotalByDate=this.carActivity.total+this.motorActivity.total+this.planeActivity.total+this.intelligentActivity.total;
          this.carActivity.percent=Number((this.carActivity.total/this.serviceTotalByDate*100).toFixed(2));
          this.motorActivity.percent=Number((this.motorActivity.total/this.serviceTotalByDate*100).toFixed(2));
          this.planeActivity.percent=Number((this.planeActivity.total/this.serviceTotalByDate*100).toFixed(2));
          this.intelligentActivity.percent=Number((this.intelligentActivity.total/this.serviceTotalByDate*100).toFixed(2));

          // 基于准备好的dom，初始化echarts实例
          let myChart = echarts.init(document.getElementById('myChart'));
          // 绘制图表
          myChart.setOption({
              tooltip: {
                trigger: 'axis'
              },
              xAxis: {
                type: 'category',
                data: dates
              },
              yAxis: {
                type: 'value'
              },
              series: [{
                itemStyle: {
                  normal: {
                    color: '#009efb',
                    lineStyle: {
                      color: '#009efb'
                    }
                  }
                },
                name: '汽车',
                type: 'line',
                smooth: true,
                data: car
              },
                {
                  itemStyle: {
                    normal: {
                      color: '#55ce63',
                      lineStyle: {
                        color: '#55ce63'
                      }
                    }
                  },
                  name: '摩托车',
                  type: 'line',
                  smooth: true,
                  data: motorcycle
                },
                {
                  itemStyle: {
                    normal: {
                      color: '#ff7676',
                      lineStyle: {
                        color: '#ff7676'
                      }
                    }
                  },
                  name: '无人机',
                  type: 'line',
                  smooth: true,
                  data: plane
                },
                  {
                      itemStyle: {
                          normal: {
                              color: '#FFB82E',
                              lineStyle: {
                                  color: '#FFB82E'
                              }
                          }
                      },
                      name: "无人机",
                      data: intelligent,
                      type: 'line',
                      smooth: true

                  }]
          });
      },
      //获取服务数据
      getServiceData(){
          this.HttpClient.post('/admin/analysis/numCache',{type:6})
              .then(res=>{
                  console.log(res);
                  if(res.data.code===200){
                      this.serviceData=res.data.data;
                      console.log(this.serviceData);
                      this.serviceData.map(item=>{
                          item.number=0;
                          item.number+=Number(item.analysis.company_services);
                          item.number+=Number(item.analysis.normal_services);
                          this.serviceTotal+=item.number
                      })
                  }
              })
      },
      //获取某一时间段内服务数据
      getServiceDataByDate(){
          this.HttpClient.post('/admin/analysis/diagram',{type:6,begin:this.startTime,end:this.endTime})
              .then(res=>{
                  console.log(res);
                  if(res.data.code===200){
                      this.serviceDataByDate=res.data.data;
                      this.carActivity=[];
                      this.motorActivity=[];
                      this.planeActivity=[];
                      this.intelligentActivity=[];
                      res.data.data.map(item=>{
                          if(item.folder_type==='汽车'){
                              this.carActivity.push(item);
                          }else if(item.folder_type==='摩托'){
                              this.motorActivity.push(item);
                          }else if(item.folder_type==='无人机'){
                              this.planeActivity.push(item);
                          }else{
                              this.intelligentActivity.push(item);
                          }
                      });
                      this.drawLine()
                  }
              })
      },
      /*****初始化时间格式*****/
      initFormat(date){
          if(date<10){
              date='0'+date;
          }
          return date
      },
      initDateValue(date){
          let year=date.getFullYear(),
              month=date.getMonth()+1,
              day=date.getDate(),
              hour=date.getHours(),
              minutes=date.getMinutes(),
              second=date.getSeconds();
          month=this.initFormat(month);
          day=this.initFormat(day);
          hour=this.initFormat(hour);
          minutes=this.initFormat(minutes);
          second=this.initFormat(second);
          return year+'-'+month+'-'+day+' '+hour + ':' + minutes + ':' + second
      }
    },
    created(){
        let arr=this.initDateValue(new Date()).split('-');
        arr[1]=arr[1]-1;
        arr.join('-');
        this.startTime=arr.join('-');
        this.endTime=this.initDateValue(new Date());
        console.log(this.startTime);
        console.log(this.endTime);
        this.getServiceData();
        this.getServiceDataByDate()
    }
  }
</script>

<style lang="less">
  .serviceData{
    .bread{
      margin: 10px;
    }
    .serviceData_main{
      background: white;
      margin: 10px 10px 0 10px;
      width: calc(100vw - 240px);
      border-radius: 2px;
      padding-bottom: 50px;

      /*标题*/
      .title{
        display: flex;
        align-items: center;
        justify-content: space-between;
        padding: 20px 40px;
        margin-bottom: 30px;
        border-bottom: 1px solid #dedede;
      }

      .serviceData_content{
        text-align: left;
        padding: 0 40px;

        .service_table{
          display: inline-block;
          .table_title{
            width: 100%;
            display: flex;
            align-items: center;
            justify-content: center;
            height: 40px;
            background: #15bafe;
            color: #fff;
            .iconfont{
              margin-right: 10px;
              position: relative;
              top: 2px;
            }
          }
          .table_box{
            display: flex;
            align-items: center;
            .table_box_list{
              min-width: 100px;
              p{
                border: 1px solid #dedede;
                display: flex;
                justify-content: center;
                align-items: center;
                height: 50px;
              }
            }
          }
        }

        .service_chart{

          .conditions{
            display: flex;
            margin-top: 20px;
            .date_item{
              display: flex;
              border: 1px solid #dcdfe6;
              border-radius: 5px;
              .el-input__inner{
                border: none !important;
              }
              .date_label{
                color: #808080;
                font-size: 12px;
                height: 28px;
                line-height: 28px;
                margin-left: 10px;
              }
              .date_picker_1{
                width: 140px;
              }
            }
            .select_type{
              width: 120px;
              margin-left: 20px;
            }
          }
          .shape_content{
            min-width: 500px;
            border: 1px solid #f2f2f2;
            margin-top: 20px;
            padding-bottom: 20px;
            .shape_header{
              display: flex;
              justify-content: space-between;
              margin-top: 20px;
              margin-left: 20px;
              .shape_header_left{
                .left_title{
                  font-size: 16px;
                  font-weight: 600;
                  color: #404040;
                  text-align: left;
                }
                .time_range{
                  font-size: 12px;
                  color: #808080;
                  margin-top: 5px;
                }
              }
              .shape_header_right{
                display: flex;
                .right_items{
                  display: flex;
                  align-items: center;
                  margin-right: 15px;
                  .point{
                    height: 8px;
                    width: 8px;
                    border-radius: 50%;
                    background: #15bafe;
                  }
                  p{
                    font-size: 13px;
                    margin-left: 5px;
                  }
                  .color1{background: #15bafe}
                  .color2{background: #55ce63}
                  .color3{background: #ff5858}
                  .color4{background: #FFB82E}
                }
              }
            }
          }

        }

        /*分类*/
        .service_category{
          margin-top: 30px;

          .category_box{
            display: flex;
            align-items: center;
            background: #fff;
            height: 80px;
            border: 1px solid #f2f2f2;
            margin-top: 20px;
            width: 540px;

            /*进度条*/
            .category_box_left{
              display: flex;
              align-items: center;
              width: 360px;
              padding: 10px 20px;

              .icon-qiche{
                font-size: 40px;
                display: flex;
                justify-content: center;
                align-items: center;
                width: 60px;
                height: 60px;
                border-radius: 50%;
                background: #15bafe;
                color: #fff;
                margin-right: 20px;
              }
              .category_box_line{
                width: 100%;
                display: flex;
                flex: 1;
                align-items: center;

                .category_line_main{
                  flex: 1;
                  p{
                    font-size: 19px;
                    color: #222;
                    margin-bottom: 10px;
                    span{
                      font-size: 16px;
                      color: #999;
                    }
                  }
                }
                .category_line_nmb{
                  display: flex;
                  justify-content: center;
                  align-items: center;
                  width: 100px;
                  font-size: 32px;
                  color: #2f323e;
                }
              }
            }

            /*按钮*/
            .category_box_btm{
              display: flex;
              justify-content: center;
              align-items: center;
              padding: 0 20px;
              height: 100%;
              cursor: pointer;
              border-left: 1px solid #f2f2f2;
              color: #666666;
              font-size: 16px;

              i{
                margin-left: 10px;
                font-size: 24px;
                color: #666666;
              }
            }
          }

          .category_content{
            display: flex;
            align-items: center;
            flex-wrap: wrap;
            .category_list{
              width: 25%;
              border: 1px solid #f2f2f2;
              background: #fff;
              padding: 20px 40px;
              box-sizing: border-box;
              .category_list_text{
                display: flex;
                align-items: center;
                justify-content: space-between;
                margin-bottom: 10px;
              }
            }
          }

        }


      }
    }
  }
</style>
