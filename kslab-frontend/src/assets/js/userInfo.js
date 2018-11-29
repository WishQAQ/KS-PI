// 返回顶部
$(function(){
    $("#backTop").click(function(e) {
        $('body,html').animate({scrollTop:0},500);
    });
    backTop();
});
function backTop()
{
    $(window).scroll(function(e) {
        if($(window).scrollTop()>200)
            $("#backTop").css('opacity','1');
        else
            $("#backTop").css('opacity','0');
    });
};
