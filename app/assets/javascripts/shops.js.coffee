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
