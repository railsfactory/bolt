class Article < ActiveRecord::Base
  
  ######   association ###########
  
  validates :title, :presence => true
  validates :alias, :presence => true
  
  belongs_to :status
  belongs_to :access
  has_many :articles_categories
  has_many :categories, :through => :articles_categories, :dependent => :destroy
  accepts_nested_attributes_for :articles_categories, :reject_if => proc { |attributes| attributes['category_id'].blank? || attributes['category_id'].to_i == 0}, :allow_destroy => true
     
 ######### for FEATURED ########
 
 NO =0
 YES =1
 FEATURED_TYPES ={
   NO =>"No",
   YES =>"Yes"
   
 }   
end
