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
          placeholder="请选择市">
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
  name: "uploadingServiceMainCity",
  props: ['serviceCityData'],
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
  created() {
    this.getAllAddress();
  },
  watch: {
    serviceCityData: {
      handler(newData, oldData) {
        console.log(newData, oldData)
        this.provinceName = newData.city.name;
        this.cityName = newData.province.name;
        this.districtName = newData.district.name;
        this.address = newData.address;
        this.telphone = newData.telphone;
        if(this.$route.query.id) {
          this.province = newData.province.id;
          this.city = newData.city.id;
          this.district = newData.district.id;
          this.$store.dispatch('getServiceUploadData',{
            province: this.province,
            city: this.city,
            district: this.district
          }).then(res=>{
            console.log(this.$store.state.serviceUpload.serviceUploadData)
          });
        }
      },
      deep: true
    }
  },
  methods: {
    /***
     * 选择省
     */
    handleChooseProvince(value) {
      this.cityOptions = this.handleGetObjectByKey(this.provinceOptions,value).child;
      this.provinceId = value;
      this.$store.dispatch('getServiceUploadData',{province: value}).then(res=>{
        console.log(this.$store.state.serviceUpload.serviceUploadData)
      });
    },
    /***
     * 选择市
     */
    handleChooseCity(value) {
      this.districtOptions = this.handleGetObjectByKey(this.cityOptions,value).child;
      this.cityId = value;
      this.$store.dispatch('getServiceUploadData',{city: value}).then(res=>{
        console.log(this.$store.state.serviceUpload.serviceUploadData)
      });
    },
    /***
     * 选择区
     */
    handleChooseDistrict(value) {
      this.districtId = value;
      this.$store.dispatch('getServiceUploadData',{district: value}).then(res=>{
        console.log(this.$store.state.serviceUpload.serviceUploadData)
      });
    },
    /***
     * 获取所有城市地区
     */
    getAllAddress() {
      this.HttpClient.get('/city/getAllCities').then(res =>{
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
      this.$store.dispatch('getServiceUploadData',{address: this.address}).then(res=>{
        console.log(this.$store.state.serviceUpload.serviceUploadData)
      });
    },
    /**
     * 获取联系电话
     * @param e
     */
    handleTel(e) {
      this.$store.dispatch('getServiceUploadData',{telphone: parseInt(this.telphone)}).then(res=>{
        console.log(this.$store.state.serviceUpload.serviceUploadData)
      });
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
