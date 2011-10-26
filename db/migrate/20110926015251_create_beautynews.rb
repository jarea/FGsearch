class CreateBeautynews < ActiveRecord::Migration
  def change
    create_table :beautynews do |t|
      t.integer :bk_id
      t.integer :num
      t.string  :topic
      t.string  :topic_content
      t.string  :author
      t.datetime   :datetime
      t.string  :img_url
      t.integer :pvcount
      t.integer :cat_id
      t.string :cat_name
      t.string :cse_title
      t.string :cse_url
      t.string :cse_description
      t.timestamps
    end
  end
end
