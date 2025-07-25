$(function() {

	var marker = [], infowindow = [], map,
		image = {
			url: 'img/marker.png',
			size: new google.maps.Size(61, 60),
			anchor: new google.maps.Point(30, 30)
		};

	function addMarker(location,name,contentstr){
        marker[name] = new google.maps.Marker({
            position: location,
            map: map,
           
			icon: image
        });
        marker[name].setMap(map);
		
		infowindow[name] = new google.maps.InfoWindow({
			content:contentstr
		});
		
		google.maps.event.addListener(marker[name], 'click', function() {
			infowindow[name].open(map,marker[name]);
		});
    }
	
	function initialize() {

        var lat = $('#map-canvas').attr("data-lat");
        var lng = $('#map-canvas').attr("data-lng");

        var myLatlng = new google.maps.LatLng(lat, lng);

        var setZoom = parseInt($('#map-canvas').attr("data-zoom"));

        var styles = [{ "featureType": "administrative", "elementType": "labels.text.fill", "stylers": [{ "color": "#444444" }] }, { "featureType": "administrative.country", "elementType": "geometry.fill", "stylers": [{ "visibility": "off" }] }, { "featureType": "administrative.country", "elementType": "geometry.stroke", "stylers": [{ "visibility": "off" }] }, { "featureType": "administrative.country", "elementType": "labels.text", "stylers": [{ "visibility": "off" }] }, { "featureType": "administrative.country", "elementType": "labels.text.fill", "stylers": [{ "visibility": "off" }] }, { "featureType": "administrative.country", "elementType": "labels.text.stroke", "stylers": [{ "visibility": "off" }] }, { "featureType": "administrative.country", "elementType": "labels.icon", "stylers": [{ "visibility": "off" }] }, { "featureType": "administrative.province", "elementType": "geometry.stroke", "stylers": [{ "visibility": "off" }] }, { "featureType": "administrative.province", "elementType": "labels.text", "stylers": [{ "visibility": "off" }] }, { "featureType": "administrative.locality", "elementType": "labels.text", "stylers": [{ "visibility": "off" }] }, { "featureType": "landscape", "elementType": "all", "stylers": [{ "color": "#f2f2f2" }] }, { "featureType": "poi", "elementType": "all", "stylers": [{ "visibility": "off" }] }, { "featureType": "poi.business", "elementType": "labels.icon", "stylers": [{ "visibility": "off" }] }, { "featureType": "road", "elementType": "all", "stylers": [{ "saturation": -100 }, { "lightness": 45 }] }, { "featureType": "road", "elementType": "geometry.stroke", "stylers": [{ "visibility": "off" }] }, { "featureType": "road.highway", "elementType": "all", "stylers": [{ "visibility": "simplified" }] }, { "featureType": "road.highway", "elementType": "labels.text", "stylers": [{ "visibility": "off" }] }, { "featureType": "road.arterial", "elementType": "labels.icon", "stylers": [{ "visibility": "off" }] }, { "featureType": "transit", "elementType": "all", "stylers": [{ "visibility": "off" }] }, { "featureType": "transit", "elementType": "labels.text", "stylers": [{ "visibility": "off" }] }, { "featureType": "transit.station", "elementType": "labels.text", "stylers": [{ "visibility": "off" }] }, { "featureType": "water", "elementType": "all", "stylers": [{ "color": "#485b77" }, { "visibility": "on" }] }];
        //var styledMap = new google.maps.StyledMapType(styles,{name: "Styled Map"});

        var mapOptions = {
           
            scrollwheel: false,
            zoom: setZoom,

            panControl: false,
            panControlOptions: {
                position: google.maps.ControlPosition.LEFT_BOTTOM
            },
            zoomControl: true,
            zoomControlOptions: {
                style: google.maps.ZoomControlStyle.LARGE,
                position: google.maps.ControlPosition.LEFT_BOTTOM
            },
            streetViewControl: true,
            streetViewControlOptions: {
                position: google.maps.ControlPosition.LEFT_BOTTOM
            },

            center: myLatlng,
            mapTypeControlOptions: {
                mapTypeIds: [google.maps.MapTypeId.ROADMAP, 'map_style']
            }

        };
        map = new google.maps.Map(document.getElementById("map-canvas"), mapOptions);
 
        //map.mapTypes.set('map_style', styledMap);
        //map.setMapTypeId('map_style');


        $('.addresses-block a').each(function () {
            var mark_lat = $(this).attr('data-lat');
            var mark_lng = $(this).attr('data-lng');
            var this_index = $('.addresses-block a').index(this);
            var mark_name = 'template_marker_' + this_index;
            var mark_locat = new google.maps.LatLng(mark_lat, mark_lng);
            var mark_str = $(this).attr('data-string');
            addMarker(mark_locat, mark_name, mark_str);
        });
	}

	$(window).load(function(){
        setTimeout(function () { initialize(); }, 0);

	});

});
