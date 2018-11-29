$(function(){
	$(".HoverClick").mouseenter(function(event) {
		var SwchitName = $(this).attr('name')
		var StyleBlue = $(this).css({
			"borderBottom":"2px solid #15bafe"
		})
		var Rovem = $(this).siblings().css("borderBottom","2px solid #FFF")

		function siki(Classname){
			$(Classname).stop(true,true).fadeIn(500)
		  	$(Classname).stop(true,true).siblings().fadeOut(100)
		}
		switch(SwchitName)
		{
		case "Encyclopedias":
		  StyleBlue
		  Rovem
		  siki(".Jg_ss")
		  break;
		case "video":
		  StyleBlue
		  Rovem
		  siki(".Fuc-section-div")
		  break;
		case "problem":
		  StyleBlue
		  Rovem
		  siki(".Fuc-section-problem")
		  break;
		case "Shopping Mall":
		  StyleBlue
		  Rovem
		  siki(".Fuc-section-Mall")
		  break;
		default:
		  console.log("4")
		}
})
	$(".Fuc-jia").click(function(){
		$(this).prev()[0].innerHTML ++
	})

	$(".Fuc-jc").click(function(){
		$(this).next()[0].innerHTML --

		$(this).next()[0].innerHTML <= 0 ? $(this).next()[0].innerHTML = 0:true
	})
})