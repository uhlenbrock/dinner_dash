class Sale < ActiveRecord::Base

  # -------------------------------------- Associations

  has_many :items

end
