class CreateFgVideos < ActiveRecord::Migration
  def change
    create_table :fg_videos do |t|

      t.timestamps
    end
  end
end
