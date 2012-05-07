module Bolt
  class UserSessionsController < Bolt::BoltController
    
    unloadable
    
    skip_before_filter :authorise, :only => [:new, :create]
    before_filter :requires_no_session_user, :except => [:destroy]
  
    layout 'bolt_auth'
  
    def new
      @user_session = Bolt::UserSession.new
    end
  
    def create
      @user_session = Bolt::UserSession.new params[:bolt_user_session]
      if @user_session.save
        flash[:notice] = "Login successful"
        redirect_back_or_default :controller => :dashboard, :action => :index
      else
        render :action => :new
      end
    end
  
    def destroy
      current_user_session.destroy
      flash[:notice] = "Logout successful"
      redirect_back_or_default new_bolt_user_session_url
    end

  private
  
    def requires_no_session_user
      if current_user
        redirect_to :controller => :bolt, :action => :index
      end
    end

  end
end