module Bolt
  class BannersController < Bolt::BoltController
  
    ## optional filters for defining usage according to Bolt::Users access_levels
    # before_filter :needs_admin, :except => [:action1, :action2]
    # before_filter :needs_admin_or_current_user, :only => [:action1, :action2]
  
    def index
      @bolt_page_title = 'Banners'
  		@banners = Banner.paginate :page => params[:page]
    end
  
    def show
      @bolt_page_title = 'View banner'
      @banner = Banner.find params[:id]
    end
 
    def new
      @bolt_page_title = 'Add a new banner'
    	@banner = Banner.new
    end

    def create
      @banner = Banner.new params[:banner]
    
      if @banner.save
        flash[:notice] = 'Banner created'
        redirect_to bolt_banners_path
      else
        flash.now[:warning] = 'There were problems when trying to create a new banner'
        render :action => :new
      end
    end
  
    def update
      @bolt_page_title = 'Update banner'
      
      @banner = Banner.find params[:id]
    
      if @banner.update_attributes params[:banner]
        flash[:notice] = 'Banner has been updated'
        redirect_to bolt_banners_path
      else
        flash.now[:warning] = 'There were problems when trying to update this banner'
        render :action => :show
      end
    end
 
    def destroy
      @banner = Banner.find params[:id]

      @banner.destroy
      flash[:notice] = 'Banner has been deleted'
      redirect_to bolt_banners_path
    end
  
  end
end
