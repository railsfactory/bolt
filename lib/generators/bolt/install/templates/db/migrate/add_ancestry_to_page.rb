class AddAncestryToPage < ActiveRecord::Migration
  def self.up
    add_index :pages, :ancestry 
  end
 
  def self.down
    remove_index :pages, :ancestry
  end
end
