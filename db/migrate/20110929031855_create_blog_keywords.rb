class CreateBlogKeywords < ActiveRecord::Migration
  def change
    create_table :blog_keywords do |t|
      t.integer :bsk_id
      t.integer :blog_num
      t.timestamps
    end
  end
end
