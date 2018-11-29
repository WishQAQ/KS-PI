<template>
    <div class="activity-data">
        <div class="head">
            活动数据     
        </div>
        <div class="content">
            <div class="title">
                <p>活动数据</p>
                <p>
                    <img src="../../assets/image/new.png" alt="">
                    <span>刷新</span>
                </p>
            </div>
            <div class="box">
                <!-- 活动总数据 -->
                <div class="act-all">
                    <div class="til">
                        <img src="../../assets/image/xin.png" alt="">
                        <span>活动总数&nbsp;&nbsp;{{activityTotal}}</span>
                    </div>
                    <div class="lei cl-lei">
                        <div class="shu" v-for="item in activityType" :key="item.id">{{item.name}}</div>
                    </div>
                    <div class="lei">
                        <div class="shu" v-for="item in activityType" :key="item.id">{{item.number}}</div>
                    </div>
                </div>
                <!-- 选择时间 -->
                <div class="slect">
                    <div class="riqi">
                        <div class="start">
                            <span>开始</span>
                            <el-date-picker
                                    v-model="startTime"
                                    class="inputdata"
                                    type="date"
                                    value-format="yyyy-MM-dd HH:mm:ss"
                                    placeholder="选择日期"
                                    @change="getActivityData">
                            </el-date-picker>
                        </div>
                        <div class="end">
                            <span>截止</span>
                            <el-date-picker
                                    v-model="endTime"
                                    class="inputdata"
                                    type="date"
                                    placeholder="选择日期"
                                    value-format="yyyy-MM-dd HH:mm:ss"
                                    @change="getActivityData"
                                    :picker-options="pickerOptions">
                            </el-date-picker>
                        </div>
                        <div class="state">
                            <el-dropdown trigger="click" class="jz">
                                <span class="el-dropdown-link">
                                   {{name}}<i class="el-icon-arrow-right el-icon--right"></i>
                                </span>
                                <el-dropdown-menu slot="dropdown" >
                                    <el-dropdown-item class="bg">全部</el-dropdown-item>
                                    <el-dropdown-item class="bg">未通过</el-dropdown-item>
                                </el-dropdown-menu>
                            </el-dropdown>
                        </div>
                    </div>
                    <!-- 曲线图 -->
                    <div class="curve">
                        <div class="bt-title">
                            <div class="cur-left">
                                <p>活动数据曲线图</p>
                                <span>{{startTime.split(' ')[0]}}——{{endTime.split(' ')[0]}}</span>
                            </div>
                            <div class="cur-right">
                                <div>
                                    <div class="qiche"></div>
                                    <span>汽车</span>
                                </div>
                                <div>
                                    <div class="motoche"></div>
                                    <span>摩托车</span>
                                </div>
                                <div>
                                    <div class="wurenji"></div>
                                    <span>无人机</span>
                                </div>
                                <div>
                                    <div class="intelligent"></div>
                                    <span>智能设备</span>
                                </div>
                            </div>
                        </div>
                        <Curve :curveData="curveData" @sendTotal="getTotalData"></Curve>
                    </div>
                    <!-- 汽车数据 -->
                    <div class="car">
                        <div class="car-top">
                            <img src="../../assets/image/qiche.png" alt="">
                            <div class="jindu">
                                <div class="jindu-top">
                                    <span>汽车</span>
                                    <span>CAR</span>
                                </div>
                                <div class="color">
                                    <div></div>
                                </div>
                            </div>
                            <div class="baifb">
                                <p>{{(carTotalByDate/totalByDate*100).toString().indexOf('.')!==-1?
                                    (carTotalByDate/totalByDate*100).toFixed(2):carTotalByDate/totalByDate*100}}%</p>
                            </div>
                            <div class="car-info" @click="eject($event)">
                                <div>
                                    <span>汽车详情</span>
                                    <img  src="../../assets/image/yuanjtx.png" alt="" >
                                    <img  src="../../assets/image/yuanjt.png" alt="" class="rotate">
                                </div>
                            </div>
                        </div>
                        <!-- 汽车分类 -->
                        <div class="qc-category rotate">
                            <div class="category" v-for="item in carData">
                                <div class="category-top">
                                    <span>{{item.name}}</span>
                                    <span>{{item.kuandu}}%</span>
                                </div>
                                <div class="category-color">
                                    <div :style="{width:item.kuandu+'%'}"></div>
                                </div>
                            </div>
                            <!-- <div class="category">
                                <div class="category-top">
                                    <span>改装</span>
                                    <span>86%</span>
                                </div>
                                <div class="category-color">
                                    <div></div>
                                </div>
                            </div>
                            <div class="category">
                                <div class="category-top">
                                    <span>改装</span>
                                    <span>86%</span>
                                </div>
                                <div class="category-color">
                                    <div></div>
                                </div>
                            </div>
                            <div class="category">
                                <div class="category-top">
                                    <span>改装</span>
                                    <span>86%</span>
                                </div>
                                <div class="category-color">
                                    <div></div>
                                </div>
                            </div>
                            <div class="category">
                                <div class="category-top">
                                    <span>改装</span>
                                    <span>86%</span>
                                </div>
                                <div class="category-color">
                                    <div></div>
                                </div>
                            </div>  -->
                        </div>
                    </div>
                    <!-- 摩托车数据 -->
                    <div class="car">
                        <div class="car-top">
                            <img src="../../assets/image/motuo.png" alt="">
                            <div class="jindu">
                                <div class="jindu-top">
                                    <span>摩托车</span>
                                    <span>MOTO</span>
                                </div>
                                <div class="color">
                                    <div></div>
                                </div>
                            </div>
                            <div class="baifb">
                                <p>{{(motorTotalByDate/totalByDate*100).toString().indexOf('.')!==-1?
                                    (motorTotalByDate/totalByDate*100).toFixed(2):motorTotalByDate/totalByDate*100}}%</p>
                            </div>
                            <div class="car-info"  @click="eject($event)">
                                <div>
                                    <span>摩托车详情</span>
                                    <img  src="../../assets/image/yuanjtx.png" alt="" >
                                    <img  src="../../assets/image/yuanjt.png" alt="" class="rotate">
                                </div>
                            </div>
                        </div>
                        <!-- 摩托车分类 -->
                        <div class="qc-category rotate" >
                            <div class="category" v-for="item in motoData">
                                <div class="category-top">
                                    <span>{{item.name}}</span>
                                    <span>{{item.kuandu}}%</span>
                                </div>
                                <div class="category-color">
                                    <div :style="{width:item.kuandu+'%'}"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- 无人机 -->
                    <div class="car">
                        <div class="car-top">
                            <img src="../../assets/image/plan.png" alt="">
                            <div class="jindu">
                                <div class="jindu-top">
                                    <span>无人机</span>
                                    <span>UAV</span>
                                </div>
                                <div class="color">
                                    <div></div>
                                </div>
                            </div>
                            <div class="baifb">
                                <p>{{(planeTotalByDate/totalByDate*100).toString().indexOf('.')!==-1?
                                    (planeTotalByDate/totalByDate*100).toFixed(2):planeTotalByDate/totalByDate*100}}%</p>
                            </div>
                            <div class="car-info"  @click="eject($event)">
                                <div>
                                    <span>无人机详情</span>
                                    <img  src="../../assets/image/yuanjtx.png" alt="" >
                                    <img  src="../../assets/image/yuanjt.png" alt="" class="rotate">
                                </div>
                            </div>
                        </div>
                        <!-- 无人机分类 -->
                        <div class="qc-category rotate" >
                            <div class="category" v-for="item in planData">
                                <div class="category-top">
                                    <span>{{item.name}}</span>
                                    <span>{{item.kuandu}}%</span>
                                </div>
                                <div class="category-color">
                                    <div :style="{width:item.kuandu+'%'}"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!--智能设备-->
                    <div class="car">
                        <div class="car-top">
                            <img src="../../assets/image/plan.png" alt="">
                            <div class="jindu">
                                <div class="jindu-top">
                                    <span>智能设备</span>
                                    <span>SMART</span>
                                </div>
                                <div class="color">
                                    <div></div>
                                </div>
                            </div>
                            <div class="baifb">
                                <p>{{(intelligentTotalByDate/totalByDate*100).toString().indexOf('.')!==-1?
                                    (intelligentTotalByDate/totalByDate*100).toFixed(2):intelligentTotalByDate/totalByDate*100}}%</p>
                            </div>
                            <div class="car-info"  @click="eject($event)">
                                <div>
                                    <span>无人机详情</span>
                                    <img  src="../../assets/image/yuanjtx.png" alt="" >
                                    <img  src="../../assets/image/yuanjt.png" alt="" class="rotate">
                                </div>
                            </div>
                        </div>
                        <!-- 智能设备分类 -->
                        <div class="qc-category rotate" >
                            <div class="category" v-for="item in planData">
                                <div class="category-top">
                                    <span>{{item.name}}</span>
                                    <span>{{item.kuandu}}%</span>
                                </div>
                                <div class="category-color">
                                    <div :style="{width:item.kuandu+'%'}"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
import Curve from '@/components/public/Curve'
    export default {
        name: "ActivityData",
        components:{
            Curve
        },
        data (){
            return {

                //时间选择范围限制
                pickerOptions: {
                    disabledDate: (time) => {
                        console.log((time.getTime() - new Date(this.startTime).getTime()) / 1000 / 60 / 60 / 24);
                        return ((time.getTime()-new Date(this.startTime).getTime())/1000/60/60/24)>31
                    }
                },

                startTime:'',
                endTime:'',
                name:"选择状态",
                show:true,
                total:{
                    car:500,
                    moto:555,
                    plan:45,
                },
                curveData:{
                    cuCar:[37,12,23,34,23,45,12,13,24,53,12,32,65,12,34,22,12,34,21,33,12,23,43,45,12,52,12,33,31,12],
                    cuMotor:[23,41,23,31,33,34,12,9,45,32,52,43,21,10,32,42,23,55,22,44,66,12,32,43,53,21,9,43,23,8],
                    cuPlan:[21,23,34,54,17,18,29,20,38,47,25,10,29,45,32,45,21,63,23,43,9,33,20,12,34,26,39,57,23,35],
                    cuIntelligent:[],
                    startTime:'',
                    endTime:''
                },//曲线数据
                kuandu:80,
                carData:[
                    {
                        name:"改装", kuandu:40,
                    },
                    {
                        name:"试驾", kuandu:60,
                    },
                    {
                        name:"预约", kuandu:80,
                    }
                ],
                motoData:[
                    {
                        name:"改装",kuandu:40,
                    },
                    {
                        name:"试驾",kuandu:60,
                    },
                    {
                        name:"预约",kuandu:80
                    }
                ],
                planData:[
                    {
                        name:"改装",kuandu:40,
                    },
                    {
                        name:"试驾",kuandu:60,
                    },
                    {
                        name:"预约",kuandu:80
                    }
                ],

                activityType:[],//活动类型数组
                activityTotal:0,//总活动数
                carActivity:[],//汽车活动统计
                motorActivity:[],//摩托车活动统计
                planeActivity:[],//无人机活动统计
                intelligentActivity:[],//智能设备活动统计
                carTotalByDate:0,//汽车分类总数(时间段内)
                motorTotalByDate:0,//摩托车分类总数(时间段内)
                planeTotalByDate:0,//无人机分类总数(时间段内)
                intelligentTotalByDate:0,//智能设备分类总数(时间段内)
                totalByDate:0,//总活动数(时间段内)

            }
        },
        mounted(){
            this.all = this.total.car+this.total.moto+this.total.plan
        },
        methods:{
            // ddd(){
            //     //转换时间格式
            //     var d = new Date(this.value1);  
            //     var time1=d.getFullYear() + '-' + (d.getMonth() + 1) + '-' + d.getDate(); 
            //     // console.log(time1)
            //     this.time1 = time1
            // },
            // dd(){
            //     // 转换时间格式
            //     var d = new Date(this.value2);  
            //     var time2=d.getFullYear() + '-' + (d.getMonth() + 1) + '-' + d.getDate(); 
            //     // console.log(time2)
            //     this.time2 = time2
            // },
           eject(e){
                // console.log(e.currentTarget.children[0].children[1])
                // console.log(e.currentTarget.parentNode.parentNode.children[1])
               if(this.show){
                    this.show = false;
                    e.currentTarget.parentNode.parentNode.children[1].classList.remove("rotate");
                    e.currentTarget.children[0].children[1].classList.add("rotate");
                    e.currentTarget.children[0].children[2].classList.remove("rotate")
               }else{
                    this.show = true;
                    e.currentTarget.parentNode.parentNode.children[1].classList.add("rotate");
                    e.currentTarget.children[0].children[1].classList.remove("rotate");
                    e.currentTarget.children[0].children[2].classList.add("rotate")
               }
           },

           /****************************数据相关********************************/
           getActivityData(){
               this.HttpClient.post('/admin/analysis/diagram',{type:5,begin:this.startTime,end:this.endTime})
                   .then(res=>{
                       console.log(res);
                       if(res.data.code===200){
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
                           this.curveData.cuCar=this.carActivity;
                           this.curveData.cuMotor=this.motorActivity;
                           this.curveData.cuPlan=this.planeActivity;
                           this.curveData.cuIntelligent=this.intelligentActivity;
                           this.curveData.startTime=this.startTime;
                           this.curveData.endTime=this.endTime;
                       }
                   })
           },

           //获取分类活动总数
           getTotalData(total){
               console.log(total);
               this.carTotalByDate=total.car;
               this.motorTotalByDate=total.motor;
               this.planeTotalByDate=total.plane;
               this.intelligentTotalByDate=total.intelligent;
               this.totalByDate=total.car+total.motor+total.plane+total.intelligent
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
            //获取活动类型统计数据
            this.HttpClient.post('/admin/analysis/numCache',{type:5})
                .then(res=>{
                    console.log(res);
                    if(res.data.code===200){
                        this.activityType=res.data.data;
                        this.activityType.map(item=>{
                            item.number=0;
                            item.number+=Number(item.analysis.company_actives);
                            item.number+=Number(item.analysis.normal_actives);
                            this.activityTotal+=item.number;
                        })
                    }
                });
            this.getActivityData()
        }
    }
</script>

<style scoped>
    .activity-data{width: 100%;padding: 0 15px; box-sizing: border-box;height: calc(100vh - 90px);}
    .head{height:50px ;width: 100%;text-align: start;line-height: 50px;color: #a0a0a0;font-size: 14px;}
    .content{background: #fff;border-radius: 8px;}
    .title{text-align: start;height: 70px;line-height: 70px;border-bottom: 2px solid #f2f2f2;padding:0 50px;display: flex;justify-content: space-between;color: #222222;}
    .box{width: 100%;padding: 33px 46px;box-sizing: border-box;}
    .act-all{width: 500px;height: 150px;border: 1px solid #e8e8e8;}
    .til{width: 100%;height: 40px;background: #15bafe;text-align: center;line-height: 40px;color: #fff;}
    .lei{width: 100%;height: 55px;display: flex;}
    .cl-lei{border-bottom:1px solid #e8e8e8;}
    .shu{border-right: 1px solid #e8e8e8;}
    .lei>div{width: 33.3333%;height: 100%;text-align: center;line-height: 53px;}
    input{outline: none !important;}
    .riqi{display: flex;margin-top: 40px;}
    .start{height: 40px;width: 190px; border:1px solid #999999;display: flex;justify-content: space-between;border-radius: 5px;}
    .start>span{margin: auto;color: #666666;font-size: 14px;}
    .el-date-editor.el-input, .el-date-editor.el-input__inner{width: 135px !important;}
    .el-input--small .el-input__inner{height: 40px !important;}
    .el-input__inner{ height: 40px !important;border-radius: 0 ! important;}
    .end{height: 40px;width: 190px; border:1px solid #999999;display: flex;justify-content: space-between;border-radius: 5px;margin-left: 15px;}
    .end>span{margin: auto;color: #666666;font-size: 14px;}
    .state{width: 135px;height: 40px;border:1px solid #7d7d7d;line-height: 40px;border-radius: 4px;margin-left: 15px;}
    .jz{margin: auto;}
    .bg{padding: 0 ;margin: 0 20px;border-bottom: 1px solid #dcdcdc;}
    .el-dropdown-menu__item:focus, .el-dropdown-menu__item:not(.is-disabled):hover{color: #66b1ff;background-color: #fff;}
    /* 活动曲线板块 */
    .curve{border: 1px solid #e9f1f3;margin-top: 25px;}
    .bt-title{display: flex;justify-content: space-between;padding: 0 80px;box-sizing: border-box;margin-top: 25px;}
    .cur-right{display: flex;}
    .cur-right>div{display: flex;align-items: center;}
    .cur-right>div>div{width: 8px;height: 8px;;border-radius: 50%;margin-right: 7px;margin-left: 30px;}
    .qiche{background: #009efb;}
    .motoche{background: #55ce63;}
    .wurenji{background: #ff7676;}
    .intelligent{background: #FFB82E;}
    .cur-left>p{font-size: 21px;color: #222222;text-align: start;margin-bottom: 12px;}
    .cur-left>span{font-size: 14px;color: #999999;}
    /* 汽车 */
    .car{margin-top: 10px;width: 100%;}
    .car-top{width: 550px;height: 110px;border: 1px solid #e9f1f3;display: flex;align-items: center;justify-content: space-around;}
    .car-top>img{width: 58px;height: 58px;}
    .car-info{height: 90px;width: 150px;border-left: 1px solid #f3f4f5;text-align: center;display: flex;align-items: center;justify-content:center;}
    .car-info>div{display: flex;align-items: center;color: #666666;font-size: 16px;}
    .car-info>div>img{width: 20px;height: 20px;margin-left: 9px;}
    .color{width: 143px;height: 8px;background: #f3f4f5;}
    .color>div{width: 50%;height: 100%; background: #009efb;margin-top: 18px;}
    .jindu-top{text-align: start;}
    .jindu-top>span:nth-child(1){font-size: 19px;color: #222222;}
    .jindu-top>span:nth-child(2){font-size: 16px;color: #999999;}
    .baifb{font-size: 32px;}
    .qc-category{width: 100%;height: 160px;border: 1px solid #e9f1f3;}
    .category{width: 25%;height: 80px;float: left;border-bottom: 1px solid #e9f1f3;border-right: 1px solid #e9f1f3;box-sizing: border-box;padding: 20px 33px;}
    .category-top{display: flex;justify-content: space-between;font-size: 18px;color: #222222;}
    .category-color{width: 100%;height: 4px;background: #f3f4f5;}
    .category-color>div{width: 80%;height: 4px;background: #15bafe;margin-top: 13px;}
    .rotate{display: none}
</style>
<style lang="less">
.inputdata{
    .el-input__inner{
        border: none;
}
}


</style>

