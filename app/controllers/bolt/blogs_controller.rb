module Bolt
  class BlogsController < Bolt::BoltController
  
    ## optional filters for defining usage according to Bolt::Users access_levels
    # before_filter :needs_admin, :except => [:action1, :action2]
    # before_filter :needs_admin_or_current_user, :only => [:action1, :action2]
  
    def index

    sortcolumn=(params[:sort]==nil)? ' ' : params[:sort]  
    @bolt_blogs = Blog.find(:all)
    @bolt_page_title = 'Blogs'
    @blogs = Blog.paginate(:page => params[:page], :order => sortcolumn)
     
    end
  
    def show
      @bolt_blog = Blog.find(params[:id])
      @bolt_page_title = 'View blog'
      @blog = Blog.find params[:id]
    end

   def new
      @bolt_page_title = 'Add a new blog'
    	@blog = Blog.new
    end

    def create
      @blog = Blog.new params[:blog]
    
      if @blog.save
        flash[:notice] = 'Blog created'
        redirect_to bolt_blogs_path
      else
        flash.now[:warning] = 'Title can not be blank!'
        render :action => :new
      end
    end
  
    def update
      @bolt_page_title = 'Update blog'
      
      @blog = Blog.find params[:id]
    
      if @blog.update_attributes params[:blog]
        flash[:notice] = 'Blog has been updated'
        redirect_to bolt_blogs_path
      else
        flash.now[:warning] =  'Title can not be blank!'
        render :action => :show
      end
    end
 
    def destroy
      @blog = Blog.find params[:id]

      @blog.destroy
      flash[:notice] = 'Blog has been deleted'
      redirect_to bolt_blogs_path
    end
      def destroy
      @blog = Blog.find params[:id]

      @blog.destroy
      flash[:notice] = 'Blog has been deleted'
      redirect_to :back
    end
    def destroy_multiple
      ids= params[:id]
      idarr=ids.split(',')
      idarr.each do |del|
        @blog = Blog.find(del)
        @blog.destroy
      end
      respond_to do |format|
        format.html { redirect_to :back  }
        # format.json { head :ok }
      end
   end
  
  end
end
