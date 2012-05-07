class ChangeMediaimagesColumn < ActiveRecord::Migration
  def up
     rename_column :media_images, :media_id, :medium_id
  end

  def down
  end
end
