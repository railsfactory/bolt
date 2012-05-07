module Bolt
  class UserStatusesController < Bolt::BoltController
  
    ## optional filters for defining usage according to Bolt::Users access_levels
    # before_filter :needs_admin, :except => [:action1, :action2]
    # before_filter :needs_admin_or_current_user, :only => [:action1, :action2]
  
    def index
      @bolt_page_title = 'User statuses'
  		@user_statuses = UserStatus.paginate :page => params[:page]
    end
  
    def show
      @bolt_page_title = 'View user status'
      @user_status = UserStatus.find params[:id]
    end
 
    def new
      @bolt_page_title = 'Add a new user status'
    	@user_status = UserStatus.new
    end

    def create
      @user_status = UserStatus.new params[:user_status]
    
      if @user_status.save
        flash[:notice] = 'User status created'
        redirect_to bolt_user_statuses_path
      else
        flash.now[:warning] = 'There were problems when trying to create a new user status'
        render :action => :new
      end
    end
  
    def update
      @bolt_page_title = 'Update user status'
      
      @user_status = UserStatus.find params[:id]
    
      if @user_status.update_attributes params[:user_status]
        flash[:notice] = 'User status has been updated'
        redirect_to bolt_user_statuses_path
      else
        flash.now[:warning] = 'There were problems when trying to update this user status'
        render :action => :show
      end
    end
 
    def destroy
      @user_status = UserStatus.find params[:id]

      @user_status.destroy
      flash[:notice] = 'User status has been deleted'
      redirect_to bolt_user_statuses_path
    end
  
  end
end
