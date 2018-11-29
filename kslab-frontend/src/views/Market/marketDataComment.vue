<template>
    <div>
      <ul class="service_ul_box">
        <li v-for="(item ,index) in commentList" :key="index">
          <!--头像框-->
          <div>
              <div class="user_div_oimg">
                 <img :src="request.picUrl + item.avatar" alt="">
              </div>
              <div class="servic_font_box_size">
                 <p>{{item.name}}</p>
                 <p>{{item.signature}}</p>
              </div>
              <p class="floatRight_box">{{handleDate(item.created_at)}}</p>
              <p class="float"></p>
          </div>
          <!--评论框-->
          <div class="service_box_userDetal">
            <div class="market_praise_left">
               <praise-div :type="comit" :index="0" letType="2"></praise-div>
            </div>
            <div class="service_presca_body">
               <div v-html="item.content">

                 <ul class="service_img_block">
                    <li v-for="(itemList ,index) in item.attachment" :key="index">
                      <img :src="request.picUrl + itemList.path" alt="">
                    </li>
                 </ul>
                 <ul class="service_re_ul">
                    <li>
                       <img src="/static/img/icon/jub.png" alt="">
                       <span>举报</span>
                    </li>
                    <li>
                      <el-rate
                        v-model="value2"
                        :colors="['#15bafe', '#15bafe', '#15bafe']">
                      </el-rate>
                    </li>
                 </ul>
               </div>
            </div>
          </div>
        </li>
      </ul>
    </div>
</template>

<script>
import FormatDate from "../../utils/GetDateUtils"
import PraiseDiv from '@/components/praise'
export default {
  data(){
    return{
      value2: 4,
      comit:[
        {
          type:'serviceDetails',
          praise:'',
          state:0,
          id:null
        }
      ],
      page:1,
      size:5,
      order:1,
      commentList:null    //评论列表数据
    }
  },
  components:{
    PraiseDiv
  },
  mounted(){
    this.dataNew()
  },
  methods:{
    handleDate(date) {
      return FormatDate.GetDate(date);
    },
    dataNew(){
      this.HttpClient.post('/goods/getAnswer',{
        source_id:this.$route.query.id,
        page:this.page,
        size:this.size,
        order:this.order
      })
      .then((res) => {
        // like_num
        this.commentList = res.data.data.data
        for(let i = 0;i<this.commentList.length;i++)
        {
          this.comit[i].praise = this.commentList[i].like_num
          this.comit[i].id = this.commentList[i].answer_id
        }

      })
    }
  },
  watch:{
    $route:function(to, form){
      this.dataNew()
    }
  }
}
</script>

<style lang="css">
.service_ul_box{
  margin-top: 15px;
}
.user_div_oimg>img{
  width: 100%;
}
.service_presca_body{
  width: 100%;
  float: left;
}
.service_box_userDetal{
  width: 100%;
  display: flex;
  margin-top: 10px;
  position: relative;
  top:10px;
}
.floatRight_box{
  float: right;
  margin-top: 36px;
  color:#737373;
}
.servic_font_box_size{
  float: left;
}
.servic_font_box_size>p:nth-child(1){
  font-size:20px;
  font-weight: 800;
}
.servic_font_box_size>p:nth-child(2){
  font-size: 14px;
  color:#737373;
}
.service_ul_box>li>div>div>img{
  width: 100%;
}
.user_div_oimg{
  width: 45px;
  height: 45px;
  border:1.5px solid #15bafe;
  border-radius: 5px;
  overflow: hidden;
  float: left;
  margin-right: 10px;
}
.service_ul_box>li>div{
  width: 100%;
  padding-right: 15px;
}
.service_ul_box>li{
  width: 100%;
  margin-bottom: 40px;
}
</style>
