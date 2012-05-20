class CreateSettings < ActiveRecord::Migration
  def self.up
    create_table :settings do |t|
      t.string :site_name
      t.string :logo_path
      t.string :slogan
      t.string :footer_text
      
      t.timestamps
    end
    
    Setting.create :site_name => "Bolt", :logo_path => "/assets/logo.png" , :slogan =>"Super CMS by Railsfactory" , :footer_text => "Copyright to <a href='#'>Railsfactory</a>@2012"
  end

  def self.down
    drop_table :settings
  end
end