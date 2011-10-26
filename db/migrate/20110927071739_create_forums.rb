class CreateForums < ActiveRecord::Migration
  def change
    create_table :forums do |t|
      t.integer :fk_id
      t.integer :topic_num
      t.integer :board_num
      t.string  :topic
      t.string  :openuser
      t.integer   :amount
      t.datetime  :datetime
      t.string  :cse_url
      t.string  :cse_url
      t.string  :cse_title
      t.string  :cse_description
      
      t.timestamps
    end
  end
end
