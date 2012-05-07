class CreateArticles < ActiveRecord::Migration
  def self.up
    create_table :articles do |t|
      t.string :title
      t.string :alias
      t.integer :status_id
      t.integer :access_id
      t.integer :featured
      t.text :body
      
      t.timestamps
    end
  end

  def self.down
    drop_table :articles
  end
end