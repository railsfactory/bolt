module Bolt
  class StatusesController < Bolt::BoltController
  
    ## optional filters for defining usage according to Bolt::Users access_levels
    # before_filter :needs_admin, :except => [:action1, :action2]
    # before_filter :needs_admin_or_current_user, :only => [:action1, :action2]
  
    def index
      @bolt_page_title = 'Statuses'
  		@statuses = Status.paginate :page => params[:page]
    end
  
    def show
      @bolt_page_title = 'View status'
      @status = Status.find params[:id]
    end
 
    def new
      @bolt_page_title = 'Add a new status'
    	@status = Status.new
    end

    def create
      @status = Status.new params[:status]
    
      if @status.save
        flash[:notice] = 'Status created'
        redirect_to bolt_statuses_path
      else
        flash.now[:warning] = 'Name can not be blank'
        render :action => :new
      end
    end
  
    def update
      @bolt_page_title = 'Update status'
      
      @status = Status.find params[:id]
    
      if @status.update_attributes params[:status]
        flash[:notice] = 'Status has been updated'
        redirect_to bolt_statuses_path
      else
        flash.now[:warning] = 'Name can not be blank'
        render :action => :show
      end
    end
 
    def destroy
      @status = Status.find params[:id]

      @status.destroy
      flash[:notice] = 'Status has been deleted'
      redirect_to bolt_statuses_path
    end
    
    def destroy_multiple
      ids= params[:id]
      idarr=ids.split(',')
      idarr.each do |del|
        @blog = Status.find(del)
        @blog.destroy
      end
      respond_to do |format|
        format.html { redirect_to :back  }
        # format.json { head :ok }
      end
   end
      
  
  end
end
