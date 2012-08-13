class Seesaa
	@@blog_map = {
		:football => 0
	}

	def initialize
	end
	
	def login id, pass
		$ie.go("http://blog.seesaa.jp/")
		$ie.find.clazz("hd",0).clazz("account",0).tag("a",2).click

		sleep 3
		$ie.find.id("email").attr("value", id)
		$ie.find.id("password").attr("value", pass)
		$ie.find.id("signin").tag("input",0).click
	end
	
	def select name
		$ie.find.clazz("bloglist_left",0).clazz("bllist",0).clazz("bllist_title",0).tag("a",@@blog_map[name]).click
	end
	
	def post title, content
		sleep 3
		$ie.find.clazz("articletitle_wrap",0).clazz("articletitle",0).html(title)
		$ie.find.id("article__body").html(content)

		$ie.find.clazz("input-save",0).click
	end
end

