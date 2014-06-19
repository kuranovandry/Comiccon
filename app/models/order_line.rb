class OrderLine < ActiveRecord::Base
  belongs_to :order
  belongs_to :book

  validates :unit_price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :quantity, presence: true, numericality: { only_integer: true,
                                                       greater_than_or_equal_to: 1 }

  def total_price
    self.unit_price * self.quantity
  end
end
