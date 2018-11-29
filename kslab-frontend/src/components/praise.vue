<template>
    <div class="praise_ctrl">
        <i class="praise_ctrl_box"><i class="praise_ctrl_icon praise_ctrl_icon_top" @click="addPraise(type,index,type[index].praise)"></i></i>
        <span class="info_ctrl_num">{{type[index].praise}}</span>
        <i class="praise_ctrl_box"><i class="praise_ctrl_icon praise_ctrl_icon_bottom" @click="trample(type,index,type[index].praise)"></i></i>
    </div>
</template>

<script>
    export default {
        name: "praise",
        data(){
            return {
                praiseTimes:0,
                trampleTimes:0,
            }
        },
        props:['type','index','letType'],
        methods:{
            addPraise(type,index,praise){
                console.log(type[index].state);
                if(this.praiseTimes>0){
                    this.$message.warning('您已经点过赞了！')
                }else{
                    let state=parseInt(type[index].state);
                    if(state===0){
                        type[index].praise=parseInt(praise)+1;
                        state+=1;
                        this.praiseTimes+=1;
                        this.HttpClient.post('/upvote',{
                          token:window.localStorage.token,
                          source_id:type[index].id,
                          type:this.letType,
                          is_like:1
                        })
                        .then((res) =>{
                          this.$message({
                            message: res.data.msg,
                            type: 'success'
                          });
                        })
                        .catch((err) => {
                          type[0].praise -= 1;
                          this.userIfStatus(err)
                        })
                        console.log(state);
                    }else if(state<0){
                        console.log("第二次点赞")
                        type[index].praise=parseInt(praise)+2;
                        state+=2;
                        this.praiseTimes+=1;
                    }else{
                        this.$message.warning('您已经点过赞了！')
                    }
                }
            },
            trample(type,index,praise){
                console.log(type[index].state);
                this.HttpClient.post('/upvote',{
                  token:window.localStorage.token,
                  source_id:type[index].id,
                  type:this.letType,
                  is_like:0
                })
                .then((res) =>{
                  console.log(res)
                })
                if(this.trampleTimes>0){
                    this.$message.warning('您已经踩过了！')
                }else{
                    let state=type[index].state;
                    if(state===0){
                        type[index].praise=parseInt(praise)-1;
                        state-=1;
                        this.trampleTimes+=1;
                    }else if(type[index].state>0){
                        type[index].praise=parseInt(praise)-2;
                        state-=2;
                        this.trampleTimes+=1;
                    }else{
                        this.$message.warning('您已经踩过了！')
                    }
                }
            }
        },
    }
</script>

<style scoped>
    .praise_ctrl{
        display:inline-block;
        margin-top:0;
        text-align: center;
        width:50px;
    }
    .praise_ctrl_box{
        display:block;
        position:relative;
        width:16px;
        height:14px;
        overflow:hidden;
        margin:0 auto;
    }
    .praise_ctrl_icon{
        display:block;
        width:0;
        height:0;
        cursor:pointer;
        border-style:solid;
        border-left-width:8px;
        border-right-width:8px;
        border-top-width:14px;
        border-bottom-width:14px;
        border-color:transparent;
    }
    .praise_ctrl_icon_top{
        position:absolute;
        top:-14px;
        border-bottom-color:#d6d6d6;
        left:50%;
        margin-left:-7px;
    }
    .praise_ctrl_icon_top:hover{
        border-bottom-color:#15bafe;
    }
    .praise_ctrl_icon_bottom{
        position:absolute;
        bottom:-14px;
        border-top-color:#d6d6d6;
    }
    .praise_ctrl_icon_bottom:hover{
        border-top-color:#15bafe;
    }
    .praise_ctrl .info_ctrl_num{
        text-align:center;
    }
</style>
