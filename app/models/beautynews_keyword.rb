class BeautynewsKeyword < ActiveRecord::Base
  validates_uniqueness_of :bsk_id, :scope => :beautynews_num
  
  belongs_to :beautynews_search_keyword , :class_name => "BeautynewsSearchKeyword"  , :primary_key => :bsk_id
  has_one :beautynews , :dependent => :destroy, :foreign_key => 'bk_id'
end
  
