class Keyword < ActiveRecord::Base
  validates_presence_of   :keyword
  validates_uniqueness_of :keyword
  
  paginates_per 50
  
end
