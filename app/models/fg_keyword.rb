class FgKeyword < ActiveRecord::Base
  validates_presence_of   :keyword
  validates_uniqueness_of :keyword
  has_many :fka ,    :class_name => 'FgKeywordAssociate' ,  :foreign_key => :parent_keyword_id
  
end
