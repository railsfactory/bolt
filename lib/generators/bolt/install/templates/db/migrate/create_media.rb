class CreateMedia < ActiveRecord::Migration
  def change
    create_table :media do |t|
      t.integer :parent_id
      t.string :link_title
      t.string :file_path
      t.boolean :status

      t.timestamps
    end
        Medium.create  :parent_id => "0" , :link_title=>"Images" , :file_path => "/assets/images", :status => "1"
        Medium.create  :parent_id => "0" , :link_title=>"Files" , :file_path => "/assets/files", :status => "1"
        Medium.create  :parent_id => "0" , :link_title=>"Audios" , :file_path => "/assets/audios", :status => "1"
        Medium.create  :parent_id => "0" , :link_title=>"Videos" , :file_path => "/assets/videos", :status => "1"
        Medium.create  :parent_id => "0" , :link_title=>"Miscellaneous" , :file_path => "/assets/miscellaneous", :status => "1"
        Medium.create  :parent_id => "1" , :link_title=>"Banners" , :file_path => "/assets/images/banners", :status => "1"	
  end
end
