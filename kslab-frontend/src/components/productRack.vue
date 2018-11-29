<template>
    <div class="product_preview_img">
        <div class="product_img_md">
            <video id="video" :src="request.picUrl+video" v-show="picIndex===null" @click.stop="paused"></video>
            <div class="video_control" v-if="picIndex===null && showControl" @click="videoControl">
                <i class="icon" :class="{'icon-bofang':isPaused,'icon-zanting':!isPaused}"></i>
            </div>
            <img :src="request.picUrl+image[picIndex]+(width<=1180?'?imageView2/1/w/317/h/317':'?imageView2/1/w/442/h/365')" alt="" v-show="picIndex!==null">
        </div>
        <div class="product_img_sm">
            <span class="product_img_prev" @click="changeImg('prev')" v-if="this.image.length>5">
                <i class="el-icon-arrow-left"></i>
            </span>
            <div class="product_img_list_box">
                <ul class="product_img_list">
                    <li class="product_img_list_item product_img_list_item_video" :class="{active:picIndex===null}" v-if="video" @mouseenter="picChange(null)">
                        <img :src="request.picUrl+image[0]+(width<=1180?'?imageView2/1/w/46/h/46':'?imageView2/1/w/66/h/66')">
                        <div class="product_list_item_video_task">
                            <div class="video_control">
                                <i class="icon icon-bofang"></i>
                            </div>
                        </div>
                    </li>
                    <li class="product_img_list_item" :class="{active:picIndex===i}" v-for="(pic,i) in image" :key="i" @mouseenter="picChange(i)">
                        <img :src="request.picUrl+pic+(width<=1180?'?imageView2/1/w/46/h/46':'?imageView2/1/w/66/h/66')" alt="">
                    </li>
                </ul>
            </div>
            <span class="product_img_next" @click="changeImg('next')" v-if="this.image.length>5">
                <i class="el-icon-arrow-right"></i>
            </span>
        </div>
    </div>
</template>

<script>
    export default {
        name: "productRack",
        props:['video','image'],//video:视频地址,image:图片数组
        data(){
            return {
                width:(document.documentElement.offsetWidth || document.body.offsetWidth)+17,//屏幕宽度
                picIndex:0,//详情图片下标
                showControl:true,
                isPaused:true,
            }
        },
        methods:{
            picChange(i){//大图切换
                this.picIndex=i;
                console.log(this.picIndex);
            },
            changeImg(type){//小图左右切换
                let $ul=$('.product_img_list');
                let left=parseFloat($ul.css('left'));
                if(type==='prev' && left!==0){
                    if(this.width<=1180){
                        console.log(left);
                        left+=54.25;
                        $ul.css('left',left+'px')
                    }else{
                        left+=80;
                        $ul.css('left',left+'px')
                    }
                }else if(type==='next'){
                    let times=this.image.length-5;
                    if(this.video){
                        times+=1
                    }
                    if(this.width<=1180){
                        if(left<=-54.25*times){
                            return
                        }
                        left-=54.25;
                        $ul.css('left',left+'px')
                    }else{
                        if(left<=-80*times){
                            return
                        }
                        left-=80;
                        $ul.css('left',left+'px')
                    }
                }
            },
            videoControl(){
                let video=document.getElementById("video");
                if(video.paused){
                    video.play();
                    this.showControl=false;
                    this.isPaused=false;
                    video.addEventListener('ended',()=>{
                        video.currentTime=0;
                        video.pause();
                        this.showControl=true;
                        this.isPaused=true
                    })
                }else{
                    video.pause();
                    this.showControl=true;
                    this.isPaused=true
                }
            },
            paused(){
                let video=document.getElementById("video");
                if(!video.paused){
                    this.showControl=!this.showControl
                }
            },
        },
        mounted(){
            const that = this;
            window.onresize = function temp() {
                that.width = (document.documentElement.offsetWidth || document.body.offsetWidth)+17;
                console.log(that.width);
            };
        }
    }
</script>

<style scoped>
    .product_preview_img{
        display:inline-block;
        width:442px;
        margin-right:31px;
    }
    .product_preview_img .product_img_md{
        position:relative;
        display:flex;
        align-items:center;
        justify-content:center;
        width:100%;
        height:365px;
        margin-bottom:10px;
        background:#000;
        overflow:hidden;
    }
    .product_preview_img .product_img_md #video{
        /*width:442px;*/
        height:100%;
    }
    .video_control{
        position:absolute;
        z-index:10;
        width:54px;
        height:54px;
        cursor:pointer;
        text-align:center;
        background:rgba(102,102,102,.5);
        border:1px solid #fff;
        border-radius:50%;
    }
    .video_control:hover{
        /*color:#15bafe;*/
        background:rgba(0,0,0,.5);
    }
    .video_control .icon-bofang,
    .video_control .icon-zanting{
        color:#fff;
        font-size:18px;
        position:relative;
        top:11px;
        left:.08rem;
    }
    .video_control .icon-zanting{
        left:1px;
    }
    .product_preview_img .product_img_sm{
        display:flex;
        align-items:center;
        justify-content:space-between;
    }
    .product_preview_img .product_img_sm .product_img_prev,
    .product_preview_img .product_img_sm .product_img_next{
        display:block;
        background:#fff;
        opacity:.2;
        font-size:24px;
        height:60px;
        line-height:60px;
        text-align:center;
        color:#000;
    }
    .product_preview_img .product_img_sm .product_img_prev:hover,
    .product_preview_img .product_img_sm .product_img_next:hover{
        opacity:1;
    }
    .product_preview_img .product_img_sm .product_img_list_box{
        overflow:hidden;
    }
    .product_img_sm .product_img_list{
        display:flex;
        position:relative;
        left:0;
    }
    .product_img_sm .product_img_list_item{
        width:70px;
        height:70px;
        margin-right:10px;
        cursor:pointer;
        border:2px solid transparent;
    }
    .product_img_sm .product_img_list_item:hover{
        border-color:#15bafe;
    }
    .product_img_sm .product_img_list_item.active{
        border-color:#15bafe;
    }
    .product_img_sm .product_img_list_item:last-child{
        margin:0;
    }
    .product_img_sm .product_img_list_item_video{
        position:relative;
    }
    .product_img_sm .product_list_item_video_task{
        position:absolute;
        top:0;left:0;
        width:100%;
        height:100%;
        display:flex;
        align-items:center;
        justify-content:center;
        background:rgba(0,0,0,.5);
    }
    .product_list_item_video_task .video_control{
        width:24px;
        height:24px;
    }
    .product_list_item_video_task .video_control .icon-bofang,
    .product_list_item_video_task .video_control .icon-zanting{
        font-size:12px;
        top:0.1rem;
    }


    /*******960兼容*******/
    @media screen and (max-width:1180px) and (min-width:960px) {
        .product_preview_img{
            width:317px!important;
            margin-right:14px!important;
        }
        .product_preview_img .product_img_md{
            height:317px!important;
        }
        .product_preview_img .product_img_md .video_control .icon-huaban7[data-v-32ea5f86]{
            font-size:50px;
        }
        .video_control{
            width:46px;
            height:46px;
        }
        .video_control .icon-bofang,
        .video_control .icon-zanting{
            font-size:16px;
            top:9px;
        }
        .product_img_sm .product_img_list_item[data-v-32ea5f86]{
            width:50px;
            height:50px;
            margin-right:4.25px;
        }
        .product_preview_img .product_img_sm .product_img_prev[data-v-32ea5f86],
        .product_preview_img .product_img_sm .product_img_next[data-v-32ea5f86]{
            height:60px;
            line-height:60px;
        }
    }
</style>