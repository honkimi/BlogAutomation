require './app/distributor/goalcom'
require './app/blog/seesaa'
require './app/process/base_process'

class GoalcomProcess < BaseProcess
	def self.exec
		url_list = [
			"http://www.goal.com/en-gb/people/japan/29077/shinji-kagawa",
			"http://www.goal.com/en/people/japan/20482/keisuke-honda",
			"http://www.goal.com/en/people/japan/23134/yuto-nagatomo"
		]
		super(url_list, Goalcom.new, Seesaa.new, :football)
	end
end