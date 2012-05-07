class ArticlesCategory < ActiveRecord::Base
   belongs_to :article
  belongs_to :category

  validates :article_id, :uniqueness => {:scope => [:category_id]}
  
  def validate 
    if self.category_id.to_i <= 0
      errors.add("Category_id", "cant be zero")
    end
  end
end