require './app/translator/translate_web'
require './app/translator/translate_sentence'

class Translator
	def initialize
	end

	#�|�󂳂ꂽ�Z���e���X��Ԃ�
	def translate_sentence sentence
		@translate_sentence = TranslateSentence.new
		@translate_sentence.translate sentence
	end
	
	#�|�󂳂ꂽ�y�[�W�܂Ŕ�Ԃ����B
	def translate_web url
		@translate_web = TranslateWeb.new
		@translate_web.translate url
	end
end

