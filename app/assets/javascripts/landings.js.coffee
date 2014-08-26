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