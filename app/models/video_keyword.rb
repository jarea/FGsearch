class VideoKeyword < ActiveRecord::Base
    validates_uniqueness_of :vsk_id, :scope => :video_num
    belongs_to :video_search_keyword , :class_name => "VideoSearchKeyword"  , :primary_key => :vsk_id
    has_one :video  , :dependent => :destroy,:foreign_key=>'vk_id'
end
