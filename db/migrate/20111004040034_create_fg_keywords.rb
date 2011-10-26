class CreateFgKeywords < ActiveRecord::Migration
  def change
    create_table :fg_keywords do |t|
      t.string :keyword
      t.integer :associate_count , :default => 0

      t.timestamps
    end
    
    add_index :fg_keywords, :keyword
  end
end
