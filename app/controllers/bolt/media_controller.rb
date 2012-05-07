module Bolt
class MediaController < Bolt::BoltController
  # GET /media
  # GET /media.json
  def index
    @media = Medium.where(:parent_id => 0)
    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @media }
    end
  end

  # GET /media/1
  # GET /media/1.json
  # def show
    # @medium = Medium.find(params[:id])
    # respond_to do |format|
      # format.html # show.html.erb
      # format.json { render :json => @medium }
    # end
  # end
  def getfolderdatas  
    @folder_data = MediaImage.where(:medium_id => params[:id])
    render :layout => false
    # render :partial => "getfolderdatas", :layout =>false
  end

  # GET /media/new
  # GET /media/new.json
  # def new
    # @medium = Medium.new
# 
    # respond_to do |format|
      # format.html # new.html.erb
      # format.json { render :json => @medium }
    # end
  # end

  # GET /media/1/edit
  # def edit
    # @medium = Medium.find(params[:id])
  # end

  # POST /media
  # POST /media.json
  # def create
    # @medium = Medium.new(params[:medium])
# 
    # respond_to do |format|
      # if @medium.save
        # format.html { redirect_to @medium, :notice => 'Medium was successfully created.' }
        # format.json { render :json => @medium, :status => :created, :location => @medium }
      # else
        # format.html { render :action => "new" }
        # format.json { render :json => @medium.errors, :status => :unprocessable_entity }
      # end
    # end
  # end

  # PUT /media/1
  # PUT /media/1.json
  # def update
    # @medium = Medium.find(params[:id])
# 
    # respond_to do |format|
      # if @medium.update_attributes(params[:medium])
        # format.html { redirect_to @medium, :notice => 'Medium was successfully updated.' }
        # format.json { head :ok }
      # else
        # format.html { render :action => "edit" }
        # format.json { render :json => @medium.errors, :status => :unprocessable_entity }
      # end
    # end
  # end

  # DELETE /media/1
  # DELETE /media/1.json
  # def destroy
    # @medium = Medium.find(params[:id])
    # @medium.destroy
# 
    # respond_to do |format|
      # format.html { redirect_to media_url }
      # format.json { head :ok }
    # end
  # end
  
   def uploadFile 
    session[:clickfolder] = params[:parentfolder]	   
    folderpath=   "app"+params[:folderpath]
    if(Dir[folderpath].empty?)	
	create_directory(folderpath)
    end
    MediaImage.save(params[:upload],params[:folderparent],params[:folderpath])
    #render :text => "File has been uploaded successfully"
    redirect_to "/bolt/media/index"   
  end
  def create_folder
    session[:clickfolder] = params[:parentfolder]
    md = Medium.new(:parent_id => params[:parentfolder],:link_title => params[:folder], :file_path => params[:infolder]+"/"+params[:folder], :status => 1)
    md.save  
    dirname="app"+params[:infolder]+"/"+params[:folder]
    create_directory(dirname)
    render :text =>"success"
  end
  def delete_folder
    session[:clickfolder] = params[:delfolder]
    Medium.remove_media(params[:delfolder])   
    dirname="app"+params[:folder]
    remove_directory(dirname)
    render :text =>"success"
  end  
  
  def delete_file
    session[:clickfolder] = params[:parentfolder]
    MediaImage.remove_image(params[:image_id])   
    file_path="app"+params[:image_path]
    remove_file(file_path)
    render :text =>"success"
  end
  
  
end
end