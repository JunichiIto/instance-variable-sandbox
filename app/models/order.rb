require 'csv'
require 'kconv'

class Order < ActiveRecord::Base
  has_many :order_details, dependent: :destroy
  accepts_nested_attributes_for :order_details, allow_destroy: true
  validates :name, :address, presence: true

  # 参考: http://ayaketan.hatenablog.com/entry/2014/01/26/180141
  def save_details_from_csv(csv_file)
    csv_text = csv_file.read
    CSV.parse(Kconv.toutf8(csv_text)) do |row|
      # 本来であればカラム数のチェック等を実施すべきだが、サンプルコードなのでここでは割愛する
      self.order_details.create(item_name: row[0], unit_price: row[1], quantity: row[2])
    end
    self.valid?
  end
end
