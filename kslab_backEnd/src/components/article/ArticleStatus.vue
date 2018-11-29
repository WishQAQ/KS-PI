<template>
  <div>
    <BreadCrumb class="bread" :breadData="breadData"></BreadCrumb>
    <div class="content">
      <p class="title">文章状态</p>
      <table class="table" border="1" cellspacing="0" cellpadding="0">
        <thead>
          <th class="my_th" :colspan="articleNum.length">
            <span>
               <i class="iconfont icon-star"></i>
              文章总数
            </span>
            {{articleTotal}}
          </th>
        </thead>
        <tbody>
          <tr class="tr1">
            <td v-for="item in articleNum" :key="item.id">{{item.name}}</td>
          </tr>
          <tr class="tr2">
            <td v-for="item in articleNum" :key="item.id">{{item.number}}</td>
          </tr>
        </tbody>
      </table>
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
            @change="getDataByDate">
          </el-date-picker>
        </div>
        <div class="date_item">
          <p class="date_label">截止</p>
          <el-date-picker
            v-model="endTime"
            class="date_picker_1"
            type="date"
            size="mini"
            placeholder="选择日期"
            value-format="yyyy-MM-dd HH:mm:ss"
            @change="getDataByDate"
            :picker-options="pickerOptions">
          </el-date-picker>
        </div>
        <el-select size="mini" class="select_type" clearable v-model="userType" placeholder="全部" @change="drawLine">
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
            <p class="left_title">文章数量曲线图</p>
            <div class="time_range">
              <span>{{startTime.split(' ')[0]}}</span>
              <span>---</span>
              <span>{{endTime.split(' ')[0]}}</span>
            </div>
          </div>
          <div class="shape_header_right">
            <div class="right_items">
              <div class="point color1"></div>
              <p>汽车占{{((car.normal+car.business)/totalByDate*100).toFixed(2)}}%</p>
            </div>
            <div class="right_items">
              <div class="point color2"></div>
              <p>摩托车占{{((motorcycle.normal+motorcycle.business)/totalByDate*100).toFixed(2)}}%</p>
            </div>
            <div class="right_items">
              <div class="point color3"></div>
              <p>无人机占{{((plane.normal+plane.business)/totalByDate*100).toFixed(2)}}%</p>
            </div>
            <div class="right_items">
              <div class="point color4"></div>
              <p>智能设备占{{((intelligent.normal+intelligent.business)/totalByDate*100).toFixed(2)}}%</p>
            </div>
          </div>
        </div>
        <div id="myChart" :style="{width:'980px',height: '400px'}">

        </div>
      </div>
    </div>
  </div>
</template>

<script>
import BreadCrumb from '@/components/public/BreadCrumb';
import echarts from 'echarts'
export default {
  name: "ArticleStatus",
  components: {
    BreadCrumb
  },
  data() {
    return {

        pickerOptions: {
            disabledDate: (time) => {
                console.log(time.getTime());
                console.log(time.getTime()-new Date(this.startTime).getTime());
                console.log((time.getTime() - new Date(this.startTime).getTime()) / 1000 / 60 / 60 / 24);
                return ((time.getTime()-new Date(this.startTime).getTime())/1000/60/60/24)>31
            }
        },


      startTime: '',
      endTime: '',
      userType: '',
      breadData: [{
        id: 1,
        name: '文章管理',
        urls: '/index',
        icon: 'icon-home'
      }, {
        id: 2,
        name: '文章状态',
        urls: '/index/test',
        icon: 'icon-home'
      }],
      userOptions: [{
          value: 1,
          label: '个人用户'
      },{
          value: 2,
          label: '专业商家'
      },{
          value: 3,
          label: '普通商家'
      }],
      articleNum:[],//文章类型数组
      articleTotal:0,//文章总数
      articleDate:[],//文章数据统计
      car:{normal:0,business:0},//汽车文章统计
      motorcycle:{normal:0,business:0},//摩托文章统计
      plane:{normal:0,business:0},//无人机文章统计
      intelligent:{normal:0,business:0},//智能设备文章统计
      totalByDate:0,//某时间段内文章总数
      carArticle:[],//汽车文章统计
      motorArticle:[],//摩托文章统计
      planeArticle:[],//无人机文章统计
      intelligentArticle:[],//智能设备文章统计
    }
  },
  methods: {
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
      dates.map(date=>{
          let carNum=0,
              carNum1=0,
              carNum2=0,
              carNum3=0;
          let motorNum=0,
              motorNum1=0,
              motorNum2=0,
              motorNum3=0;
          let planeNum=0,
              planeNum1=0,
              planeNum2=0,
              planeNum3=0;
          let intelligentNum=0,
              intelligentNum1=0,
              intelligentNum2=0,
              intelligentNum3=0;
          this.carArticle.map(item=>{
              if(new Date(year+'-'+month+'-'+date).getTime()===new Date(item.created_at.split(' ')[0]).getTime() ||
                 new Date(year+'-'+(month+1)+'-'+date).getTime()===new Date(item.created_at.split(' ')[0]).getTime()){
                  carNum+=Number(item.articles);
                  //按用户类型搜索
                  if(item.user_type===1){
                      carNum1+=Number(item.articles)
                  }else if(item.user_type===2){
                      carNum2+=Number(item.articles)
                  }else if(item.user_type===3){
                      carNum2+=Number(item.articles)
                  }
              }
          });
          this.motorArticle.map(item=>{
              if(new Date(year+'-'+month+'-'+date).getTime()===new Date(item.created_at.split(' ')[0]).getTime() ||
                  new Date(year+'-'+(month+1)+'-'+date).getTime()===new Date(item.created_at.split(' ')[0]).getTime()){
                  motorNum+=Number(item.articles);
                  //按用户类型搜索
                  if(item.user_type===1){
                      motorNum1+=Number(item.articles)
                  }else if(item.user_type===2){
                      motorNum2+=Number(item.articles)
                  }else if(item.user_type===3){
                      motorNum3+=Number(item.articles)
                  }
              }
          });
          this.planeArticle.map(item=>{
              if(new Date(year+'-'+month+'-'+date).getTime()===new Date(item.created_at.split(' ')[0]).getTime() ||
                  new Date(year+'-'+(month+1)+'-'+date).getTime()===new Date(item.created_at.split(' ')[0]).getTime()){
                  planeNum+=Number(item.articles);
                  //按用户类型搜索
                  if(item.user_type===1){
                      planeNum1+=Number(item.articles)
                  }else if(item.user_type===2){
                      planeNum2+=Number(item.articles)
                  }else if(item.user_type===3){
                      planeNum3+=Number(item.articles)
                  }
              }
          });
          this.intelligentArticle.map(item=>{
              if(new Date(year+'-'+month+'-'+date).getTime()===new Date(item.created_at.split(' ')[0]).getTime() ||
                  new Date(year+'-'+(month+1)+'-'+date).getTime()===new Date(item.created_at.split(' ')[0]).getTime()){
                  intelligentNum+=Number(item.articles);
                  //按用户类型搜索
                  if(item.user_type===1){
                      intelligentNum1+=Number(item.articles)
                  }else if(item.user_type===2){
                      intelligentNum2+=Number(item.articles)
                  }else if(item.user_type===3){
                      intelligentNum3+=Number(item.articles)
                  }
              }
          });
          if(this.userType===1){
              car.push(carNum1);
              motorcycle.push(motorNum1);
              plane.push(planeNum1);
              intelligent.push(intelligentNum1);
          }else if(this.userType===2){
              car.push(carNum2);
              motorcycle.push(motorNum2);
              plane.push(planeNum2);
              intelligent.push(intelligentNum2);
          }else if(this.userType===3){
              car.push(carNum3);
              motorcycle.push(motorNum3);
              plane.push(planeNum3);
              intelligent.push(intelligentNum3);
          }else{
              car.push(carNum);
              motorcycle.push(motorNum);
              plane.push(planeNum);
              intelligent.push(intelligentNum);
          }
      });
        console.log(car);
        console.log(motorcycle);
        console.log(plane);
        console.log(intelligent);
        console.log(this.carArticle);
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
                name: '智能设备',
                type: 'line',
                smooth: true,
                data: intelligent
            }]
      });
    },

    //按时间段获取统计数据
    getDataByDate(){

        this.HttpClient.post('/admin/analysis/diagram',{type:1,begin:this.startTime,end:this.endTime})
            .then(res=>{
                console.log(res);
                if(res.data.code===200){
                    this.articleDate=res.data.data;
                    this.totalByDate=0;
                    this.car.normal=0;
                    this.car.business=0;
                    this.motorcycle.normal=0;
                    this.motorcycle.business=0;
                    this.plane.normal=0;
                    this.plane.business=0;
                    this.intelligent.normal=0;
                    this.intelligent.business=0;
                    this.carArticle=[];
                    this.motorArticle=[];
                    this.planeArticle=[];
                    this.intelligentArticle=[];
                    this.articleDate.map(item=>{
                        if(item.folder_type==='汽车'){
                            this.carArticle.push(item);
                            if(item.user_type===1){
                                this.car.normal+=Number(item.articles);
                                this.totalByDate+=Number(item.articles);
                            }else{
                                this.car.business+=Number(item.articles);
                                this.totalByDate+=Number(item.articles);
                            }
                        }else if(item.folder_type==='摩托'){
                            this.motorArticle.push(item);
                            if(item.user_type===1){
                                this.motorcycle.normal+=Number(item.articles);
                                this.totalByDate+=Number(item.articles);
                            }else{
                                this.motorcycle.business+=Number(item.articles);
                                this.totalByDate+=Number(item.articles);
                            }
                        }else if(item.folder_type==='无人机'){
                            this.planeArticle.push(item);
                            if(item.user_type===1){
                                this.plane.normal+=Number(item.articles);
                                this.totalByDate+=Number(item.articles);
                            }else{
                                this.plane.business+=Number(item.articles);
                                this.totalByDate+=Number(item.articles);
                            }
                        }else{
                            this.intelligentArticle.push(item);
                            if(item.user_type===1){
                                this.intelligent.normal+=Number(item.articles);
                                this.totalByDate+=Number(item.articles);
                            }else{
                                this.intelligent.business+=Number(item.articles);
                                this.totalByDate+=Number(item.articles);
                            }
                        }
                    });
                    this.drawLine();
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
      this.HttpClient.post('/admin/analysis/numCache',{type:1})
          .then(res=>{
              console.log(res);
              if(res.data.code===200){
                  this.articleNum=res.data.data;
                  this.articleNum.map(item=>{
                      item.number=0;
                      item.number+=Number(item.analysis.company_articles);
                      item.number+=Number(item.analysis.normal_articles);
                      this.articleTotal+=item.number;
                  });
                  console.log(this.articleTotal);
              }
          });
      this.getDataByDate();
  },
}
</script>

<style scoped lang="less">
  .bread {
    margin: 10px;
  }
  .content {
    background: white;
    margin-left: 10px;
    margin-right: 10px;
    height: calc(100vh - 87px);
    width: calc(100vw - 240px);
    border-radius: 2px;
    .title {
      text-align: left;
      padding: 10px;
      padding-left: 20px;
      font-size: 14px;
      border-bottom: 1px solid #f2f2f2;
    }
    table,table tr table tr td { border:1px solid #f2f2f2; }
    th{
      border:1px solid #15bafe;
    }
    td{
      line-height: 55px;
      text-align: center;
      width: 100px;
      height: 55px;
    }
    .table {
      text-align: center;
      border-collapse: collapse;
      margin-top: 20px;
      margin-left: 20px;
      .my_th{
        height: 40px;
        line-height: 40px;
        background: #15bafe;
        color: white;
        font-size: 14px;
        span{
          margin-right: 10px;
          i{
            margin-right: 5px;
          }
        }
      }
      .tr1{
        color: #808080;
        font-size: 14px;
      }
      .tr2{
        color: #404040;
        font-size: 15px;
        font-weight: 600;
      }
    }
    .conditions{
      display: flex;
      margin-top: 20px;
      .date_item{
        display: flex;
        border: 1px solid #dcdfe6;
        margin-left: 20px;
        border-radius: 5px;
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
      margin-left: 20px;
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
</style>
<style lang="less">
.date_item{
  .el-input__inner{
    border: none !important;
  }
}
</style>
