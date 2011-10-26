class Beautynews < ActiveRecord::Base
  paginates_per 20

    validates_presence_of :bk_id
    validates_uniqueness_of :bk_id , :scope => :num
    belongs_to :beautynews_keyword , :primary_key => :bk_id 

end
