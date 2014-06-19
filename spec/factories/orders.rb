FactoryGirl.define do
  factory :order do
    ignore do
      line_count 2
    end
    shipping_address Faker::Address.street_address
    total_amount 0
    order_lines { create_list(:order_line, line_count) }

    after(:build, :create) do |order|
      order.order_lines.each do |line|
        order.total_amount += line.unit_price * line.quantity
      end
    end
  end

  factory :order_line do
    unit_price Faker::Number.number(2)
    quantity 1
  end
end