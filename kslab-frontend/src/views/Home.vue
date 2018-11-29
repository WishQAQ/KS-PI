<template lang="html">
  <div>
    <headers/>
    <router-view :style="{minHeight:currentScreenHeight-'285'+'px'}"></router-view>
    <footers></footers>
    <div id="allmap"></div>
  </div>
</template>

<script>
import headers from '@/components/header'
import footers from '@/components/footer'
export default {
  name:'Home',
  components: {
    headers,
    footers
  },
  data(){
    return{
      currentScreenHeight: $(window).height(),
    }
  },
  created() {
    //this.getOutIp();
    console.log(window.screen.availWidth);
    console.log(window.screen.availHeight);
    window.localStorage.setItem('apiInfo',JSON.stringify({screen_size:window.screen.availHeight+'*'+window.screen.availWidth}));
    const address = localStorage.getItem('address');
    if(address) {

    }else {
      //百度地图
      var map = new BMap.Map("allmap");
      // var point = new BMap.Point(116.331398,39.897445);
      // map.centerAndZoom(point,12);
      var transCity;
      let lon,lat;
      var self = this;
      var geolocation = new BMap.Geolocation();
      console.log(111)
      geolocation.getCurrentPosition(function(r){
        if(this.getStatus() == BMAP_STATUS_SUCCESS){
          lon=r.point.lng;
          lat = r.point.lat;
          console.log('您的位置：'+r.point.lng+','+r.point.lat);
          var point = new BMap.Point(lon,lat); //这里设置刚开始的点所在处
          var gc = new BMap.Geocoder();  //初始化，Geocoder类
          gc.getLocation(point, function (rs) {   //getLocation函数用来解析地址信息，分别返回省市区街等
            var addComp = rs.addressComponents;
            console.log(addComp)
            const province = addComp.province;//获取省份
            const city = addComp.city;//获取城市
            const district = addComp.district;//区
            console.log(province,city,district)
            const street = addComp.street;//街
            console.log('22'+province+city+district)
            const locationData = {
              province: province,
              city: city,
              district: district
            };
            self.HttpClient.get('/getCityLinkageId',{name: province}).then(res =>{
              if(res.data.code === 200) {
                localStorage.setItem('addressId',res.data.data.id);
              }
            });
            localStorage.setItem('address',province);
            self.$store.dispatch('getMyLocationData', locationData).then(res =>{
              console.log(self.$store.state.getCurrentLocation.myLocation)
            })
          });
        }else {
          alert('failed'+this.getStatus());
        }

      },{enableHighAccuracy: true})
    }

  },
  mounted(){
    // 获取浏览器可视区域高度
    const _this = this;
    window.onresize = function temp() {
      _this.currentScreenHeight = $(window).height();
      // console.log(_this.currentScreenHeight);
      this.currentScreenHeight = _this.currentScreenHeight;
    };
  },
  methods: {
    /*getOutIp() {
      const ip = localStorage.getItem('outIp')?JSON.parse(localStorage.getItem('outIp')).ip:'';
      console.log(ip)
      console.log(window.localStorage.getItem('outIp'))
      this.HttpClient.post('').then(res => {
        if(res.data.code === 200) {}

      })
    }*/
  }
}
</script>
