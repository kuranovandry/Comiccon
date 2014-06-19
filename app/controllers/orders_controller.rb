class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    @orders = current_user.orders.order(created_at: :desc).paginate(page: params[:page])
  end

  def new
    @order = Order.new
  end

  def create
    if user_params[:shipping_address].present?
      begin
        @order = current_user.orders.new(user_params)
        @order.create_order(session)
        session[:cart] = nil
        flash[:success] = "Order is confirmed successfully!"
        redirect_to orders_path
      rescue Exception => e
        redirect_to carts_path, alert: e.message
      end
    else
      redirect_to new_order_path, alert: "Shipping address cannot be empty!"
    end
  end

  private

    def user_params
      params.require(:order).permit(:shipping_address)
    end
end