require "bolt"
require "will_paginate"
require "ancestry"
require "acts_as_trashable"
require "authlogic"
require "paperclip"
require "aws-sdk"
require "rails"

module Bolt
  class Engine < Rails::Engine    
    rake_tasks do      
      load "railties/tasks.rake"
    end
    
  end
  
  class RouteConstraint
     def matches?(request)
       return false if request.fullpath.include?("/bolt")
       return false if request.fullpath.include?("/admin")
       true
     end

   end
end
