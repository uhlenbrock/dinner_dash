class User < ActiveRecord::Base

  # -------------------------------------- Plugins
  
  has_secure_password
  
  # -------------------------------------- Associations
  
  has_many :orders
  
  # -------------------------------------- Validations
  
  validates_presence_of :name, :email
  validates_uniqueness_of :email, case_sensitive: false
  
end
