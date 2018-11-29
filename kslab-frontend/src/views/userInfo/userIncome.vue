<template>

  <div class="appBackground">
    <!--个人页面头部-->
    <userInfoHeader-div></userInfoHeader-div>

    <div class="userIncome width_1200">

      <div class="userIncome_left">
        <!-- <div class="tab">
          <div class="switch1 slect" @click="switchType()">收益周增长</div>
          <div class="switch2" @click="switchType()">收益月增长</div>
        </div> -->
        <div class="block">
          <span class="demonstration" >月份</span>
          <el-date-picker v-model="month" type="month" @change="selectDate()"></el-date-picker>
        </div>
        <div class="userIncome_charts">
          <ve-line
            :colors="colors"
            :data="chartData"
            :settings="chartSettings"
            :legend-visible="false"
          ></ve-line>

        </div>

        <div class="userIncome_box">
          <div class="userIncome_box_balance">
            <p>
              &yen;458.50
              <span>总余额</span>
            </p>
            <div class="userIncome_box_balance_btm" @click="dialogVisible = true">提现</div>

          </div>

          <div class="userIncome_box_day">
            <!-- <div class="balance_toDay">
              <img src="/static/img/icon/previewToday.png" alt="">
              <span>今天</span>
              <span>￥886</span>
            </div>
            <div class="balance_yesterday">
              <img src="/static/img/icon/previewYesterday.png" alt="">
              <span>昨天</span>
              <span>￥886</span>
            </div>
            <div class="balance_week">
              <img src="/static/img/icon/previewWeek.png" alt="">
              <span>本周</span>
              <span>￥886</span>
            </div>
            <div class="balance_month">
              <img src="/static/img/icon/previewMonth.png" alt="">
              <span>本月</span>
              <span>￥886</span>
            </div> -->
          </div>



        </div>

      </div>

      <div class="userIncome_right">

        <p>收支明细</p>
        <el-table :data="tableData" style="width: 100%">
          <el-table-column prop="created_at" label="日期" width="150"></el-table-column>
          <el-table-column prop="message" label="详细信息" class-name="details" width="360"></el-table-column>
          <el-table-column label="金额">
            <template slot-scope="scope">
              <span :style="(scope.tableData.amount.indexOF('-')>-1)?'color:red':'color:#15bafe'">{{scope.tableData.amount}}</span>
            </template>
          </el-table-column>
        </el-table>
        <div class="userIncome_table_pagination">
          <el-pagination 
          layout="prev, pager, next" 
          @current-change="handleCurrentChange"
          :page-size="1"
          :total="total">
          </el-pagination>
        </div>


      </div>

    </div>

    <!--侧边悬浮框-->
    <floating-div></floating-div>
    <!-- 提现弹框 -->
    <el-dialog :visible.sync="dialogVisible" width="614px">
      <img class="image" src="/static/img/logo/logo_block.png" alt="">
      <div class="drawing">
        <div class="til">提款到</div>
        <div class="xx">
          <div class="drawing-top">
            <div style="margin-right:30px">
              <img class="pay" src="/static/img/icon/weix.png" alt="">
              <span>微信</span>
              <img class="sle" src="/static/img/icon/hyes.png" alt="">
            </div>
            <div>
              <img class="pay" src="/static/img/icon/Alipay.png" alt="">
              <span>支付宝</span>
              <img class="sle" src="/static/img/icon/hyes.png" alt="">
            </div>  
          </div>
          <div class="drawing-bot">
            <input type="text" placeholder="请输入支付宝账号...">
          </div>
        </div>
      </div>
      <div class="drawing">
        <div class="til">提取金额</div>
        <div class="xxx">
          <div class="extract">
            <input type="text" placeholder="输入提取金额...">
            <span>元</span>
          </div>
          <div class="balance">
            <span>当前余额：</span>
            <span style="font-size:20px;color:#15bafe;">￥886</span>
          </div>
        </div>
      </div>
      <div class="drawing">
        <div class="til">验证手机</div>
        <div class="xxxx">
          <div class="phone">
            <span>+86</span>
            <input type="text" placeholder="请输入手机号...">
            <img src="/static/img/icon/user_error.png" alt="">
          </div>
          <div class="verification">
            <input type="text" placeholder="">
            <div>获取验证码</div>
          </div>
        </div>
      </div>
      <span slot="footer" class="dialog-footer">
        <el-button @click="dialogVisible = false">取 消</el-button>
        <el-button type="primary" @click="dialogVisible = false">确 定</el-button>
      </span>
    </el-dialog>
  </div>

</template>

<script>
  import FloatingDiv from "@/components/floating"
  import userInfoHeaderDiv from "@/components/userInfoHeader"

  import VeLine from 'v-charts/lib/line'

  export default {
    data(){
      this.chartSettings = {
        stack: {'用户': ['访问用户', '¥']},
        color: '#fff',
      }
      this.colors = ['#15bafe']

      return{
        month:"",
        type:'week',
        dialogVisible:false,
        chartData: {
          columns: ['日期', '¥'],
          rows: [
            { '日期': '01', '¥': 1393,},
            { '日期': '02', '¥': 3530,},
            { '日期': '03', '¥': 2923,},
            { '日期': '04', '¥': 1723,},
            { '日期': '05', '¥': 3792,},
            { '日期': '06', '¥': 4593,},
            { '日期': '07', '¥': 4593,},
            { '日期': '08', '¥': 1393,},
            { '日期': '09', '¥': 3530,},
            { '日期': '10', '¥': 2923,},
            { '日期': '11', '¥': 1723,},
            { '日期': '12', '¥': 3792,},
            { '日期': '13', '¥': 4593,},
            { '日期': '14', '¥': 4593,},
            { '日期': '15', '¥': 1393,},
            { '日期': '16', '¥': 3530,},
            { '日期': '17', '¥': 2923,},
            { '日期': '18', '¥': 1723,},
            { '日期': '19', '¥': 3792,},
            { '日期': '20', '¥': 4593,},
            { '日期': '21', '¥': 4593,},
            { '日期': '22', '¥': 1393,},
            { '日期': '23', '¥': 3530,},
            { '日期': '24', '¥': 2923,},
            { '日期': '25', '¥': 1723,},
            { '日期': '26', '¥': 3792,},
            { '日期': '27', '¥': 4593,},
            { '日期': '28', '¥': 4593,},
          ]
        },


        tableData: [],
        page:1,
        size:2,
        total:null,
      }
    },
    mounted(){
      //获取曲线图数据
      var today = new Date();
      var year = today.getFullYear();
      var month = today.getMonth()+1;
      var day = today.getDate();
      var today_time = year+'-'+month+'-'+day+' '+today.getHours()+':'+today.getMinutes()+':'+today.getSeconds();
      this.month =  year+'-'+month  //进入页面，获取的当前月份
      var firstDay = new Date(year, month-1, 1); //当前月份第一天
      var lastDay = new Date(year, month, 0); //当前月份最后一天
      console.log(firstDay,lastDay)
      this.start_time = this.timeFormat(firstDay);
      this.end_time = this.timeFormat(lastDay);
      console.log(this.start_time,this.end_time)
      this.$ajax.post(this.request.axiosPort+this.request.axiosApi+'web/user/incomeListByDate',{
          token:window.localStorage.getItem('token'),
          type:"month",
          begin:this.start_time,
          end:this.end_time
      })
      .then((res) => {
          console.log(res)
          // 数据赋值
          // this.chartData.rows = res.data.data
      })
      //获取收支信息列表
      const param ={
        page:this.page,
        size:this.size
      }
      this.getList(param);
    },
    methods:{
      getList(param){
        this.HttpClient.post('/web/user/incomeList',param).then((res) => {
            console.log(res)
            this.tableData = res.data.data.data;
            this.total = res.data.data.total;
        })
      },
      selectDate(){
        console.log('换时间了')
        console.log(this.month.getFullYear()+'-'+(this.month.getMonth()+1))
        var firstDay = new Date(this.month.getFullYear(),this.month.getMonth(), 1);
        var lastDay = new Date(this.month.getFullYear(), this.month.getMonth()+1, 0);
        console.log(firstDay,lastDay)
        this.start_time = this.timeFormat(firstDay);
        this.end_time = this.timeFormat(lastDay);
        console.log(this.start_time,this.end_time)
        this.$ajax.post(this.request.axiosPort+this.request.axiosApi+'web/user/incomeListByDate',{
            token:window.localStorage.getItem('token'),
            type:"month",
            begin:this.start_time,
            end:this.end_time
        })
        .then((res) => {
            console.log(res)
            // 数据赋值
            // this.chartData.rows = res.data.data
        })   
      },
      //时间格式转换处理
      timeFormat(time){
        if(time.getDate() >= 10 && time.getMonth()+1 >= 10){
          var data = time.getFullYear()+'-'+(time.getMonth()+1)+'-'+time.getDate()+' '+'00:00:00';
          return data
        }else if(time.getDate() >= 10 && time.getMonth()+1 < 10){
          var data = time.getFullYear()+'-'+'0'+(time.getMonth()+1)+'-'+time.getDate()+' '+'00:00:00';
          return data
        }else if(time.getDate() < 10 && time.getMonth()+1 >= 10){
          var data = time.getFullYear()+'-'+(time.getMonth()+1)+'-'+'0'+time.getDate()+' '+'00:00:00';
          return data
        }else if(time.getDate() < 10 && time.getMonth()+1 < 10){
          var data = time.getFullYear()+'-'+'0'+(time.getMonth()+1)+'-'+'0'+time.getDate()+' '+'00:00:00';
          return data
        }
      },
      handleCurrentChange(value){
        console.log(value)
        let param = {
          page: value,
          size:2
        }
        this.getList(param);
      }
    },
    components:{
      FloatingDiv,
      userInfoHeaderDiv,
      VeLine
    }
  }
</script>

<style scoped src="../../assets/css/userIncome.css">

</style>
<style lang="less">
  .appBackground{
    .el-dialog{
      background: url(/static/img/tkbgg.jpg) no-repeat;
      background-size: 100% 100%;
      .el-dialog__header{
        padding: 8px 20px 10px;
      }
      .el-dialog__body{
        padding: 0px 20px 10px 20px;
        border-bottom: 1px solid #f4f4f4;
        margin-bottom: 10px;
      }
    }
  }
  .block{
    .el-input{
      width: 115px;
      .el-input__inner{
        height: 30px;
        line-height: 30px;
        outline: 0;
      }
      .el-input__prefix{
        .el-input__icon{
          line-height: 30px;
        }
      }
    }
  }
</style>

