


class Distributor
	attr_reader :title, :content

	def initialize()
		@title   = ""
		@content = ""
	end
	
	def url=(url)
		@url = url
		$ie.go url
	end
		
	def go_detail
	end
	
	def check_update_time d
		today = DateTime.now
		article_date = Date.parse(d)
		return false unless article_date.day == today.day
		return true
	end
	
	def process
	end
	

end