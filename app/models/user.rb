class User < ActiveRecord::Base
  
  # -------------------------------------- Associations
  
  has_many :orders
  
end
