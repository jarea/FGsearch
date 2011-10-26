class CreateKeywords < ActiveRecord::Migration
  def change
    create_table :keywords do |t|
      t.column :keyword , :string  , :null     => false
      t.column :count   , :integer, :default  => 0      , :null => false
      t.timestamps
    end
  end
end
