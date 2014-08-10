$(document).on 'page:change', ->
  setProgressBar = (selector, attr)->
    $(selector).each ->
      progress = $(@).attr('percent') + '%';
      $(@).css(attr, progress)

  setTimeout ->
    setProgressBar('.bar-chart.walking .bar-overlay', 'height')
    setProgressBar('.bar-chart.running .bar-overlay', 'width')
  , 1000

  $('.bar, .dot').on 'mouseover', ->
    $('#indicator').html("<div>Distance: #{$(@).data('distance')}</div><div>Duration: #{$(@).data('duration')}</div>")
    offset = $(@).offset()
    width = $(@).width()
    $('#indicator').css('left', offset.left + width + 10).css('top', offset.top).removeClass('inactive')
  .on 'mouseout', ->
    $('#indicator').addClass('inactive')