class BlogSearchKeyword < ActiveRecord::Base
    validates_presence_of :keyword
    validates_uniqueness_of :keyword
    
    has_many  :blog_keyword , :dependent => :destroy , :foreign_key => 'bsk_id'
    has_many  :blog , :through => :blog_keyword
    
    
end
