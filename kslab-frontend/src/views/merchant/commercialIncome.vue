<template lang="html">
    <div class="width_1200 margin_top">
        <!--header头部-->
        <div class="commerciaIncome_header">
           <div>
             <span class="commercial_span_div"></span>
             <span class="commercial_font_title">收支详情表</span>
           </div>
           <div class="commercial_data">
             <i class="icon icon-ziyuan23" @click="prevDay"></i>
             <span>{{nowDate}}</span>
             <i class="icon icon-ziyuan23" @click="nextDay"></i>
           </div>
           <div class="commercial_right_deta">
             <span @click="monthClick" class="commercial_cupurt">月</span>
             <span class="commercial_span_right">日</span>
           </div>
        </div>
        <div class="commercial_text_align">{{nowDate}} {{week}}</div>
        <div class="commercial_width_div">
          <div class="commercial_width_odiv">
            <ul>
               <!--<li v-for="(income,index) in incomeData" :key="index">-->
                 <!--<p>{{new Date(income.created_at).getHours()>12?new Date(income.created_at).getHours()-12:new Date(income.created_at).getHours()}}:{{new Date(income.created_at).getMinutes()}} {{new Date(income.created_at).getHours()>12?'PM':'AM'}}</p>-->
                 <!--<div class="commercial_border_span">-->
                   <!--<span class="commercial_dot"></span>-->
                   <!--<div class="income_info">-->
                       <!--<hr class="wireborder" />-->
                       <!--<div class="commercial_user_name">-->
                           <!--<p>{{income.message}}</p>-->
                       <!--</div>-->
                       <!--<hr class="wireborder" />-->
                   <!--</div>-->
                   <!--<div class="commercial_income">-->
                     <!--<p>{{Number(income.amount)>0?'收入':'支出'}}：￥{{income.amount}}</p>-->
                     <!--<p>余额：￥{{income.balance}}</p>-->
                   <!--</div>-->
                   <!--<hr class="wireborder width_200" />-->
                   <!--<p class="commercial_p_font">到账时间：10:47AM</p>-->
                   <!--<div class="float"></div>-->
                 <!--</div>-->
               <!--</li>-->
               <li v-for="(a,i) in group" :key="i">
                 <div v-if="i>0?a.data.length>0 || group[i-1].data.length>0:a.data.length>0 || group[i+1].data.length>0">
                     <p class="trading_time">{{a.time}}</p>
                     <div class="commercial_border_span" v-for="(info,index) in a.data" :key="index">
                         <span class="commercial_dot"></span>
                         <div class="income_info">
                             <hr class="wireborder" />
                             <div class="commercial_user_name">
                                 <p>{{info.message}}</p>
                             </div>
                             <hr class="wireborder" />
                         </div>
                         <div class="commercial_income">
                             <p>{{Number(info.amount)>0?'收入':'支出'}}：￥{{info.amount}}</p>
                             <p>余额：￥{{info.balance}}</p>
                         </div>
                         <hr class="wireborder width_200" />
                         <p class="commercial_p_font">到账时间：{{new Date(info.updated_at).getHours()>=10?new Date(info.updated_at).getHours():'0'+new Date(info.updated_at).getHours()}}:{{new Date(info.updated_at).getMinutes()>=10?new Date(info.updated_at).getMinutes():'0'+new Date(info.updated_at).getMinutes()}}</p>
                         <div class="float"></div>
                     </div>
                 </div>
               </li>
            </ul>
          </div>
        </div>
        <div class="commercial_box_width">
          <p>本日收入共计：<span class="color_box_font">￥{{totalAmount}}</span></p>
          <p>余额共计：<span class="color_box_font">￥{{incomeData.length>0?incomeData[0].balance:0}}</span></p>
        </div>
    </div>
</template>

<script>
export default {
  props:['dateDaild'],
  data(){
    return{
      nowDate:'',//当前日期
      incomeData:[],//当日收支数据
      week:'',//当前星期
      totalAmount:0,//总收支
      group:[
          {time:'00:00',data:[]},
          {time:'00:30',data:[]},
          {time:'01:00',data:[]},
          {time:'01:30',data:[]},
          {time:'02:00',data:[]},
          {time:'02:30',data:[]},
          {time:'03:00',data:[]},
          {time:'03:30',data:[]},
          {time:'04:00',data:[]},
          {time:'04:30',data:[]},
          {time:'05:00',data:[]},
          {time:'05:30',data:[]},
          {time:'06:00',data:[]},
          {time:'06:30',data:[]},
          {time:'07:00',data:[]},
          {time:'07:30',data:[]},
          {time:'08:00',data:[]},
          {time:'08:30',data:[]},
          {time:'09:00',data:[]},
          {time:'09:30',data:[]},
          {time:'10:00',data:[]},
          {time:'10:30',data:[]},
          {time:'11:00',data:[]},
          {time:'11:30',data:[]},
          {time:'12:00',data:[]},
          {time:'12:30',data:[]},
          {time:'13:00',data:[]},
          {time:'13:30',data:[]},
          {time:'14:00',data:[]},
          {time:'14:30',data:[]},
          {time:'15:00',data:[]},
          {time:'15:30',data:[]},
          {time:'16:00',data:[]},
          {time:'16:30',data:[]},
          {time:'17:00',data:[]},
          {time:'17:30',data:[]},
          {time:'18:00',data:[]},
          {time:'18:30',data:[]},
          {time:'19:00',data:[]},
          {time:'19:30',data:[]},
          {time:'20:00',data:[]},
          {time:'20:30',data:[]},
          {time:'21:00',data:[]},
          {time:'21:30',data:[]},
          {time:'22:00',data:[]},
          {time:'22:30',data:[]},
          {time:'23:00',data:[]},
          {time:'23:30',data:[]},
      ],//时间段分组
    }
  },
  methods:{
    monthClick(){
      this.$emit('onClickIncome',true)
    },
    //获取当日收支数据
    getDayIncome(date){
        this.HttpClient.post('/web/user/incomeListByDate',{type:'day',begin:date+' 00:00:00',end:date+' 23:59:59'})
            .then(res=>{
                console.log(res);
                if(res.data.code===200){
                    this.incomeData=res.data.data;
                    this.totalAmount=0;
                    this.group.forEach(item=>{
                        item.data=[];
                    });
                    this.incomeData.forEach(item=>{
                        this.totalAmount+=Number(item.amount);
                        let hours=new Date(item.created_at).getHours(),
                            minutes=new Date(item.created_at).getMinutes();
                        switch (hours) {
                            case 0:
                                if(minutes<=30){
                                    this.group[0].data.push(item)
                                }else{
                                    this.group[1].data.push(item)
                                }
                                break;
                            case 1:
                                if(minutes<=30){
                                    this.group[2].data.push(item)
                                }else{
                                    this.group[3].data.push(item)
                                }
                                break;
                            case 2:
                                if(minutes<=30){
                                    this.group[4].data.push(item)
                                }else{
                                    this.group[5].data.push(item)
                                }
                                break;
                            case 3:
                                if(minutes<=30){
                                    this.group[6].data.push(item)
                                }else{
                                    this.group[7].data.push(item)
                                }
                                break;
                            case 4:
                                if(minutes<=30){
                                    this.group[8].data.push(item)
                                }else{
                                    this.group[9].data.push(item)
                                }
                                break;
                            case 5:
                                if(minutes<=30){
                                    this.group[10].data.push(item)
                                }else{
                                    this.group[11].data.push(item)
                                }
                                break;
                            case 6:
                                if(minutes<=30){
                                    this.group[12].data.push(item)
                                }else{
                                    this.group[13].data.push(item)
                                }
                                break;
                            case 7:
                                if(minutes<=30){
                                    this.group[14].data.push(item)
                                }else{
                                    this.group[15].data.push(item)
                                }
                                break;
                            case 8:
                                if(minutes<=30){
                                    this.group[16].data.push(item)
                                }else{
                                    this.group[17].data.push(item)
                                }
                                break;
                            case 9:
                                if(minutes<=30){
                                    this.group[18].data.push(item)
                                }else{
                                    this.group[19].data.push(item)
                                }
                                break;
                            case 10:
                                if(minutes<=30){
                                    this.group[20].data.push(item)
                                }else{
                                    this.group[21].data.push(item)
                                }
                                break;
                            case 11:
                                if(minutes<=30){
                                    this.group[22].data.push(item)
                                }else{
                                    this.group[23].data.push(item)
                                }
                                break;
                            case 12:
                                if(minutes<=30){
                                    this.group[24].data.push(item)
                                }else{
                                    this.group[25].data.push(item)
                                }
                                break;
                            case 13:
                                if(minutes<=30){
                                    this.group[26].data.push(item)
                                }else{
                                    this.group[27].data.push(item)
                                }
                                break;
                            case 14:
                                if(minutes<=30){
                                    this.group[28].data.push(item)
                                }else{
                                    this.group[29].data.push(item)
                                }
                                break;
                            case 15:
                                if(minutes<=30){
                                    this.group[30].data.push(item)
                                }else{
                                    this.group[31].data.push(item)
                                }
                                break;
                            case 16:
                                if(minutes<=30){
                                    this.group[32].data.push(item)
                                }else{
                                    this.group[33].data.push(item)
                                }
                                break;
                            case 17:
                                if(minutes<=30){
                                    this.group[34].data.push(item)
                                }else{
                                    this.group[35].data.push(item)
                                }
                                break;
                            case 18:
                                if(minutes<=30){
                                    this.group[36].data.push(item)
                                }else{
                                    this.group[37].data.push(item)
                                }
                                break;
                            case 19:
                                if(minutes<=30){
                                    this.group[38].data.push(item)
                                }else{
                                    this.group[39].data.push(item)
                                }
                                break;
                            case 20:
                                if(minutes<=30){
                                    this.group[40].data.push(item)
                                }else{
                                    this.group[41].data.push(item)
                                }
                                break;
                            case 21:
                                if(minutes<=30){
                                    this.group[42].data.push(item)
                                }else{
                                    this.group[43].data.push(item)
                                }
                                break;
                            case 22:
                                if(minutes<=30){
                                    this.group[44].data.push(item)
                                }else{
                                    this.group[45].data.push(item)
                                }
                                break;
                            case 23:
                                if(minutes<=30){
                                    this.group[46].data.push(item)
                                }else{
                                    this.group[47].data.push(item)
                                }
                                break;
                            default:
                                this.group[48].data.push(item);
                                break;
                        }
                    });
                }
            });
    },
    //前一日
    prevDay(){
        let dateArr=this.nowDate.split('-');
        if(parseInt(dateArr[2])===1){
            if(parseInt(dateArr[1])===1){
                dateArr[0]--;
                dateArr[1]='12';
            }else{
                dateArr[1]--;
            }
            dateArr[2]= new Date(parseInt(dateArr[0]),parseInt(dateArr[1]),0).getDate().toString();
        }else{
            dateArr[2]--
        }
        dateArr[1]=dateArr[1]<10?'0'+parseInt(dateArr[1]):dateArr[1].toString();
        dateArr[2]=dateArr[2]<10?'0'+parseInt(dateArr[2]):dateArr[2].toString();
        dateArr[0]=dateArr[0].toString();
        this.nowDate=dateArr.join('-');
        this.getDayIncome(this.nowDate);
        this.week="星期"+"日一二三四五六".charAt(new Date(this.nowDate).getDay());
    },
    //后一日
    nextDay(){
        let dateArr=this.nowDate.split('-');
        if(parseInt(dateArr[2])===new Date(parseInt(dateArr[0]),parseInt(dateArr[1]),0).getDate()){
            if(parseInt(dateArr[1])===12){
                dateArr[0]++;
                dateArr[1]='01';
            }else{
                dateArr[1]++;
            }
            dateArr[2]= '1';
        }else{
            dateArr[2]++
        }
        dateArr[1]=dateArr[1]<10?'0'+parseInt(dateArr[1]):dateArr[1].toString();
        dateArr[2]=dateArr[2]<10?'0'+parseInt(dateArr[2]):dateArr[2].toString();
        dateArr[0]=dateArr[0].toString();
        this.nowDate=dateArr.join('-');
        this.getDayIncome(this.nowDate);
        this.week="星期"+"日一二三四五六".charAt(new Date(this.nowDate).getDay());
    }
  },
  watch:{
      dateDaild(){
          console.log(this.dateDaild);
          this.nowDate=this.dateDaild;
          this.getDayIncome(this.dateDaild);
          this.week="星期"+"日一二三四五六".charAt(new Date(this.dateDaild).getDay());
      }
  }
}
</script>

<style lang="css">
.commercial_cupurt{
  cursor: pointer;
}
.color_box_font{
  font-size: 22px;
  color:#15befe;
}
.commercial_box_width>p{
  display: inline-block;
  margin-right: 20px;
  margin-left: 20px;
  color:#999999;
  font-size:14px;
}
.commercial_box_width{
  width: 100%;
  border-top:1px solid #dcdcdc;
  text-align: center;
  background-color: #FFF;
  padding: 10px;
}
.commercial_width_div::-webkit-scrollbar{
  width: 16px;
  height: 16px;
}
.commercial_width_div::-webkit-scrollbar-track{
  border-radius: 10px;
  background-color: #f2f2f2;
}

.commercial_width_div::-webkit-scrollbar-thumb{
  border-radius: 10px;
  background: url("/static/img/icon/commercial_scrollBar.png") no-repeat #2ab0f7 center center;
  background-size: 100%;
}
.width_200{
  width: 200px !important;
}
.commercial_p_font{
  color:#999999;
  margin-left: 10px;
  margin-right: 10px;
  flex:1;
}
.commercial_income>p{
  display: inline-block;
  color:#999999;
  margin-right: 10px;
  font-size: 14px;
}
.commercial_income{
  flex:2;
  margin-left: 10px;
  margin-right: 10px;
  position: relative;
  top:-2px;
}
.commercial_user_name{
  display: inline-block;
  float: left;
  font-size: 14px;
  margin-left: 10px;
  margin-right: 10px;
  color:#999999;
}
.commercial_user_name p{
    max-width:380px;
    word-wrap: break-word;
    word-break: break-all;
}
.income_info{
    width:480px;
    display:flex;
}
.income_info .wireborder{
    flex:1;
}
.wireborder{
  width: 125px;
  height:0;
  border:1px dashed #dcdcdc;
  display: inline-block;
  position: relative;
  top:2.4px;
  left:-2px;
  float: left;
}
.commercial_dot{
  display: inline-block;
  width: 10px;
  height: 10px;
  background-color: #999999;
  border-radius: 10px;
  float: left;
  position: relative;
  top:3px;
  z-index: 99;
}
.commercial_border_span{
  width: 100%;
  position: relative;
  top:32px;
  left:-5px;
  margin-bottom:10px;
  display:flex;
  justify-content:flex-start;
}
.commercial_width_odiv ul li{
  margin-bottom:20px;
}
.commercial_width_odiv ul li .trading_time{
  width: 100px;
  text-align: center;
  font-size: 18px;
  background-color: #FFF;
  padding: 0;
  position:relative;
  left:-45px;
  top:20px;
}
.commercial_width_odiv{
  width: 1110px;
  border-left:1px solid #dcdcdc;
  margin: 0 0 0 70px;
}
.commercial_width_div{
  width: 100%;
  border-left:1px solid #ebebeb;
  border-right:1px solid #ebebeb;
  height: 600px;
  background-color: #FFF;
  overflow: auto;
}
.commercial_text_align{
  border-left:1px solid #ebebeb;
  border-right:1px solid #ebebeb;
  background-color: #f2f7f8;
  text-align: center;
  padding: 10px;
  font-size:14px;
}
.commercial_span_right{
  margin-left: 10px;
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
  position:relative;
  top:3px;
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
