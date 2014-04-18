class Item < ActiveRecord::Base
  
  # -------------------------------------- Validations
  
  validates_presence_of :title
  validates_presence_of :description
  validates :price, numericality: { only_integer: true, greater_than: 0 }
  validates_uniqueness_of :title, case_sensitive: false
  
  # -------------------------------------- Scopes
  
  scope :active, -> { where(active: true) }
  
  # -------------------------------------- Callbacks
  
  before_create do
    self.prep_time ||= 12
  end
  
  # -------------------------------------- Associations
  
  belongs_to :category
  has_and_belongs_to_many :orders
  has_many :reviews
  
  # -------------------------------------- Instance Methods
  
  def average_rating
    reviews.average(:rating).try(:round, 1)
  end
  
end
