$(document).on 'page:change', ->

  $('#numbers').on 'mouseover', ->
    $('#application').removeClass()
    $('#application').addClass 'selected-numbers'

  $('#places').on 'mouseover', ->
    $('#application').removeClass()
    $('#application').addClass 'selected-places'

  $('#words').on 'mouseover', ->
    $('#application').removeClass()
    $('#application').addClass 'selected-words'

  L.mapbox.accessToken = 'pk.eyJ1IjoiZWd1aXRhcnoiLCJhIjoiM0h4WFlDYyJ9.6gw0kHIYT7hX8C3eLfbgxA';
  map = L.mapbox.map('map', 'eguitarz.j621dk0e').setView([53.53683887552085, -113.50181579589844], 15);