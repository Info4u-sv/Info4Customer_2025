$(function () {
    var timeout;
    //	Scrolled by user interaction
    //	$('#foo2').carouFredSel({
    //	    auto: true,
    //	    slideInterval: 3000,
    //		prev : '#prev2',
    //		next : '#next2',
    //		mousewheel : false
    //	});
    $('#foo2').carouFredSel({
        items: 8,
        scroll: 1,
        prev: '#prev2',
        next: '#next2',
        mousewheel: false
    });
    //Menu
    $("#main_menu div").hover(
		function () {
		    $(this).addClass('hover');
		},
		function () {
		    $(this).removeClass('hover');
		}
	);

    // menu catalogo e subcatalogo

    $(".menu_catalogo div").mouseover(
		function () {
		    jQuery('.menu_catalogo div').removeClass('hover');
		    jQuery(this).addClass('hover');
		    jQuery('.sub_menu_catalogo').hide();
		    var to_activate = $(this).attr('rel');
		    jQuery("#" + to_activate).show();
		}
	);
		$(".menu_assistenza div").mouseover(
		function () {
		    jQuery('.menu_assistenza div').removeClass('hover');
		    jQuery(this).addClass('hover');
		    jQuery('.sub_menu_assistenza').hide();
		    var to_activate = $(this).attr('rel');
		    jQuery("#" + to_activate).show();
		}
	);
    $(".sub_menu_catalogo").mouseover(
		function () {
		    clearTimeout(timeout);
		}
	);
    $(".sub_menu_assistenza").mouseover(
		function () {
		    clearTimeout(timeout);
		}
	);
    $("#menu_catalogo_container").mouseleave(
	function () {
	    timeout = setTimeout(function () {
	        jQuery('.sub_menu_catalogo').hide();
	        jQuery('div.sub_menu_catalogo.actived').show();
	        jQuery('.menu_catalogo div').removeClass('hover');
	        jQuery('.menu_catalogo div.actived').addClass('hover');

	    }, 1000)
	}
	);
    $("#menu_assistenza_container").mouseleave(
	function () {
	    timeout = setTimeout(function () {
	        jQuery('.sub_menu_assistenza').hide();
	        jQuery('div.sub_menu_assistenza.actived').show();
	        jQuery('.menu_assistenza div').removeClass('hover');
	        jQuery('.menu_assistenza div.actived').addClass('hover');

	    }, 1000)
	}
	);

});

jQuery(document).ready(function () {
    jQuery('#sub_menu_catalogo').hide();
    jQuery('#voce_catalogo').hover(function () {
        jQuery('#voce_catalogo').addClass('hover');
        jQuery('#sub_menu_catalogo').show();
        jQuery('.sub_menu_catalogo_contenuto').hide();
    });
});
jQuery(document).ready(function () {
    jQuery('#sub_menu_assistenza').hide();
    jQuery('#voce_assistenza').hover(function () {
        jQuery('#voce_assistenza').addClass('hover');
        jQuery('#sub_menu_assistenza').show();
        jQuery('.sub_menu_assistenza_contenuto').hide();
    });
});
jQuery(document).ready(function () {
    jQuery('.sub_menu_catalogo_title').hover(function () {
        jQuery('.sub_menu_catalogo_contenuto').hide();
        jQuery('.sub_menu_catalogo_title').removeClass('actived');
        jQuery(this).addClass('actived');
        if (jQuery(this).hasClass('sx')) { $('.sub_menu_catalogo_contenuto.sx').show(); };
        if (jQuery(this).hasClass('dx')) { $('.sub_menu_catalogo_contenuto.dx').show(); };
    });
});
jQuery(document).ready(function () {
    jQuery('.sub_menu_assistenza_title').hover(function () {
        jQuery('.sub_menu_assistenza_contenuto').hide();
        jQuery('.sub_menu_assistenza_title').removeClass('actived');
        jQuery(this).addClass('actived');
        if (jQuery(this).hasClass('sx')) { $('.sub_menu_assistenza_contenuto.sx').show(); };
        if (jQuery(this).hasClass('dx')) { $('.sub_menu_assistenza_contenuto.dx').show(); };
    });
});
jQuery(document).ready(function () {
    jQuery('#sub_menu_catalogo').mouseleave(function () {
        jQuery('#sub_menu_catalogo').hide();
        jQuery('#voce_catalogo').removeClass('hover');
    });

});
jQuery(document).ready(function () {
    jQuery('#sub_menu_assistenza').mouseleave(function () {
        jQuery('#sub_menu_assistenza').hide();
        jQuery('#voce_assistenza').removeClass('hover');
    });

});
jQuery(document).ready(function () {
    jQuery('.voce_generica').hover(function () {
        jQuery('#sub_menu_catalogo').hide();
        jQuery('#voce_catalogo').removeClass('hover');
        jQuery('#sub_menu_assistenza').hide();
        jQuery('#voce_assistenza').removeClass('hover');
    });
});

