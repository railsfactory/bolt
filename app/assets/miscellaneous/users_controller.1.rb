module Casein
  class UsersController < Casein::CaseinController
    layout :change_layout
    before_filter :authorise
    before_filter :find_student_user, :only=>[:index]
    #before_filter :find_super_user
    #unloadable
    
    #~ before_filter :needs_admin, :except => [:show, :destroy, :update, :update_password]
    #~ before_filter :needs_admin_or_current_user, :only => [:show, :destroy, :update, :update_password]
 
    def index
      @casein_page_title = "Users"
      params[:type] = 'all' if params[:type].blank?
      @organization = current_user.organization
      @users = Casein::User.find_users_roles(@organization.id, params[:type]).paginate :page => params[:page], :per_page =>10
    end
 
    def new
      @casein_page_title = "Add a new user"
    	@casein_user = Casein::User.new
      @organization = current_user.organization
    	@casein_user.time_zone = Rails.configuration.time_zone
			@photo = Photo.new
      @student_info = StudentInfo.new
      calulate_for_common_objects
    end
  
    def create
      @organization = current_user.organization
      @casein_user = Casein::User.new params[:casein_user]
      calulate_for_common_objects
      @student_info = StudentInfo.new params[:casein_user][:student_info]  if params[:type] == "student" || params[:type].blank?
      @photo = Photo.new params[:photo]
      if @casein_user.valid?
        @organization.users << @casein_user
        if @student_info && @student_info.valid?
          @casein_user.student_info = @student_info 
          @casein_user.add_roles(:student)
        else
          if params[:admin]
            @casein_user.add_roles(params[:type].to_sym, :admin)
          else
            @casein_user.add_roles(params[:type].to_sym) 
          end
        end
        @casein_user.photo = @photo if @photo.valid?
        create_record_in_students
        flash[:notice] = "An email has been sent to " + @casein_user.first_name + " with the new account details"
        redirect_to casein_organization_users_path(@organization)
      else
        flash.now[:warning] = "There were problems when trying to create a new user"
        render :action => :new
      end
    end
  
    def edit
      @casein_page_title = "Add a new user"
    	@casein_user = (current_user.is_admin?) ? (Casein::User.find params[:id]) : ( (current_user.is_learning_coach? || current_user.is_life_coach? || current_user.is_parent? || current_user.is_sponsors?|| current_user.is_therapist?) ? current_user.students.where(:id => params[:id]).first || current_user : current_user ) 
      @organization = current_user.organization
    	#@casein_user.time_zone = Rails.configuration.time_zone
			@photo = Photo.new
      @student_info = @casein_user.student_info if @casein_user.student_info
      calulate_for_common_objects
      # @organization = Organization.find params[:organization_id]
    	params[:life_coaches_user] = {:id=>@life_coaches.length > 0 ? @life_coaches.first.id : 0}
    	params[:learn_coaches_user] = {:id=>@learn_coaches.length > 0 ? @learn_coaches.first.id : 0}
    	params[:sponsors_user] = {:id=>@sponsors.length > 0 ? @sponsors.first.id : 0}
    	params[:therapists_user] = {:id=>@therapists.length > 0 ? @therapists.first.id : 0}
    	params[:first_parents_user] = {:id=>@parents.length > 0 ? @parents.first.id : 0}
    	params[:second_parents_user] = {:id=>@parents.length > 1 ? @parents.last.id : 0}
      @state = @casein_user.state
      @emp_state = @casein_user.student_info.emp_state if @casein_user.student_info
      #render 'my_profile' if !current_user.is_admin? && params && params[:d]=="view"
    end
 
 def show #added later on 23rd.
       @organization = Organization.find_by_id(params[:organization_id])
       @user = Casein::User.where(:id =>params[:id], :organization_id => @organization.id).first
  end
 
    def update
      @organization = current_user.organization
      @casein_user = (current_user.is_admin?) ? (Casein::User.find params[:id]) : ( (current_user.is_learning_coach? || current_user.is_life_coach? || current_user.is_parent? || current_user.is_sponsors? || current_user.is_therapist? ) ? current_user.students.where(:id => params[:id]).first || current_user : current_user ) 
      #@casein_page_title = @casein_user.name + " | Update User"
      @student_info = @casein_user.student_info
      @photo = Photo.new params[:photo]
      calulate_for_common_objects
      if @casein_user.update_attributes params[:casein_user]
        @student_info.update_attributes params[:casein_user][:student_info] if @casein_user.student_info
        @casein_user.photo = @photo if @photo.valid?
        therapists_users = TherapistsUser.destroy_all("user_id = #{@casein_user.id}")
        sponsors_users = SponsorsUser.destroy_all("user_id = #{@casein_user.id}")
        life_coach_users = LifeCoachesUser.destroy_all("user_id = #{@casein_user.id}")
        parents_users = ParentsUser.destroy_all("user_id = #{@casein_user.id}")
        students_users = StudentsUser.destroy_all("user_id = #{@casein_user.id}")
        create_record_in_students
        flash[:notice] = @casein_user.first_name + " has been updated"
      else
        flash.now[:warning] = "There were problems when trying to update this user"
        render :action => :edit
        return
      end
      
      if @session_user.is_super_user?
        redirect_to casein_organization_user_path(@organization,current_user,:type => current_user.roles.first)  
      elsif @session_user.is_admin?
        redirect_to casein_organization_users_path(@organization)
        elsif current_user.is_learning_coach?
          puts"I am here in student section learning coach"
          redirect_to  otheruser_profile_casein_organization_users_path(@organization)
       elsif current_user.is_life_coach?
          puts"I am here in student section life coach"
          redirect_to  otheruser_profile_casein_organization_users_path(@organization) 
      elsif current_user.is_parent?
          puts"I am here in student section life coach"
          redirect_to  otheruser_profile_casein_organization_users_path(@organization) 
      elsif current_user.is_sponsors?
          puts"I am here in student section life coach"
          redirect_to  otheruser_profile_casein_organization_users_path(@organization)     
      elsif current_user.is_therapist?
          puts"I am here in student section life coach"
          redirect_to  otheruser_profile_casein_organization_users_path(@organization)     
      else
        puts"I am here in else section"
        redirect_to casein_organization_user_path(@organization,current_user, :type => current_user.roles.first.to_s, :d => 'view')
      end
    end
 
    def update_password
      @casein_user = Casein::User.find params[:id]
      @casein_page_title = @casein_user.first_name + " | Update Password"
       
      if @casein_user.valid_password? params[:form_current_password]
        if @casein_user.update_attributes params[:casein_user]
          flash.now[:notice] = "Your password has been changed"
        else
          flash.now[:warning] = "There were problems when trying to change the password"
        end
      else
        flash.now[:warning] = "The current password is incorrect"
      end
      
      render :action => :show
    end
 
    def reset_password
      @casein_user = Casein::User.find params[:id]
      @casein_page_title = @casein_user.first_name + " | Reset Password"
       
      @casein_user.notify_of_new_password = true unless @casein_user.id == @session_user.id
      
      if @casein_user.update_attributes params[:casein_user]
        if @casein_user.id == @session_user.id
          flash.now[:notice] = "Your password has been reset"
        else    
          flash.now[:notice] = "Password has been reset and " + @casein_user.first_name + " has been notified by email"
        end
        
      else
        flash.now[:warning] = "There were problems when trying to reset this user's password"
      end
      render :action => :show
    end
 
    def destroy
      user = Casein::User.find params[:id]
      if user.is_admin? == false || Casein::User.has_more_than_one_admin
        user.destroy
        flash[:notice] = user.first_name + " has been deleted"
      end
      redirect_to casein_users_path
    end
    
    def generate_random_password
      alphanumerics = [('0'..'9'),('a'..'z')].map {|range| range.to_a}.flatten
      rand=(0...7).map { alphanumerics[Kernel.rand(alphanumerics.size)] }.join
      @password=rand
    end
 
    def change_layout
      if params[:action] == "index"
        'admin_list_users'
      else
        'admin_create_account' 
      end 
    end
    
  def create_record_in_users
    @casein_user = Casein::User.new params[:casein_user]
    @casein_user.add_roles(params[:type].to_sym)
    
  end
  
  def create_record_in_students
    unless params[:stud].blank?
      params[:stud].each do |key,value|
        @students_user= StudentsUser.create(:user_id => @casein_user.id, :student_id => value.to_i)
      end
    end   
    TherapistsUser.create(:user_id => @casein_user.id, :therapist_id => params[:therapists_user][:id].to_i) if params[:therapists_user] && !params[:therapists_user][:id].blank?
    LearnCoachesUser.create(:user_id => @casein_user.id, :learn_coach_id => params[:learn_coaches_user][:id].to_i) if params[:learn_coaches_user] && !params[:learn_coaches_user][:id].blank?
    SponsorsUser.create(:user_id => @casein_user.id, :sponsor_id => params[:sponsors_user][:id].to_i) if params[:sponsors_user] && !params[:sponsors_user][:id].blank?
    LifeCoachesUser.create(:user_id => @casein_user.id, :life_coach_id => params[:life_coaches_user][:id].to_i) if params[:life_coaches_user] && !params[:life_coaches_user][:id].blank?
    ParentsUser.create(:user_id => @casein_user.id, :parent_id => params[:first_parents_user][:id].to_i) if params[:first_parents_user] && !params[:first_parents_user][:id].blank?
    ParentsUser.create(:user_id => @casein_user.id, :parent_id => params[:second_parents_user][:id].to_i) if params[:second_parents_user] && !params[:second_parents_user][:id].blank?
  end
  
  def calulate_for_common_objects
    @students = Casein::User.find_users_roles(@organization.id, :student)
    @learn_coaches = Casein::User.find_users_roles(@organization.id, :learning_coach)
    @life_coaches = Casein::User.find_users_roles(@organization.id, :life_coach)
    @sponsors = Casein::User.find_users_roles(@organization.id, :sponsors)
    @parents = Casein::User.find_users_roles(@organization.id, :parent)
    @therapists = Casein::User.find_users_roles(@organization.id, :therapist)
    @state = params[:casein_user] ? params[:casein_user][:state] : ""
    @emp_state = params[:casein_user] && params[:casein_user][:student_info] ? params[:casein_user][:student_info][:emp_state] : ""
  end

  def fetch_users
    @users = Casein::User.where("first_name like ? and organization_id=?", "%#{params[:term]}%", current_user.organization_id)
    @us = []
    @users.map{|u| @us << {:value => (u.id == current_user.id)? "#{u.first_name}(ME)" : u.first_name, :id => u.id}}
    render :json => @us
  end
  
 def otheruser_profile
   puts "############################################"
  @organization=Organization.find(params[:organization_id])
  @students = Casein::User.find_users_roles(@organization.id, :student)
  @my_students = current_user.students.collect(&:id)
   @other_students =Casein::User.where("id NOT IN (?) && roles_mask=?",@my_students,32)
  #puts @organization.inspect
  #@user = Casein::User.where(:id =>params[:id], :organization_id =>current_user.organization_id).first
    end
  end
end
