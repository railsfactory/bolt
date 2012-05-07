include Bolt::ConfigHelper

$BOLT_USER_ACCESS_LEVEL_ADMIN = 0
$BOLT_USER_ACCESS_LEVEL_USER = 10
$BOLT_USER_ACCESS_LEVEL_TO_CMS = 15
$BOLT_USER_ACCESS_LEVEL_TO_API = 20
$BOLT_USER_ACCESS_LEVEL_TO_API_AND_CMS = 25
$BOLT_ACCESS_NONE = 100

module Bolt
  class User < ActiveRecord::Base
    def self.table_name
      self.to_s.gsub("::", "_").tableize
    end
    
    validates_presence_of :users_groups
   
    has_many :users_groups
    has_many :groups, :through => :users_groups, :dependent => :destroy
    accepts_nested_attributes_for :users_groups, :reject_if => proc { |attributes| attributes['group_id'].blank? || attributes['group_id'].to_i == 0}, :allow_destroy => true
    
    acts_as_authentic { |c| c.validate_email_field = false }
    
    attr_accessor :notify_of_new_password
    
        
    def self.has_more_than_one_admin
      Bolt::User.where(:access_level => $BOLT_USER_ACCESS_LEVEL_ADMIN).count > 1
    end
    
    def send_create_notification
      Bolt::BoltNotification.new_user_information(bolt_config_email_from_address, self, bolt_config_hostname, @password).deliver
    end
    
    def send_update_notification
      if notify_of_new_password
        notify_of_new_password = false
        Bolt::BoltNotification.generate_new_password(bolt_config_email_from_address, self, bolt_config_hostname, @password).deliver
      end
    end
    
    def send_password_reset_instructions
      reset_perishable_token!
      Bolt::BoltNotification.password_reset_instructions(bolt_config_email_from_address, self, bolt_config_hostname).deliver
    end
    
    def check_time_zone
      self.time_zone = Rails.configuration.time_zone unless self.time_zone
    end
    
    def is_admin?
      users_groups.include?(Group.first)
    end
    
  end
end
