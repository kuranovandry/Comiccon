require 'spec_helper'

describe Order do
  let(:order) { FactoryGirl.build(:order, line_count: 0) }

  subject { order }

  it { should be_valid }

  [:id, :total_amount, :shipping_address, :created_at].each do |field|
    it { should respond_to(field) }
  end

  it { should have_many(:order_lines) }
  it { should belong_to(:user) }
  it { should validate_presence_of(:shipping_address) }
  it { should validate_presence_of(:total_amount) }
  it { should validate_numericality_of(:total_amount).is_greater_than_or_equal_to(0) }

  describe "create order function" do
    let(:book) { FactoryGirl.create(:book) }
    let(:cart) { Cart.new(Hash.new) }
    let(:session_cart) { cart.session[:cart] }

    before { cart.add_book(book.id) }

    it "should add a new order to database" do
      expect{ order.create_order(cart.session) }.to change(Order, :count).by(1)
      Order.last.total_amount.should == session_cart[:total_amount]
    end

    it "should add new order lines to database" do
      expect{ order.create_order(cart.session) }.to change(OrderLine, :count).by(1)
      order_line = OrderLine.last
      order_line.book.should == book
      order_line.order.should == Order.last
      order_line.unit_price.should == book.unit_price
      order_line.quantity.should == session_cart[:books][book.id][:quantity]
    end
  end
end