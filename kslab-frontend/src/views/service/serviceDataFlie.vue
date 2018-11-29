<template lang="html">
  <div class="activity_Data_file">
    <ul>
       <li v-for="(item, index) in attachmentData" :key="index">
         <div class="icon_div_samll">
           <img src="/static/img/icon/fuj.png" alt="">
         </div>
         <p>{{item.name}}</p>
         <div class="file_Dwond">
           <a :href="bindImage(item.path)">[下载]</a>
         </div>
       </li>
    </ul>
  </div>
</template>

<script>
import {HttpClient} from "../../utils/HttpUtils";
import cfg from '../../../config/app'
export default {
  props: ['serviceId'],
  data() {
    return {
      attachmentData: []
    }
  },
  created() {
    this.$watch('serviceId',function (newVal, oldVal) {
      this.service_id = newVal;
      //console.log(newVal,' ',this.service_id );
      const param = {
        service_id: newVal,
        token: window.localStorage.getItem('token')
      };
      this.getServiceData(param);
    })
  },
  methods: {
    /***
     * 获取协议的数据
     * @param param
     */
    getServiceData(param) {
      HttpClient.post('/services/attachmentList', param).then(res =>{
        //console.log(res)
        if(res.data.code === 200) {
          this.attachmentData = JSON.parse(res.data.data.attachment)
        }
      })
    },
    /***
     * 格式化imgUrl
     * @param url
     * @returns {string}
     */
    bindImage(url) {
      return cfg.imageUrl + url+ '?attname=';
    }
  }
}
</script>

<style lang="css">
.file_Dwond{
  float: right !important;
  padding-top: 2px;
  cursor: pointer;
}
.activity_Data_file>ul{
  overflow: hidden;
}
.activity_Data_file>ul>li>div{
  float: left;
  margin-right: 10px;
}
.activity_Data_file>ul>li{
  padding: 10px;
  border-bottom:1px dashed #CCC;
  overflow: hidden;
  margin-bottom: 10px;
}
.activity_Data_file>ul>li>p{
  font-size: 14px;
  color:#737373;
  float: left;
}
.icon_div_samll{
  width: 20px;
  height: 20px;
}
.activity_Data_file{
  width: 100%;
}
</style>
