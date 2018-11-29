<template>
  <div class="" v-if="userDataInfo">
    <el-tooltip placement="bottom-start" popper-class="userModal_box" :visible-arrow="false">
      <div slot="content">
        <div class="merchantModal userModal">
          <div class="userModal_banner"><img src="/static/img/others_banner.jpg" alt=""></div>

          <div class="userModal_text">
            <div class="userModal_avatar"><img :src="request.picUrl + userDataInfo.avatar" alt=""></div>
            <div class="userModal_info">
              <p><i class="icon icon-ziyuan31"></i>{{userDataInfo.nickname}}</p>
              <span>{{userDataInfo.signature}}</span>
            </div>
          </div>

          <div class="merchantModal_energy" v-if="userType">
            <span class="merchantModal_energy_line"></span>
            <div class="merchantModal_energy_icon">
              <i class="icon icon-ziyuan39"></i>
              <div class="merchantModal_energy_name">
                <p>燃料</p>
                <span>Electric</span>
              </div>
            </div>
            <div class="merchantModal_energy_schedule">
              <div class="merchantModal_schedule_bar"><span style="width: 37%;"></span></div>
              <div class="merchantModal_schedule_text">
                <p>0</p>
                <span>当前燃料：37mAh</span>
                <p>100</p>
              </div>
            </div>
          </div>

          <div class="userModal_energy" v-else>
            <span class="userModal_energy_line"></span>
            <div class="userModal_energy_icon">
              <i class="icon icon-ranliao"></i>
              <div class="userModal_energy_name">
                <p>电量</p>
                <span>Fuel</span>
              </div>
            </div>
            <div class="userModal_energy_schedule">
              <div class="userModal_schedule_bar"><span style="width: 37%;"></span></div>
              <div class="userModal_schedule_text">
                <p>0</p>
                <span>当前电量：37mAh</span>
                <p>100</p>
              </div>
            </div>
          </div>

        </div>
      </div>
      <span>{{userDataInfo.nickname}}</span>
    </el-tooltip>
  </div>
</template>

<script>
import MerchantModalDiv from '@/components/merchantModal'
    export default {
        props:['name'],
        name: "merchantModal",
        data(){
          return{
            userDataInfo:null,
            userType:null       //判断为商户还是用户
        }
     },
     methods:{
       axiosUser(){
         this.HttpClient.post('/user/info',{
           uid:this.name
         })
         .then((res) => {

           this.userDataInfo = res.data.data

           if(this.userDataInfo.type == 1){
             this.userType == false
           }else{
             this.userType == true
           }
           
           console.log(this.userDataInfo.type)
         })
       }
     },
     created(){
       this.axiosUser()
     },
     components:{
       MerchantModalDiv
     }
  }
</script>

<style src="../assets/css/userModal.css"></style>
