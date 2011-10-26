class ForumKeyword < ActiveRecord::Base
    validates_uniqueness_of :fsk_id, :scope => :topic_num
    belongs_to :forum_search_keyword , :class_name => "ForumSearchKeyword"  , :primary_key => :fsk_id
    has_one :forum  , :dependent => :destroy , :foreign_key => 'fk_id'
    has_one :f , :foreign_key => 'fk_id'
end
