require 'spec_helper'

describe OrdersController do
  let(:user) { FactoryGirl.create(:confirmed_user) }
  let(:book) { FactoryGirl.create(:book) }
  let(:order) { FactoryGirl.build(:order, user: user, line_count: 0) }
  let(:cart) { Cart.new(session) }

  before { cart.add_book(book.id) }

  describe "GET #new" do
    context "user is not signed in" do
      it "redirect to sign in page" do
        get :new
        response.should redirect_to new_user_session_path
      end
    end

    context "user is signed in" do
      before { sign_in user }
      it "renders the new view" do
        get :new
        response.should render_template :new
      end
    end
  end

  describe "POST #create" do
    before { sign_in user }

    context "with valid attributes" do
      it "saves the new order to database" do
        expect { post :create, order: order.attributes }.to change(Order, :count).by(1)
      end

      it "saves the new order lines to database" do
        expect { post :create, order: order.attributes }.to change(OrderLine, :count).by(1)
      end

      it "saves the new order with the right attributes" do
        post :create, order: order.attributes
        last_order = Order.last
        last_order.user.should == user
        last_order.shipping_address.should == order.shipping_address
      end

      describe "after saving new order" do
        before { post :create, order: order.attributes }

        it "resets the cart" do
          session[:cart].should be_nil
        end

        it "redirects to the order index page" do
          response.should redirect_to orders_path
        end

        it "shows a success message" do
          flash[:success].should == "Order is confirmed successfully!"
        end
      end
    end

    context "with invalid attributes" do
      before { order.shipping_address = "" }

      it "does not save the new order to database" do
        expect { post :create, order: order.attributes }.not_to change(Order, :count)
      end

      it "rerenders the new template" do
        post :create, order: order.attributes
        response.should redirect_to new_order_path
      end

      it "shows an alert message" do
        post :create, order: order.attributes
        flash[:alert].should == "Shipping address cannot be empty!"
      end
    end
  end

  describe "GET #index" do
    before do
      sign_in user
      order.save
      get :index
    end

    it "populates an array of orders belonging to current user" do
      assigns(:orders).should eq [order]
    end

    it "renders the index view" do
      response.should render_template :index
    end
  end
end
