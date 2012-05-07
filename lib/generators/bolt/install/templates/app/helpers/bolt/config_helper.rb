module Bolt
  module ConfigHelper
    
  	# Text string containing the name of the website or client
  	# Used in text and titles throughout Bolt
    def bolt_config_website_name
    	'Bolt'
    end

  	# URL to the logo used for the login screen and top banner - it should be a transparent PNG
    def bolt_config_logo
    	'/bolt/images/bolt.png'
    end

  	# The server hostname where Bolt will run
    def bolt_config_hostname
      if ENV['RAILS_ENV'] == 'production'
        'http://www.caseincms.com'
      else
        'http://localhost:3000'
      end
    end

  	# The sender email address used for notifications
  	def bolt_config_email_from_address
  		'donotreply@caseincms.com'
  	end
	
  	# The page that the user is shown when they login or click the logo
  	# do not point this at bolt/index!
  	def bolt_config_dashboard_url
  		url_for :controller => :bolt, :action => :blank
  	end
	
  	# A list of stylesheet files to include in the page head section
  	def bolt_config_stylesheet_includes
  		%w[/bolt/stylesheets/custom /bolt/stylesheets/screen /bolt/stylesheets/elements]
  	end
	
  	# A list of JavaScript files to include in the page head section
  	def bolt_config_javascript_includes
  	  %w[/bolt/javascripts/jquery /bolt/javascripts/custom /bolt/javascripts/bolt /bolt/javascripts/rails]
  	end
  	
  end
end
