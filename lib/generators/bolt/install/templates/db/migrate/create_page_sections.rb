class CreatePageSections < ActiveRecord::Migration
  def self.up
    create_table :page_sections do |t|
      t.integer :page_id
      t.string :title
      t.text :body
      t.integer :position
      
      t.timestamps
    end
    Page.all.each do |page|
      page.page_sections.create(:body => "This is a test page section", :title => "Main Section")
      page.page_sections.create(:body => "This is a test page section", :title => "Side Section")
    end
  end

  def self.down
    drop_table :page_sections
  end
end
