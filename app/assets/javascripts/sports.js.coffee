$(document).on 'page:change', ->
	setProgressBar = (selector, attr)->
		$(selector).each ->
			progress = $(@).attr('percent') + '%';
			$(@).css(attr, progress)

	setTimeout ->
		setProgressBar('.bar-chart.walking .bar-overlay', 'height')
		setProgressBar('.bar-chart.running .bar-overlay', 'width')
	, 1000