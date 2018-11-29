<template lang="html">
    <div class="width_1200 margin_top">
        <!--header头部-->
        <div class="commerciaIncome_header">
           <div>
             <span class="commercial_span_div"></span>
             <span class="commercial_font_title">收支详情表</span>
           </div>
           <div class="commercial_data">
             <i class="icon icon-ziyuan23" @click="preMonth"></i>
             <span>{{date[0]}}-{{date[1]}}</span>
             <i class="icon icon-ziyuan23" @click="nextMonth"></i>
           </div>
           <div class="commercial_right_deta">
             <span class="commercial_span_left">月</span>
             <span class="commercial_cupurt">日</span>
           </div>
        </div>
        <div class="commercial_text_align_month">
            <p>周日</p>
            <p>周一</p>
            <p>周二</p>
            <p>周三</p>
            <p>周四</p>
            <p>周五</p>
            <p>周六</p>
        </div>
        <div class="commercial_ul_li">
            <ul>
                <li v-for="(empty) in beforeEmpty" :key="empty"></li>
                <li class="merchant_day" :class="{active:selectedIndex===day}" @click="clickTime(day)" v-for="day in days" :key="day+beforeEmpty">
                    <span class="commercial_day_month">{{day}}</span>
                    <div class="merchant_day_income">
                        <p
                            class="merchant_day_amount"
                            :class="{green:getByDate(day).amount>500,yellow:500>=getByDate(day).amount>100,blue:100>=getByDate(day).amount>0,red:0>=getByDate(day).amount}"
                            v-if="getByDate(day).amount!==null">
                                收支:¥{{getByDate(day).amount}}
                        </p>
                        <p class="merchant_day_balance" v-if="getByDate(day).amount!==null">余额:¥{{getByDate(day).balance}}</p>
                    </div>
                <li class="backend_box_div">
                    <span class="commercial_day_month_back">总计</span>
                    <div class="merchant_day_income">
                        <p
                            class="merchant_day_amount_total">
                                收支:¥{{totalAmount}}
                        </p>
                        <p class="merchant_day_balance_total">余额:¥{{totalBalance}}</p>
                    </div>
                </li>
              <div class="float"></div>
            </ul>
        </div>
    </div>
</template>

<script>
export default {
    data(){
      return{
        DataLength:[
          {
            date_time:"2018-11-1",
            amount:"541",
            balance:"650"
          },
          {
            date_time:'2018-11-2',
            amount:"541",
            balance:"650"
          },
          {
            date_time:null,
            amount:"541",
            balance:"650"
          },
          {
            date_time:null,
            amount:"541",
            balance:"650"
          },
          {
            date_time:null,
            amount:"541",
            balance:"650"
          },
          {
            date_time:null,
            amount:"541",
            balance:"650"
          },
          {
            date_time:null,
            amount:"541",
            balance:"650"
          },
          {
            date_time:null,
            amount:"541",
            balance:"650"
          },
          {
            date_time:null,
            amount:"541",
            balance:"650"
          },
          {
            date_time:null,
            amount:"541",
            balance:"650"
          }
        ],//每日数据
        totalAmount:0,//总收支
        totalBalance:0,//余额
        date:[],//年/月/日
        days:0,//天数
        beforeEmpty:0,//空白格数
        selectedIndex:1,//是否选中天
      }
    },
    props:['getMonth'],
    methods:{
        clickTime(day){
            this.selectedIndex=day;
            if(day<10){
                day='0'+day
            }
            let dateSelect=this.date[0]+'-'+this.date[1]+'-'+day;
            this.$emit("comMercialemit",dateSelect)
        },
        //传入年份和月份 获取该年对应月份的天数
        getMonthDays(year,month){
            var thisDate = new Date(year,month,0); //当天数为0 自动处理为上一月的最后一天
            return thisDate.getDate();
        },
        //判断闰年
        leapYear(_year) {
            return _year % 400 === 0 || (_year % 4 === 0 && _year % 100 !== 0);
        },
        //判断某年某月的1号是星期几
        getFirstDay(_year,_month) {
            var allDay = 0, y = _year-1, i = 1;
            allDay = y + Math.floor(y/4) - Math.floor(y/100) + Math.floor(y/400) + 1;
            for ( ; i<_month; i++) {
                switch (i) {
                    case 1: allDay += 31; break;
                    case 2:
                        if(this.leapYear(_year)) { allDay += 29; }
                        else { allDay += 28; }
                        break;
                    case 3: allDay += 31; break;
                    case 4: allDay += 30; break;
                    case 5: allDay += 31; break;
                    case 6: allDay += 30; break;
                    case 7: allDay += 31; break;
                    case 8: allDay += 31; break;
                    case 9: allDay += 30; break;
                    case 10: allDay += 31; break;
                    case 11: allDay += 30; break;
                    case 12: allDay += 31; break;
                }
            }
            return allDay%7;
        },
        //上一月
        preMonth() {
            let year=Number(this.date[0]),
                month=Number(this.date[1]);
            if(month===1){
                year-=1;
                month=12;
            }else{
                month-=1;
            }
            this.days=this.getMonthDays(year,month);
            this.beforeEmpty=this.getFirstDay(year,month);
            if(month<10){
                month='0'+month;
            }
            this.date[0]=year;
            this.date[1]=month;
            this.getMonthData(this.date[0]+'-'+this.date[1]+'-01'+' 00:00:00',this.date[0]+'-'+this.date[1]+'-'+this.days+' 23:59:59')
        },
        //下一月
        nextMonth() {
            let year=Number(this.date[0]),
                month=Number(this.date[1]),
                now=new Date().toLocaleDateString().split('/');
            if(year<=now[0]){
                if(month===12){
                    year+=1;
                    month=1;
                }else{
                    month+=1;
                }
                this.days=this.getMonthDays(year,month);
                this.beforeEmpty=this.getFirstDay(year,month);
                if(month<10){
                    month='0'+month;
                }
                this.date[0]=year;
                this.date[1]=month;
                let start=this.date[0]+'-'+this.date[1]+'-01'+' 00:00:00',
                    end='';
                if(month<now[1]){
                    end=this.date[0]+'-'+this.date[1]+'-'+this.days+' 23:59:59'
                }else{
                    now[2]='0'+now[2];
                    end=now.join('-')+' 23:59:59'
                }
                this.getMonthData(start,end)
            }

        },

        //获取某月收支数据
        getMonthData(start,end){
            this.HttpClient.post('/web/user/incomeListByDate',{begin:start,end:end,type:'month'})
                .then(res=>{
                    console.log(res);
                    if(res.data.code===200){
                        this.DataLength=res.data.data;
                        this.DataLength.forEach(item=>{
                            this.totalAmount+=Number(item.amount);
                            this.totalBalance=Number(item.balance)
                        })
                    }
                })
        },

        //获取每日收支，余额
        getByDate(day){
            if(day<10){
                day='0'+day;
            }
            if(this.DataLength.find((obj)=>{
                return obj.date_time===this.date[0]+'-'+this.date[1]+'-'+day
            })){
                return this.DataLength.find((obj)=>{
                    return obj.date_time===this.date[0]+'-'+this.date[1]+'-'+day
                })
            }else{
                return {amount:null,balance:null}
            }

        }
    },
    created(){
        this.date=new Date().toLocaleDateString().split('/');
        this.selectedIndex=Number(this.date[2]);
        console.log(this.selectedIndex);
        this.date[2]='0'+this.date[2];
        console.log(this.date);
        this.days=this.getMonthDays(this.date[0],this.date[1]);
        this.beforeEmpty=this.getFirstDay(this.date[0],this.date[1]);
        console.log(this.days,this.beforeEmpty);
        console.log(this.date[0]+'-'+this.date[1]+'-'+1,this.date.join('-'));
        this.getMonthData(this.date[0]+'-'+this.date[1]+'-01'+' 00:00:00',this.date.join('-')+' 23:59:59')
    }
}
</script>

<style lang="css">
.margin_top{
  margin-top: 20px;
}
.commercial_cupurt{
  cursor: pointer;
}
.backend_box_div{
  background-color: #15befe !important;
}
.commercial_day_month_back{
  font-size:22px;
  color:#FFF;
  position: absolute;
  right: 0;
  margin-right: 20px;
  margin-top: 5px;
}
.commercial_day_month{
  font-size:22px;
  color:#999999;
  position: absolute;
  right: 0;
  margin-right: 20px;
  margin-top: 5px;
}
.merchant_day_income{
    position:absolute;
    bottom:0;
    right:0;
    text-align:center;
    font-size:14px;
}
.merchant_day_income p{
    padding:5px 0;
}
.merchant_day_income .merchant_day_amount{
    color:#fff;
}
.merchant_day_income .merchant_day_amount.green{
    background:#4aca6d;
}
.merchant_day_income .merchant_day_amount.yellow{
    background:#ffbc34;
}
.merchant_day_income .merchant_day_amount.blue{
    background:#15bafe;
}
.merchant_day_income .merchant_day_amount.red{
    background:#f62d51;
}
.merchant_day_income .merchant_day_balance{
    color:#666;
    background:#f2f2f2;
}
.merchant_day_income .merchant_day_amount_total{
    color:#fff;
    background:#1593fe;
}
.merchant_day_income .merchant_day_balance_total{
    color:#fff;
    background:#4462bd;
}
.commercial_ul_li>ul{
  display: flex;
  align-items: center;
  flex-wrap: wrap;
  flex: 7;
}
.commercial_ul_li>ul>li{
  width: 14.28%;
  border:1px solid #d5d5d5;
  height: 142px;
  background-color: #fff;
  position: relative;
  cursor:pointer;
}
.commercial_ul_li ul .merchant_day:hover{
    background:#f1fbff;
}
.commercial_ul_li ul .merchant_day.active{
    background:#eaeaea;
}
.commercial_ul_li{
  width: 100%;
}
.commercial_text_align_month>p{
  width: 159px;
  display: inline-block;
  text-align: center;
  margin-right: 5px;
  position: relative;
  left:3px;
}
.commercial_text_align_month{
  border-left:1px solid #ebebeb;
  border-right:1px solid #ebebeb;
  background-color: #f2f7f8;
  padding: 10px;
  font-size:14px;
  padding-left: 13px;
  display: flex;
  align-items: center;
  justify-content: space-between;
}
.commercial_span_left{
  margin-right: 10px;
  background-color: #FFF;
  color:#15bafe;
  padding: 5px 6px 5px 6px;
  width: 50px;
  border-radius: 80px;
  cursor: pointer;
}
.commercial_right_deta{
  display: inline-block;
  color:#FFF;
  font-size: 16px;
  margin-right: 15px;
}
.commercial_data>span{
  font-size: 18px;
}
.commercial_data>i{
  width: 40px;
  font-size: 20px;
}
.commercial_data>i:nth-child(1){
  transform:rotate(180deg);
}
.commercial_font_title{
  font-size:18px;
  color:#FFF;
  display: inline-block;
}
.commerciaIncome_header{
  width: 100%;
  display: flex;
  justify-content:space-between;
  height: 60px;
  background: linear-gradient(to left,#239df4,#2ab1f7,#239df4);
  border-radius: 20px 20px 0 0;
  padding-top: 17px;
  padding-left: 25px;
}
.commercial_span_div{
  background-color: #FFF;
  width: 5px;
  height: 20px;
  display: inline-block;
  position: relative;
  top:2.5px;
  margin-right: 5px;
}
.commerciaIncome_header>div{
  width: 33%
}
.commerciaIncome_header>div:nth-child(2){
  text-align: center;
  color:#FFF;
  font-size: 16px;
}
.commerciaIncome_header>div:nth-child(3){
  text-align: right;
}
</style>
