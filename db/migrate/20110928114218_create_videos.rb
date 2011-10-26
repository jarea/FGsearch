class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.integer :vk_id
      t.integer :num
      t.string  :img_url
      t.string  :topic
      t.text  :topic_content
      t.integer :click_amount
      t.integer :amount
      t.date    :date
      t.string  :cse_title
      t.string  :cse_url
      t.string  :cse_description
      t.timestamps
    end
  end
end
