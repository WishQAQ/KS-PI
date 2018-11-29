<template>
    <div class="is_login modalBox" v-if="showModal">
        <div class="modalBox_title">
            <p><img src="/static/img/logo/logo_block.png" alt=""></p>
            <div class="modelDelete" @click="cancelClick">
                <p></p>
                <p></p>
            </div>
        </div>


        <div class="modalBox_box">
            <span><img src="/static/img/icon/notPass.png" alt=""></span>
            <p class="prompt_txt">未登录，不能进行此操作</p>
            <div class="modalBox_box_btm">
                <p @click="cancelClick">取消</p>
                <p @click="confirmClick">去登录</p>
            </div>
        </div>
    </div>
</template>

<script>
    export default {
        name: "isLogin",
        data(){
            return{
                showModal:false,
            }
        },
        methods:{
            cancelClick(){
                this.showModal=false;
            },
            confirmClick(){
                window.localStorage.clear();
                this.$router.push({path:'/login'})
            }
        }
    }
</script>

<style src="@/assets/css/modalBox.css"></style>
<style scoped>
    .info_prompt{
        width:400px;
        z-index:99;
    }
    .modalBox_title{
        border-bottom:1px solid #f4f4f4;
    }
</style>