class ProductSearchKeyword < ActiveRecord::Base
    validates_presence_of :keyword
    validates_uniqueness_of :keyword
    has_many  :product_keyword  , :dependent => :destroy, :foreign_key => 'psk_id'
    has_many  :product , :through => :product_keyword 
end
