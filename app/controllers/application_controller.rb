class ApplicationController < ActionController::Base
  protect_from_forgery
   before_filter :get_fg_top_AD  
   before_filter :get_fg_left_AD 
   before_filter :get_fg_right_AD 
   before_filter :get_fg_botton_AD 
  
  caches_action :get_fg_top_AD
  caches_action :get_fg_left_AD 
  caches_action :get_fg_right_AD 
  caches_action :get_fg_botton_AD 
  
  require 'nokogiri'
  require 'open-uri'
  require 'iconv'    
  
  
       
  def get_fg_top_AD
    @fg_top = Nokogiri::HTML.parse(open('http://ad5.fashionguide.com.tw/include/top.php') ,nil , 'UTF-8' ).to_s.html_safe
  end
  def get_fg_left_AD
    @fg_left = Nokogiri::HTML.parse(open('http://ad5.fashionguide.com.tw/include/leftdiv.php') ,nil , 'UTF-8' ).to_s.html_safe
  end
  def get_fg_right_AD
    @fg_right = Nokogiri::HTML.parse(open('http://ad5.fashionguide.com.tw/include/rightdiv.php') ,nil , 'UTF-8' ).to_s.html_safe
  end
  def get_fg_botton_AD
    @fg_botton = Nokogiri::HTML.parse(open('http://ad5.fashionguide.com.tw/include/bottom.php') ,nil , 'UTF-8' ).to_s.html_safe
  end
end
