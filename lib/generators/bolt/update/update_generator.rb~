module Bolt
  class UpdateGenerator < Rails::Generators::Base
    
      source_root File.expand_path('../templates', __FILE__)
      
      def generate_files
        puts "*** Updating Bolt public assets. These should not be modified as they may be overwritten in future updates. ***"

        #stylesheets
  			copy_file "public/bolt/stylesheets/screen.css", "public/bolt/stylesheets/screen.css"
  			copy_file "public/bolt/stylesheets/elements.css", "public/bolt/stylesheets/elements.css"
  			copy_file "public/bolt/stylesheets/login.css", "public/bolt/stylesheets/login.css"
			copy_file "public/bolt/stylesheets/bubble.css", "public/bolt/stylesheets/bubble.css"
copy_file "public/bolt/stylesheets/custom.css", "public/bolt/stylesheets/custom.css"
copy_file "public/bolt/stylesheets/depot.css", "public/bolt/stylesheets/depot.css"
copy_file "public/bolt/stylesheets/dropdown.css", "public/bolt/stylesheets/dropdown.css"
copy_file "public/bolt/stylesheets/jquery_treeview.css", "public/bolt/stylesheets/jquery_treeview.css"
copy_file "public/bolt/stylesheets/mediamanager.css", "public/bolt/stylesheets/mediamanager.css"
copy_file "public/bolt/stylesheets/scaffolds.css", "public/bolt/stylesheets/scaffolds.css"
copy_file "public/bolt/stylesheets/ui_dynatree.css", "public/bolt/stylesheets/ui_dynatree.css"
copy_file "public/bolt/stylesheets/users_style.css", "public/bolt/stylesheets/users_style.css"

  			#javascripts
  			copy_file "public/bolt/javascripts/bolt.js", "public/bolt/javascripts/bolt.js"
  			copy_file "public/bolt/javascripts/login.js", "public/bolt/javascripts/login.js"
  			copy_file "public/bolt/javascripts/jquery.js", "public/bolt/javascripts/jquery.js"
  			copy_file "public/bolt/javascripts/rails.js", "public/bolt/javascripts/rails.js"

        #images
        copy_file "public/bolt/images/header.png", "public/bolt/images/header.png"
        copy_file "public/bolt/images/nav.png", "public/bolt/images/nav.png"
        copy_file "public/bolt/images/rightNav.png", "public/bolt/images/rightNav.png"
        copy_file "public/bolt/images/rightNavButton.png", "public/bolt/images/rightNavButton.png"
        copy_file "public/bolt/images/bolt.png", "public/bolt/images/bolt.png"
        copy_file "public/bolt/images/visitSiteNav.png", "public/bolt/images/visitSiteNav.png"
  			copy_file "public/bolt/images/login/top.png", "public/bolt/images/login/top.png"
  		  copy_file "public/bolt/images/login/bottom.png", "public/bolt/images/login/bottom.png"

  			#icons
  			all_icons = Dir.new(File.expand_path('../templates/public/bolt/images/icons/', __FILE__)).entries

  			for icon in all_icons
  				if File.extname(icon) == ".png"
  					copy_file "public/bolt/images/icons/#{icon}", "public/bolt/images/icons/#{icon}"
  				end
  			end
  		end
  end
end
