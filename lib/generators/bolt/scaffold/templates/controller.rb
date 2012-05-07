module Bolt
  class <%= class_name.pluralize %>Controller < Bolt::BoltController
  
    ## optional filters for defining usage according to Bolt::Users access_levels
    # before_filter :needs_admin, :except => [:action1, :action2]
    # before_filter :needs_admin_or_current_user, :only => [:action1, :action2]
  
    def index
      @bolt_page_title = '<%= plural_name.humanize.capitalize %>'
  		@<%= plural_name %> = <%= class_name %>.paginate :page => params[:page]
    end
  
    def show
      @bolt_page_title = 'View <%= singular_name.humanize.downcase %>'
      @<%= singular_name %> = <%= class_name %>.find params[:id]
    end
 
    def new
      @bolt_page_title = 'Add a new <%= singular_name.humanize.downcase %>'
    	@<%= singular_name %> = <%= class_name %>.new
    end

    def create
      @<%= singular_name %> = <%= class_name %>.new params[:<%= singular_name %>]
    
      if @<%= singular_name %>.save
        flash[:notice] = '<%= singular_name.humanize.capitalize %> created'
        redirect_to bolt_<%= @plural_route %>_path
      else
        flash.now[:warning] = 'There were problems when trying to create a new <%= singular_name.humanize.downcase %>'
        render :action => :new
      end
    end
  
    def update
      @bolt_page_title = 'Update <%= singular_name.humanize.downcase %>'
      
      @<%= singular_name %> = <%= class_name %>.find params[:id]
    
      if @<%= singular_name %>.update_attributes params[:<%= singular_name %>]
        flash[:notice] = '<%= singular_name.humanize.capitalize %> has been updated'
        redirect_to bolt_<%= @plural_route %>_path
      else
        flash.now[:warning] = 'There were problems when trying to update this <%= singular_name.humanize.downcase %>'
        render :action => :show
      end
    end
 
    def destroy
      @<%= singular_name %> = <%= class_name %>.find params[:id]

      @<%= singular_name %>.destroy
      flash[:notice] = '<%= singular_name.humanize.capitalize %> has been deleted'
      redirect_to bolt_<%= @plural_route %>_path
    end
  
  end
end
