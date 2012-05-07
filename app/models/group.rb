class Group < ActiveRecord::Base
  validates :name, :presence => true,
                    :length => { :minimum => 5 }, :uniqueness => true
                    
  has_many :users_groups
  has_many :users, :class_name => "Bolt::User", :through => :users_groups, :dependent => :destroy
end

