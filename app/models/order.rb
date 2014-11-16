require 'csv'
require 'kconv'

class Order < ActiveRecord::Base
  attr_reader :result
  has_many :order_details, dependent: :destroy
  accepts_nested_attributes_for :order_details, allow_destroy: true
  validates :name, :address, presence: true

  def read_csv(csv_file)
    @csv_text = csv_file.read
  end

  # 参考: http://ayaketan.hatenablog.com/entry/2014/01/26/180141
  def save_details
    @result = []
    CSV.parse(Kconv.toutf8(@csv_text)) do |row|
      # 本来であればカラム数のチェック等を実施すべきだが、サンプルコードなのでここでは割愛する
      order_detail = self.order_details.build(item_name: row[0], unit_price: row[1], quantity: row[2])
      if order_detail.save
        @result << true
      else
        @result += order_detail.errors.full_messages
      end
    end
  end
end
