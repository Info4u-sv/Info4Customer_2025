$(window).load(function(){
	/* shadow */
    //console.log($('#wrapper').height());
    
	$('#wrapper-shadow img').css('height', $('#wrapper').height() - 200);

	/* top horizontal menu */
	$('.second-level').hide();
	$('.fourth-level').hide();

	$('#main-menu .first-level li').mouseenter(function() {
		$('.second-level').hide();
		$('.fourth-level').hide();
		$(this).addClass('hover');

		var item = $(this).attr('data-item');
		$('.second-level[data-item="' + item + '"]').show();
		var left = $('#main-menu .first-level li.hover').position().left;
		$('.second-level').css('margin-left', left + 2);
	});

	$('#main-menu .first-level li').mouseleave(function() {
		$(this).removeClass('hover');
		
		var item = $(this).attr('data-item');
		
		close = true;
		hideAction = function() {
			if (close == true) {
				$('.second-level[data-item="' + item + '"]').hide();
			}
		};
		setTimeout('hideAction();', 200);
	});

	$('.second-level').mouseenter(function() {
		close = false;
		var item = $(this).attr('data-item');
		$('.first-level li[data-item="' + item + '"]').addClass('hover');
	});

	$('.second-level').mouseleave(function() {
		var self = this;
		close2 = true;
		hideAction2 = function() {
			if (close2 == true) {
				$(self).hide();
				$('.fourth-level').hide();
				$('.first-level li').removeClass('hover');
			}
		};
		setTimeout('hideAction2();', 200);
	});

	$('.fourth-level').mouseenter(function() {
		close2 = false;
	});

	$('.third-level li').mouseenter(function() {		
		var item = $(this).attr('data-item');
		$('.fourth-level').hide();
        $('.fourth-level').removeClass('visibility');
       
		$('.fourth-level[data-item="' + item + '"]').show();
		
		// vertical positioning and background image
		var top = $(this).position().top;
		if ($(this).hasClass('first')) {
		    $('.fourth-level').css('visibility', "visible");		
			$('.fourth-level').css('background-image', "url(static/img/fourth-level-bg-top.gif)");	
			$('.fourth-level').css('background-position', "left top");	
			$('.fourth-level').css('top', top + 24);
} else if ($(this).hasClass('last')) {
    $('.fourth-level').css('visibility', "visible");
			$('.fourth-level').css('background-image', "url(static/img/fourth-level-bg-bottom.gif)");	
			$('.fourth-level').css('background-position', "left bottom");	
			$('.fourth-level').css('top', top);
} else {
    $('.fourth-level').css('visibility', "visible");
			$('.fourth-level').css('background-image', "url(static/img/fourth-level-bg.gif)");	
			$('.fourth-level').css('background-position', "left center");	
			$('.fourth-level').css('top', top + 10);
		}		

	});

	/* right menu */
	$('#right-menu-area .label:not([data-item="news"])').hide();

	$('#right-menu-area .icon:not([data-item="news"])').click(function() {		
		var item = $(this).attr('data-item');
		$('#right-menu-area .label:not([data-item="news"])').slideUp('slow');
		var item = $(this).attr('data-item');
		$('#right-menu-area .label[data-item="' + item + '"]').slideToggle('slow');
	});	
	
})
