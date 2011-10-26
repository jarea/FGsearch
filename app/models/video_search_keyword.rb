class VideoSearchKeyword < ActiveRecord::Base
    validates_presence_of :keyword
    validates_uniqueness_of :keyword
    
    has_many  :video_keyword  , :dependent => :destroy, :foreign_key => 'vsk_id'
    has_many  :video , :through => :video_keyword
end
