<template>
    <div class="disk" >
       <div :id="ids" :name="names" style="height:270px;width:320px"></div>
    </div>
</template>

<script>
import echarts from 'echarts'
export default {
    name: "Disk",
    data(){
        return {
            
        }
    },
    mounted(){
        this.drawLine();
    },
    props:["ids","names"],
    created(){
        // console.log(this.names)
    },
    methods:{
        drawLine(){
            // 基于准备好的dom，初始化echarts实例
            var myChart = echarts.init(document.getElementById(this.ids));
            // 绘制图表
            myChart.setOption({
                tooltip: {
        trigger: 'item',
        formatter: "{a} <br/>{b}: {c} ({d}%)"
    },
    color:["#15bafe","#1e88e5"],
    // legend: {
    //     orient: 'vertical',
    //     x: 'left',
    //     data:['直接访问','邮件营销']
    // },
    graphic:{
        type:'text',
        left:'center',
        top:'center',
        style:{
            text:'50%\n'+'今日'+this.names+'增长率', //使用“+”可以使每行文字居中
            textAlign:'center',
            font:' 16px cursive',
            fill:'#000',
            width:30,
            height:30
        }
    },
    series: [
        {
            name:'访问来源',
            type:'pie',
            radius: ['50%', '70%'],
            avoidLabelOverlap: false,
            label: {
                normal: {
                    show: false,
                    position: 'center'
                },
                emphasis: {
                    show: false,
                    textStyle: {
                        fontSize: '30',
                        fontWeight: 'bold'
                    }
                }
            },
            labelLine: {
                normal: {
                    show: false
                }
            },
            data:[
                {value:15111, name:'增长人数'},
                {value:1500, name:'总人数'},
                // {value:234, name:'联盟广告'},
                // {value:135, name:'视频广告'},
                // {value:1548, name:'搜索引擎'}
            ]
        }
    ]
            });
        }
    }
}

</script>

<style scoped>
    #main1{margin: 0 auto;}
    #main2{margin: 0 auto;}
    
</style>