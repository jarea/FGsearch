class FindImgController < ApplicationController
      before_filter :keyword , :only => [:index]
      before_filter :page , :only => [:index]
      before_filter :site_url , :only => [:index]
      
  def index
      require 'hpricot'
      require 'open-uri'
      
      @site = site = ''
        site = '%2Bsite%3A'+ params[:site].to_s if params[:site] && !params[:site].empty?
        @site = params[:site].to_s if params[:site] && !params[:site].empty?
        
        
      if !keyword.nil?
          url = "http://hpricot.com/demos/search?uurl=http%3A%2F%2Fwww.google.com.tw%2Fsearch%3Fq%3D"+keyword+site+"%26start%3D"+start(page)+"%26hl%3Dzh-TW%26source%3Dlnms%26tbm%3Disch%26biw%3D1574%26bih%3D882&searchexpr=img%5B%40src*%3Dhttp%5D"
          
          resp = Net::HTTP.get_response(URI.parse(url))
          if resp and resp.code == "200"
            @list = Hpricot(open(url)).search("img[@src*=http]").to_s.html_safe
            @page_link = page_link(keyword , page , @site).html_safe
          end
      end
      render :layout => "window"
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
      page = params[:page].to_i || 1
    end
    def site_url
        @site = site = ''
        site = '+site:'+ params[:site].to_s if params[:site]
        @site = params[:site].to_s if params[:site]  
    end
    def start page
      start = ( (page + 0) * 18 ).to_s 
    end
    def page_link(keyword , page , site )
      link = []
      
      for i in 1..10
         link << '<a href="?q='+keyword+'&page='+i.to_s+'&site='+site+'">'+i.to_s+'</a>'
      end
      
      links = link.join(' ')
    end
  
end
