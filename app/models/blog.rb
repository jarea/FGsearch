class Blog < ActiveRecord::Base
    validates_presence_of :bk_id
    validates_uniqueness_of :bk_id , :scope => :num
    belongs_to :blog_keyword  ,:primary_key => :bk_id
    paginates_per 20 
end
