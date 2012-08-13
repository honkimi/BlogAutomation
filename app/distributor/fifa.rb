require 'date'
require './app/translator/translator'

class Fifa < Distributor
	def check_update_time
		tag_date = $ie.find.tag("h1",0).nextSibling.html()
		tag_date.sub!(/([a-zA-Z]*)/,"")
		super(tag_date)
	end
	
	def go_detail
		@detail_url = "http://www.fifa.com" + $ie.find.id("mainContent").tag("div",27).tag("a",0).attr("href")
		$ie.go( @detail_url )
	end
	
	def process
		trans = Translator.new
		law_comment = get_law_comment
		comment = trans.translate_sentence(law_comment)
		trans.translate_web(@detail_url)
		body = get_translated_content
		@title   = $ie.find.tag("h1",0).html().gsub!(/<.*?>/,"")
		@content = body +"<hr/><h4>äCäOÇÃîΩâû</h4><br />"+ comment + "<br /><h4>éQè∆å≥</h4><a href=\"" + @detail_url + "\">" + @detail_url + "</a>"
	end
	
	private
	def get_law_comment
		law_comment = ""
		for i in 0..4
			begin
				name =  $ie.find.id("listComment").tag("div",3+i*8).tag("div",2).tag("strong",0).html + $ie.find.id("listComment").tag("div",3+i*8).tag("div",2).html().match(/\([a-zA-Z]*?\)/)[0]
				msg  =  $ie.find.id("listComment").tag("div",3+i*8).tag("div",3).tag("span",0).html
				law_comment += name + "\n"
				law_comment += msg + "\n\n"
			rescue
			end
		end
		
		return law_comment
	end
	
	private
	def get_translated_content
		sleep 3
		@title   = $ie.find.tag("h1",0).html()
		law_body = $ie.find.id("mainContent").tag("div",12 ).html()
		format(law_body)
	end
	
	private
	def format law_body
		img_url = $ie.find.id("pcImg").attr("src")
		img_alt = $ie.find.id("pcImg").attr("alt")
		
		formed_text = law_body #""

		body = "<img src=\"http://www.fifa.com"+img_url+"\" alt=\"" + img_alt + "\" />" + formed_text
		return body
	end
	
end



