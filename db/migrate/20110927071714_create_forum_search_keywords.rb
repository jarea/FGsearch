class CreateForumSearchKeywords < ActiveRecord::Migration
  def change
    create_table :forum_search_keywords do |t|
      t.string :keyword
      t.integer :total
      t.integer :beauty_total
      t.integer :fashion_total
      t.integer :freetalk_total
      t.integer :fit_total
      
      t.timestamps
    end
    
    add_index :forum_search_keywords, :keyword
  end
end
