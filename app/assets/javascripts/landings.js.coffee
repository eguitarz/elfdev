$(document).on 'page:change', ->

  $('#numbers').on 'mouseover', ->
    $('sidebar').removeClass()
    $('sidebar').addClass 'selected-numbers'

  $('#places').on 'mouseover', ->
    $('sidebar').removeClass()
    $('sidebar').addClass 'selected-places'

  $('#words').on 'mouseover', ->
    $('sidebar').removeClass()
    $('sidebar').addClass 'selected-words'