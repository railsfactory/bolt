module Bolt
  class PagesController < Bolt::BoltController
    
    ## optional filters for defining usage according to Bolt::Users access_levels
    # before_filter :needs_admin, :except => [:action1, :action2]
    # before_filter :needs_admin_or_current_user, :only => [:action1, :action2]
    
    def index
      @bolt_page_title = 'Pages'
      @pages = Page.parent_menu.paginate :page => params[:page]
    end
    
    def show
      @bolt_page_title = 'View page'
      media_id =Medium.where(:link_title  => 'banners')
       @site_images =MediaImage.where(:medium_id => media_id)
      @page = Page.find params[:id]
    end
    
    def new
      @bolt_page_title = 'Add a new page'
    media_id =Medium.where(:link_title  => 'banners')
       @site_images =MediaImage.where(:medium_id => media_id)
      @page = Page.new
    end

    def create     
      if(!params[:parent].blank? && params[:parent].to_i > 0)
        parent = Page.find(params[:parent].to_i)
      end
      @page = Page.new params[:page]        
      @page.parent_id = parent.id if(!parent.nil?)
           
      if @page.save
        flash[:notice] = 'Page created'
        redirect_to bolt_pages_path
      else
        flash.now[:warning] = 'There were problems when trying to create a new page'
        render :action => :new
      end
    end
    
    def update
      @bolt_page_title = 'Update page'
      @page = Page.find params[:id]
      if(params[:parent].to_i > 0 && params[:parent].to_i != @page.parent_id)
	  parent = Page.find_by_id(params[:parent])	
	  if(!parent.nil?)
              @page.parent_id = parent.id
          end
      elsif(params[:parent].blank? || params[:parent].nil?) 
           	@page.parent_id = nil      
      end
      
      
      if @page.update_attributes params[:page]
        flash[:notice] = 'Page has been updated'
        redirect_to bolt_pages_path
      else
        flash.now[:warning] = 'There were problems when trying to update this page'
        render :action => :show
      end
    end
    
    def destroy
      @page = Page.find params[:id]
      @page.destroy
      flash[:notice] = 'Page has been deleted'
      redirect_to bolt_pages_path
    end
    
    
  def destroy_multiple
     ids= params[:id]
     idarr=ids.split(',')
     idarr.each do |del|
      #@page = Page.find(del)
      total_rows=Page.find(:all, :conditions => { :id => del}).count
      if(total_rows > 0)
       Page.destroy(del)
      end
    end
    respond_to do |format|
      format.html { redirect_to :action =>"index"  }
      # format.json { head :ok }
    end
   end
    
  end
end
