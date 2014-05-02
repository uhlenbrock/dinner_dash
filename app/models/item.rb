class Item < ActiveRecord::Base
  
  include ActionView::Helpers::NumberHelper 
  
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
  
  belongs_to :category, counter_cache: true
  belongs_to :sale, counter_cache: true
  has_and_belongs_to_many :orders
  has_many :reviews
  
  # -------------------------------------- Instance Methods
  
  def average_rating
    reviews.average(:rating).try(:round, 1)
  end
  
  def display_price
    if on_sale?
      "<s style='color:red'>#{number_to_currency(price)}</s> #{number_to_currency(calculated_price)}"
    else
      number_to_currency(price)
    end
  end

  def calculated_discount
    if on_sale?
      price.to_f * (sale.discount.to_f / 100.to_f)
    else
      0
    end
  end
  
  def calculated_price
    if on_sale?
      price.to_f - calculated_discount
    else
      price
    end
  end

  def on_sale?
    sale.present? && sale.active?
  end
  
end
