<template>
    <div class="questionData">
      <!--面包屑-->
      <BreadCrumb class="bread" :breadData="breadData"></BreadCrumb>
      <!--主体内容-->
      <div class="questionData_main">
        <!--标题-->
        <div class="title">
          <p>问题状态</p>
        </div>

        <!--内容盒子-->
        <div class="questionData_content">
          <!--表格-->
          <div class="question_table">
            <div class="table_title">
              <i class="iconfont icon-star"></i>问题总数 12313
            </div>
            <div class="table_box">
              <div class="table_box_list">
                <p>汽车</p>
                <p>1231</p>
              </div>
              <div class="table_box_list">
                <p>摩托车</p>
                <p>1231</p>
              </div>
              <div class="table_box_list">
                <p>无人机</p>
                <p>1231</p>
              </div>
            </div>
          </div>

          <div class="question_chart">
            <div class="conditions">
              <div class="date_item">
                <p class="date_label">开始</p>
                <el-date-picker
                  v-model="startTime"
                  class="date_picker_1"
                  type="date"
                  size="mini"
                  placeholder="选择日期">
                </el-date-picker>
              </div>
              <div class="date_item">
                <p class="date_label">截止</p>
                <el-date-picker
                  v-model="endTime"
                  class="date_picker_1"
                  type="date"
                  size="mini"
                  placeholder="选择日期">
                </el-date-picker>
              </div>
              <el-select size="mini" class="select_type" v-model="userType" placeholder="全部">
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
                  <p class="left_title">问题数量曲线图</p>
                  <div class="time_range">
                    <span>2018-08-08</span>
                    <span>---</span>
                    <span>2018-09-08</span>
                  </div>
                </div>
                <div class="shape_header_right">
                  <div class="right_items">
                    <div class="point color1"></div>
                    <p>汽车占25%</p>
                  </div>
                  <div class="right_items">
                    <div class="point color2"></div>
                    <p>摩托车占25%</p>
                  </div>
                  <div class="right_items">
                    <div class="point color3"></div>
                    <p>无人机占25%</p>
                  </div>
                  <div class="right_items">
                    <div class="point color4"></div>
                    <p>智能设备占25%</p>
                  </div>
                </div>
              </div>
              <div id="myChart" :style="{width:'100%',height: '400px'}"></div>
            </div>
          </div>

          <div class="question_pie">
            <div class="question_pie_title">

            </div>

          </div>

        </div>
      </div>
    </div>
</template>

<script>
  import BreadCrumb from '@/components/public/BreadCrumb';
  import echarts from 'echarts'

  export default {
    name: "questionData",
    data(){
      return{
        // 面包屑
        breadData: [{
          id: 1,
          name: '问题',
          urls: '/index/question/question',
          icon: 'icon-home'
        }, {
          id: 2,
          name: '问题数据',
          urls: '/index/question/questionData',
          icon: 'icon-home'
        }],
        userOptions: [{
          value: 1,
          label: '公司'
        },{
          value: 2,
          label: '普通用户'
        }],

        startTime: '',
        endTime: '',
        userType: '',
      }
    },
    components:{
      BreadCrumb,
    },
    mounted() {
      this.drawLine();
    },

    methods: {
      drawLine(){
        // 基于准备好的dom，初始化echarts实例
        let myChart = echarts.init(document.getElementById('myChart'))
        // 绘制图表
        myChart.setOption({
          tooltip: {
            trigger: 'axis'
          },
          xAxis: {
            type: 'category',
            data: ['1', '2', '3', '4', '5', '6', '7','9','10','11','12','13','14','15','16','17','18','19','20','21','22','23','24','25','26','27','28','29','30']
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
            name: '成交',
            type: 'line',
            smooth: true,
            data: [10, 12, 21, 54, 260, 830, 710]
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
              name: '预购',
              type: 'line',
              smooth: true,
              data: [30, 182, 434, 791, 390, 30, 10,30, 182, 434, 791, 390, 30, 10]
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
              name: '意向',
              type: 'line',
              smooth: true,
              data: [1320, 1132, 601, 234, 120, 90, 20]
            }]
        });
      }
    }
  }
</script>

<style lang="less">
  .questionData{
    .bread{
      margin: 10px;
    }
    .questionData_main{
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

      .questionData_content{
        text-align: left;
        padding: 0 40px;

        .question_table{
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

        .question_chart{

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


      }
    }
  }
</style>
