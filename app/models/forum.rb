class Forum < ActiveRecord::Base
    paginates_per 20
    validates_presence_of :fk_id
    validates_uniqueness_of :fk_id , :scope => :topic_num
    belongs_to :forum_keyword  , :primary_key => :fk_id  
end
