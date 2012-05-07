module Bolt
  class CategoriesController < Bolt::BoltController
  
    ## optional filters for defining usage according to Bolt::Users access_levels
    # before_filter :needs_admin, :except => [:action1, :action2]
    # before_filter :needs_admin_or_current_user, :only => [:action1, :action2]
  
    def index               
      @bolt_page_title = 'Categories'
  		@categories = Category.paginate :page => params[:page]
    end
  
    def show
      @bolt_page_title = 'View category'
      @category = Category.find params[:id]
    end
 
    def new
      @bolt_page_title = 'Add a new category'
    	@category = Category.new
    end

    def create
      @category = Category.new params[:category]
    
      if @category.save
        flash[:notice] = 'Category created'
        redirect_to bolt_categories_path
      else
        flash.now[:warning] = 'There were problems when trying to create a new category'
        render :action => :new
      end
    end
  
    def update
      @bolt_page_title = 'Update category'
      
      @category = Category.find params[:id]
    
      if @category.update_attributes params[:category]
        flash[:notice] = 'Category has been updated'
        redirect_to bolt_categories_path
      else
        flash.now[:warning] = 'There were problems when trying to update this category'
        render :action => :show
      end
    end
 
    def destroy
      @category = Category.find params[:id]

      @category.destroy
      flash[:notice] = 'Category has been deleted'
      redirect_to bolt_categories_path
    end
    
    def destroy_multiple
     ids= params[:id]
     idarr=ids.split(',')
     idarr.each do |del|
      @category = Category.find(del)
      @category.destroy
     end
    respond_to do |format|
      format.html { redirect_to :back  }
      # format.json { head :ok }
    end
    
  end
  
  end
end
