<template>
    <div class="oBackground_color">
        <div class="baikeDetail_body_width">
          <!--header-->
            <baike-header :baikePropsHeader="dataBaikecont" :infoData="infoData"></baike-header>
            <div class="baike_body_html">
                <!--左侧内容-->
                <baike-detail :baikeProps="dataBaike"></baike-detail>
                 <!--右侧内容-->
                 <baike-chrch :baikeCategoryId="categoryId"></baike-chrch>
            </div>
        </div>
    </div>
</template>

<script>
import BaikeDetail from '@/views/baike/baikeFontBody'
import BaikeChrch from '@/views/baike/baikeRightFont'
import BaikeHeader from '@/views/baike/baikeDetailHeader'
export default {
    data(){
      return{
        dataBaike:null,
        dataBaikecont:null,
        categoryId:null,
        infoData:this.$route.query.info,
        encyclopedia_id:null,
      }
    },
    components:{
      BaikeDetail,
      BaikeChrch,
      BaikeHeader
    },
    created(){
      this.bodyDate();
      
    },
    watch:{
      $route(to,from){
        this.bodyDate()
        this.getInfo()
      }
    },
    methods:{
      //请求这条修改的百科的百科详情
      getInfo(){
        console.log(this.infoData)
        this.$ajax.post(this.request.axiosPort+this.request.axiosApi+'my/encyclopedias/info',{
          token:window.localStorage.token,
          encyclopedia_id:this.encyclopedia_id
        })
        .then((res) => {
          console.log(res)
        })
      },
      bodyDate(){
        // console.log(this.$route.query.uid)
        //百科主体数据
        this.$ajax.post(this.request.axiosPort+this.request.axiosApi+'encyclopedias/info',{
          encyclopedia_id:this.$route.query.uid
        })
        .then((res) => {
          console.log(res)
          console.log("1")
          this.dataBaike = res.data;
          this.dataBaikecont = res.data;
          this.encyclopedia_id = res.data.data.encyclopedia_id;
          console.log(this.encyclopedia_id)
          // this.getInfo();
          //百科右侧数据
          this.$ajax.post(this.request.axiosPort+this.request.axiosApi+"encyclopedias/related",{
            category_id:this.dataBaike.data.category_id
          })
          .then((res) => {
            this.DateTime()
            this.categoryId = res.data.data
          })
        })
      }
    }
}
</script>

<style lang="css">
.baikeDetail_body_width{
  width: 1200px;
  margin: 0 auto;
  padding: 10px;
  background-color: #FFF;
  padding: 16px;
}

@media screen and (min-width: 1200px) {
  .baikeDetail_body_width{
    width: 1200px;
  }
  .baike_body_html_left{
    width: 800px;
  }
}

@media screen and (max-width:1119px) and (min-width:300px) {
  .baikeDetail_body_width{
    width: 100% !important;
  }
  .baike_body_html_left{
    width:100% !important;
  }
  .baike_headline_button{
    width: 300px;
  }
}
</style>
