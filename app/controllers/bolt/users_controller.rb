module Bolt
  class UsersController < Bolt::BoltController
    # GET /bolt/users
    # GET /bolt/users.json
    def index
      sortcolumn=(params[:sort]==nil)? 'name' : params[:sort]  
      @bolt_users = Bolt::User.find(:all, :order => sortcolumn)
      respond_to do |format|
        format.html # index.html.erb
        format.json { render :json => @bolt_users }
      end
    end

    # GET /bolt/users/1
    # GET /bolt/users/1.json
    

    # GET /bolt/users/new
    # GET /bolt/users/new.json
    def new
      @bolt_user = Bolt::User.new
      
      @groups = Group.all
      
      respond_to do |format|
        format.html # new.html.erb
        format.json { render :json => @bolt_users }
      end
    end

    def show 
      @bolt_user = Bolt::User.find(params[:id])
      @u_groups = @bolt_user.groups.collect{|g| g.id}
      @groups = Group.all      
    end

    # GET /bolt/users/1/edit
    def edit
      @bolt_user = Bolt::User.find(params[:id])
      
    end

    # POST /bolt/users
    # POST /bolt/users.json
    def create
      @bolt_user = Bolt::User.new(params[:bolt_user])
      
      respond_to do |format|
        if @bolt_user.save
	  flash[:success] = 'User was successfully created.'
          format.html { redirect_to :action=>'index'}
          format.json { render :json => @bolt_users, :status => "created", :location => @bolt_user }
        else
	  @groups = Group.all	
          format.html { render :action => "new" }
          format.json { render :json => @bolt_user.errors, :status => :unprocessable_entity}
        end
      end
    end

    # PUT /bolt/users/1
    # PUT /bolt/users/1.json
    def update
      @bolt_user = Bolt::User.find(params[:id])

      respond_to do |format|
        if @bolt_user.update_attributes(params[:bolt_user])
  	  flash[:success] = 'User was successfully updated.'
          format.html { redirect_to :action=>'index' }
          format.json { head :no_content }
        else
          format.html { render :action => "show" }
          format.json { render :json => @bolt_user.errors, :status => :unprocessable_entity }
        end
      end
    end

    # DELETE /bolt/users/1
    # DELETE /bolt/users/1.json
    def destroy
      @bolt_user = Bolt::User.find(params[:id])
      @bolt_user.destroy

      respond_to do |format|
        format.html { redirect_to bolt_users_url }
        format.json { head :no_content }
      end
    end
    
    def destroy_multiple
      ids= params[:id]
      idarr=ids.split(',')
      idarr.each do |del|
        @bolt_user = User.find(del)
        @bolt_user.destroy
      end
      respond_to do |format|
        format.html { redirect_to :back  }
       # format.json { head :ok }
      end
    end
   end
  end
