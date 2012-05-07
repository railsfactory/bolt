class MediaImage < ActiveRecord::Base
  belongs_to :medium
  #has_attached_file :datafile, :styles => {:thumb => "75x75#", :small => "100x100#",:medium => "150x150>" }
  def self.save(upload,folderparent,folderpath)
    name =  upload['datafile'].original_filename   
    directory = "app"+folderpath
    # create the file path
    path = File.join(directory, name)
    # write the file
    File.open(path, "wb") { |f| f.write(upload['datafile'].read) }    
    bs = MediaImage.new(:medium_id => folderparent ,:image_path => name)
    bs.save  
  end
  
  def self.remove_image(delid)   
    MediaImage.delete_all "id = #{delid}" 
  end

end