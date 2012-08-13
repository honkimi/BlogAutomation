class BaseProcess
	def self.exec url_list, dist, blog, blog_kind
		url_list.each do |url|
			i=0
			begin
				dist.url = url
				dist.go_detail
				next unless dist.check_update_time
				dist.process
				title = dist.title
				content = dist.content
				blog.login("#######", "#######")
				blog.select(blog_kind)
				blog.post(title, content)
			rescue => e
				puts exc
				i+=1
				if i < 5
					retry 
				else
					puts "5‰ñˆÈã¸”s‚µ‚½‚æB‰½‚©‚¨‚©‚µ‚¢B\nurl -> #{url}"
					p $@
					p e.backtrace
				end
			end
		end
	end
end




