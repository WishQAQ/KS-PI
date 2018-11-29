$(function(){
  /**********************类别鼠标事件*************************/
  $(".mod_uploading .main_type_list .figure_list").on("mouseenter",".list_item",function(){
      var $this=$(this);
        var index=$this.index();
        var $typeImg=$this.find(".type_content_img");
        var $activeImg=$(".main_type_list .active .type_content_img");
        var activeSrc=$activeImg.attr("src").split(".png")[0];
        $this.css({"borderColor":"#dfdfdf","boxShadow":"1px 1px 5px 1px #dfdfdf"})
            .siblings().css({"borderColor":"transparent","boxShadow":"none"});
        if(!$this.is(".active")){
          var src=$typeImg.attr("src").split("_")[0];
          $typeImg.attr("src",src+".png");
            $activeImg.attr("src",activeSrc+"_1.png");
            $this.addClass("active").siblings().removeClass("active");
        }
        $($this.parent().siblings().children()[index]).removeClass("none").siblings().addClass("none");
    });

  /***********************确认按钮***********************************/
  var $uploadingConfirm=$(".mod_uploading .mod_uploading_confirm");
  $uploadingConfirm.on("mouseenter","a",function(){
    var $this=$(this);
    $this.addClass("active").siblings().removeClass("active");
  })

  /***********************提示信息***********************************/
  // $(window).scroll(function(){
  //   console.log(11);
  //   console.log($("body").width());
  //   var $describe=$("#main_city_map");
  //   $scrollTop=$(window).scrollTop();
  //   var $mainTips=$(".mod_uploading .main_item_tips");
  //   function getPoint(obj) { //获取某元素以浏览器左上角为原点的坐标
  //     var t = obj.offsetTop; //获取该元素对应父容器的上边距
  //     var l = obj.offsetLeft; //对应父容器的上边距
  //     //判断是否有父容器，如果存在则累加其边距
  //     while (obj = obj.offsetParent) {//等效 obj = obj.offsetParent;while (obj != undefined)
  //       t += obj.offsetTop; //叠加父容器的上边距
  //       l += obj.offsetLeft; //叠加父容器的左边距
  //     }
  //     return t;
  //   }
  //   var top=getPoint($describe[0])-120;
  //   if($scrollTop>100 && $scrollTop<top){
  //     if($("body").width()<=1200){
  //       $mainTips.css({"position":"fixed","top":"100px","left":"61%","width":"20%"});
  //     }else{
  //     $mainTips.css({"position":"fixed","top":"100px","left":"58%","width":"20%"});}
  //   }else if($scrollTop>top){
  //     $mainTips.css({"position":"absolute","top":top+"px","left":"63%","width":"32%"});
  //   }else{
  //     $mainTips.css({"position":"absolute","top":"113px","left":"63%","width":"32%"});
  //   }
  // });
});
