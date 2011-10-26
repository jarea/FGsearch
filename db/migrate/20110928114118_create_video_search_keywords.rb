class CreateVideoSearchKeywords < ActiveRecord::Migration
  def change
    create_table :video_search_keywords do |t|
      t.string  :keyword
      t.integer :total
      t.timestamps
    end
    
    add_index :video_search_keywords, :keyword
  end
end
