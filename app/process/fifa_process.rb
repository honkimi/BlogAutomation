require './app/distributor/fifa'
require './app/blog/seesaa'
require './app/process/base_process'

class FifaProcess < BaseProcess
	def self.exec
		url_list = [
			#"http://www.fifa.com/worldfootball/statisticsandrecords/players/player=268596/index.html",
			"http://www.fifa.com/worldfootball/statisticsandrecords/players/player=291372/index.html",
			"http://www.fifa.com/worldfootball/statisticsandrecords/players/player=233500/index.html"
		]
		super(url_list, Fifa.new, Seesaa.new, :football)
	end
end