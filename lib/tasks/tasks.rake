require 'authlogic'

namespace :bolt do

    desc "Create default admin user"
    task :create_admin => :environment do
    
      raise "Usage: specify email address, e.g. rake [task] email=mail@boltcms.com" unless ENV.include?("email")
  		    
      admin = Bolt::User.new( {:login => 'admin', :name => 'Admin', :email => ENV['email'], :access_level => $BOLT_USER_ACCESS_LEVEL_ADMIN, :password => 'password', :password_confirmation => 'password'} )
	admin.users_groups.build(:group_id => 6)
      
      unless admin.save
	admin.errors
        puts "[Bolt] Failed: check that the 'admin' account doesn't already exist."
      else
        puts "[Bolt] Created new admin user with login 'admin' and password 'password'"
      end      
    end

    desc "Remove all users"
    task :remove_all => :environment do
      users = Bolt::User.find(:all)
      num_users = users.size
      users.each { |user| user.destroy }
      puts "[Bolt] Removed #{num_users} user(s)"      
    end

end
