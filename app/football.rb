require './lib/IeHandler'
require 'date'
require 'open-uri'
require 'rss'
require 'translator' 

begin
	#Goal.com ����y�[�W
	ie = IeHandler::IePage.new("http://www.goal.com/en-gb/people/japan/29077/shinji-kagawa")

	href = ie.find.id("left_column").clazz("first",0).clazz("feedText",0).tag("a",0).attr("href")
	href = "http://www.goal.com"+href

	#�L���ڍ׃y�[�W�i����&�擾�j
	ie.go(href)

	today = DateTime.now

	tag_date = ie.find.clazz("articleDate",0).tag("h4",0).html()
	article_date = Date.parse(tag_date)
	#exit unless article_date.day == today.day


	divs = ie.find.id("goal-widget-gigyacomments-6-comments").tag("div")
	comments = ""

	i=0
	divs.each do |div|
		break if i > 10
		comments += div.sa.find.clazz("gig-comments-username",i).html() + "<br>"
		comments += div.sa.find.clazz("gig-comments-comment-body",i).html() + "<hr>"
		i+=1
	end

	#tr = Translator.new()
	#comments = tr.translate(comments,"ja")

	#�R�����g�G�L�T�C�g�|��
	ie.go("http://www.excite.co.jp/world/english/")
	ie.find.id("before").html(comments)
	ie.find.id("before_en").click
	ie.find.id("exec_transfer").click
	comment_mix = ie.find.id("after").html() + comments


	#infoseek �E�F�u�|��y�[�W
	ie.go("http://translation.infoseek.ne.jp/web.html")
	ie.find.id("url").attr( "value",href)
	ie.find.id("op2a_4").click
	ie.find.id("ul-mode").tag("a",1).click
	ie.find.id("op2a_2").click

	#�|�󂳂ꂽ�L���ڍ׃y�[�W
	ie.go(ie.find.id("tran-frame").attr("src"))
	title = ie.find.tag("h1",0).html()
	img_url = ie.find.id("large_article_image").tag("img",0).attr("src")
	img_alt = ie.find.id("large_article_image").tag("img",0).attr("alt")

	content = ie.find.id("divAdnetKeyword").html()

	formed_text = ""
	content.each_line do |line|
		formed_text += line + "\n" if line =~ /^\s*?(<a|<br>[��-���@-����-��a-zA-Z0-9"�u]|[��-���@-����-��a-zA-Z0-9])/s && !(line =~ /^\s*?���I/) && !(line =~ /^\s*?Goal./)
	end

	content_mix = "<img src=\""+img_url+"\" alt=\"" + img_alt + "\" />" + formed_text
	content_mix.gsub!("CRHTML_TXN","langja")

	#�ŏI�I�ȋL������
	article = content_mix+"<hr/><h3>�C�O�̔���</h3><br />"+comment_mix + "<br /><h4>�Q�ƌ�</h4><a href=\"" + href + "\">" + href + "</a>"


	#Seesaa �g�b�v�y�[�W
	ie.go("http://blog.seesaa.jp/")
	ie.find.clazz("hd",0).clazz("account",0).tag("a",2).click

	#���O�C���y�[�W
	ie.find.id("email").attr("value", "cevid_cpp@yahoo.co.jp")
	ie.find.id("password").attr("value", "0482862560")
	ie.find.id("signin").tag("input",0).click

	#�u���O�ꗗ�y�[�W
	ie.find.clazz("bloglist_left",0).clazz("bllist",0).clazz("bllist_title",0).tag("a",0).click

	#�L�����e�y�[�W
	ie.find.clazz("articletitle_wrap",0).clazz("articletitle",0).html(title)
	ie.find.id("article__body").html(article)

	ie.find.clazz("input-save",0).click
rescue
	ie.close
	retry
end
ie.close

