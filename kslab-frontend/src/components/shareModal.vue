<template>
    <div class="share_modal" v-if="modelDelete">
        <div class="modal_mask"></div>
        <div class="share_modal_box" >
          <div class="share_modal_box_title">
            <span><img src="/static/img/logo/logo_block.png" alt=""></span>
            <div class="modelDelet" @click="deleteClick">
              <p></p>
              <p></p>
            </div>
          </div>
          <div class="share_modal_main">
            <div class="share_modal_main_icon">
              <p><img src="/static/img/icon/weibo_block.png" alt=""></p>
              <span>新浪微博</span>
            </div>
            <div class="share_modal_main_icon">
              <p><img src="/static/img/icon/qq.png" alt=""></p>
              <span>QQ</span>
            </div>
            <div class="share_modal_main_icon wechat_icon">
              <p><img src="/static/img/icon/wechar_block.png" alt=""></p>
              <span>微信</span>

              <div class="share_modal_main_qr">
                <img src="/static/img/qr.png" alt="">
                <p>扫码分享至微信</p>
              </div>

            </div>
            <a class="share_modal_main_icon" @click="copy" :data-clipboard-text="href">
              <p><img src="/static/img/icon/shareLink.png" alt=""></p>
              <span>复制链接</span>
            </a>
          </div>
        </div>
    </div>
</template>

<script>

    import Clipboard from 'clipboard'

    export default {
      data(){
        return{
          modelDelete:false,
          href:window.location.href
        }
      },
      methods: {
        copy() {
            // let link=window.location.href;
            // if (window.clipboardData) {
            //     window.clipboardData.clearData();
            //     window.clipboardData.setData("Text",link);
            // } else if (navigator.userAgent.indexOf("Opera") !== -1) {
            //     window.location = link;
            // }
            // console.log(window.clipboardData);
            // console.log(window.location);
            let clipboard = new Clipboard('.wx');
            console.log(clipboard);
            clipboard.on('success', e => {
                // 释放内存
                clipboard.destroy()
            });
            clipboard.on('error', e => {
                // 不支持复制
                alert('浏览器不支持自动复制，请手动复制微信号')
                // 释放内存
                clipboard.destroy()
            });
            this.$message({
                message: '链接复制成功！',
                center: true,
                type: 'success'
            });
        },
        show(){
          this.modelDelete=true;
        },
        deleteClick(){
          this.modelDelete = false
        },
      },
    }



</script>

<style scoped>
  body{
    position: relative;
    overflow: hidden;
  }

  .modal_mask{
    width: 100%;
    height: 100%;
    background-color: rgba(0,0,0,0.6);
    position: fixed;
    left: 0;
    top: 0;
    z-index: 99;
    overflow: hidden;
  }

  .share_modal_box{
    background: url("/static/img/share_modal_bg.png") no-repeat center 80% #fff;
    background-size: contain;
    width: 400px;
    height: 250px;
    box-shadow: 0px 2px 5px 0px
    rgba(34, 24, 21, 0.16);
    position: fixed;
    left: 50%;
    top: 50%;
    margin-left: -200px;
    margin-top: -125px;
    z-index: 999;
  }

  .share_modal_box_title{
    display: flex;
    justify-content: space-between;
    align-items: center;
    height: 30px;
    padding: 0 15px;
    border: solid 1px #f4f4f4;
  }

  .share_modal_box_title .modelDelet{
    position: relative;
    width: 12px;
    height: 12px;
    cursor: pointer;

  }
  .share_modal_box_title .modelDelet p{
    width: 12px;
    height: 1px;
    background-color: #bbb;
    position: absolute;
    top: 50%;
    left: 50%;
    margin-left: -6px;
    transition: all .2s;
  }
  .share_modal_box_title .modelDelet p:nth-child(1){
    transform: rotate(45deg);
    transform-origin: center center;
  }
  .share_modal_box_title .modelDelet:hover p:nth-child(1){
    transform: rotate(180deg);
    top: 3px;
  }
  .share_modal_box_title .modelDelet p:last-child{
    transform: rotate(-45deg);
    transform-origin: center center;
  }
  .share_modal_box_title .modelDelet:hover p:last-child{
    transform: rotate(-180deg);
    top: 7px;
  }





  .share_modal_main{
    display: flex;
    justify-content: center;
    align-items: center;
    height: 220px;
    transition: all .3s;
  }

  .share_modal_main_icon{
    text-align: center;
    margin: 0 22px;
    cursor: pointer;
  }
  .share_modal_main_icon>p{
    display: flex;
    justify-content: center;
    align-items: center;
  }
  .share_modal_main_icon>p img{
    width: 40px;
    height: 40px;
  }
  .share_modal_main_icon>span{
    display: block;
    margin-top: 8px;
  }


  .wechat_icon{
    position: relative;
  }

  .wechat_icon:hover .share_modal_main_qr{
    display: block;
  }

  .share_modal_main_qr{
    display: none;
    position: absolute;
    top: -155px;
    left: 50%;
    margin-left: -60px;
    width: 120px;
    height: 140px;
    background-color: #fff;
    text-align: center;
    font-size: 12px;
    color: #777;
    padding: 10px;
    box-shadow: 0px 2px 5px 0px rgba(34, 24, 21, 0.16);
  }
  .share_modal_main_qr:after{
    content: '';
    position: absolute;
    display: inline-block;
    width: 0;
    height: 0;
    border-style: solid;
    border-width: 5px;
    border-color: #fff #fff transparent transparent;
    transform: rotate(135deg);
    box-shadow: 2px -2px 2px rgba(34, 24, 21, 0.16);
    left: 50%;
    margin-left: -5px;
    bottom: -5px;
  }


</style>
