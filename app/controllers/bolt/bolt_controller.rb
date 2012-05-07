require 'authlogic'

module Bolt
  class BoltController < ApplicationController

    unloadable

    require 'bolt/bolt_helper'
    include Bolt::BoltHelper

    require 'bolt/config_helper'
    include Bolt::ConfigHelper
    include Paperclip::Storage::S3    

    layout 'bolt_main'
    
    helper_method :current_user_session, :current_user
    
    #Authorize the user for all his actions except on new and create actions of users controller as users can be created without having to login 
    before_filter :authorise, :if => Proc.new{|controller| controller_name != "info"}
    

    #Check if the device is valid for all the api requests
    before_filter :is_device_valid?, :if => Proc.new {|c|
      request.format == Mime::JSON
    }

    before_filter :set_time_zone
    #before_filter :is_permitted?
    
    ActionView::Base.field_error_proc = proc { |input, instance| "<span class='formError'>#{input}</span>".html_safe }

    def index		
      redirect_to bolt_config_dashboard_url
    end
    
    def blank
      @bolt_page_title = "Welcome"
    end
    
    private

    def connect_to_s3
      AWS::S3::Base.establish_connection!(parse_credentials(YAML.load("#{Rails.root}/config/s3.yml")))
    end

    def redirect_to_https        
      redirect_to :protocol => "https://" unless request.ssl?
      return true
    end
    
    def authorise
      unless current_user   
        respond_to do |format|
          format.html {
            session[:return_to] = request.fullpath
            redirect_to new_bolt_user_session_url
            return false
          }
          
          format.json {  
            return render :json => {:success => false, :responsecode => 1, :message => "Please log in to access the requested resource."} 
          }
        end
      end
    end
    
    def set_time_zone
      Time.zone = current_user.time_zone if current_user
    end
    
    def current_user_session
      return @current_user_session if defined?(@current_user_session)
      @current_user_session = Bolt::UserSession.find
    end

    def current_user
      return @session_user if defined?(@session_user)
      @session_user = current_user_session && current_user_session.user
    end
    
    def needs_admin
      unless @session_user.is_admin?
        respond_to do |format|
          format.html {
            redirect_to :controller => :bolt, :action => :index
          }
          format.json {
            render :json => {:success => false, :response_code => 1, :messsage => "You are not authorized."}
          }
        end
        else
          redirect_to new_bolt_user_session_url
        end
      end
    
    def needs_admin_or_current_user
      unless @session_user.is_admin? || params[:id].to_i == @session_user.id
        respond_to do |format|
          format.html {
            redirect_to :controller => :bolt, :action => :index
          }
          format.json {
            render :json => {:success => false, :response_code => 1, :messsage => "You are not authorized."}
          }
          
        end
      end
    end
    
    def redirect_back_or_default(default)
      redirect_to(session[:return_to] || default)
      session[:return_to] = nil
    end

    #Used only for api requests. If the device is invalid it should render json with an appropriate message.
    def is_device_valid?
      success = true
      error_message = ""
      current_device = Device.find_by_udid(params[:udid])
      devices = Device.where(:udid => params[:udid])
      if current_device 
        if current_device.disabled
          error_message = "Your device has been disabled. Please contact support."
          success = false
        end
      elsif(!Util.none(devices))
        error_message = "Your device is not registered."
        success = false
      end

      if(!success)
        return render :status => 200, :json => "{\"responsecode\": 1, \"responseMessage\": \"#{error_message}\"}"
      end
    end
 
    def process_device(devices, udid)
      is_current_device_owned = false
      if(!current_user.nil?)
        if(Util.none(current_user.devices))          
          current_user.devices.each do |device|
            is_current_device_owned = true if(udid == device.udid)
            return true if(is_current_device_owned)
          end
          if(current_user.devices.size >= $MAX_DEVICES_PER_USER && !is_current_device_owned)
                      
            render :json => {:success => false, :responsecode => 1, :message => "You have exceeded the maximum number of devices you can log in from. Please select one of the devices you currently own." }
            return false
          end
        end
        if(!is_current_device_owned)          
          unassociated_device = nil
          device_associated_with_other_user = nil
          if(Util.none(devices))
            devices.each do |device|
              unassociated_device = device if(device.user_id.nil?)
              device_associated_with_other_user = device if(!device.user_id.nil? && device.user_id != current_user.id)
            end
          end

          if(!unassociated_device.nil?)
            unassociated_device.user_id = current_user.id
            unassociated_device.save
            return true
          elsif(!device_associated_with_other_user.nil?)
            new_device = device_associated_with_other_user.dup
            new_device.user_id = current_user.id
            new_device.save()
            return true
          else
            render :status => 200, :json => "{\"responsecode\": 1, \"responseMessage\": \"No devices found\"}"
            return false
          end 
        end
      else
        if(!Util.none(device))
          render :status => 200, :json => "{\"responsecode\": 1, \"responseMessage\": \"No devices found\"}"
          return false
        end
      end
      return true
    end
    
    def is_permitted?
      unless current_user.nil?
        if(!current_user.is_admin?)
          if(current_user.is_ignored?)
            render(:text => "You cant access this resource.")
            return
          end
          if(request.format == Mime::JSON)
            if(current_user.access_level != $BOLT_USER_ACCESS_LEVEL_TO_API_AND_CMS && current_user.access_level != $BOLT_USER_ACCESS_LEVEL_TO_API)
              render :text => "Permission denied"
            end 
          elsif(request.format == Mime::HTML) 
            if(current_user.access_level != $BOLT_USER_ACCESS_LEVEL_TO_API_AND_CMS && current_user.access_level != $BOLT_USER_ACCESS_LEVEL_TO_CMS)
              render :text => "Permission denied"
            end
          end 
        end
      end
    end
    
  def create_directory(dirname)   
    Dir.mkdir(dirname)
  end
  
  def remove_directory(dirname)
    if(Dir["#{dirname}/*"].empty?)     
     Dir.rmdir("#{dirname}")
    else     
     FileUtils.rm_rf("#{dirname}/.")
     Dir.delete("#{dirname}")
    end   
  end
  
  def remove_file(file_path)
    if(File.exist?(file_path))     
     File.unlink(file_path)  
    end
  end

  helper_method :format_url_id
    def format_url_id(id)
      id.gsub(" ", "-")
    end

    def deformat_url_id(id)
      id.gsub("-", " ")
    end
  
  
  end
end
