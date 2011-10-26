class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.integer :pk_id
      t.integer :num
      t.string  :topic
      t.string  :product_name
      t.integer :product_num
      t.string  :img_url
      t.datetime  :date
      t.integer :amount
      t.string  :price
      t.string  :volume
      t.string  :cse_url
      t.string  :cse_title
      t.string  :cse_description
      t.integer :item_type
      t.integer :version
      t.integer :item1grade
      t.integer :item2grade
      t.integer :item3grade
      t.integer :item4grade
      t.integer :item5grade
      t.integer :item6grade
      t.integer :item7grade
      t.integer :item8grade
      t.integer :item9grade
      t.integer :item10grade
      t.integer :item_total_sum
      t.integer :item_grade_1_sum
      t.integer :item_grade_2_sum
      t.integer :item_grade_3_sum
      t.integer :item_grade_4_sum
      t.integer :item_grade_5_sum

      t.timestamps
    end
  end
end
