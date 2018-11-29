<template>
    <div class="info_prompt modalBox" v-if="showModal">
        <div class="modalBox_title">
            <p><img src="/static/img/logo/logo_block.png" alt=""></p>
            <div class="modelDelete" @click="cancelClick">
                <p></p>
                <p></p>
            </div>
        </div>


        <div class="modalBox_box">
            <span><img :src="active.pic" alt=""></span>
            <p class="prompt_txt">{{active.status}}</p>
            <p class="prompt_reason">{{reason}}</p>
            <div class="modalBox_box_btm">
                <p @click="cancelClick">确定</p>
            </div>
        </div>
    </div>
</template>

<script>
    export default {
        name: "infoPrompt",
        data(){
            return {
                showModal:false,
                warehouse:[//仓库
                    {status:'状态正常',pic:'/static/img/icon/normal.png'},
                    {status:'审核未通过',pic:'/static/img/icon/notPass.png'},
                    {status:'系统正在审核此商品，请稍后查看',pic:'/static/img/icon/wait.png'},
                    {status:'商品已下架，用户无法进行购买',pic:'/static/img/icon/soldOut.png'},
                ],
                upload:[//上传管理
                    {status:'其他用户可以正常查看你的上传',pic:'/static/img/icon/normal.png'},
                    {status:'审核未通过',pic:'/static/img/icon/notPass.png'},
                    {status:'系统还在审核你的上传，稍后再查看',pic:'/static/img/icon/wait.png'},
                ],
                activity:[//活动
                    {status:'用户可以浏览和参加活动',pic:'/static/img/icon/normal.png'},
                    {status:'审核未通过',pic:'/static/img/icon/notPass.png'},
                    {status:'系统还未完成审核，请稍后再查看',pic:'/static/img/icon/wait.png'},
                    {status:'当前用户无法报名',pic:'/static/img/icon/pause.png'},
                    {status:'系统已暂停你的活动，详情请咨询客服',pic:'/static/img/icon/stop.png'},
                ],
                active:{},
                reason:''
            }
        },
        methods:{
            cancelClick(){
                this.showModal = false
            },
            getTips(type,status,reason){
                if(type==='warehouse'){
                    if(status==='状态正常') {
                        this.active = this.warehouse[0]
                    }else if(status==='审核未通过'){
                        this.active = this.warehouse[1]
                    }else if(status==='系统正在审核此商品，请稍后查看'){
                        this.active = this.warehouse[2]
                    }else{
                        this.active = this.warehouse[3]
                    }
                }else if(type==='upload'){
                    if(status===1) {
                        this.active = this.upload[0]
                    }else if(status===3){
                        this.active = this.upload[1]
                    }else{
                        this.active = this.upload[2]
                    }
                }else{
                    if(status==='用户可以浏览和参加活动') {
                        this.active = this.activity[0]
                    }else if(status==='审核未通过'){
                        this.active = this.activity[1]
                    }else if(status==='系统还未完成审核，请稍后查看'){
                        this.active = this.activity[2]
                    }else if(status==='当前用户无法报名'){
                        this.active = this.activity[3]
                    }else{
                        this.active = this.activity[4]
                    }
                }
                this.reason=reason;
            }
        }
    }
</script>

<style src="@/assets/css/modalBox.css"></style>
<style scoped>
    .info_prompt{
        width:400px;
        z-index:1000;
    }
    .modalBox_title{
        border-bottom:1px solid #f4f4f4;
    }
</style>