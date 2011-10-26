class CreateVideoKeywords < ActiveRecord::Migration
  def change
    create_table :video_keywords do |t|
      t.integer :vsk_id
      t.integer :video_num
      t.timestamps
    end
  end
end
