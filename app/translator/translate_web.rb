
class TranslateWeb
	def initialize
		#$ie.go("http://translation.infoseek.ne.jp/web.html")
		$ie.go("http://translate.google.com/#en/ja/")
	end
	
	def translate url
		$ie.find.id("source").html(url)
		sleep 3
		$ie.find.id("result_box").tag("a",0).click
		begin
			$ie.go("http://translate.google.com"+$ie.find.id("contentframe").tag("iframe",0).attr("src"))
		rescue
		end
	end
	
	def translate_infoseek url
		$ie.find.id("url").attr( "value",url)
		$ie.find.id("op2a_4").click
		$ie.find.id("ul-mode").tag("a",1).click
		$ie.find.id("op2a_2").click
		$ie.go($ie.find.id("tran-frame").attr("src"))
	end

end