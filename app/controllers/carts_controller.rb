class CartsController < ApplicationController
  before_action :create_cart

  def index
    @cart_items = session[:cart][:books]
  end

  def update_cart
    if user_signed_in? || !@cart.expired?
      @cart.update_cart(params[:book_ids], params[:quantities])
      redirect_to carts_path
    else
      expire
    end
  end

  def add_book
    if user_signed_in? || !@cart.expired?
      if @cart.add_book(params[:book_id])
        flash[:success] = "Book added succesfully to cart"
        redirect_to carts_path
      else
        flash[:error] = "Book cannot be found"
        redirect_to root_path
      end
    else
      expire
    end
  end

  def remove_book
    if user_signed_in? || !@cart.expired?
      @cart.remove_book(params[:book_id])
      redirect_to carts_path
    else
      expire
    end
  end

  private
    def create_cart
      @cart ||= Cart.new(session)
    end

    def expire
      flash[:alert] = "Your shopping cart has expired!"
      session[:cart] = nil
      @cart = Cart.new(session)
      redirect_to root_path
    end
end