<template>
    <input type="text" :id="id" placeholder="请选择活动日期">
</template>

<script>

    // import '@/assets/js/laydate/laydate.js'

    export default {
        name: "layDate",
        data(){
            return {
                id:""
            }
        },
        methods:{
            output(id){
                this.id=id;
            }
        },
        updated(){
            //执行一个laydate实例
            laydate.render({
                elem: '#'+this.id //指定元素
            });
        }
    }
</script>

<style>

    .layui-laydate-header{
        background:#15bafe;
    }

    .laydate-set-ym{
        width:90%!important;
        margin-left:6px;
        border-radius:15px;
        background:#13a7e4;
        color:#fff;
    }

    .laydate-set-ym span:hover{
        color:#15bafe;
    }

    .laydate-icon{
        width:30px;
        height:30px;
        color:#fff!important;
    }

    .laydate-icon:hover{
        /*border-radius:50%;*/
        /*background:#13a7e4;*/
        color:#13a7e4!important;
    }

    .layui-laydate .layui-this{
        background:#15bafe!important;
        /*border-radius:50%;*/
    }

</style>