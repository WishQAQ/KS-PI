<template>
  <!--收货地址-->
  <div class="shippingAddress">
    <div class="title">
      收货人信息
    </div>

    <div class="add_address">
      <div class="address_info">
        <div class="address_info_list" v-for="(item, index) in addressList" :key="index" @click="addressActive(item.address_id, index)" :class="currentId===item.address_id?'active':''">
          <div class="address_userInfo">
            <p class="userName">{{item.conducts}}</p>
            <p class="userAddress">{{item.province+item.city+item.area+item.detail}}</p>
            <p class="userPhoneNbm">{{item.telphone}}</p>
          </div>

          <div class="address_operating">
            <i class="icon icon-ziyuan17 address_modify" @click="modifyAddress = true"></i>
            <i class="icon icon-delete address_delete"></i>
          </div>

          <i class="icon icon-gou address_true"></i>
        </div>


      </div>
      <div class="add_shippingAddress" @click="modifyAddress = true">新增收货人</div>
    </div>

    <el-dialog
      title="修改收货人信息"
      :visible.sync="modifyAddress"
      width="600px">
      <div class="modify_address">
        <div>
          <p><span>*</span>收货人</p>
          <el-input v-model="receivePerson"></el-input>
        </div>
        <div class="service_choose">
          <p><span>*</span>收货地址</p>
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
        <div>
          <p><span>*</span>详细地址</p>
          <el-input v-model="receiveDetailAddress"></el-input>
        </div>
        <div>
          <p><span>*</span>联系电话</p>
          <el-input v-model="receivePhone"></el-input>
        </div>
      </div>
      <span slot="footer" class="dialog-footer">
        <el-button @click="modifyAddress = false">取 消</el-button>
        <el-button type="primary" @click="handleAddAddress">确 定</el-button>
      </span>
    </el-dialog>


  </div>
</template>

<script>
  export default {
    name: "shippingAddress",
    data() {
      return {
        currentId: '',
        addActive: false,  // 地址选中样式
        modifyAddress: false, // 修改地址弹出框
        addressList: [], //地址列表
        receivePerson: '',
        receiveDetailAddress:'',
        receivePhone: '',
        provinceId: null,
        provinceName: '',
        provinceOptions: [],
        cityId: null,
        cityName: '',
        cityOptions: [],
        districtId: null,
        districtName: '',
        districtOptions: [],
      }
    },
    created() {
      this.getAddressList();
      this.getAllAddress();
    },
    methods: {
      addressActive(id,index) {
        this.addActive = true;
        this.currentId = id;
        this.$emit('getAddressId',id)
      },
      /***
       * 获取地址列表
       */
      getAddressList() {
        this.HttpClient.get('/addresses/list').then(res =>{
          if(res.data.code === 200){
            this.addressList =res.data.data;
          }
        })
      },
      /***
       * 添加收货人
       */
      handleAddAddress() {
        const param = {
          conducts: this.receivePerson,
          province_id: this.provinceId,
          city_id: this.cityId,
          area_id: this.districtId,
          detail: this.receiveDetailAddress,
          telphone: this.receivePhone
        };
        this.HttpClient.post('/addresses/add', param).then(res =>{
          if(res.data.code === 200) {
            this.modifyAddress = false;
            this.getAddressList();
          }else{
            this.$message.error(res.data.msg)
          }
        })
      },
      /***
       * 选择省
       */
      handleChooseProvince(value) {
        this.cityOptions = this.handleGetObjectByKey(this.provinceOptions,value).child;
        this.provinceId = value;
      },
      /***
       * 选择市
       */
      handleChooseCity(value) {
        this.districtOptions = this.handleGetObjectByKey(this.cityOptions,value).child;
        this.cityId = value;
      },
      /***
       * 选择区
       */
      handleChooseDistrict(value) {
        this.districtId = value;
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
    }

  }
</script>

<style lang="less">
  .shippingAddress {
    .title {
      border-bottom: 1px solid #dedede;
      font-size: 16px;
      color: #333;
      margin-bottom: 15px;
    }

    /*收货地址*/
    .add_address {
      display: flex;
      justify-content: space-between;
      align-items: flex-start;

      /*收货人信息*/
      .address_info {
        flex: 1;

        .active {
          border-color: #15befe !important;
          .address_true {
            opacity: 1 !important;
            color: #15befe !important;
          }
        }

        .address_info_list:hover {
          border-color: #dedede;
          .address_delete,
          .address_modify {
            opacity: 1 !important;
            z-index: 0 !important;
          }
        }

        .address_info_list {
          display: flex;
          justify-content: space-between;
          align-items: center;
          height: 40px;
          font-size: 14px;
          color: #333;
          padding-left: 20px;
          padding-right: 20px;
          border: 1px solid transparent;
          position: relative;
          cursor: pointer;
          overflow: hidden;
          width: 80%;

          /*用户信息*/
          .address_userInfo {
            display: flex;
            align-items: center;
            text-align: center;
            width: 100%;

            .userName {
              width: 28%;
            }
            .userAddress {
              width: 45%;
              overflow: hidden;
              margin-right: 5%;
            }
          }

          /*操作*/
          .address_operating {
            display: flex;
            align-items: center;
            .address_modify {
              margin-right: 20px;
            }
          }

          /*删除按钮*/
          .address_delete,
          .address_modify {
            opacity: 0;
            z-index: -1;
          }
          .address_delete:hover,
          .address_modify:hover {
            color: #15befe;
          }
        }

        /*选中ICON*/
        .address_true {
          position: absolute;
          right: 0;
          bottom: -0.15em;
          opacity: 0;
          font-size: 22px;
          height: 22px;
        }
        .address_true:before {
          position: absolute;
          right: 0;
          bottom: 0;
        }
      }

      /*新增按钮*/
      .add_shippingAddress {
        height: 40px;
        display: flex;
        justify-content: center;
        align-items: center;
        padding: 0 15px;
        border-radius: 4px;
        border: 1px solid #dedede;
        color: #333;
        font-size: 14px;
        transition: all .2s;
      }
      .add_shippingAddress:hover {
        border-color: #15befe;
        background-color: #15befe;
        color: #fff;
      }
    }

    /*修改收货人弹出框*/
    .modify_address {
      > div:not(:last-child) {
        margin-bottom: 20px;
      }
      > div {
        display: flex;
        align-items: center;
        p {
          display: flex;
          justify-content: flex-start;
          align-items: flex-start;
          width: 100px;
          span {
            color: red;
          }
        }
      }
    }

  }
</style>
