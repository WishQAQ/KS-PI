$(function(){
	$(".left_div_t ul li").hover(function() {
		var BacolorC = $(this).css("borderRight-color")
		$(this).find('span').stop().animate({
			"right":"30px",
		},300)

		$(this).find('span').css({
			"backgroundColor":BacolorC,
			"color":"#FFF"
		})
		$(this).css("backgroundColor",BacolorC)
	}, function() {
		var BacolorC = $(this).css("borderRight-color")
		$(this).find('span').stop().animate({
			"right":"0px",
		},300)

		$(this).find('span').css({
			"backgroundColor":"#FFF",
			"color":"#000"
		})

		$(this).css("backgroundColor","#FFF")
	});


	$(".CssXz_m").click(function(){
		var DivOSlidetoggle = $(".title_proce").slideToggle()
		if($(".CssXz_m img").css("transform") == "matrix(-1, -1.22465e-16, 1.22465e-16, -1, 0, 0)")
		{
			$(".CssXz_m img").css("transform","rotate(0)")
			DivOSlidetoggle
		}
		else
		{
			$(".CssXz_m img").css("transform","rotate(-180deg)")
			DivOSlidetoggle
		}
	})



	setInterval(function(){
		if(document.documentElement.clientWidth <= 1360)
		{
			$(".left_div_t").slideUp()
		}
		else{
			$(".left_div_t").slideDown()
		}
    },100)
})
