module Bolt
  class InstallGenerator < Rails::Generators::Base
    
    include Rails::Generators::Migration
    source_root File.expand_path('../templates', __FILE__)
    
    def self.next_migration_number dirname
      orm = Rails.configuration.generators.options[:rails][:orm]
      require "rails/generators/#{orm}"
      "#{orm.to_s.camelize}::Generators::Base".constantize.next_migration_number(dirname)
    end
    
    def generate_files
      puts "*** WARNING - Generating configuration files. Make sure you have backed up any files before overwriting them. ***"
      
      #config helper
      copy_file "app/helpers/bolt/config_helper.rb", "app/helpers/bolt/config_helper.rb"
      #initial view partials
      copy_file "app/views/bolt/layouts/_left_navigation.html.erb", "app/views/bolt/layouts/_left_navigation.html.erb"
      copy_file "app/views/bolt/layouts/_right_navigation.html.erb", "app/views/bolt/layouts/_right_navigation.html.erb"
      #robots.txt
      puts " ** Overwrite if you haven't yet modified your robots.txt, otherwise add disallow rules for /bolt and /admin manually **"
      copy_file "public/robots.txt", "public/robots.txt"
      
      #blank stylesheets and JavaScript files
      copy_file "public/bolt/javascripts/application.js", "public/bolt/javascripts/application.js"
      copy_file "public/bolt/javascripts/backbone.js", "public/bolt/javascripts/backbone.js"
      copy_file "public/bolt/javascripts/jquery_dynatree.js", "public/bolt/javascripts/jquery_dynatree.js"
      copy_file "public/bolt/javascripts/custom.js", "public/bolt/javascripts/custom.js"
      copy_file "public/bolt/javascripts/javascript_functions.js", "public/bolt/javascripts/javascript_functions.js"
      copy_file "public/bolt/javascripts/media.js", "public/bolt/javascripts/media.js"
      copy_file "public/bolt/javascripts/login.js", "public/bolt/javascripts/login.js"
      copy_file "public/bolt/javascripts/jquery_new.js", "public/bolt/javascripts/jquery_new.js"
      copy_file "public/bolt/javascripts/jquery_treeview.js", "public/bolt/javascripts/jquery_treeview.js"
      copy_file "public/bolt/javascripts/jquery.js", "public/bolt/javascripts/jquery.js"
      copy_file "public/bolt/javascripts/rails.js", "public/bolt/javascripts/rails.js"
      directory 'public/bolt/jqueryui/', 'public/jqueryui/'	
      copy_file "public/bolt/stylesheets/application.css", "public/bolt/stylesheets/application.css"
      copy_file "public/bolt/stylesheets/bubble.css", "public/bolt/stylesheets/bubble.css"
      copy_file "public/bolt/stylesheets/custom.css", "public/bolt/stylesheets/custom.css"
      copy_file "public/bolt/stylesheets/depot.css", "public/bolt/stylesheets/depot.css"
      copy_file "public/bolt/stylesheets/dropdown.css", "public/bolt/stylesheets/dropdown.css"
      copy_file "public/bolt/stylesheets/mediamanager.css", "public/bolt/stylesheets/mediamanager.css"
      copy_file "public/bolt/stylesheets/login.css", "public/bolt/stylesheets/login.css"
      copy_file "public/bolt/stylesheets/jquery_treeview.css", "public/bolt/stylesheets/jquery_treeview.css"
      copy_file "public/bolt/stylesheets/elements.css", "public/bolt/stylesheets/elements.css"
      copy_file "public/bolt/stylesheets/scaffolds.css", "public/bolt/stylesheets/scaffolds.css"
      copy_file "public/bolt/stylesheets/ui_dynatree.css", "public/bolt/stylesheets/ui_dynatree.css"
      copy_file "public/bolt/stylesheets/users_style.css", "public/bolt/stylesheets/users_style.css"
      
      #Images files
      #copy_file "public/bolt/images/", "public/bolt/images/"
      all_icons = Dir.new(File.expand_path('../templates/public/bolt/images/', __FILE__)).entries

                          for icon in all_icons
                                  if(File.extname(icon) == ".png" || File.extname(icon) == ".jpg" || File.extname(icon) == ".gif" || File.extname(icon) == ".jpeg")
            puts "icon is #{icon.inspect}"
                                          copy_file "public/bolt/images/#{icon}", "public/bolt/images/#{icon}"
                                  end
                          end
      #migrations
      migration_template 'db/migrate/bolt_create_users.rb', "db/migrate/bolt_create_users.rb"
      migration_template 'db/migrate/create_groups.rb', "db/migrate/create_groups"
      migration_template 'db/migrate/create_accesses.rb', "db/migrate/create_accesses.rb"
      migration_template 'db/migrate/create_articles.rb', "db/migrate/create_articles.rb"
      migration_template 'db/migrate/create_articles_categories.rb', "db/migrate/create_articles_categories.rb"
      migration_template 'db/migrate/create_blogs.rb', "db/migrate/create_blogs.rb"
      migration_template 'db/migrate/create_categories.rb', "db/migrate/create_categories.rb"
      migration_template 'db/migrate/create_media.rb', "db/migrate/create_media.rb"
      migration_template 'db/migrate/create_media_images.rb', "db/migrate/create_media_images.rb"
      migration_template 'db/migrate/create_pages.rb', "db/migrate/create_pages.rb"
      migration_template 'db/migrate/create_page_sections.rb', "db/migrate/create_page_sections.rb"
      migration_template 'db/migrate/create_settings.rb', "db/migrate/create_settings.rb"
      migration_template 'db/migrate/create_statuses.rb', "db/migrate/create_statuses.rb"
      migration_template 'db/migrate/create_users_groups.rb', "db/migrate/create_users_groups.rb"
      migration_template 'db/migrate/create_user_statuses.rb', "db/migrate/create_user_statuses.rb"
      migration_template 'db/migrate/add_ancestry_to_page.rb', "db/migrate/add_ancestry_to_page.rb"
      migration_template 'db/migrate/change_mediaimages_column.rb', "db/migrate/change_mediaimages_column.rb"
    end  
  end
end
