<template lang="html">
    <div class="" v-if="baikeCategoryId">
      <div class="baike_right_border">
        <div class="baike_body_fild">
          <div class="baike_body_button">
              相关百科
          </div>
          <div class="baike_body_right">
             <ul>
                <li v-for="(baikeDate ,index) in DateTimeComputed" :key="index" @click="repeatClick(index)">
                  <div class="baike_new_list">
                    <div class="baike_odiv_img">
                      <img :src="request.picUrl+baikeDate.cover" alt="">
                    </div>
                    <div class="baike_width_210">
                      <div class="baike_font_span">
                        <span></span>
                        <span>{{baikeDate.title}}</span>
                      </div>
                      <p class="baike_font_p">{{baikeDate.view_num}} 次观看 · {{baikeDate.created_at}}</p>
                    </div>
                  </div>
                </li>
             </ul>
          </div>
        </div>
      </div>
    </div>
</template>

<script>
export default {
    props:['baikeCategoryId'],
    data(){
      return{

      }
    },
    computed:{
      DateTimeComputed : function(){
        var listencyclopedia = this.baikeCategoryId
        for(var a = 0;a<listencyclopedia.length;a++){
          var DateTimen = new Date(listencyclopedia[a].created_at)
          var ultimatelytTime = Number(new Date) - Date.parse(DateTimen)
          var DateIndex = this.DateTime(ultimatelytTime)
          listencyclopedia[a].created_at = DateIndex
        }
         return listencyclopedia
      }
    },
    methods:{
      repeatClick(index){
        this.$router.push({
          path:'/home/BaikeDetail',
          query:{
            uid:this.baikeCategoryId[index].encyclopedia_id
          }
        })
      }
    }
}
</script>

<style lang="css">
.baike_width_210{
  width: 210px;
}
.baike_odiv_img{
  width: 124px;
  height: 94px;
  overflow: hidden;
  display: flex;
  justify-content: center;
  align-items: center;
  background: #f2f2f2;
}
.baike_odiv_img>img{
  height: 100%;
}
.baike_body_right>ul>li{
  margin-top: 20px;
  cursor: pointer;
}
.baike_new_list{
  display: flex;
  position: relative;
}
.baike_font_p{
  margin-left: 12px;
  color:#898989;
  position: absolute;
  bottom: 0;
}
.baike_headline_detail>ul>li:hover{
  cursor: pointer;
}
.baike_ul_display>li{
  margin-left: 12px;
  color:#15befe;
  border:1px solid #15befe;
  padding: 2px 5px 2px 5px;
  border-radius: 5px;
  font-size: 11px;
  cursor: pointer;
}
.baike_ul_display>li:hover{
  background-color: #15befe;
  color:#FFF;
}
.baike_ul_display{
  display: flex;
  margin-top: 6px;
}
.baike_font_right{
  width: 95%;
  margin-left: 13px;
  color:#898989;
  margin-top: 5px;
}
.baike_font_span{
  margin-left: 10px;
}
.baike_font_span>span:nth-child(2){
  font-size: 14px;
}
.baike_body_right{
  border-top: 1px solid #e6e6e6;
}
.baike_right_border{
  margin-left: 40px;
}
</style>
