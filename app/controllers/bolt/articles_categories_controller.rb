module Bolt
  class ArticlesCategoriesController < Bolt::BoltController
  
    ## optional filters for defining usage according to Bolt::Users access_levels
    # before_filter :needs_admin, :except => [:action1, :action2]
    # before_filter :needs_admin_or_current_user, :only => [:action1, :action2]
  
    def index
      @bolt_page_title = 'Articles categories'
  		@articles_categories = ArticlesCategory.paginate :page => params[:page]
    end
                                    
    def show
      @bolt_page_title = 'View articles category'
      @articles_category = ArticlesCategory.find params[:id]
    end
 
    def new
      @bolt_page_title = 'Add a new articles category'
    	@articles_category = ArticlesCategory.new
    end

    def create
      @articles_category = ArticlesCategory.new params[:articles_category]
    
      if @articles_category.save
        flash[:notice] = 'Articles category created'
        redirect_to bolt_articles_categories_path
      else
        flash.now[:warning] = 'There were problems when trying to create a new articles category'
        render :action => :new
      end
    end
  
    def update
      @bolt_page_title = 'Update articles category'
      
      @articles_category = ArticlesCategory.find params[:id]
    
      if @articles_category.update_attributes params[:articles_category]
        flash[:notice] = 'Articles category has been updated'
        redirect_to bolt_articles_categories_path
      else
        flash.now[:warning] = 'There were problems when trying to update this articles category'
        render :action => :show
      end
    end
 
    def destroy
      @articles_category = ArticlesCategory.find params[:id]

      @articles_category.destroy
      flash[:notice] = 'Articles category has been deleted'
      redirect_to bolt_articles_categories_path
    end
   def destroy_multiple
      ids= params[:id]
      idarr=ids.split(',')
      idarr.each do |del|
        @blog = ArticlesCategory.find(del)
        @blog.destroy
      end
      respond_to do |format|
        format.html { redirect_to :back  }
        # format.json { head :ok }
      end
   end
  
  
  end
end
