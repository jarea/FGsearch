class CreateProductSearchKeywords < ActiveRecord::Migration
  def change
    create_table :product_search_keywords do |t|
      t.string  :keyword
      t.integer :total
      t.timestamps
    end
    
    add_index :product_search_keywords, :keyword
  end
end
