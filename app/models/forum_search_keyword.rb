class ForumSearchKeyword < ActiveRecord::Base
    validates_presence_of :keyword
    validates_uniqueness_of :keyword
    
    has_many  :forum_keyword , :dependent => :destroy ,:class_name => "ForumKeyword" , :foreign_key => 'fsk_id' 
    has_many  :forum , :through => :forum_keyword
end
