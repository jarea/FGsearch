class CreateProductKeywords < ActiveRecord::Migration
  def change
    create_table :product_keywords do |t|
      t.integer :psk_id
      t.integer :product_num
      t.timestamps
    end
  end
end
