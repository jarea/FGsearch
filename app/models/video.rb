class Video < ActiveRecord::Base
    validates_presence_of :vk_id
    validates_uniqueness_of :vk_id , :scope => :num
    belongs_to :video_keyword  ,:primary_key => :vk_id
    
    paginates_per 20 
end
