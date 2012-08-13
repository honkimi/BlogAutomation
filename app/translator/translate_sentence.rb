
class TranslateSentence
	def initialize
		#$ie.go("http://www.excite.co.jp/world/english/")
		$ie.go("http://translate.google.com/#en/ja/")
	end
	
	def translate sentence
		$ie.find.id("source").html(sentence)
		sleep 15
		return $ie.find.id("result_box").html() + "<hr />" + sentence
	end
	
	def translate_excite sentence
		$ie.find.id("before").html(sentence)
		$ie.find.id("before_en").click
		$ie.find.id("exec_transfer").click
		mix = $ie.find.id("after").html() + sentence
		mix.sub!("‚±‚¿‚ç‚É–|–ó‚µ‚½‚¢•¶Í‚ğ“ü—Í‚µ‚Ä‚­‚¾‚³‚¢B","")
		return mix
	end

end