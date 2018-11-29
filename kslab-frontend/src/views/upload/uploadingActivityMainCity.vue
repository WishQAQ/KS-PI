<template>
    <div class="service_city">
      <div class="main_head">
        <i class="icon icon_location"></i>
        <span class="main_txt">城市</span>
        <span class="main_txt_describe"></span>
      </div>
      <div class="service_choose">
        <el-select
          class="choose_province"
          v-model="provinceName"
          size="mini"
          @change="handleChooseProvince"
          placeholder="请选择省">
          <el-option
            v-for="item in provinceOptions"
            :key="item.id"
            :label="item.name"
            :value="item.id">
          </el-option>
        </el-select>
        <el-select
          class="choose_city"
          v-model="cityName"
          size="mini"
          @change="handleChooseCity"
          placeholder="请选择市">
          <el-option
            v-for="item in cityOptions"
            :key="item.id"
            :label="item.name"
            :value="item.id">
          </el-option>
        </el-select>
        <el-select
          class="choose_district"
          v-model="districtName"
          size="mini"
          @change="handleChooseDistrict"
          placeholder="请选择区">
          <el-option
            v-for="item in districtOptions"
            :key="item.id"
            :label="item.name"
            :value="item.id">
          </el-option>
        </el-select>
      </div>
      <div class="service_address">
        <p class="address_name">具体地址:</p>
        <el-input class="address_input" @change="handleAddress" size="mini" v-model="address"></el-input>
      </div>
      <div class="service_phone">
        <p class="phone_name">联系电话:</p>
        <el-input class="phone_input" @change="handleTel" size="mini" v-model="telphone"></el-input>
      </div>
    </div>
</template>

<script>
export default {
  name: "uploadingActivityMainCity",
  data() {
    return {
      provinceId: null,
      provinceName: '',
      provinceOptions: [],
      cityId: null,
      cityName: '',
      cityOptions: [],
      districtId: null,
      districtName: '',
      districtOptions: [],
      allCity: [], //所有省市区,
      telphone: null,
      address: ''
    }
  },
  props:['data'],
  async created() {
      await this.getAllAddress();
  },
  methods: {
    /***
     * 选择省
     */
    handleChooseProvince(value) {
      this.cityOptions = this.handleGetObjectByKey(this.provinceOptions,value).child;
      this.provinceId = value;
      this.$store.dispatch('getActivityUploadData',{province: value}).then(res=>{
        console.log(this.$store.state.activityUpload.activityUploadData)
      });
    },
    /***
     * 选择市
     */
    handleChooseCity(value) {
      this.districtOptions = this.handleGetObjectByKey(this.cityOptions,value).child;
      this.cityId = value;
      this.$store.dispatch('getActivityUploadData',{city: value}).then(res=>{
        console.log(this.$store.state.activityUpload.activityUploadData)
      });
    },
    /***
     * 选择区
     */
    handleChooseDistrict(value) {
      this.districtId = value;
      this.$store.dispatch('getActivityUploadData',{district: value}).then(res=>{
        console.log(this.$store.state.activityUpload.activityUploadData)
      });
    },
    /***
     * 获取所有城市地区
     */
    async getAllAddress() {
        await this.HttpClient.get('/city/getAllCities').then(res =>{
        console.log(res)
        if(res.data.code === 200) {
          this.allCities = res.data.data;
          this.provinceOptions = this.allCities;
        }
      })
    },
    /***
     * 根据key查询数组对象中的item
     * @param arr
     * @param value
     * @returns {*}
     */
    handleGetObjectByKey(arr,value) {
      return arr.find(function (obj) {
        return obj.id === value
      });
    },
    /***
     * 获取详细地址
     * @param e
     */
    handleAddress(e) {
        this.$store.dispatch('getActivityUploadData',{address: this.address}).then(res=>{
        console.log(this.$store.state.activityUpload.activityUploadData)
      });
    },
    /**
     * 获取联系电话
     * @param e
     */
    handleTel(e) {
      this.$store.dispatch('getActivityUploadData',{telphone: parseInt(this.telphone)}).then(res=>{
        console.log(this.$store.state.activityUpload.activityUploadData)
      });
    }
  },
  watch:{
    data:{
        async handler(){
            this.provinceId=this.$store.state.activityUpload.activityUploadData.province;
            this.cityId=this.$store.state.activityUpload.activityUploadData.city;
            this.districtId=this.$store.state.activityUpload.activityUploadData.district;
            this.address=this.$store.state.activityUpload.activityUploadData.address;
            this.telphone=this.$store.state.activityUpload.activityUploadData.telphone;
            await this.getAllAddress();
            if(this.provinceId!==null){
                this.provinceOptions.forEach(item=>{
                    if(item.id===this.provinceId){
                        this.provinceName=item.name;
                        console.log(this.provinceName);
                        return
                    }
                });
                this.handleChooseProvince(this.provinceId);
                this.cityOptions.forEach(item=>{
                    if(item.id===this.cityId){
                        this.cityName=item.name;
                        return
                    }
                });
                this.handleChooseCity(this.cityId);
                this.districtOptions.forEach(item=>{
                    if(item.id===this.districtId){
                        this.districtName=item.name
                    }
                });
            }
        },
        deep:true,
        immediate: true
    }
  }
}
</script>

<style scoped lang="less">
.service_city{
  margin-top: 10px;
  .service_choose{
    display: flex;
    .choose_province{
      margin-right: 10px;
      width: 200px;
    }
    .choose_city{
      margin-right: 10px;
      width: 200px;
    }
    .choose_district{
      width: 200px;
    }
  }
  .service_address{
    display: flex;
    margin-top: 10px;
    .address_name{
      font-size: 13px;
      color: #404040;
      width: 70px;
      height: 28px;
      line-height: 28px;
    }
    .address_input{
      width: 300px;
    }
  }
  .service_phone{
    display: flex;
    margin-top: 10px;
    .phone_name{
      font-size: 13px;
      color: #404040;
      width: 70px;
      height: 28px;
      line-height: 28px;
    }
    .phone_input{
      width: 300px;
    }
  }
}
</style>
