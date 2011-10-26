class FgKeywordAssociate < ActiveRecord::Base
  validates_presence_of   :keyword
  validates_uniqueness_of :keyword
  belongs_to :fg_keyword
end
