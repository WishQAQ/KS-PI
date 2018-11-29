$(function(){
/*-------图片hover切换方法可通用---------*/
/*----Longimg为原图片链接，img为新，class元素class/id----*/
	function HoverImg(Cclass,img,Longimg){
		$(Cclass).hover(function() {
			var a  =$(this).attr("src",img)
			console.log($(this).attr("src"))
		}, function() {
			$(this).attr("src",Longimg)
		});
	}

	HoverImg(".HoverQQ a img","images/QQ_block.gif","images/qq.gif")
	HoverImg(".HoverWeibo a img","images/weibo_block.gif","images/weibo.gif")
	HoverImg(".Hoverwechar a img","images/wechar_block.gif","images/wechar.gif")


/*-------对电子邮件/手机的验证-------*/

	function Iphone(Idiphone){
		var temp = document.getElementById(Idiphone);
		var myreg = /^([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,3}$/;  //邮箱正则

		var PhoneReg = /^1[0-9]{10}$/;    //手机正则

		if (!myreg.test(temp.value) && !PhoneReg.test(temp.value)) {

			temp.nextSibling.nextElementSibling.innerHTML = "请输入正确的邮箱地址/或者手机"

			return false;
		}
		else{
			temp.nextSibling.nextElementSibling.innerHTML = ""
			return true;
		}
	}

	function Emilm(Cemlid){
		var tempL = document.getElementById(Cemlid);

		var myreg = /^([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,3}$/;  //邮箱正则

		if (!myreg.test(tempL.value)) {

			tempL.nextSibling.nextElementSibling.innerHTML = "请输入正确的邮箱地址"

			return false;
		}
		else{
			tempL.nextSibling.nextElementSibling.innerHTML = ""
			return true;
		}
	}

	function Yanz(IphoneC){
		var PhoneReg = /^1[0-9]{10}$/;
		var Cpas = document.getElementById(IphoneC)
		if(!PhoneReg.test(Cpas.value))
		{
			Cpas.nextSibling.nextElementSibling.innerHTML = "请输入正确的手机"
			return false;
		}
		else{
			Cpas.nextSibling.nextElementSibling.innerHTML = "";
			return true;
		}
	}


	/*---密码必须为字母加数字且长度不小于8位----*/
	function Psarrword(password){
		var ThisC = document.getElementById(password)
		var str = document.getElementById(password).value
		    if (str.length <8) {
		    	ThisC.nextSibling.nextElementSibling.innerHTML = "密码必须为字母加数字且长度不小于8位"
		        return false;
		    }
		    else{

		    	ThisC.nextSibling.nextElementSibling.innerHTML = ""
		    	return true;

		    }
		    var reg1 = new RegExp(/^[0-9A-Za-z]+$/);
		    if (!reg1.test(str)) {
		        return false;
		    }
		    var reg = new RegExp(/[A-Za-z].*[0-9]|[0-9].*[A-Za-z]/);
		    if (reg.test(str)) {
		        return false;
		    } else {
		        return true;
		    }
	}
	/*------验证密码是否相同-------*/
	function PassContD(ContPass,ContDspass){
		if($(ContPass).val() != $(ContDspass).val())
		{
			$(ContDspass).next().html("俩次密码必须相同哟~~")
			return false;
		}
		else{
			$(ContDspass).next().html("")
			return true;
		}
	}
/*---必须为字母加数字且长度不小于8位-----*/
	$("#Passwrod").keyup(function(){
		Psarrword("Passwrod")

		return false;
	})

	$("input[name=Passcontws]").keyup(function() {
		PassContD("#Passwrod","#ContIdPassd")

		return false;
	});

	$("#Fuc-NewPasswrod").click(function(){
		console.log(PassContD("#Passwrod","#ContIdPassd"))
		if(!Psarrword("Passwrod") || !PassContD("#Passwrod","#ContIdPassd"))
		{
			console.log("1")
			return false
		}
		else
		{
			return true;
		}
	})

/*------------------------------------*/

	$("input[name=Dc_title_emild]").keyup(function(){
		Iphone("email_Coiphone");

	})
	$(".Fuc-Form-submit").click(function(){
		console.log(Iphone("email_Coiphone"))
		if(Iphone("email_Coiphone") == false)
		{
			return false;
		}
		else
		{
			var Form = document.getElementsByClassName('oForm')[0]
			Form.submit()
			return true;
		}

	})
/*-----------------------------------*/

	$("#Iphone").keydown(function() {
		Yanz("Iphone");
	});

	$("#email").keydown(function() {
		Emilm("email")
	});

	$("#passwordT").keydown(function() {
		Psarrword("passwordT")
	});

	$("#ContVPassword").keydown(function() {
		PassContD("#passwordT","#ContVPassword")
	});
		$("#Contsc").click(function(){
			if(!Yanz("Iphone") || !Emilm("email"))
			{
				return false;
			}
			else
			{
				if(!Psarrword("passwordT") || !PassContD("#passwordT","#ContVPassword"))
				{
					return false
				}
				else{console.log("可提交代码了")
					var Zc = document.getElementById('FormCd')
					Zc.submit();
				}
			}
		})
	$(".Fuc-NoneBtn").click(function(){
		$("input[name]").val('')
		return false
	})

/*-----百度选择项------*/
	// var ue = UE.getEditor('container',{
  //     	toolbars: [
  //       		[
  //       			'fullscreen',
  //       			'source',
  //       			'undo',
  //       			'redo',
  //       			'bold',
  //       			'indent',
  //       			'unlink',
  //       			'inserttitle',
  //       			'simpleupload',
  //       			'insertimage',
  //       			'link',
  //       			'map',
  //       			'justifyleft',
  //       			'justifyright',
  //       			'justifycenter',
  //       			'music',
  //       			'insertorderedlist',
  //       			'insertunorderedlist',
  //       			'backcolor',
  //       			'forecolor',
  //       			'snapscreen',
  //       			"insertvideo"
  //       		]
  //   				],
  //     			  	initialFrameHeight:100,
  //     			  	initialFrameWidth:555,
  //     			  	imagesActionName:'uploadimage',
  //     			  	imageAllowFiles:['.png','.jpg','jpeg','gif','bmp'],
  //     			  	imageUrlProfix:"http://www.baidu.com",  //图片访问路径前缀
  //     			  	imageCompressEnable:true,
  //     			  	videoMaxSize: 512000000,
  //     			  	videoAllowFiles:[
	// 					".flv", ".swf", ".mkv", ".avi", ".rm", ".rmvb", ".mpeg", ".mpg",
	// 					".ogg", ".ogv", ".mov", ".wmv", ".mp4", ".webm", ".mp3", ".wav", ".mid"],
	// 				fileActionName: "uploadfile",
	// 				fileFieldName: "upfile",
  //     			  });
})
