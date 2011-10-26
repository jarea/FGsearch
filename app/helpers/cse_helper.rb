module CseHelper
	def menu_on(page)
		if page ==( request.url.split('/').at(6)  ||   request.url.split('/').at(4).split('?').at(0))
		    res = "on"
		end
	end
	
	def dismainnav_on(board)
	   if board == params[:board].to_i
	     res = " on "
	   end
	end
	def dismainnav_url(board)
	   res = "?q="+@keyword+"&board="+board.to_s
	end
	
	def sort_menu_on(type)
	  
	  if type == params[:sort].to_i
	    res = "checked"
	  end
	end
  def mark_keyword(str , keyword)
    #TODO 要做的事
    str = str.gsub(keyword , "<b>"+keyword.to_s+"</b>" )
  end
	
end


               