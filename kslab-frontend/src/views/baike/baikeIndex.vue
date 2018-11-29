<template>
    <div class="magintop30">
        <float-div></float-div>
        <div class="baike_index_banner">
            <img src="/static/img/baike_banner_car.png" alt="">

            <!--指向线1-->
            <div class="baike_zxx_width">
                <div class="baike_blue_border">
                  <span></span>
                  改&nbsp;装
                </div>
                <div class="baike_postd_top">
                    <div class="baike_div_font">
                        包括DIY 和成品改装件。
                    </div>
                    <img src="/static/img/icon/smllcar_1.png" alt="">
                </div>
                <div class="float"></div>
            </div>

            <!--指向线2-->
            <div class="baike_zxx_width two">
                <div class="baike_blue_border baike_two_font">
                  <span></span>
                  内燃机、发动机管理
                </div>
                <div class="baike_postd_top">
                    <div class="baike_div_font baike_two_width_font">
                        供油系统、火花塞系统、尾气排放和循环系统、mapping等.。
                    </div>
                    <img src="/static/img/icon/smllcar_2.png" alt="">
                </div>
                <div class="float"></div>
            </div>

            <!--指向线3-->
            <div class="baike_zxx_width tree">
                <div class="baike_blue_border baike_two_font">
                  <span></span>
                  车身系统
                </div>
                <div class="baike_postd_top baike_tree_img">
                    <div class="baike_div_font baike_two_width_font">
                        悬挂、避震器、悬挂运动学、轮毂、轮胎、转向系统、刹车系统、牵引力控制气筒、车身稳定系统。
                    </div>
                    <img src="/static/img/icon/smllcar_3.png" alt="">
                </div>
                <div class="float"></div>
            </div>

            <!--指向线4-->
            <div class="baike_four_width">
              <div class="baike_blue_border baike_four_font">
                机械零件、连接和粘合技术
                <span></span>
              </div>
              <img src="/static/img/icon/smllcar_4.png" alt="">
              <div class="baike_four_div">
                  包含弹簧、轴承、齿轮、皮带、链传动等。
              </div>
            </div>

            <!--指向线5-->
            <div class="baike_four_width five">
              <div id="five_top" class="baike_blue_border baike_four_font">
                维修保养
                <span></span>
              </div>
              <img src="/static/img/icon/smllcar_5.png" alt="">
              <div class="baike_four_div five_baike">
                  所有维修，包括车灯、雨刮、防晒膜、油路清洗、空滤更换，也包含大修，例如：发动机清洗、三元更换、变速箱维修等。
              </div>
            </div>
        </div>
        <div class="baike_index_body">
           <ul>
              <li @click='NameMusver' v-for="( Namelist ,index) in listName" :key="index" :id="index">
                {{Namelist.name}}
                <div class="" v-if="Sindex == index">
                    {{Namelist.body}}
                </div>
              </li>
           </ul>
        </div>
        <div class="baike_Boady_index">
          <span>百&nbsp;&nbsp;科</span>
          <!--组件（百科数据）-->
          <baike-data :dataList="baikeData"></baike-data>
        </div>
    </div>
</template>

<script>
import FloatDiv from '@/components/floating'
import BaikeData from '@/views/baike/baikedata'
export default {
    data(){
      return{
          Sindex:"false",
          activeName: 'first',
          listName:[
            {
              name:"基础理论、数学和设计",
              body:"包括机械学、震动、声学、流体静力学、热力学及电子理论。"
            },
            {
              name:"材料、车内液体",
              body:"包括机械学、震动、声学、流体静力学、热力学及电子理论。"
            },
            {
              name:"混合动力、燃料电池",
              body:"包括机械学、震动、声学、流体静力学、热力学及电子理论。"
            },
            {
              name:"动力系统",
              body:"包括机械学、震动、声学、流体静力学、热力学及电子理论。"
            },
            {
              name:"乘客安全和驾驶辅助系统",
              body:"包括机械学、震动、声学、流体静力学、热力学及电子理论。"
            },
            {
              name:"汽车电气",
              body:"包括机械学、震动、声学、流体静力学、热力学及电子理论。"
            },
            {
              name:"软件和电器系统",
              body:"包括机械学、震动、声学、流体静力学、热力学及电子理论。"
            }
          ],
          baikeData:''
      }
    },
    components:{
       FloatDiv,
       BaikeData
    },
    methods:{
      NameMusver(index){
         this.Sindex = index.target.id
      }
    },
    beforeCreate(){
      this.$ajax.post(this.request.axiosPort + this.request.axiosApi + 'encyclopedias/list',{

      })
      .then((res) => {
        this.baikeData = res.data.data
        for(var k = 0;k<res.data.data.length;k++){
          this.baikeData[k].label_name = this.filtration(res.data.data[k].label_name)
        }

        // this.filtration(res.data.data)
      })
    }
}
</script>

<style src="../../assets/css/baikeIndex.css"></style>
<style lang="css">
.magintop30{
  margin-top: 30px;
}
.baike_Boady_index .el-tabs>.el-tabs__header>.el-tabs__nav-wrap>.el-tabs__nav-scroll>.is-top{
  float: right;
}
@media screen and (min-width: 1200px) {
  .baike_index_banner{
    width: 1200px;
  }
  .baike_index_body{
    width: 1200px;
  }
  .baike_Boady_index{
    width: 1200px;
  }
  .baike_Node_class>li{
    width: 570px;
    height: 170px;
    margin-bottom: 30px;
    cursor: pointer;
  }
  .baike_Node_class>li>div{
    width: 260px;
    height: 170px;
    float: left;
    margin-right: 10px;
  }
}
@media screen and (max-width:1199px) and (min-width:300px) {
  .baike_index_banner{
    margin: 0;
  }
  .baike_index_body{
    width: 100% !important;
    padding: 0 30px;
  }
  .baike_Boady_index{
    width: 94% !important;
  }
  .baike_Node_class>li{
    width: 50%;
  }
  .baike_Node_class>li{
    width: 49% !important;
    height: 170px;
    margin-bottom: 30px;
    cursor: pointer;
  }
  .baike_Node_class>li>div{
    width: 47% !important;
    height: 170px;
    float: left;
    margin-right: 10px;
  }
  .baike_zxx_width.two{
    width: auto !important;
    top: 45px !important;
    left: 40px !important;
  }
  .baike_zxx_width{
    left: 15px;
  }
  .tree{
    left:66% !important;
  }
  .baike_four_width{
    right: -63%;
  }
  .five{
    top:257px !important;
    right:-255px !important;
  }
}
</style>
