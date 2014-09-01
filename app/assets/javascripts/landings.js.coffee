$(document).on 'page:change', ->
  select = (name)->
    $('#application').removeClass()
    $('#application').addClass "selected-#{name}"

  $('#numbers').on 'mouseover', ->
    select('numbers')
  $('#numbers-indicator').on 'click', ->
    select('numbers')

  $('#places').on 'mouseover', ->
    select('places')
  $('#places-indicator').on 'click', ->
    select('places')

  $('#words').on 'mouseover', ->
    select('words')
  $('#words-indicator').on 'click', ->
    select('words')

  # L.mapbox.accessToken = 'pk.eyJ1IjoiZWd1aXRhcnoiLCJhIjoiM0h4WFlDYyJ9.6gw0kHIYT7hX8C3eLfbgxA';
  # map = L.mapbox.map('map', 'eguitarz.j621dk0e').setView([53.53683887552085, -113.50181579589844], 15);