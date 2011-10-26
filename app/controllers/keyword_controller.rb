class KeywordController < ApplicationController
      skip_before_filter :get_fg_top_AD
      skip_before_filter :get_fg_left_AD 
      skip_before_filter :get_fg_right_AD 
      skip_before_filter :get_fg_botton_AD 
  
  def index
      key_word = params[:q]  
      @keywords = Keyword.connection.select_values("select keyword from keywords where keyword like '%#{key_word}%'")  
      respond_to do |format|  
        format.html { render :text => @keywords.join("\n")}  
      end  
  end
  
  def next
     @keywords = Keyword.page(params[:page])
  end

  def cp 
    require 'rubygems'
    require 'redis'
    
    r = Redis.new

     q = params[:q].to_s
     res = complete(r,q,50)
    render :text => res.join("\n")
  end
  
  def complete(r,prefix,count)
      results = []
      rangelen = 50 # This is not random, try to get replies < MTU size
      start = r.zrank(:keyword,prefix)
      return [] if !start
      while results.length != count
          range = r.zrange(:keyword,start,start+rangelen-1)
          start += rangelen
          break if !range or range.length == 0
          range.each {|entry|
              minlen = [entry.length,prefix.length].min
              if entry[0...minlen] != prefix[0...minlen]
                  count = results.count
                  break
              end
              if entry[-1..-1] == "*" and results.length != count
                  results << entry[0...-1]
              end
          }
      end
      return results
  end
  
  def add_keyword
    @keyword = FgKeyword.new
    @add_list = JSON.parse( params[:list] ,:symbolize_names => true) if params[:list]
  end
  def add_keyword_insert
     acssociate_keyword_list = params[:acssociate_keyword_list]
     @add_list = []
     if acssociate_keyword_list.nil?
          keyword = params[:fg_keyword][:keyword].strip
          accociate_keyword = params[:acssociate_keyword].strip
          if !FgKeyword.find_by_keyword(keyword).nil?
            @keyword = FgKeyword.find_by_keyword(keyword)
          else
            @keyword = FgKeyword.create(:keyword => keyword)
          end
         @keyword.fka.create(:keyword => accociate_keyword) if !@keyword.id.nil?
         @add_list << {:keyword => keyword , :accociate_keyword => accociate_keyword }
         res = !@keyword.id.nil?
     else
        acssociate_keyword_list.each_line do |r|
          accociate_keyword_arr = []
          keyword = r.split(':').at(0).strip
          accociate_keyword = r.split(':').at(1).split(',')  if !r.split(':').at(1).nil?
          if !FgKeyword.find_by_keyword(keyword).nil?
            keyword_iinsert = FgKeyword.find_by_keyword(keyword)
          else
            keyword_iinsert = FgKeyword.create(:keyword => keyword)    
          end
          
          if !accociate_keyword.nil?
            accociate_keyword.each do |ak|
              accociate_keyword_arr << ak.strip
              keyword_iinsert.fka.create(:keyword => ak.strip) if !keyword_iinsert.id.nil?
            end
          end
          @add_list << {:keyword => keyword , :accociate_keyword => accociate_keyword_arr.join(',') }
          res = !keyword_iinsert.id.nil?
          keyword_iinsert.associate_count = keyword_iinsert.fka.count
          keyword_iinsert.save
        end
        
     end
     
     if res
          flash[:notice] = '新增成功'
          redirect_to :action => :add_keyword  , :list => @add_list.to_json
     else  
          flash[:alert] = '新增失敗'
          redirect_to :action => :add_keyword
     end
  end
  
  def get_fg_keyword
      key_word = params[:q]  
      @keywords = FgKeyword.connection.select_values("select keyword from fg_keywords where keyword like '%#{key_word}%'")  
      respond_to do |format|  
        format.html { render :text => @keywords.join("\n")}  
      end 
  end
  
  def get_keyword
    
      key_word = params[:q]   
      
      keyword_array = []
      
      fgkeyword = FgKeyword.find( :keyword => key_word).at(0)
      keyword_array << fgkeyword.keyword
      fgkeyword.fka.select(:keyword).each do |r|
        keyword_array << r.keyword
      end  
      
      respond_to do |format|  
        format.html { render :text => keyword_array.join(" OR ")}  
      end
  end
  
  
  
end
