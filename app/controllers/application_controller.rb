class ApplicationController < ActionController::Base
  protect_from_forgery
  private 
  def is_admin?
    true 
  end
end
