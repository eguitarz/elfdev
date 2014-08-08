$(document).on 'page:change', ->
	self = @

	setDisplayer = (index, number, unit)->
		elem = $('.displayer').get(index-1)
		$(elem).html "<span class=\"number\">#{number}</span> #{unit}"
		$(".ring-1 .spoke:nth-child(#{index+1})").addClass('display')

	hideDisplayer = (index)->
		$(".ring-1 .spoke:nth-child(#{index+1})").removeClass('display')

	updateClock = ()->
		prepandZeroes = (number, times)->
			zeroes = ''
			for i in [0..times]
				zeroes += '0'
			return zeroes + number

		now = new Date()
		h = prepandZeroes(now.getHours(), 2);
		m = prepandZeroes(now.getMinutes(), 2);
		s = prepandZeroes(now.getSeconds(), 2);
		ms = prepandZeroes(Math.round(now.getMilliseconds() / 100 + 0.5), 1);
		$('#clock .time').text "#{h.slice(-2)}:#{m.slice(-2)}:#{s.slice(-2)}.#{ms.slice(-1)}"
		self.clockCallback = setTimeout ->
			updateClock()
		,100

	stopClock = ()->
		clearTimeout self.clockCallback

	updateDate = ()->
		getMonthStr = (m)->
			['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'][m]

		getDayStr = (day)->
			['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'][day]

		now = new Date()
		monthStr = getMonthStr(now.getMonth()).toUpperCase()
		dateStr = now.getDate()
		dayStr = getDayStr(now.getDay()).toUpperCase()
		$('.ring-1 .date').html "#{monthStr} #{dateStr} <span class=\"day\">#{dayStr}</span>"

	getDayOfYear = ()->
		now = new Date()
		start = new Date(now.getFullYear(), 0, 0)
		diff = now - start
		oneDay = 1000 * 60 * 60 * 24
		Math.floor(diff / oneDay)

	initialize = ()->
		updateClock();
		updateDate();

		$('#status').on 'mouseover', ->
			setDisplayer(1, 7132, 'steps')
			setDisplayer(2, 3385, 'runs')
		.on 'mouseout', ->
			hideDisplayer(1)
			hideDisplayer(2)

		$('#journal').on 'mouseover', ->
			setDisplayer(1, 1, 'posts')
		.on 'mouseout', ->
			hideDisplayer(1)

		$('#recipe').on 'mouseover', ->
			setDisplayer(1, 3, 'recipes')
		.on 'mouseout', ->
			hideDisplayer(1)

		tmp = $('.ring-1 .date').html()
		dayOfYear = getDayOfYear()
		$('.ring-1').on 'mouseover', ->
			$(@).find('.date').html("DAY <span class=\"day\">#{dayOfYear}</span>")
		.on 'mouseout', ->
			$(@).find('.date').html(tmp)

		# show menu
		$('#menu-container').addClass 'show'

		$('#clock').on 'mouseover', ->
			stopClock()
		.on 'mouseout', ->
			updateClock()

		# set time zone
		diff = (new Date).getTimezoneOffset() / 60
		diff = if diff >= 0 then 'UTC -' + diff else 'UTC ' + -diff
		$('#clock .zone').text diff

	initialize();