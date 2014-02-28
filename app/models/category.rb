class Category < ActiveRecord::Base
  
  # -------------------------------------- Validations
  
  validates_presence_of :title
  
  # -------------------------------------- Associations
  
  has_many :items
  
end
