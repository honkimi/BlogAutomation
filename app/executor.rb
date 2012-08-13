require './lib/IeHandler'
require './app/process/goalcom_process'
require './app/process/fifa_process'


module Executor
	def self.exec
		$ie = IeHandler::IePage.new("http://google.com/")
		GoalcomProcess.exec
		FifaProcess.exec
		$ie.close
	end
end
