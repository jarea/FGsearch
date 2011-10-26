class BeautynewsSearchKeyword < ActiveRecord::Base
  validates_presence_of :keyword
  validates_uniqueness_of :keyword
  
  has_many  :beautynews_keywords  , :dependent => :destroy,:class_name => "BeautynewsKeyword" , :foreign_key => 'bsk_id'
  has_many  :beautynews , :through => :beautynews_keywords
   
end
