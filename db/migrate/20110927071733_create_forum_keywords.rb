class CreateForumKeywords < ActiveRecord::Migration
  def change
    create_table :forum_keywords do |t|
      t.integer :fsk_id
      t.integer :topic_num
      t.timestamps
    end
  end
end
