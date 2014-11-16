class OrderDetail < ActiveRecord::Base
  belongs_to :order
  validates :item_name, :unit_price, :quantity, presence: true
  validates :unit_price, :quantity, numericality: { only_integer: true, greater_than: 0 }
end
