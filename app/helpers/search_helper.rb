module SearchHelper
  
  
  def menu_link(keyword,name)
     keyword.nil? ? "#"+name : "?keyword=" + keyword + "&type="+name
  end
end
