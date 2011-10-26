class CreateFgKeywordAssociates < ActiveRecord::Migration
  def change
    create_table :fg_keyword_associates do |t|
      t.integer :parent_keyword_id
      t.string :keyword

      t.timestamps
    end
  end
end
