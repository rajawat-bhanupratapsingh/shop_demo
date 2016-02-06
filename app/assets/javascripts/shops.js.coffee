map = null

setLatLong = (e) ->
	$('#shop_latitude').val e.latLng.lat()
	$('#shop_longitude').val e.latLng.lng()

$(document).on 'ready', ->
	map = new GMaps {
	  div: '#map',
	  lat: 20.593684,
	  lng: 78.96288,
	  click: (e) ->
	  	setLatLong(e)
	 }

$(document).on 'click', '#search-button', ->
	GMaps.geocode
  address: $('#address').val()
  callback: (results, status) ->
    if status == 'OK'
      latlng = results[0].geometry.location
      map.setCenter latlng.lat(), latlng.lng()
      map.addMarker
        lat: latlng.lat()
        lng: latlng.lng()
    return


