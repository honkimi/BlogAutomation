require './lib/IeHandler'
require 'date'


ie = IeHandler::IePage.new("http://www.goal.com/en-gb/people/japan/29077/shinji-kagawa")

p ie.methods

