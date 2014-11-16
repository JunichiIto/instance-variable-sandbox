class Order < ActiveRecord::Base
  has_many :order_details, dependent: :destroy
  accepts_nested_attributes_for :order_details, allow_destroy: true
  validates :name, :address, presence: true
end
