class Access < ActiveRecord::Base
     validates :name, :presence => true
     has_many :articles
  
end
