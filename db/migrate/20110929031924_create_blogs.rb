class CreateBlogs < ActiveRecord::Migration
  def change
    create_table :blogs do |t|
      t.integer   :bk_id
      t.integer   :num
      t.string    :topic
      t.string    :img_url
      t.datetime  :date
      t.string    :type_name
      t.integer   :click_amount
      t.integer   :amount
      t.string    :per_name
      t.string    :cse_url
      t.string    :cse_title
      t.string    :cse_description
      t.timestamps
    end
  end
end
