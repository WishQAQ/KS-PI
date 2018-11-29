<template>
  <div class="uploading_main_item uploading_main_city">
    <div class="main_head">
      <i class="icon icon_location"></i>
      <span class="main_txt">城市</span>
      <span class="main_txt_describe"></span>
    </div>
    <div class="main_city_detail">
      <div class="main_city_map" id="main_city_map"></div>
      <div class="main_city_address">
        <span class="main_city_address_txt">具体地址:</span>
        <input type="text" class="main_city_input" placeholder="请输入具体地址">
      </div>
      <div class="main_city_tel">
        <span class="main_city_tel_txt">联系电话:</span>
        <input type="text" class="main_city_input" placeholder="请填写联系电话">
      </div>
    </div>
  </div>
</template>

<script>
    export default {
        name: "uploadingMainCity",
        mounted(){
          //百度地图
          var map = new BMap.Map("main_city_map");          // 创建地图实例
          var point = new BMap.Point(116.404, 39.915);  // 创建点坐标
          map.centerAndZoom(point, 15);
          map.enableScrollWheelZoom(true);
          map.enableInertialDragging();

          map.enableContinuousZoom();

          //城市选择
          var size = new BMap.Size(10, 20);
          map.addControl(new BMap.CityListControl({
            anchor: BMAP_ANCHOR_TOP_LEFT,
            offset: size,
            // 切换城市之间事件
            // onChangeBefore: function(){
            //    alert('before');
            // },
            // 切换城市之后事件
            // onChangeAfter:function(){
            //   alert('after');
            // }
          }));

          //定位
          var geolocation = new BMap.Geolocation();
          geolocation.getCurrentPosition(function(r){
            if(this.getStatus() == BMAP_STATUS_SUCCESS){
              var mk = new BMap.Marker(r.point);
              map.addOverlay(mk);
              map.panTo(r.point);
              console.log('您的位置：'+r.point.lng+','+r.point.lat);

            }
            else {
              alert('failed'+this.getStatus());
            }
          },{enableHighAccuracy: true});

          //检索
          var $addressInput = $(".mod_uploading .main_city_address .main_city_input");
          $addressInput.keyup(function(){
            var kw = $addressInput.val();
            var local = new BMap.LocalSearch(map, {
              renderOptions:{map: map}
            });
            local.search(kw);
          })
        }
    }
</script>

<style scoped>

</style>
