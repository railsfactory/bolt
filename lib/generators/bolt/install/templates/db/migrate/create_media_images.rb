class CreateMediaImages < ActiveRecord::Migration
  def change
    create_table :media_images do |t|
      t.integer :media_id
      t.string :image_path

      t.timestamps
    end
  end
end
