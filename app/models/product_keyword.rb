class ProductKeyword < ActiveRecord::Base
      validates_uniqueness_of :psk_id, :scope => :product_num
      belongs_to :product_search_keyword , :class_name => "ProductSearchKeyword"  , :primary_key => :psk_id
      has_one :product  , :dependent => :destroy ,:foreign_key=>'pk_id'     
end
