class Product < ActiveRecord::Base
    validates_uniqueness_of :pk_id
    validates_presence_of :pk_id
    belongs_to :product_keyword ,:primary_key =>:product_num  , :foreign_key => :num
    paginates_per 10 
end
