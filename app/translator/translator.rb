require './app/translator/translate_web'
require './app/translator/translate_sentence'

class Translator
	def initialize
	end

	#翻訳されたセンテンスを返す
	def translate_sentence sentence
		@translate_sentence = TranslateSentence.new
		@translate_sentence.translate sentence
	end
	
	#翻訳されたページまで飛ぶだけ。
	def translate_web url
		@translate_web = TranslateWeb.new
		@translate_web.translate url
	end
end

