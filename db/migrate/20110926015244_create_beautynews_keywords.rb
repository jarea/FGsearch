class CreateBeautynewsKeywords < ActiveRecord::Migration
  def change
    create_table :beautynews_keywords do |t|
      t.integer   :bsk_id
      t.integer   :beautynews_num
      t.timestamps
    end
  end
end
