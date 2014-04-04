class Order < ActiveRecord::Base

  # -------------------------------------- Associations

  belongs_to :user
  has_and_belongs_to_many :items

  # -------------------------------------- Validations

  validates_presence_of :user_id
  validate :minimum_order_size

  # -------------------------------------- Scopes

  scope :with_status, -> (status) { where(order_status: status) }

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

  def total
    items.sum(:price)
  end

  def cancelable?
    Order.order_statuses[0..1].include? order_status
  end

  def ordered?
    order_status == 'ordered'
  end

  def paid?
    order_status == 'paid'
  end

  # -------------------------------------- Class Methods

  def self.order_statuses
    ['ordered', 'paid', 'cancelled', 'completed']
  end

  def self.order_statuses_for_select
    order_statuses.collect { |o| [o.humanize, o] }.unshift(['Show All', ''])
  end

end
