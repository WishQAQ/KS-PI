$(function(){
    /*********************点赞事件***************************/
    $(".video_info_ctrl").on("click",".info_ctrl_icon",function(){
       var $this=$(this);
       var $CtrlNum=$this.siblings(".info_ctrl_num");
       var num=parseInt($CtrlNum.html());
        if(!$this.is(".disabled")){
            if($this.is(".info_ctrl_icon_top")){
               num++;
               $this.addClass("disabled").siblings(".info_ctrl_icon").removeClass("disabled");
            }else if($this.is(".info_ctrl_icon_bottom")){
                num--;
                $this.addClass("disabled").siblings(".info_ctrl_icon").removeClass("disabled");
            }else{
                confirm("是否举报该评论？")
            }
        }
        $CtrlNum.html(num);
    })

    /***********************编写评论***************************/
    $(".comment_publish_btn").on("click",".a",function(){
        var $this=$(this);
        var $comment=$("#comment");
        if($this.is(".publish_btn_cancel")){
            $comment.val("");
        }else{
            if($comment.val()==""){
                alert("请编辑内容！")
            }else{
                alert("已发布！");
            }
        }
    })
})