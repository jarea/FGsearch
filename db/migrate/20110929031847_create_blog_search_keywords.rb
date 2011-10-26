class CreateBlogSearchKeywords < ActiveRecord::Migration
  def change
    create_table :blog_search_keywords do |t|
      t.string  :keyword
      t.integer :total
      t.timestamps
    end
    
    add_index :blog_search_keywords, :keyword
  end
end
