<template>
    <div class="footer">
      <div class="footer_box">
        <div class="footer_nav">
          <ul>
            <li><router-link to="recruitment">人才招聘</router-link></li>
            <li><router-link to="businessCooperation">企业合作</router-link></li>
            <li><router-link to="opinion">提出意见</router-link></li>
            <li><router-link to="">关注我们</router-link></li>
          </ul>
        </div>
        <div class="footer_info">
          <p>工作时间：周一至周五  8:30 — 17:45</p>
          <p>公司地址：重庆市渝中区大坪英利国际2号楼11-5</p>
        </div>
        <div class="footer_logo">
          <router-link to="index"><i class="icon icon-huaban4"></i></router-link>
          <p>世间万物，伟大只是一种简单</p>
          <p>只有真实才不怕简单</p>
        </div>
      </div>
      <div class="footer_bottom">
        <div class="footer_bottom_box">
          <p>重庆市酷耍电子商务有限公司版权所有</p>
          <span>|</span>
          <a href="http://www.miibeian.gov.cn" target="_blank">渝ICP备18012810号-1</a>
          <span>|</span>
          <p>Copyright ©2018</p>
          <p>All Rights Reserved</p>
        </div>
      </div>
    </div>
</template>

<script>
export default {
    data(){
      return {

      }
    }
}
</script>

<style scoped lang="less">
  .footer{
    background-color: #37313f;
    padding-top: 10px;
  }
  .footer_box{
    background: url("../../static/img/footer_background.png") no-repeat 85%;
    background-size: contain;
    padding-bottom: 40px;
    padding-left: 20px;
    position: relative;
    max-width: 1200px;
    min-width: 960px;
    margin: 0 auto;
  }

  .footer_nav{
    padding: 30px 0 40px 0;
  }
  .footer_nav ul{
    display: flex;
    align-items: center;
  }
  .footer_nav ul li{
    margin-right:50px;
  }
  .footer_nav ul li a{
    color: #fff;
    font-size: 16px;
  }

  .footer_info{
    font-size: 14px;
    color: #999;
  }

  .footer_logo{
    text-align: right;
    position: absolute;
    right: 20px;
    top: 20%;
  }
  .footer_logo a{
    color: #15bafe;
  }
  .footer_logo i{
    font-size: 68px;
    line-height: 60px;
  }
  .footer_logo p{
    font-size: 12px;
    color: #fff;
    font-style: italic;
  }


  .footer_bottom {
    font-size: 14px;
    color: #999;
    background-color: #261f2f;
  }
  .footer_bottom_box{
    padding: 10px 20px;
    display: flex;
    align-items: center;
    max-width: 1200px;
    min-width: 960px;
    margin: 0 auto;
  }
  .footer_bottom_box a{
    color: #999;
  }
  .footer_bottom_box span{
    margin: 0 5px;
  }


  @media screen and(max-width: 1400px) and (min-width: 300px){
    .footer_nav ul li a{
      font-size: 14px;
    }
    .footer_info{
      font-size: 12px;
    }
    .footer_bottom {
      font-size: 12px;
    }
    .footer_box{
      padding-bottom: 52px !important;
    }
  }

</style>
