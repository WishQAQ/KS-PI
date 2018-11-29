
//
//
// // 个人资料背景
// $(".information_file").click(function(){
//     $(".information_file_mode").slideToggle(1);
// });
// $(".btn-primary-cancel").click(function(){
//     $(".information_file_mode").slideToggle(1);
// });
//
// var initCropper = function (img, input){
//     var $image = img;
//     var options = {
//         aspectRatio: 6, // 纵横比
//         viewMode: 1,
//         zoomable:'true',
//         dragCrop:' ',
//         autoCropArea:'1',
//     };
//     $image.cropper(options);
//     var $inputImage = input;
//     var uploadedImageURL;
//     if (URL) {
//         // 给input添加监听
//         $inputImage.change(function () {
//             var files = this.files;
//             var file;
//             if (!$image.data('cropper')) {
//                 return;
//             }
//             if (files && files.length) {
//                 file = files[0];
//                 // 判断是否是图像文件
//                 if (/^image\/\w+$/.test(file.type)) {
//                     // 如果URL已存在就先释放
//                     if (uploadedImageURL) {
//                         URL.revokeObjectURL(uploadedImageURL);
//                     }
//                     uploadedImageURL = URL.createObjectURL(file);
//                     // 销毁cropper后更改src属性再重新创建cropper
//                     $image.cropper('destroy').attr('src', uploadedImageURL).cropper(options);
//                     $inputImage.val('');
//                 } else {
//                     window.alert('请选择一个图像文件！');
//                 }
//             }
//         });
//     } else {
//         $inputImage.prop('disabled', true).addClass('disabled');
//     }
// }
// var crop = function(){
//     var $image = $('#photo');
//     var $target = $('#result');
//     $image.cropper('getCroppedCanvas',{
//         width:1200, // 裁剪后的长宽
//         height:200
//     }).toBlob(function(blob){
//         // 裁剪后将图片放到指定标签
//         $target.attr('src', URL.createObjectURL(blob));
//     });
//     $('.information_file_mode').slideToggle(1);
// }
// $(function(){
//     initCropper($('#photo'),$('#input'));
// });
//
//
//
//
//
// // 个人头像
// $(".user_avatar_file").click(function(){
//     $(".user_avatar_file_mode").slideToggle(1);
// });
//
// $(".btn-primary-cancel2").click(function(){
//     $(".user_avatar_file_mode").slideToggle(1);
// });
//
// var initCropper2 = function (img, input){
//     var $image = img;
//     var options = {
//         aspectRatio: 1, // 纵横比
//         viewMode: 1,
//         zoomable:'true',
//         dragCrop:' ',
//         autoCropArea:'1',
//     };
//     $image.cropper(options);
//     var $inputImage = input;
//     var uploadedImageURL;
//     if (URL) {
//         // 给input添加监听
//         $inputImage.change(function () {
//             var files = this.files;
//             var file;
//             if (!$image.data('cropper')) {
//                 return;
//             }
//             if (files && files.length) {
//                 file = files[0];
//                 // 判断是否是图像文件
//                 if (/^image\/\w+$/.test(file.type)) {
//                     // 如果URL已存在就先释放
//                     if (uploadedImageURL) {
//                         URL.revokeObjectURL(uploadedImageURL);
//                     }
//                     uploadedImageURL = URL.createObjectURL(file);
//                     // 销毁cropper后更改src属性再重新创建cropper
//                     $image.cropper('destroy').attr('src', uploadedImageURL).cropper(options);
//                     $inputImage.val('');
//                 } else {
//                     window.alert('请选择一个图像文件！');
//                 }
//             }
//         });
//     } else {
//         $inputImage.prop('disabled', true).addClass('disabled');
//     }
// }
// var crop2 = function(){
//     var $image = $('#userPhoto');
//     var $target = $('#userResult');
//     $image.cropper('getCroppedCanvas',{
//         width:160, // 裁剪后的长宽
//         height:160,
//     }).toBlob(function(blob){
//         // 裁剪后将图片放到指定标签
//         $target.attr('src', URL.createObjectURL(blob));
//     });
//     $('.user_avatar_file_mode').slideToggle(1);
// }
// $(function(){
//     initCropper2($('#userPhoto'),$('#userInput'));
// });
//








// 修改个人简介
$(function(){
    var flg = false;
    $(".user_introduction").click(function(){
        if(flg == false){
            $(this).html("<input value='"+$(this).html()+"'>");
            flg = true;
            $(this).find("input").focus().blur(function(){
                $(".user_introduction").html($(this).val());
                flg = false;
            }).keypress(function(e){
                // 回车键事件
                if(e.which == 13) {
                    $(this).blur();
                }
            });
        }
    });
});






// 列表收缩
$(function(){
    $('.fold_orderOver').click(function(){
        if($('.orderOver_box').is(':hidden')){
            $('.orderOver_box').slideToggle();
        }
        else{
            $('.orderOver_box').slideToggle();
        }
    })
});

$(function(){
    $('.fold_delivery').click(function(){
        if($('.delivery_box').is(':hidden')){
            $('.delivery_box').slideToggle();
        }
        else{
            $('.delivery_box').slideToggle();
        }
    })
});

$(function(){
    $('.fold_evaluate').click(function(){
        if($('.evaluate_box').is(':hidden')){
            $('.evaluate_box').slideToggle();
        }
        else{
            $('.evaluate_box').slideToggle();
        }
    })
});




// tab页切换
function tab(tabID,box){
    $(tabID).click(function(){
        $(tabID).removeClass('active');
        $(box).hide();
        $(this).addClass('active');
        $(box).eq($(this).index()).show();
    });
}
$(document).ready(function(){
    //选项卡
    tab("#tab11 li",'.box1');

    // 上传管理选项卡
});




// 全选框
function changeState(isChecked){
    var chk_list=document.getElementsByTagName("input");
    for(var i=0;i<chk_list.length;i++)
    {
        if(chk_list[i].type=="checkbox")
        {
            chk_list[i].checked=isChecked;
        }
    }
};




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
