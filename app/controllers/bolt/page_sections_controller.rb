module Bolt
  class PageSectionsController < Bolt::BoltController
  
    ## optional filters for defining usage according to Bolt::Users access_levels
    # before_filter :needs_admin, :except => [:action1, :action2]
    # before_filter :needs_admin_or_current_user, :only => [:action1, :action2]
  
    def index
      @bolt_page_title = 'Page sections'
  		@page_sections = PageSection.paginate :page => params[:page]
    end
  
    def show
      @bolt_page_title = 'View page section'
      @page_section = PageSection.find params[:id]
    end
 
    def new
      @bolt_page_title = 'Add a new page section'
    	@page_section = PageSection.new
    end

    def create
      @page_section = PageSection.new params[:page_section]
    
      if @page_section.save
        flash[:notice] = 'Page section created'
        redirect_to bolt_page_sections_path
      else
        flash.now[:warning] = 'There were problems when trying to create a new page section'
        render :action => :new
      end
    end
  
    def update
      @bolt_page_title = 'Update page section'
      
      @page_section = PageSection.find params[:id]
    
      if @page_section.update_attributes params[:page_section]
        flash[:notice] = 'Page section has been updated'
        redirect_to bolt_page_sections_path
      else
        flash.now[:warning] = 'There were problems when trying to update this page section'
        render :action => :show
      end
    end
 
    def destroy
      @page_section = PageSection.find params[:id]

      @page_section.destroy
      flash[:notice] = 'Page section has been deleted'
      redirect_to bolt_page_sections_path
    end
  
  end
end
