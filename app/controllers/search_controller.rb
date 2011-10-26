class SearchController < ApplicationController

  def index
        require 'open-uri'
        require 'iconv'
        
        # if params.has_value? (:type) and params[:type]
          # inurl = url_ary[params[:type].inturn]
        # else
          # inurl = ''
        # end
  
        if  params[:keyword]
          keyword = CGI.escape(params[:keyword])
          @keyword =  params[:keyword]
          @type = type =  params[:type]
        else 
          keyword = ''  
          type = ''
        end
        
        if params[:start]
        	start = params[:start]
        else
        	start = '0'
        end
        url_ary = {
                  'forum' => 'http://www.fashionguide.com.tw/forum/07/MsgL.asp?BoardNum=', 
                  'product'=>'http://www.fashionguide.com.tw/BMsgL/08/',
                  'blog'=>'http://blog.fashionguide.com.tw/',
                  'beautynews'=>'http://beautynews.fashionguide.com.tw/',
                  'video'=>'http://video.fashionguide.com.tw/'}
        
        if url_ary[type] 
          inurl = '+inurl:'+ url_ary[type] 
        else
          inurl = ''
        end
        
        #搜尋時間  y：一年 y2兩年  m：一個月      相關設定 參照 http://www.google.com/support/forum/p/customsearch/thread?tid=5a91da4720bfbe5b&hl=en
        y = '&as_qdr=y'
        
        
        url = 'http://www.google.com/cse?cx=008214668176899870401%3Aqwwvtl8vcqg&client=google-csbe&output=xml_no_dtd&num=20&q=' + keyword + inurl + '&start=' + start + y
        @xml = xml  = open(url)
        
        # http://www.google.com/cse?cx=008214668176899870401%3Aqwwvtl8vcqg&client=google-csbe&output=xml_no_dtd&num=20&q=diro+inurl:http://www.fashionguide.com.tw/forum/07/MsgL.asp?BoardNum=  
        #xml = '<?xml version="1.0" encoding="UTF-8" standalone="yes"?> <gsp ver="3.2"> <tm>0.464463</tm><q>美白</q> <param js_escaped_value="008214668176899870401:qwwvtl8vcqg" name="cx" url_escaped_value="008214668176899870401%3Aqwwvtl8vcqg" original_value="008214668176899870401%3Aqwwvtl8vcqg" value="008214668176899870401:qwwvtl8vcqg" /> <param js_escaped_value="google-csbe" name="client" url_escaped_value="google-csbe" original_value="google-csbe" value="google-csbe" /> <param js_escaped_value="xml_no_dtd" name="output" url_escaped_value="xml_no_dtd" original_value="xml_no_dtd" value="xml_no_dtd" /> <param js_escaped_value="美白" name="q" url_escaped_value="%E7%BE%8E%E7%99%BD" original_value="%E7%BE%8E%E7%99%BD" value="美白" /> <param js_escaped_value="AELymgXmLebT6WtzpkX-v22PTf5jbO9jsZhrPpekJKAqpuC9CbrGIzSc1GyreE5z-U-Ea7ZFM12qL4H62MkKXkPSBcWgPV-Lp898lM17QGOsAQCxicB06lQ" name="adkw" url_escaped_value="AELymgXmLebT6WtzpkX-v22PTf5jbO9jsZhrPpekJKAqpuC9CbrGIzSc1GyreE5z-U-Ea7ZFM12qL4H62MkKXkPSBcWgPV-Lp898lM17QGOsAQCxicB06lQ" original_value="AELymgXmLebT6WtzpkX-v22PTf5jbO9jsZhrPpekJKAqpuC9CbrGIzSc1GyreE5z-U-Ea7ZFM12qL4H62MkKXkPSBcWgPV-Lp898lM17QGOsAQCxicB06lQ" value="AELymgXmLebT6WtzpkX-v22PTf5jbO9jsZhrPpekJKAqpuC9CbrGIzSc1GyreE5z-U-Ea7ZFM12qL4H62MkKXkPSBcWgPV-Lp898lM17QGOsAQCxicB06lQ" /> <param js_escaped_value="zh-TW" name="hl" url_escaped_value="zh-TW" original_value="zh-TW" value="zh-TW" /> <param js_escaped_value="UTF-8" name="oe" url_escaped_value="UTF-8" original_value="UTF-8" value="UTF-8" /> <param js_escaped_value="UTF-8" name="ie" url_escaped_value="UTF-8" original_value="UTF-8" value="UTF-8" /> <param js_escaped_value="0" name="boostcse" url_escaped_value="0" original_value="0" value="0" /> <context><title>FG</title><facet><facetitem><label>美顏情報站</label><anchor_text>美顏情報站</anchor_text></facetitem></facet><facet><facetitem><label>討論區</label><anchor_text>討論區</anchor_text></facetitem><facetitem><label>部落格</label><anchor_text>部落格</anchor_text></facetitem></facet><facet><facetitem><label>影音</label><anchor_text>影音</anchor_text></facetitem></facet><facet><facetitem><label>商品評鑑</label><anchor_text>商品評鑑</anchor_text></facetitem></facet></context><ares></ares><res sn="1" en="10"> <m>49000</m> <nb><nu>/custom?q=%E7%BE%8E%E7%99%BD&amp;hl=zh-TW&amp;client=google-csbe&amp;cx=008214668176899870401:qwwvtl8vcqg&amp;boostcse=0&amp;output=xml_no_dtd&amp;ie=UTF-8&amp;oe=UTF-8&amp;ei=nkRLTrv4Bu2emQXYxoieCA&amp;start=10&amp;sa=N</nu> </nb> <rg size="10" start="1"></rg><rg size="1" start="1"></rg><r n="1"><u>http://www.fashionguide.com.tw/BMsgL/08/TopicL_2575_1.html</u><ue>http://www.fashionguide.com.tw/BMsgL/08/TopicL_2575_1.html</ue><t>請問理膚寶水美得高效&lt;b&gt;美白&lt;/b&gt;保濕乳液好用嗎？-FG投票評鑑-FashionGuide &lt;b&gt;...&lt;/b&gt;</t><rk>0</rk><s>網友評鑑人氣最旺的美容時尚討論區,美得高效&lt;b&gt;美白&lt;/b&gt;保濕乳液,改善我的膚色暗沉,黑斑,乾裂&lt;br&gt; 粗糙,乾燥缺水,理膚寶水美得高效&lt;b&gt;美白&lt;/b&gt;保濕乳液還不錯, 聞起來的味道有點香香, &lt;b&gt;...&lt;/b&gt;</s><lang>zh-TW</lang><label>_cse_qwwvtl8vcqg</label><label>商品評鑑</label><has><l /><c sz="243k" cid="fgCXUzlrohEJ" /><rt /></has></r> <rg size="1" start="2"></rg><r n="2"><u>http://www.fashionguide.com.tw/BMsgL/08/CateSubL_525_Brand_139_Ques_18_1.html</u><ue>http://www.fashionguide.com.tw/BMsgL/08/CateSubL_525_Brand_139_Ques_18_1.html</ue><t>請問哪一牌的身體&lt;b&gt;美白&lt;/b&gt;乳液較有效？-FG投票評鑑-FashionGuide華人第一 &lt;b&gt;...&lt;/b&gt;</t><rk>0</rk><s>網友評鑑人氣最旺的美容時尚討論區,嫩白潤膚乳液,改善我的膚色暗沉,乾裂粗糙,真的會變&lt;br&gt; 白哦~ , 可是夏天用有點小油~ , 冬天&amp;#39;嘟嘟&amp;#39;好~,,150ml、400ml,滋潤肌膚， &lt;b&gt;...&lt;/b&gt;</s><lang>zh-TW</lang><label>_cse_qwwvtl8vcqg</label><label>商品評鑑</label><has><l /><c sz="237k" cid="7hw_wcrrAzgJ" /><rt /></has></r> <rg size="1" start="3"></rg><r n="3"><u>http://www.fashionguide.com.tw/forum/07/MsgL.asp?BoardNum=2&amp;LinkTo=TopicL&amp;TopicNum=101378&amp;AbsoluteMsg=1</u><ue>http://www.fashionguide.com.tw/forum/07/MsgL.asp%3FBoardNum%3D2%26LinkTo%3DTopicL%26TopicNum%3D101378%26AbsoluteMsg%3D1</ue><t>拜託推薦&lt;b&gt;美白&lt;/b&gt;有效的東西。保養品......-FashionGuide華人第一時尚美容網站</t><rk>0</rk><s>FG Beauty討論區是網友評鑑人氣最旺的美容討論區--請大家說說什麼產品，或專櫃品牌，&lt;br&gt; &lt;b&gt;美白&lt;/b&gt;很有效的？</s><lang>zh-TW</lang><label>_cse_qwwvtl8vcqg</label><label>討論區</label><has><l /><c sz="205k" cid="wkddQJ58fbYJ" /><rt /></has></r> <rg size="1" start="4"></rg><r n="4"><u>http://www.fashionguide.com.tw/forum/07/MsgL.asp?BoardNum=2&amp;LinkTo=TopicL&amp;TopicNum=263456&amp;AbsoluteMsg=1</u><ue>http://www.fashionguide.com.tw/forum/07/MsgL.asp%3FBoardNum%3D2%26LinkTo%3DTopicL%26TopicNum%3D263456%26AbsoluteMsg%3D1</ue><t>&lt;b&gt;美白&lt;/b&gt;針/ 台南市附近哪家診所的&lt;b&gt;美白&lt;/b&gt;針有效又不貴?-FashionGuide華人第一 &lt;b&gt;...&lt;/b&gt;</t><rk>0</rk><s>FG Beauty討論區是網友評鑑人氣最旺的美容討論區--台南市附近哪裡有診所的&lt;b&gt;美白&lt;/b&gt;針有效&lt;br&gt; 又不貴? , 之前看過其他版(台北地區診所)的&lt;b&gt;美白&lt;/b&gt;針價格比較便宜. , 我之前詢價過 &lt;b&gt;...&lt;/b&gt;</s><lang>zh-TW</lang><label>_cse_qwwvtl8vcqg</label><label>討論區</label><has><l /><c sz="218k" cid="j4_xIhDMG6oJ" /><rt /></has></r> <rg size="1" start="5"></rg><r n="5"><u>http://www.fashionguide.com.tw/BMsgL/08/TopicL_5142_1.html</u><ue>http://www.fashionguide.com.tw/BMsgL/08/TopicL_5142_1.html</ue><t>請問DR.WU RS抗氧&lt;b&gt;美白&lt;/b&gt;防曬霜SPF35.PA+++ 好用嗎？-FG投票評鑑 &lt;b&gt;...&lt;/b&gt;</t><rk>0</rk><s>網友評鑑人氣最旺的美容時尚討論區,RS抗氧&lt;b&gt;美白&lt;/b&gt;防曬霜SPF35.PA+++,改善我的防曬,康氏美&lt;br&gt; 現在88折，買了一條來用，防曬黑係數PA+++，擦起來清爽，不油膩，有變白提亮的 &lt;b&gt;...&lt;/b&gt;</s><lang>zh-TW</lang><label>_cse_qwwvtl8vcqg</label><label>商品評鑑</label><has><l /><c sz="250k" cid="gagHJbnf9GgJ" /><rt /></has></r> <rg size="1" start="6"></rg><r n="6"><u>http://www.fashionguide.com.tw/BMsgL/08/CateSubL_1249_Brand_11_Cate_36_1.html</u><ue>http://www.fashionguide.com.tw/BMsgL/08/CateSubL_1249_Brand_11_Cate_36_1.html</ue><t>哪個&lt;b&gt;美白&lt;/b&gt;面膜最有效果哩？-FG投票評鑑-FashionGuide華人第一時尚美容網站</t><rk>0</rk><s>網友評鑑人氣最旺的美容時尚討論區,藥用雪肌精〔醫藥部外用〕,改善我的膚色暗沉,乾燥&lt;br&gt; 缺水,這四種我都用過了， , 白的最快的當屬雪肌精， , 但是肌膚狀況正常使用才 &lt;b&gt;...&lt;/b&gt;</s><lang>zh-TW</lang><label>_cse_qwwvtl8vcqg</label><label>商品評鑑</label><has><l /><c sz="245k" cid="Cmt1KHEGHV0J" /><rt /></has></r> <rg size="1" start="7"></rg><r n="7"><u>http://beautynews.fashionguide.com.tw/member/forum_topic.php?ft=2464</u><ue>http://beautynews.fashionguide.com.tw/member/forum_topic.php%3Fft%3D2464</ue><t>[2011&lt;b&gt;美白&lt;/b&gt;]~H2O+水中&lt;b&gt;美白&lt;/b&gt;極淨精華 全力出擊- FG美研情報站</t><rk>0</rk><bylinedate>1298033943</bylinedate><s>2011年2月18日 &lt;b&gt;...&lt;/b&gt; 圖片/資料來源：~H2O+水貝爾&lt;b&gt;美白&lt;/b&gt;再進化『徹底擊黑喚白』還原妳的Babywhite~H2O+...</s><lang>zh-TW</lang><label>_cse_qwwvtl8vcqg</label><label>美顏情報站</label><has><l /><c sz="123k" cid="s712xguKdcUJ" /><rt /></has></r> <rg size="1" start="8"></rg><r n="8"><u>http://www.fashionguide.com.tw/forum/07/MsgL.asp?BoardNum=2&amp;LinkTo=TopicL&amp;TopicNum=154117&amp;AbsoluteMsg=1</u><ue>http://www.fashionguide.com.tw/forum/07/MsgL.asp%3FBoardNum%3D2%26LinkTo%3DTopicL%26TopicNum%3D154117%26AbsoluteMsg%3D1</ue><t>&lt;b&gt;美白&lt;/b&gt;/ 淡化腋下跨下乳暈痘疤色素暗沉的&lt;b&gt;美白&lt;/b&gt;東西-FashionGuide華人第一 &lt;b&gt;...&lt;/b&gt;</t><rk>0</rk><s>FG Beauty討論區是網友評鑑人氣最旺的美容討論區--請問各位大大~~淡化黑斑雀斑的淡斑&lt;br&gt; 膏可以用在腋下跨下乳暈或者是痘痘消後遺留下來的色素暗沉處嗎~~謝謝.</s><lang>zh-TW</lang><label>_cse_qwwvtl8vcqg</label><label>討論區</label><has><l /><c sz="208k" cid="5evxNRufpjcJ" /><rt /></has></r> <rg size="1" start="9"></rg><r n="9"><u>http://www.fashionguide.com.tw/BMsgL/08/CateSubL_1768_Brand_36_Cate_31_1.html</u><ue>http://www.fashionguide.com.tw/BMsgL/08/CateSubL_1768_Brand_36_Cate_31_1.html</ue><t>請問下列那項&lt;b&gt;美白&lt;/b&gt;精華液較好用呢???-FG投票評鑑-FashionGuide華人第一 &lt;b&gt;...&lt;/b&gt;</t><rk>0</rk><s>用了不會長痘痘…,1890元,30ml,擁有&lt;b&gt;美白&lt;/b&gt;、保濕成分，能有效改善並預防雀斑黑斑等問題，&lt;br&gt; 修護肌膚因乾燥泛紅的傷害，使肌膚呈現水潤透明的光澤，促進血液循環。..</s><lang>zh-TW</lang><label>_cse_qwwvtl8vcqg</label><label>商品評鑑</label><has><l /><c sz="239k" cid="o01irNvP_Q4J" /><rt /></has></r> <rg size="1" start="10"></rg><r n="10"><u>http://beautynews.fashionguide.com.tw/member/forum_topic.php?ft=2493</u><ue>http://beautynews.fashionguide.com.tw/member/forum_topic.php%3Fft%3D2493</ue><t>[2011&lt;b&gt;美白&lt;/b&gt;]DIOR迪奧 雪晶靈打造10年&lt;b&gt;美白&lt;/b&gt;盛世- FG美研情報站</t><rk>0</rk><bylinedate>1299084271</bylinedate><s>2011年3月2日 &lt;b&gt;...&lt;/b&gt; 圖片/資料來源：DIOR迪奧迪奧雪晶靈(Diorsnow)打造10年&lt;b&gt;美白&lt;/b&gt;盛世致力研究DNA&lt;b&gt;美白&lt;/b&gt;...</s><lang>zh-TW</lang><label>_cse_qwwvtl8vcqg</label><label>美顏情報站</label><has><l /><c sz="139k" cid="-tje29dO4MsJ" /><rt /></has></r> </res> </gsp>'



        # reslut = Nokogiri::HTML(xml)
        reslut = Hpricot(xml)
        @list = []
        total = reslut.search("m").inner_text.to_s  #搜尋結果總數
        @list << 'total = '+total
        
        reslut.search("//res/r").each do|res|
          u = res.search('u').inner_text.to_s #url
          ue = res.search('ue').inner_text.to_s
          t = res.search('t').inner_text.to_s #title
          s = res.search('s').inner_text.to_s #Description
         
          html = ''
          pic_url = ''
          if type == 'product'
              fg_id = u.to_s.split('_').at(1)
              product = Product.find_by_fg_id(fg_id)
              if product.nil?
                # fgs =  Nokogiri::HTML(open(u) )
                fgs =  Hpricot(open(u) )
                  # logger.debug fgs.search('a[@href*="http://i.fgi.tw/Beauty/ImgPro"]/img').inspect
                  # pic_url = ( fgs.search('a[@href*="http://i.fgi.tw/Beauty/ImgPro"]/img').first )['src'].to_s
                  fgs.search('a[@href*="http://i.fgi.tw/Beauty/ImgPro"]/img').each { |i| pic_url = i['src'].to_s }
                  # fgs.search('a[@href*="http://i.fgi.tw/Beauty/ImgPro"]/img').each do  |i|
                     # pic_url = i['src'].to_s
                  # end
                Product.create(:fg_id => fg_id , :url => u , :picurl => pic_url , :title => t , :comment => s  )
              else
                pic_url = product.picurl
              end
              
              if pic_url.empty?
                html = '<img src="http://i.fgi.tw/Beauty/ImgPro/2/57s.jpg">'
              else
                html = '<img src="'+pic_url+'">'
              end
          elsif type == 'forum'
          		param = u.to_s.split('?').at(1)
  				params = CGI.parse(param)
  				boardNum = params["BoardNum"].to_s 
  				topicNum = params["TopicNum"].to_s

				  # html = boardNum + ':' + topicNum  + topicNum.empty?.to_s
				
				  # if  topicNum.empty? == true 
				  # 	html = boardNum + ':' + topicNum  + 'false' + '<br />url' + u  
				  # else
				  # 	html = boardNum + ':' + topicNum  + 'true'+ '<br />url' + u
				  # end
				
				
				if topicNum.empty? !=  true
									res  = ActiveSupport::JSON.decode( open('http://172.16.1.158/api/forum?BoardNum='+boardNum+'&TopicNum='+topicNum)  )
									html = '<br /><a href="'+u+'"  target="_blank" >' + res['Topic'].to_s + '</a> \' +res['OpenUser'].to_s+',x' + res['Amount'].to_s + "Date:" + res['Date'].to_s + "<br />" +s
									
									
								 else
								  	html = boardNum + ':' + topicNum
								end
          end
          
          
          if html.empty?
          	html = '<br /><br /><a href="'+u+'" >'+t+'</a><br />'+s+'<br>'+u +'<br>'
		  end
		  
		 
          @list << html.to_s.html_safe
          
        end
    
  end
  
  
  def seo
      require 'hpricot'
      require 'open-uri'
      url = 'http://www.google.com.tw/search?hl=zh-TW&q=%E6%84%9B%E6%83%85%E5%BF%83%E7%90%86%E6%B8%AC%E9%A9%97&num=100'
      f = open(url)
      list = Hpricot(f)
      find = 'www.twms.us'
      urls = []
      list.search("h3[@class=r]").search("a").map {|e|  e.get_attribute('href') }.each_with_index do |url , i |
        i = (i+1).to_s
        urls << i.to_s+url if url.include? find
      end
      # render :text => urls.join('<br>') 
  end
  
  def beta 
      require 'hpricot'
      require 'open-uri'
      require 'iconv'
      
      if params[:keyword]
        keyword = CGI.escape(params[:keyword])
        @keyword =  params[:keyword]
      else 
        keyword = ''  
      end
      
      
      url = 'http://www.google.com.tw/search?q='+keyword+'+site%3Ahttp%3A%2F%2Fwww.fashionguide.com.tw%2FBMsgL%2F08%2F'
      f = open(url)
      # f.rewind
      list = Hpricot(Iconv.conv('UTF8//IGNORE', 'BIG5', f.readlines.join("\n")))
  
      # list  = Hpricot(open(url))
      @google_count = (list/'div[@id=resultStats]').to_s.html_safe
  
      # @google = (list/'li[@class=g]').to_s.html_safe
      # @googl = (list/'a[@class=l]').to_s.html_safe
      @google = {}
      @list = (list/'li[@class=g]').to_s.html_safe
      (list/'li[@class=g]').search('a[@class=l]').map {|e|  e.get_attribute('href')}.each_with_index do |url , i |
        i = (i+1).to_s
        
        f = open(url)
        f.rewind
        fg_obj = Hpricot(Iconv.conv('UTF8//IGNORE', 'BIG5' , f.readlines.join("\n")))
        
        # fg_obj = Hpricot(open(url))
        img = fg_obj.search("a[@href*=http://i.fgi.tw/Beauty/ImgPro]").search("img").to_s.html_safe
        title = fg_obj.at('title').inner_html
        id = url.to_s.split('_').at(1)
        @google[i] = {:url => url.to_s , :img => img ,:title => title  , :id => id }
      end
      @google = @google.sort # 排序
      @select = (list/'tr[@valign=top]').to_s.html_safe
   
  end
  
  def cse

    redirect_to :controller =>  'cse/forum'
  end
  
  def sitemap
    require 'iconv'     
    require 'open-uri'
    #抓取 fg sitemap 裡的關鍵字轉圜到 db  
    
     Hpricot(open('http://www.fashionguide.com.tw/sitemap.htm')).search("a").map {|e| "#{e.innerText}" }.each_with_index do |k , i|
        cd = Iconv.new('UTF8//IGNORE', 'BIG5')
            keyword = cd.iconv(k)
            res =  Keyword.create(:keyword => keyword )  
       end
      
  end
  def sitemap2
    require 'iconv'     
    require 'open-uri'
    require 'redis'
    
    r = Redis.new
    @k = []
     Hpricot(open('http://www.fashionguide.com.tw/sitemap.htm')).search("a").map {|e| "#{e.innerText}" }.each_with_index do |k , i|
        cd = Iconv.new('UTF8//IGNORE', 'BIG5')
            keyword = cd.iconv(k)
            # res =  Keyword.create(:keyword => keyword )  
            n = keyword
            
            n.strip!
            (1..(n.length)).each{|l|
                prefix = n[0...l]
                @k << prefix
                r.zadd(:keyword,0,prefix)
                #@show << prefix
            }
            @k << n
            r.zadd(:keyword,0,n+"*")
     end
     render :json => @k
  end
  
  
  def nokogiri
      require 'nokogiri'
      require 'open-uri'
      
      
      if params[:keyword]
        keyword = CGI.escape(params[:keyword])
        @keyword =  params[:keyword]
      else 
        keyword = ''  
      end
       @result = []
      
      # url = 'http://www.google.com.tw/search?q=+site%3Ahttp%3A%2F%2Fwww.fashionguide.com.tw%2FBMsgL%2F08%2F'
      # f = open(url)
      # f.rewind
      # doc = Nokogiri::HTML(Iconv.conv('UTF8//IGNORE', 'BIG5', f.readlines.join("\n")))
      # doc.search('//a[@class="l"]').each_with_index do |link , i|
      # # doc.xpath('//h3/a[@class="l"]').each do |link|
        # # doc.css('h3.r a.l').each do |link|
          # # @result << link['href']
      # end
         
          fgs =  Nokogiri::HTML(open('http://www.fashionguide.com.tw/BMsgL/08/TopicL_4607_1.html') )
          # @result <<  (i+=1).to_s + link.to_s+fgs.search('a[@href*="http://i.fgi.tw/Beauty/ImgPro"]/img').to_s
          fgs.search('//table/tr/td[@class="tac1"]').each do |i , n |
            
             @result <<  i.parent
          end
         
      
      @result = @result.join("<br>").html_safe
  end
  
  def apitest
  	
  	
  	# parsed_json =  RestClient.get "http://172.16.1.158/api/forum", { 'BoardNum' => 1  , 'TopicNum' => '215674' }
  	
  	
  		parsed_json = ActiveSupport::JSON.decode( open('http://172.16.1.158/api/forum?BoardNum=1&TopicNum=215674'))
  	
  	 # res  = Nokogiri::HTML(   open('http://172.16.1.158/api/forum?BoardNum=1&TopicNum=215674')  )

  	 
  	render :text => parsed_json

  	
  	
  end
  
  def google
      require 'nokogiri'
      require 'open-uri'
      url = 'http://google.com/complete/search?output=toolbar&q=mac'
      reslut = Nokogiri::XML(open(url))
      ress = []
      reslut.xpath('//suggestion').each do |res|
        ress << res.attributes['data'].value
      end

    render :text =>  ress.join("<br/>")
  end
  
	protected
	  
  
  
  
  
end