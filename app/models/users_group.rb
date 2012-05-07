class UsersGroup < ActiveRecord::Base
  belongs_to :user, :class_name => "Bolt::User"
  belongs_to :group

  validates :user_id, :uniqueness => {:scope => [:group_id]}
  
  def validate 
    if self.group_id.to_i <= 0
      errors.add("Group_id", "cant be zero")
    end
  end

end

