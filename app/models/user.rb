class User < ActiveRecord::Base

  # -------------------------------------- Plugins
  
  has_secure_password
  
  # -------------------------------------- Associations
  
  has_many :orders
  has_many :reviews
  has_many :items, through: :orders
  
  # -------------------------------------- Validations
  
  validates_presence_of :name, :email
  validates_uniqueness_of :email, case_sensitive: false
  
  # -------------------------------------- Instance Methods
  
  def has_purchased?(item)
    item_ids.include?(item.id)
  end
  
end
