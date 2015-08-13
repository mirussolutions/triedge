class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :title
      t.text :description
      t.string :video_url
      t.integer :chapter_id

      t.timestamps null: false
    end
  end
end
