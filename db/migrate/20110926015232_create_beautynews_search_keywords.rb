class CreateBeautynewsSearchKeywords < ActiveRecord::Migration
  def change
    create_table :beautynews_search_keywords do |t|
      t.string  :keyword 
      t.integer :total
      t.timestamps
    end
    add_index :beautynews_search_keywords, :keyword
  end
end
