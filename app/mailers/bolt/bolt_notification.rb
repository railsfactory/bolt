module Bolt
  
  class BoltNotification < ActionMailer::Base
	
  	self.prepend_view_path File.join(File.dirname(__FILE__), '..', 'views', 'bolt')
	
  	def generate_new_password from, bolt_user, host, pass
  		@name = bolt_user.name
  		@host = host
  		@login = bolt_user.login
  		@pass = pass
  		@from_text = bolt_config_website_name
  		
  		mail(:to => bolt_user.email, :from => from, :subject => "[#{bolt_config_website_name}] New password")
  	end
  
  	def new_user_information from, bolt_user, host, pass
      @name = bolt_user.name
  		@host = host
  		@login = bolt_user.login
  		@pass = pass
  		@from_text = bolt_config_website_name
  		
  		mail(:to => bolt_user.email, :from => from, :subject => "[#{bolt_config_website_name}] New user account")
  	end
  	
  	def password_reset_instructions from, bolt_user, host
  	  ActionMailer::Base.default_url_options[:host] = host.gsub("http://", "")
      @name = bolt_user.name
      @host = host
      @login = bolt_user.login
      @reset_password_url = edit_bolt_password_reset_url + "/?token=#{bolt_user.perishable_token}"
      @from_text = bolt_config_website_name

      mail(:to => bolt_user.email, :from => from, :subject => "[#{bolt_config_website_name}] Password reset instructions")
    end

  end
end
