class Order < ActiveRecord::Base
  
  # -------------------------------------- Associations
  
  belongs_to :user
  has_and_belongs_to_many :items
  
  # -------------------------------------- Validations
  
  validates_presence_of :user_id
  validate :minimum_order_size
  
  # -------------------------------------- Callbacks
  
  # When a new order is saved, automatically set 
  # the default order status
  before_create do
    self.pickup_at  ||= Time.zone.now + 15.minutes
    self.order_status = Order.order_statuses.first
  end
  
  # -------------------------------------- Instance Methods
  
  def minimum_order_size
    errors.add(:items, 'must contain at least one') if items.none?
  end
  
  # -------------------------------------- Class Methods
  
  def self.order_statuses
    ['ordered', 'paid', 'cancelled', 'completed']
  end  
  
end
