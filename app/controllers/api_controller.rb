class ApiController < ApplicationController
	def forum
		boardNum = params[:BoardNum]
		topicNum = params[:TopicNum]
		boardAry =  { "1" => "TopicF" , "2" =>"TopicB" , "3" =>"TopicT" , "6" =>"TopicI" }
		client = TinyTds::Client.new( :dataserver => 'fg_db' ,  :username => 'fgsearch', :password => 'd2e5s6a3e',  :database => 'Forum')
		sql =  'select num,Topic,Amount,OpenUser,Date from '+ boardAry[boardNum].to_s  + ' where num = '+ topicNum 
		result = client.execute( sql  )
		# result = { 'topicNum' => topicNum , 'boardNum' => boardNum }
		result.each do |row|
			render :json =>  row
		end
		client.close
	end
	def forum_more
		results = []
		nums = params[:topicNums].split('|')
		boardAry =  { "1" => "TopicF" , "2" =>"TopicB" , "3" =>"TopicT" , "6" =>"TopicI" }
		client = TinyTds::Client.new( :dataserver => 'fg_db' ,  :username => 'fgsearch', :password => 'd2e5s6a3e',  :database => 'Forum')
		nums.each do |num|
		  tmp = num.split(',')
		  boardNum = tmp.at(0)
		  topicNum = tmp.at(1)
  		sql =  'select num,Topic,Amount,OpenUser,Date from '+ boardAry[boardNum].to_s  + 'visible != 0 AND where num = '+ topicNum 
  		res = client.execute( sql  )
		  begin
           result = res.each[0]
      rescue
           result = nil
           client = TinyTds::Client.new( :dataserver => 'fg_db' ,  :username => 'fgsearch', :password => 'd2e5s6a3e',  :database => 'Forum')
      end
      results << result if !result.nil?
		end
		render :json => results
		client.close
	end
	
	
	def product
		topicNum = params[:topicNum].to_s
    #連結 beauty 資料庫  
		client = TinyTds::Client.new( :dataserver => 'fg_db' ,  :username => 'fgsearch', :password => 'd2e5s6a3e',  :database => 'Beauty')
		
		#取得商品資訊
		proSql = 'select  P.Name,P.ImgAmount ,P.ImgRnd ,P.Num,P.Price,P.Volume,B.Name as BrabdName  
		    from TopicPro TP INNER JOIN Pro P ON TP.ProNum = P.Num INNER JOIN TypeBrand B ON P.BrandNum = B.Num   where TP.TopicNum = ' + topicNum
		result2 = client.execute(proSql).each[0]
		proNum = result2['Num'].to_i
		proName = result2['Name']
		brandName = result2['BrabdName']
		imgRnd = result2['ImgRnd']
		imgAmount = result2['ImgAmount']
		price = result2['Price']
		volume = result2['Volume']
		membercounter = result2['MemberCounter']

		#取得 商品評鑑 資訊
		topicSql = 'select * from  Topic  where Num =' + topicNum
		res = result3  = client.execute( topicSql ).each[0]
    res.store("proNum" , proNum )
    res.store("proName" , proName )
    res.store("brandName" , brandName )
    res.store("imgRnd" , imgRnd )
    res.store("imgAmount" , imgAmount )
    res.store("price" , price )
    res.store("volume" , volume )
    res.store("membercounter" , membercounter )

		render :json => res
		client.close
	end
	def product_more
	  results = []
		topicNums = params[:topicNums].split(',')
    #連結 beauty 資料庫  
		client = TinyTds::Client.new( :dataserver => 'fg_db' ,  :username => 'fgsearch', :password => 'd2e5s6a3e',  :database => 'Beauty')
		topicNums.each do |topicNum|
    		#取得商品資訊
    		proSql = 'select  P.Name,P.ImgAmount ,P.ImgRnd ,P.Num,P.Price,P.Volume,B.Name as BrabdName  
    		    from TopicPro TP INNER JOIN Pro P ON TP.ProNum = P.Num INNER JOIN TypeBrand B ON P.BrandNum = B.Num   where TP.TopicNum = ' + topicNum
    		begin
      		  result2 = client.execute(proSql).each[0]  
        rescue
            result2 = nil
        end
    		if !result2.nil?
        		proNum = result2['Num'].to_i
        		proName = result2['Name']
        		brandName = result2['BrabdName']
        		imgRnd = result2['ImgRnd']
        		imgAmount = result2['ImgAmount']
        		price = result2['Price']
        		volume = result2['Volume']
        		membercounter = result2['MemberCounter']
    		  
        		#取得 商品評鑑 資訊
        		topicSql = 'select * from  Topic  where checkexist != 0 AND  Num =' + topicNum
        		begin
            		res = result3  = client.execute( topicSql ).each[0]
            rescue
                res = nil
                client = TinyTds::Client.new( :dataserver => 'fg_db' ,  :username => 'fgsearch', :password => 'd2e5s6a3e',  :database => 'Beauty')
            end
        		if !res.nil?
                res.store("proNum" , proNum )
                res.store("proName" , proName )
                res.store("brandName" , brandName )
                res.store("imgRnd" , imgRnd )
                res.store("imgAmount" , imgAmount )
                res.store("price" , price )
                res.store("volume" , volume )
                res.store("membercounter" , membercounter )
        		end
    		end
        results << res if !res.nil?
    end
		render :json => results
		client.close
	end
	
	def blog
	  #http://60.199.195.135:81/api/blog?topicNum=27310
	  #http://60.199.230.187/api/blog?topicNum=27310
	  topicNum = params[:topicNum].to_s
	  client = TinyTds::Client.new( :dataserver => 'fg_db_blog' ,  :username => 'fgsearch', :password => 'd2e5s6a3e',  :database => 'blog')
	  sql =  'select T.Num,T.Topic,T.ImgRnd,T.ClickAmount,T.Amount,T.Date ,T.LastUpDate,T.TypeNum,P.PerID as PerName  from  Topic T INNER JOIN Per P  ON P.Num = T.PerNum   where  T.Num =' + topicNum
	  res = client.execute( sql  )
	  #例外
	  begin
	     result = res.each[0]
	  rescue
	     result = nil
	  end
	  if !result.nil?
      typeSql = "select Name from Type where Num = " + result['TypeNum'].to_i.to_s
      typeName = client.execute( typeSql ).each[0]['Name']
      result.store("typeName" , typeName )
    end
      render :json => result
      client.close
	end
	def blog_more
	  #http://60.199.195.135:81/api/blog_more?topicNums=27310
	  results = []
	  topicNums = params[:topicNums].split(',')
	  client = TinyTds::Client.new( :dataserver => 'fg_db_blog' ,  :username => 'fgsearch', :password => 'd2e5s6a3e',  :database => 'blog')
	  topicNums.each do |topicNum|
    	  sql =  "select T.Num,T.Topic,T.ImgRnd,T.ClickAmount,T.Amount,T.Date ,T.LastUpDate,T.TypeNum,P.PerID as PerName  from  Topic T INNER JOIN Per P  ON P.Num = T.PerNum   where T.Visible != false  T.Num =" + topicNum
    	  res = client.execute(sql)
    	  #例外
    	  begin
    	     result = res.each[0]
    	  rescue
    	     result = nil
    	     client = TinyTds::Client.new( :dataserver => 'fg_db_blog' ,  :username => 'fgsearch', :password => 'd2e5s6a3e',  :database => 'blog')
    	  end
    	  if !result.nil?
          typeSql = "select Name from Type where Num = " + result['TypeNum'].to_i.to_s
          typeName = client.execute( typeSql ).each[0]['Name']
          result.store("typeName" , typeName )
        end
        results << result if !result.nil?
	  end
        render :json => results
        client.close
	end
	
	def video
	  #http://60.199.230.187/api/video?topicNum=1278
	  result = FgVideo.select('Num,Topic,Content,OnlineDate,ImgRnd,ClickAmount,Amount').find(params[:topicNum])
	  render :json => result
	end
	def video_more
	  #http://60.199.230.187/api/video_more?topicNums=1278
	    # results = []
      # topicNums = params[:topicNums].split(',')
      # topicNums.each do |topicNum|
          # begin
             # result = FgVideo.select('Num,Topic,Content,OnlineDate,ImgRnd,ClickAmount,Amount').where(["Visible != 'Del'"]).find(topicNum)
          # rescue
             # result = nil
          # end 
          # results << result if !result.nil?
      # end
      results = FgVideo.select('Num,Topic,Content,OnlineDate,ImgRnd,ClickAmount,Amount').where(["Visible != 'Del'"]).where(:id=>params[:topicNums].split(',').map{|i|i} )
      render :json => results
	end
	
	def beautynews
	  #http://60.199.230.187/api/beautynews?topicNum=1278
	  result = FgBeautynews.select('ft_mi_fg_id,ft_mi_fg_nickname,ft_pvcount,ft_ftc_rid,ft_title,ft_intime,ft_pic1,ft_pic1_path').find(params[:topicNum])
	  render :json => result
	end
	
	def beautynews_more
  	  # results = []
      # topicNums = params[:topicNums].split(',')
      # topicNums.each do |topicNum|
          # begin
          	 # result = FgBeautynews.select('ft_rid,ft_mi_fg_id,ft_mi_fg_nickname,ft_pvcount,ft_ftc_rid,ft_title,ft_intime,ft_pic1,ft_pic1_path').where(["ft_visible != 'n' "]).find(topicNum)
          # rescue
             # result = nil
          # end 
          # results << result if !result.nil?
      # end
  	  results = FgBeautynews.select('ft_rid,ft_mi_fg_id,ft_mi_fg_nickname,ft_pvcount,ft_ftc_rid,ft_title,ft_intime,ft_pic1,ft_pic1_path').where(["ft_visible != 'n' "]).where(:id => params[:topicNums].split(',').map{|i|i} )
	    render :json => results
	end
	
end
