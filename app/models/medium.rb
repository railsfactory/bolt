class Medium < ActiveRecord::Base
  has_many :media_images
  def self.remove_media(delid)   
    Medium.delete_all "id = #{delid}"
    MediaImage.delete_all "medium_id = #{delid}" 
  end  

end
