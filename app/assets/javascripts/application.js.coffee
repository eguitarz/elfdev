#= require jquery
#= require jquery_ujs
#= require turbolinks
#= require bootstrap

#= require_tree .

$(document).on 'page:change', ->
	console.log $('.loadable').removeClass('loadable')