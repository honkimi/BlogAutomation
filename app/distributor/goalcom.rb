require 'date'
require './app/translator/translator'
require './app/distributor/base'

class Goalcom < Distributor
	
	def check_update_time
		tag_date = $ie.find.clazz("articleDate",0).tag("h4",0).html()
		super(tag_date)
	end
	
	def go_detail
		@detail_ur = $ie.find.id("left_column").clazz("first",0).clazz("feedText",0).tag("a",0).attr("href")
		$ie.go( "http://www.goal.com" + @detail_ur )
	end
	
	def process
		trans = Translator.new
		law_comment = get_law_comment
		comment = trans.translate_sentence(law_comment)
		trans.translate_web(@detail_url)
		body = get_translated_content
		@title   = $ie.find.tag("h1",0).html().gsub!(/<.*?>/,"")
		@content = body +"<hr/><h4>ŠCŠO‚Ì”½‰</h4><br />"+ comment + "<br /><h4>QÆŒ³</h4><a href=\"" + @detail_url + "\">" + @detail_url + "</a>"
	end
	
	private
	def get_law_comment
		divs = $ie.find.id("goal-widget-gigyacomments-6-comments").tag("div")
		law_comment = ""

		i=0
		divs.each do |div|
			break if i > 10
			law_comment += "\n\n" + div.sa.find.clazz("gig-comments-username",i).html() + "\n"
			law_comment += div.sa.find.clazz("gig-comments-comment-body",i).html()
			i+=1
		end
		
		return law_comment
	end
	

	
	private
	def get_translated_content
		sleep 3
		@title   = $ie.find.tag("h1",0).html()
		law_body = $ie.find.id("article_content").html()
		format(law_body)
	end
	
	private
	def format law_body
		img_url = $ie.find.id("large_article_image").tag("img",0).attr("src")
		img_alt = $ie.find.id("large_article_image").tag("img",0).attr("alt")
		
		formed_text = law_body #""

		body = "<img src=\""+img_url+"\" alt=\"" + img_alt + "\" />" + formed_text
		return body
	end
	
end



