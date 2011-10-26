class BlogKeyword < ActiveRecord::Base
      validates_uniqueness_of :bsk_id, :scope => :blog_num
      belongs_to :blog_search_keyword , :class_name => "BlogSearchKeyword"  , :primary_key => :bsk_id
      has_one :blog  , :dependent => :destroy ,:foreign_key=>'bk_id'
end
