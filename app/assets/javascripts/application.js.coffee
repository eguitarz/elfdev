#= require jquery
#= require jquery_ujs
#= require turbolinks

#= require_tree .

$(document).on 'page:change', ->
  $('body').addClass('loaded')

  # redispatch every hyper link
  $('a').on 'click mouseup', (e)->
    e.preventDefault()
    e.stopPropagation()
    $('body').removeClass('loaded')

    hyperlink = @
    setTimeout ->
      window.location = $(hyperlink).attr('href')
    , 600