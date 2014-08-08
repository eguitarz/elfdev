class SportsController < ApplicationController
	before_action :set_moves_client

	Activity = Struct.new(:summary) do
		def name
			summary['activity']
		end

		def steps
			summary['steps']
		end

		def distance
			summary['distance']
		end
	end

	DailySummary = Struct.new(:raw_daily_summary) do
		def date
			Time.parse raw_daily_summary['date']
		end

		def activities
			result = []
			raw_daily_summary['summary'] and raw_daily_summary['summary'].each do |s|
				result << convert_activity(s)
			end

			result
		end

		def convert_activity(summary)
			Activity.new summary
		end
	end

	def index
		now = DateTime.now
		month = now.strftime('%B')
		ds = get_daily_summaries now.strftime('%Y-%m')
		@summaries = [ process_daily_summaries(ds).merge(month: month) ]
		p @summaries
	end

	private
	def push_activity(date, summary, array)
		array << { date: date, steps: summary['steps'], distance: summary['distance'], duration: summary['duration'] }
	end

	def process_daily_summaries(daily_summary)
		walks = []
		walk_steps = 0
		runs = []
		run_distance = 0
		cycles_v1 = []
		cycles_v2 = []
		cycles_v3 = []
		cycles_count = 0

		daily_summary.each do |ds|
			summary = ds['summary']
			date = ds['date']
			summary and summary.each do |s|
				activity = s['activity']
				if activity == 'walking'
					push_activity(date, s, walks) 
					walk_steps += s['steps']
				end
				if activity == 'running'
					push_activity(date, s, runs) 
					run_distance += s['distance']
				end
				if activity == 'cycling'
					cycles_count += 1
					if s['distance'] < 10000
						push_activity(date, s, cycles_v1) 
					elsif s['distance'] < 20000
						push_activity(date, s, cycles_v2)
					else
						push_activity(date, s, cycles_v3) 
					end
				end

			end
		end
		
		{walks: walks, walk_steps: walk_steps, runs: runs, run_distance: run_distance, cycles_v1: cycles_v1, cycles_v2: cycles_v2, cycles_v3: cycles_v3, cycles_count: cycles_count}
	end

	def set_moves_client
		auth = Authentication.where(provider: 'moves').first
		if auth.present?
			@moves_client = Moves::Client.new(auth.access_token)
		else
			redirect_to "#{Rails.application.config.action_controller.relative_url_root}/auth/moves"
		end
	end

	def get_daily_summaries(query)
		summaries = []
		result = @moves_client.daily_summary(query)
		p result
		result

		# result.each do |s|
		# 	summaries << DailySummary.new(s)
		# end

		# summaries
	end
end
