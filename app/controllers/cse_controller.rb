class CseController < ApplicationController
	
	 before_filter :keyword , :except => [ :forum, :product, :blog, :video, :beautynews ]		
	 before_filter :page , :except => [ :forum, :product, :blog, :video, :beautynews ]		
	 before_filter :sort , :except => [ :forum, :product, :blog, :video, :beautynews ]		
	 
	 

	
	
  def index
    redirect_to :action => :forum
  end

  def forum
    
     @fsks = fsks = ForumSearchKeyword.find_by_keyword(keyword)
     @html
     if !keyword.nil? && !keyword.empty?
       if fsks.nil? 
         @results = google_cse(keyword , 'http://www.fashionguide.com.tw/MsgL/07/' , page ) 
         @results ? @total = @results.total : @total = 0
         @total = "500+"  if @total > 500
         if  @results 
            fsk = ForumSearchKeyword.create(:keyword => keyword   )   
            forum_getdata(keyword , page )
            if @results.total.to_i > 20
                @page = @results.total.to_i
                 t1 = Thread.new{forum_getdata(keyword , 2)}
                 t2 = Thread.new{forum_getdata(keyword , 3)}
                 t1.join
                 t2.join
            end 
         end  
         @html = fsk.forum.where("openuser != '' ").order("datetime DESC").page(params[:page])  
         @fsks = ForumSearchKeyword.find_by_keyword(keyword)  
       else
         
         forum_getdata(keyword , page.to_i+1)
         where = {0 => "" , 1 => "board_num = 1" , 2 => "board_num = 2", 3 => "board_num = 3" , 6 => "board_num = 6"}
         @html = fsks.forum.where("openuser != '' ").where(where[params[:board].to_i]).order("datetime DESC").page(params[:page])

       end
         @related_eywords = google_complete(keyword , '/cse/forum/?q=')
     else
       @html= @fsks = nil
     end
    
   			
  end

  def product 
      
           @psks = ProductSearchKeyword.find_by_keyword(keyword)
           @html = ""
           @related_eywords = google_complete(keyword , '/cse/product/?q=')
           if !keyword.nil?  && !keyword.empty?
               if @psks.nil?
                    
                     results = google_cse(keyword,  'http://www.fashionguide.com.tw/BMsgL/08/' , page)      
                     if results
                         ProductSearchKeyword.create(:keyword => keyword , :total => results.total )
                          product_getdata(keyword , page)
                          product_getdata(keyword , 2)             
                     
                         @psks = ProductSearchKeyword.find_by_keyword(keyword)
                         @html = @psks.product.where('item_type !=2').page(params[:page])
                     end
               else
                   sort_type = {1 => "id ASC" , 2 => "date DESC" , 3 => "amount DESC"}
                   if  @psks.product.count  <= page.to_i * 10 
                      product_getdata(keyword , page.to_i + 1)
                   end 
                   #item_type !=2  不顯示投票比較型
                   @html = @psks.product.where('item_type !=2').order( sort_type[sort.to_i] ).page(params[:page])
               end
           end
           if @psks
              @psks.total > 500 ? @total = '500+' : @total = @psks.total
           end
     
  end


  def blog
     
     @bsks = BlogSearchKeyword.find_by_keyword(keyword)
     @html = ""
     @related_eywords = google_complete(keyword , '/cse/blog/?q=')
     if !keyword.nil?  && !keyword.empty?
         if @bsks.nil?
               results = google_cse(keyword, 'http://blog.fashionguide.com.tw/BlogD.asp' , page)      
               if results
                   BlogSearchKeyword.create(:keyword => keyword , :total => results.total )
                   blog_getdata(keyword , page)
                    t1 = Thread.new{blog_getdata(keyword , 2)}
                    t2 = Thread.new{blog_getdata(keyword , 3)}
                    t1.join
                    t2.join
                  
                   @html = BlogSearchKeyword.find_by_keyword(keyword).blog.page(params[:page])
                   @bsks = BlogSearchKeyword.find_by_keyword(keyword)
               end
         else
             sort_type = {1 => "id ASC" , 2 => "date DESC" , 3 => "click_amount DESC"}
             if  @bsks.blog.count  <= page.to_i * 20 
                blog_getdata(keyword , page.to_i + 1)
             end   
             @html = @bsks.blog.order( sort_type[sort.to_i] ).page(params[:page])
         end
     end
     if @bsks
        @bsks.total > 500 ? @total = '500+' : @total = @bsks.total
     end
    
  end

  def video
  	 @vsks = VideoSearchKeyword.find_by_keyword(keyword)
  	 @html = ""
  	 @total = 0
  	 @related_eywords = google_complete(keyword , '/cse/video/?q=')
  	 if !keyword.nil?  && !keyword.empty?
  	     if @vsks.nil?
  	           results = google_cse(keyword, 'http://video.fashionguide.com.tw/VideoD.php' , page)      
  	           if results
    	             VideoSearchKeyword.create(:keyword => keyword , :total => results.total )
    	             video_getdata(keyword , page)
    	              t1 = Thread.new{video_getdata(keyword , 2)}
                    t1.join
               
                  
    	             @html = VideoSearchKeyword.find_by_keyword(keyword).video.page(params[:page])
    	             @vsks = VideoSearchKeyword.find_by_keyword(keyword)
  	           end
  	     else
             sort_type = {1 => "id ASC" , 2 => "date DESC" , 3 => "click_amount DESC"}
             if  @vsks.video.count  <= page.to_i * 20 
                video_getdata(keyword , page)
             end   
             @html = @vsks.video.order( sort_type[sort.to_i] ).page(params[:page])
  	     end
  	 end
  	 if @vsks
  	   @vsks.total > 500 ? @total =  '500+' : @total =  @vsks.total
  	 end
  end

  def beautynews
     bsks = BeautynewsSearchKeyword.find_by_keyword(keyword)
     @related_eywords = google_complete(keyword , '/cse/beautynews/?q=')
     if !keyword.nil? && !keyword.empty?
         if bsks.nil?     
             @results = google_cse(keyword , 'http://beautynews.fashionguide.com.tw/member/forum_topic.php' , page)  
             @results ?  @total = @results.total :  @total = 0
             @total = "500+"  if @total > 500
             if @results
                  bsk = BeautynewsSearchKeyword.create(:keyword => keyword  , :total => @results.total )         
                  t1 = Thread.new{beautynews_getdata(keyword , page)}
                  t2 = Thread.new{beautynews_getdata(keyword , 2)}
                  t1.join
                  t2.join
                  @html = BeautynewsSearchKeyword.find_by_keyword(keyword).beautynews.page(params[:page])
             end
         else
            bsks.total > 500 ? @total = "500+" :  @total =  bsks.total
             sort_type = {1 => "id ASC" , 2 => "datetime DESC" , 3 => "pvcount DESC"}
             if  bsks.beautynews.count  <= page.to_i * 20 
                 beautynews_getdata(keyword , page.to_i + 1)
             end 
             @html = bsks.beautynews.order( sort_type[sort.to_i] ).page(params[:page])
         end
      else
        @html = ""
      end
   #end beautynews    
  end
  
  
 
  

   

  protected
  
  def keyword
  	@keyword = keyword = ''
  	if  params[:q]
  		keyword = CGI.escape(params[:q])
  		@keyword =  params[:q]
  	end
  end
  def page
  	@page = page = 0
  	if  params[:page]
  		@page = page = params[:page]
  	end
  	@next_page = next_page  = page.to_i + 1 
  end
  
  def sort
    @sort = sort = 1
    if params[:sort]
      @sort= sort = params[:sort]
    end
    
  end
 
  # 2010-12-02T13:20:24+08:00   to  2010-12-02 13:20:24  
  def time_format(time_data , type = nil)
    tmp = time_data.to_s.split('T')
    tmp2 = tmp.at(1).split('+')
    
    
    if type == "to_sql"
      date = DateTime.strptime(date , "%Y-%m-%d %H:%M:%S").to_time
    else 
      date = tmp.at(0).to_s+' '+ tmp2.at(0).to_s
    end
    
  end
    
  
  def google_cse(keyword , inurl , page , length = 20  )
  	require 'open-uri'
  	results = []
  	page = page.to_i - 1 
  	(page * 20 ) == 0 ? start = 0 : start = (page * 20)+1 
  	
  	if keyword 
    	# results = GoogleCustomSearch.search( keyword+"intitle:"+keyword + "+inurl:" + inurl , start )
    	results = GoogleCustomSearch.search( keyword + "+site:" + inurl , start , length)
    end
  end
  
  def google_complete(keyword , url)
      if !keyword.nil?
        require 'nokogiri'
        require 'open-uri'
        resulte = []
        Nokogiri::XML(open('http://google.com/complete/search?output=toolbar&q='+CGI.escape(keyword))).xpath('//suggestion').each_with_index do |res , index|
            # if index != 0 && index <= 3
            gckeyword = res.attributes['data'].value
            if keyword != gckeyword && index <= 3
                resulte << '<a href="'+url+gckeyword+'">'+gckeyword+'</a>'
            end
        end
        resulte.join('、')
       end
  end
  
  
  def get_associate_keyword keyword
      res = []
      res << keyword
      
      keyword_obj = FgKeyword.find_by_keyword(keyword)
      
      if !keyword_obj.nil?      

        keyword_obj.fka.each_with_index do |r,index|
          if index <= 1
            res << r.keyword
          end
        end
        
      end 
      res.join(' OR ')
  end

  
  private

   def beautynews_getdata(keyword , page)
         bsk = BeautynewsSearchKeyword.find_by_keyword(keyword)
         @results = google_cse(keyword , 'http://beautynews.fashionguide.com.tw/member/forum_topic.php' , page)  
         if @results
                topicNums = []
                bk_objects = {}
                cat_name_array = { 0 => "綜合" , 2 => "創意市集" , 3=> "旅遊生活", 4 => "休閒玩樂" , 5 => "美髮造型" , 6 => "美體瘦身", 7 => "時尚潮流" , 8 => "美容保養" ,9 => "流行彩妝" , 10 =>"明星部落",11=>"醫學美容",}
              @results.pages.each do |result|
                topicNum = result.url.to_s.split('?ft=').at(1)
                    if topicNum.empty? !=  true
                        bk = bsk.beautynews_keywords.create(:beautynews_num => topicNum )
                        bk_objects[topicNum] = {:bk_id => bk.id , :cse_url=> result.url.to_s ,:cse_title => result.title.to_s,:cse_description => result.description.to_s}
                        topicNums << topicNum
                    end
              end
                    url = 'http://60.199.230.187/api/beautynews_more?topicNums='+topicNums.join(',')
                    res_json  = ActiveSupport::JSON.decode( open(url) )
                    res_json = JSON.parse( res_json.to_json ,:symbolize_names => true)
                    res_json.each do |res|
                        if !res[:ft_pic1_path].empty?
                            ft_pic1_path = res[:ft_pic1_path].split('/vhost/').at(1)
                            ft_pic1_path = ft_pic1_path.split('webroot/').at(0)+ft_pic1_path.split('webroot/').at(1)
                            img_url = "http://" + ft_pic1_path +"s_"+res[:ft_pic1]
                        else 
                            img_url = "http://i.fgi.tw/Beauty/Img/noitem.gif"
                        end
                         res.store(:img_url , img_url  )
                         res[:ft_intime] = time_format(res[:ft_intime])
                         res[:cat_name] = cat_name_array[res[:ft_ftc_rid]]
                         
                         topicNum = res[:ft_rid].to_s
                          Beautynews.create(
                            :bk_id => bk_objects[topicNum][:bk_id] ,:num => topicNum , :topic => res[:ft_title] ,
                            :topic_content => '' ,:author => res[:ft_mi_fg_nickname] ,
                            :datetime => res[:ft_intime] , :img_url => img_url ,
                            :pvcount => res[:ft_pvcount] , :cat_id => res[:ft_ftc_rid] ,
                            :cat_name => res[:cat_name] ,:cse_title => bk_objects[topicNum][:cse_title],
                            :cse_url => bk_objects[topicNum][:cse_url] , :cse_description => bk_objects[topicNum][:cse_description])
                    end 
         end
  end
  
  def forum_getdata(keyword , page)
        fsk = ForumSearchKeyword.find_by_keyword(keyword)
        results = google_cse(keyword , 'http://www.fashionguide.com.tw/MsgL/07/' , page ) 
        if  results 
            topicNums = []
            objects = {}
            results.pages.each do |result|
                param = result.url.to_s.split('/07/').at(1)
                params = param.split('_')
                boardNum = params.at(0)
                topicNum = params.at(2)
                if topicNum.empty? !=  true && boardNum.empty? != true
                    topicNums << boardNum+","+topicNum
                    fk = fsk.forum_keyword.create(:topic_num => topicNum)
                    objects[topicNum] = {:fk_id => fk.id ,:boardNum => boardNum, :cse_url =>result.url.to_s , :cse_title =>result.title.to_s , :cse_description => result.description.to_s   }
                end
            end   
                url = 'http://60.199.230.187/api/forum_more?topicNums='+CGI.escape(topicNums.join('|')) 
             
                res_json  = ActiveSupport::JSON.decode( open(url) )
                res_json = JSON.parse( res_json.to_json ,:symbolize_names => true)
                res_json.each do |res|
                    topicNum = res[:num].to_i.to_s
                    date = time_format(res[:Date])
                    if !res[:OpenUser].to_s.empty?
                        Forum.create(:fk_id=>objects[topicNum][:fk_id], :topic_num => topicNum, :board_num => objects[topicNum][:boardNum],
                         :topic => res[:Topic].to_s, :openuser => res[:OpenUser].to_s ,
                         :amount => res[:Amount].to_s, :datetime => date ,
                         :cse_url => objects[topicNum][:cse_url], :cse_title => objects[topicNum][:cse_title] ,  :cse_description => objects[topicNum][:cse_description] )
                    end
                end    
             
           forum_board_count(keyword)
        end
  end
  
  def forum_board_count(keyword)
      fsk = ForumSearchKeyword.find_by_keyword(keyword)
      fsk.update_attribute(:total , fsk.forum.count)
      fsk.update_attribute(:beauty_total , fsk.forum.where(:board_num => 1).count )
      fsk.update_attribute(:fashion_total , fsk.forum.where(:board_num => 2).count )
      fsk.update_attribute(:freetalk_total , fsk.forum.where(:board_num => 3).count )
      fsk.update_attribute(:fit_total , fsk.forum.where(:board_num => 6).count )
  end
  
  def video_getdata(keyword , page)
        vsk = VideoSearchKeyword.find_by_keyword(keyword)
        results = google_cse(keyword, 'http://video.fashionguide.com.tw/VideoD.php' , page)  
        if results
              topicNums = []
              objects = {}
              results.pages.each do |result|  
                  param = result.url.to_s.split('?Num=').at(1)
                  topicNum = param.to_s.split('&').at(0)
                  if topicNum.empty? !=  true
                      topicNums << topicNum
                      vk = vsk.video_keyword.create(:video_num => topicNum)
                      objects[topicNum] = {:vk_id => vk.id , :cse_url =>result.url.to_s , :cse_title =>result.title.to_s , :cse_description => result.description.to_s   } 
                  end    
              end    
              url = 'http://60.199.230.187/api/video_more?topicNums='+topicNums.join(',')
              res_json  = ActiveSupport::JSON.decode( open(url) )
              res_json = JSON.parse( res_json.to_json ,:symbolize_names => true)
              res_json.each do |res|
                  img_url = "http://v.fgi.tw/p/MN" + res[:Num].to_s + "_v" + res[:ImgRnd].to_s + "_j68.jpg"
                  topicNum = res[:Num].to_s
                  Video.create(:vk_id => objects[topicNum][:vk_id] ,:num => topicNum , :img_url => img_url , :topic =>res[:Topic] ,
                   :topic_content =>res[:Content] ,:click_amount =>res[:ClickAmount],:amount=>res[:Amount],
                   :date => res[:OnlineDate] ,
                   :cse_url => objects[topicNum][:cse_url], :cse_title => objects[topicNum][:cse_title] ,
                   :cse_description =>objects[topicNum][:cse_description] )
              end
         end 
  end
  
  def blog_getdata(keyword , page)
        bsk = BlogSearchKeyword.find_by_keyword(keyword)
        results = google_cse(keyword , 'http://blog.fashionguide.com.tw/BlogD.asp' , page) 
        if results
              topicNums = []
              objects = {}
              results.pages.each do |result|  
                   param = result.url.to_s.split('?Num=').at(1)
                   topicNum = param.to_s.split('&').at(0)
                   if topicNum.nil?
                        topicNum = result.url.to_s.split('&Num=').at(1)
                   end
                   if !topicNum.nil? && topicNum.empty? !=  true
                      bk = bsk.blog_keyword.create(:blog_num => topicNum)
                      topicNums << topicNum
                      objects[topicNum] = {:bk_id => bk.id , :cse_url =>result.url.to_s , :cse_title =>result.title.to_s , :cse_description => result.description.to_s   }                 
                   end
              end
                url = 'http://60.199.230.187/api/blog_more?topicNums='+topicNums.join(',')
                res_json  = ActiveSupport::JSON.decode( open(url) )
                res_json = JSON.parse( res_json.to_json ,:symbolize_names => true)
                res_json.each do |res|
                    date = time_format(res[:Date])
                    topicNum = res[:Num].to_i.to_s
                    if !res[:ImgRnd].empty?
                        img_url = "http://cb.fashionguide.com.tw/Blogfiles/TopicImg450/"+res[:ImgRnd].to_s
                    else 
                        img_url = "http://i.fgi.tw/Beauty/Img/noitem.gif"
                    end   
                    if objects[topicNum]
                      Blog.create(:bk_id => objects[topicNum][:bk_id] , :num=>topicNum,:topic=>res[:Topic],:img_url=>img_url,:date=>date,:type_name=>res[:typeName],:click_amount=>res[:ClickAmount],:amount=>[:Amount],:per_name=>res[:PerName] , 
                          :cse_url => objects[topicNum][:cse_url], :cse_title => objects[topicNum][:cse_title] ,  :cse_description => objects[topicNum][:cse_description] )
                    end       
                end  
         end 
  end
  
  def product_getdata(keyword , page)
        psk = ProductSearchKeyword.find_by_keyword(keyword)
        results = google_cse(get_associate_keyword(keyword) , 'http://www.fashionguide.com.tw/BMsgL/08/' , page  ) 
        if results
              topicNums = []
              objects = {}
              results.pages.each do |result|  
                   param = result.url.to_s.split('/08/TopicL_').at(1)
                   if !param.nil?
                      topicNum =  param.to_s.split('_').at(0)
                   else 
                      param = result.url.to_s.split('/08/CateL_').at(1)
                      topicNum = param.to_s.split('_').at(0)
                   end
                   if topicNum.nil?
                      param = result.url.to_s.split('/08/NiceL_').at(1)
                      topicNum = param.to_s.split('_').at(0)
                   end
                   if topicNum.nil?
                      param = result.url.to_s.split('/08/CateSubL_').at(1)
                      topicNum = param.to_s.split('_').at(0)
                   end 
                   
                      url = 'http://60.199.230.187/api/product?topicNum='+topicNum

                    if (topicNum.empty? !=  true) 
                        pk = psk.product_keyword.create(:product_num => topicNum)
                        topicNums << topicNum 
                        objects[topicNum] = {:pk_id => pk.id , :cse_url =>result.url.to_s , :cse_title =>result.title.to_s , :cse_description => result.description.to_s   }
                    end
               end     
                        url = "http://60.199.230.187/api/product_more?topicNums="+topicNums.join(',')
                        res_json  = ActiveSupport::JSON.decode(open(url) )
                        res_json = JSON.parse( res_json.to_json ,:symbolize_names => true)
                        res_json.each do |res|
                             topicNum = res[:Num].to_i.to_s
                             # res.store(:url , result.url.to_s)
                             # res.store(:description , result.description.to_s   )
                             # res.store(:topicNum , topicNum  )
                             if res[:imgAmount] == 1
                                img_url =  "http://i.fgi.tw/Beauty/ImgPro/#{res[:imgRnd]}/#{res[:proNum].to_i}s.jpg"  
                             else
                                img_url =  "http://i.fgi.tw/Beauty/Img/noitem.gif"
                             end  
                             date= time_format(res[:Date])
                             item_total_sum = res[:Item1Grade]+res[:Item2Grade]+res[:Item3Grade]+res[:Item4Grade]+res[:Item5Grade]+
                                              res[:Item6Grade]+res[:Item7Grade]+res[:Item8Grade]+res[:Item9Grade]+res[:Item10Grade]
                             
                             if res[:Version] == 0
                                item_total_sum = res[:Item1Grade]+res[:Item2Grade]+res[:Item3Grade]+res[:Item4Grade]+res[:Item5Grade]
                                item_grade_1_sum = (res[:Item5Grade].to_f / item_total_sum) * 100
                                item_grade_2_sum = (res[:Item4Grade].to_f / item_total_sum) * 100
                                item_grade_3_sum = (res[:Item3Grade].to_f / item_total_sum) * 100
                                item_grade_4_sum = (res[:Item2Grade].to_f / item_total_sum) * 100
                                item_grade_5_sum = (res[:Item1Grade].to_f / item_total_sum) * 100
      
                             else
                                 item_total_sum = res[:Item1Grade]+res[:Item2Grade]+res[:Item3Grade]+res[:Item4Grade]+res[:Item5Grade]+
                                 res[:Item6Grade]+res[:Item7Grade]+res[:Item8Grade]+res[:Item9Grade]+res[:Item10Grade]
                                 item_grade_1_sum = ((res[:Item1Grade].to_f+res[:Item2Grade].to_f)/item_total_sum)*100
                                 item_grade_2_sum = ((res[:Item3Grade].to_f+res[:Item4Grade].to_f)/item_total_sum)*100
                                 item_grade_3_sum = ((res[:Item5Grade].to_f+res[:Item6Grade].to_f)/item_total_sum)*100
                                 item_grade_4_sum = ((res[:Item7Grade].to_f+res[:Item8Grade].to_f)/item_total_sum)*100
                                 item_grade_5_sum = ((res[:Item9Grade].to_f+res[:Item10Grade].to_f)/item_total_sum)*100
                             end
                             #解決 FloatDomainError 有些會沒有分數
                             if  item_total_sum == 0 
                               item_grade_1_sum = 0
                               item_grade_2_sum = 0
                               item_grade_3_sum = 0
                               item_grade_4_sum = 0
                               item_grade_5_sum = 0
                             end 
                             
                              
                             Product.create(:pk_id => objects[topicNum][:pk_id] ,  :num => topicNum,  :topic=>res[:Topic], :product_name=>res[:proName],:product_num=>res[:proNum], :img_url=>img_url,  :date=>date,
                              :amount=>res[:Amount],
                              :price=>res[:price],
                              :volume=>res[:volume],
                              :cse_url=>objects[topicNum][:cse_url],
                              :cse_title=>objects[topicNum][:cse_title],
                              :cse_description=>objects[topicNum][:cse_description],
                              :item_type=>res[:Type],
                              :version=>res[:Version],
                              :item1grade=>res[:Item1Grade],
                              :item2grade=>res[:Item2Grade],
                              :item3grade=>res[:Item3Grade],
                              :item4grade=>res[:Item4Grade],
                              :item5grade=>res[:Item5Grade],
                              :item6grade=>res[:Item6Grade],
                              :item7grade=>res[:Item7Grade],
                              :item8grade=>res[:Item8Grade],
                              :item9grade=>res[:Item9Grade],
                              :item10grade=>res[:Item10Grade],
                              :item_total_sum=> item_total_sum ,
                              :item_grade_1_sum=>item_grade_1_sum.round,
                              :item_grade_2_sum=>item_grade_2_sum.round,
                              :item_grade_3_sum=>item_grade_3_sum.round,
                              :item_grade_4_sum=>item_grade_4_sum.round,
                              :item_grade_5_sum=>item_grade_5_sum.round
                             )
                        end
         end 
  end

 
end
