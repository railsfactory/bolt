class Category < ActiveRecord::Base
  validates :name, :presence => true,
                    :length => { :minimum => 5 }, :uniqueness => true
  has_many :articles_categories
  has_many :articles, :through => :articles_categories, :dependent => :destroy
  
end